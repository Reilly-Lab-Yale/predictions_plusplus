#!/bin/bash
#SBATCH --job-name=f1_22
#SBATCH --partition=gpu_h200
#SBATCH --gres=gpu:1
#SBATCH -c 3
#SBATCH --mem=60G
#SBATCH -t 1:30:00
#SBATCH --array=2,3,5,7,9,11,14,15,17,18,21,23,25,27,29,30,34,35,37,39,41,42,46,47,49,50,53,55,58,59,61,62,65,66,69,71,73,75,77,79,82,83,85,87,90,91,93,95,97,99,101,102,105,107,110,111,113,114,117,118,121,123,126,127,129,130,133,135,138,139,141,143,146,147,149,151,153,154,157,158,161,163,165,167,169,170,173,175,178,179,182,183,185,186,190,191,193,194,197,199,201,202,205,206,210,211,214,215,218,219,221,222,225,227,229,231,234,235,237,238,241,242,245,247,250

module load miniconda
conda activate boda_cu128

chr_pair="chr1_chr22"

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
