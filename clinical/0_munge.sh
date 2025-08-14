#!/bin/bash
#SBATCH --job-name=munge_clinvars
#SBATCH --partition=day
#SBATCH -c 1
#SBATCH --mem=1M
#SBATCH -t 1:00:00
#currently, we have a (mostly) properly formatted VCF
#We actually want a tsv of chromosome (starting with chr), 
#position, name, ref, alt
cat ~/project_pi_skr2/mcn26/bale_freq_Jul2025.vcf \
    | grep -v "^#" \
    | awk -F'\t' 'BEGIN{OFS="\t"} {print "chr"$1, $2, $8, $4, $5}' \
    > ~/project_pi_skr2/mcn26/clinical_formatted.tsv