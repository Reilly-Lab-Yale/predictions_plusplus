#!/bin/bash
#SBATCH --job-name=sepchr
#SBATCH --partition=day
#SBATCH -c 1
#SBATCH --mem=1G
#SBATCH -t 2:00:00
#For each variant, we need to use the model trained where the held-out set a pair of chromosomes
#contains the chromosome the variant in question is on.


#cat bale_freq_Jul2025.vcf | grep -v "^#" | cut -f1 | sort | uniq -c

#returns

# 716570 1
# 289046 10
# 418624 11
# 377613 12
# 127351 13
# 225196 14
# 255814 15
# 354499 16
# 426026 17
# 111917 18
# 507502 19
# 512527 2
# 183463 20
#  96494 21
# 177641 22
# 401406 3
# 277717 4
# 310771 5
# 351396 6
# 358945 7
# 261139 8
# 315982 9
#   7300 MT
# 174948 X
#   2784 Y

#Nothing too crazy.
#MT, X, and Y we will discard.
#the rest we will place in pairs, 
#1 & 22, 2 & 21, 3 & 20 ... 11 & 12

#module reset
#module load miniconda
conda activate speedracer

cat /home/mcn26/project_pi_skr2/mcn26/clinical_formatted.tsv | pypy separate_by_chromosome.py

#examining the output

#wc -l ./*

#   416397 ./chr10_chr13.tsv
#   796237 ./chr11_chr12.tsv
#   894211 ./chr1_chr22.tsv
#   609021 ./chr2_chr21.tsv
#   584869 ./chr3_chr20.tsv
#   785219 ./chr4_chr19.tsv
#   422688 ./chr5_chr18.tsv
#   777422 ./chr6_chr17.tsv
#   713444 ./chr7_chr16.tsv
#   516953 ./chr8_chr15.tsv
#   541178 ./chr9_chr14.tsv
#   185032 ./default.tsv
#  7242671 total

#numbers sum correctly