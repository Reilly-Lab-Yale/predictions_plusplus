#!/bin/bash
#SBATCH -p day
#SBATCH -t 2:00:00
#SBATCH -c 1
#SBATCH --mem-per-cpu=8G

data_root="/home/mcn26/scratch_pi_skr2/mcn26/output_indel"

#add tab to fix cols

for d in "${data_root}"/*; do
    bn=$(basename "$d")
    out="${data_root}/${bn}.vcf"
    cat dummy_header.txt > $out

    for f in "$d"/*; do
	    tail -n +2 "$f" | awk -v OFS="\t" '{print $1, $2, $3, $4, $5, ".", ".", $6}' >> "$out"
    done
done

