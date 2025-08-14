#!/bin/bash
#SBATCH --job-name=gzip_vcf
#SBATCH --time=04:00:00
#SBATCH -p day
START_DIR="/home/mcn26/scratch_pi_skr2/mcn26/output"
find "$START_DIR" -mindepth 2 -maxdepth 2 -type f -name "*.vcf" -exec gzip {} \;
