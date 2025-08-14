#!/bin/bash
#SBATCH --job-name=f3_20
#SBATCH --partition=gpu_h200
#SBATCH --gres=gpu:1
#SBATCH -c 2
#SBATCH --mem=64G
#SBATCH -t 1:45:00
#SBATCH --array=49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226

module load miniconda
conda activate boda_cu128

chr_pair="chr3_chr20"

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
