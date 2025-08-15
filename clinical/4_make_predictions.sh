#!/bin/bash
#SBATCH --job-name=clinpred
#SBATCH --partition=gpu_h200
#SBATCH --gres=gpu:1
#SBATCH -c 2
#SBATCH --mem=64G
#SBATCH -t 1:45:00
#SBATCH --array=0-10

module load miniconda
conda activate boda_cu128

# Build array of pairs
mapfile -t chromosome_pairs < <(
    paste -d"_" <(seq -f "chr%g" 1 22) <(seq -f "chr%g" 22 -1 1) | head -n 11
)

scratch_root="/home/mcn26/scratch_pi_skr2/mcn26"
input_root="/home/mcn26/project_pi_skr2/mcn26/clinical_by_chromosome"
output_root="/home/mcn26/project_pi_skr2/mcn26/clinical_predictions"

chr_pair=${chromosome_pairs[${SLURM_ARRAY_TASK_ID}]}

mkdir $chr_pair
cd $chr_pair

#path where all the model artifact tgzs are
model_root="${scratch_root}/sumner_pulldown/boda_ensembl_models/${chr_pair}"
#get all model artifact tgzs
models=$(find $model_root -maxdepth 1 -type f -printf "%f\n" | sed "s|^|$model_root/|" | paste -sd " " -)


vcf_file="${input_root}/${chr_pair}.tsv"
fasta_file="${scratch_root}/GRCh38_no_alt_analysis_set_GCA_000001405.15.fasta"
output="${output_root}/${chr_pair}.vcf"


echo "[*] Running pair ${chr_pair} on host: $(hostname) with CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES}"
python "${scratch_root}/sumner_pulldown/boda2/src/vcf_predict.py" \
--artifact_path ${models} \
--use_vmap TRUE \
--vcf_file ${vcf_file} \
--fasta_file ${fasta_file} \
--output ${output} \
--relative_start 9 \
--relative_end 181 \
--step_size 10 \
--raw_predictions FALSE \
--strand_reduction mean \
--window_reduction mean \
--feature_ids K562 HepG2 SKNSH


echo "[+] Finished!"
