#!/bin/bash
#SBATCH --job-name=c15
#SBATCH --partition=gpu_h200
#SBATCH --gres=gpu:1
#SBATCH -c 2
#SBATCH --mem=50G
#SBATCH -t 0:15:00
#SBATCH --array=0-69

module load miniconda
conda activate boda_cu128

chr_pair="chr8_15"
current_chr="chr15"

#path to scratch dir
scratch_root="/home/mcn26/scratch_pi_skr2/mcn26"
#path where all the model artifact tgzs are
model_root="${scratch_root}/sumner_pulldown/boda_ensembl_models/${chr_pair}"
#get all model artifact tgzs
models=$(find $model_root -maxdepth 1 -type f -printf "%f\n" | sed "s|^|$model_root/|" | paste -sd " " -)
output_dir="${scratch_root}/output_indel/${current_chr}"
mkdir -p $output_dir

chunk=$SLURM_ARRAY_TASK_ID

echo "[+] Making ./${current_chr}/chunk_${chunk}"
mkdir -p "./${current_chr}/chunk_${chunk}"
cd "./${current_chr}/chunk_${chunk}"

vcf_file="${scratch_root}/munged_indel/${current_chr}_chunk_${chunk}.tsv"
fasta_file="${scratch_root}/GRCh38_no_alt_analysis_set_GCA_000001405.15.fasta"
output="${output_dir}/chunk_${chunk}.vcf"

echo "[*] Running chunk ${chunk} on host: $(hostname) with CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES}"

python /home/mcn26/project_pi_skr2/mcn26/boda2/src/vcf_predict_indel.py \
--artifact_path ${models} \
--use_vmap True \
--vcf_file ${vcf_file} \
--fasta_file ${fasta_file} \
--output ${output} \
--window_size 200 \
--relative_start 9 \
--relative_end 181 \
--step_size 10 \
--raw_predictions False \
--strand_reduction mean \
--window_reduction mean \
--use_simple_padding True \
--feature_ids K562 HepG2 SKNSH > "chr_${current_chr}_chunk_${chunk}.out"

echo "[+] Finished!"
