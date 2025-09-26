#!/bin/bash
#SBATCH -p day
#SBATCH -t 2:00:00
#SBATCH -c 1
#SBATCH --mem-per-cpu=1G

data_root="/home/mcn26/scratch_pi_skr2/mcn26/output_indel"

for d in "${data_root}"/*; do
    bn=$(basename "$d")
    cat "$d"/* > "${data_root}/${bn}.tsv"
done
