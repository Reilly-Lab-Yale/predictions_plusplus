#!/bin/bash
#SBATCH --job-name=f7_16
#SBATCH --partition=gpu_h200
#SBATCH --gres=gpu:1
#SBATCH -c 2
#SBATCH --mem=64G
#SBATCH -t 1:30:00
#SBATCH --array=199,247,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,104,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,248,249,250,251

module load miniconda
conda activate boda_cu128

chr_pair="chr7_chr16"

#path to scratch dir
scratch_root="/home/mcn26/scratch_pi_skr2/mcn26"
#path where all the model artifact tgzs are
model_root="${scratch_root}/sumner_pulldown/boda_ensembl_models/${chr_pair}"
#get all model artifact tgzs
models=$(find $model_root -maxdepth 1 -type f -printf "%f\n" | sed "s|^|$model_root/|" | paste -sd " " -)
output_dir="${scratch_root}/output/${chr_pair}"
mkdir -p $output_dir

chunk=$SLURM_ARRAY_TASK_ID

echo "[+] Making ./${chr_pair}/chunk_${chunk}"
mkdir -p "./${chr_pair}/chunk_${chunk}"
cd "./${chr_pair}/chunk_${chunk}"

vcf_file="${scratch_root}/sumner_pulldown/${chr_pair}/GRCh38-dELS-${chr_pair}chunk_${chunk}.tsv"
fasta_file="${scratch_root}/GRCh38_no_alt_analysis_set_GCA_000001405.15.fasta"
output="${output_dir}/chunk_${chunk}.vcf"


echo "[*] Running chunk ${chunk} on host: $(hostname) with CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES}"
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
--feature_ids K562 HepG2 SKNSH  > "chunk_${chunk}.out"


echo "[+] Finished!"
