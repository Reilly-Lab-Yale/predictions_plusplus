#!/bin/bash
#SBATCH --job-name=munge_indel
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2G
#SBATCH -p day
#SBATCH --array=1-22

module load miniconda
conda activate speedracer

DATA_ROOT="/home/mcn26/scratch_pi_skr2/mcn26/split_off_indel"
OUTPUT_ROOT="/home/mcn26/scratch_pi_skr2/mcn26/munged_indel"

CHR="chr${SLURM_ARRAY_TASK_ID}"

zcat ${DATA_ROOT}/gnomad_${CHR}_indels_only.vcf.gz | pypy3 munge.py ${OUTPUT_ROOT}/${CHR}
