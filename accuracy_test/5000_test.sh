#!/bin/bash
#SBATCH --job-name=5000_mpac_test
#SBATCH --output=5000_mpac_%j.out
#SBATCH --error=5000_mpac_%j.out
#SBATCH --partition=gpu
#SBATCH --gpus 1
#SBATCH -c 1
#SBATCH --mem-per-cpu=64G
#SBATCH -t 4:00:00

module load miniconda
module load CUDA/12.6.0
module load GCC/13.3.0
conda activate boda_fresh

chr_pair="chr1_chr22"
chunk="toy"

#path to scratch dir
scratch_root="/home/mcn26/scratch_pi_skr2/mcn26"
#path where all the model artifact tgzs are
model_root="${scratch_root}/sumner_pulldown/boda_ensembl_models/${chr_pair}"
#get all model artifact tgzs
models=$(find $model_root -maxdepth 1 -type f -printf "%f\n" | sed "s|^|$model_root/|" | paste -sd " " -)

output_dir="${scratch_root}/output/5000_${chr_pair}"
mkdir -p $output_dir

#make a working directory for just this instance to play in...
mkdir -p "./5000_${chr_pair}/chunk_${chunk}"
cd "./5000_${chr_pair}/chunk_${chunk}"

## define & echo the parameters for debugging

vcf_file="${scratch_root}/sumner_pulldown/${chr_pair}/GRCh38-dELS-${chr_pair}chunk_${chunk}.tsv"
echo "[*] VCF input file ${vcf_file}"

fasta_file="${scratch_root}/GRCh38_no_alt_analysis_set_GCA_000001405.15.fasta"
echo "[*] Fasta file ${fasta_file}"

output="${output_dir}/chunk_${chunk}.vcf"
echo "[*] Output ${output}"

echo "[+] Running!"

#invoke actual script
python "/home/mcn26/project_pi_skr2/mcn26/boda2/src/vcf_predict.py" \
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