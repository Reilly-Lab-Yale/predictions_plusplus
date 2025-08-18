#!/bin/bash
#SBATCH --job-name=sepchr
#SBATCH --partition=day
#SBATCH -c 1
#SBATCH --mem=1G
#SBATCH -t 2:00:00
#For each variant, we need to use the model trained where the held-out set a pair of chromosomes
#contains the chromosome the variant in question is on.


#cat single_file_processed_variants_nostar.tsv | grep -v "^#" | cut -f1 | sort | uniq -c

#returns

# 715438 chr1
# 288697 chr10
# 418303 chr11
# 377282 chr12
# 127240 chr13
# 224810 chr14
#     44 chr14_KI270846v1_alt
# 255046 chr15
#    414 chr15_KI270850v1_alt
#     24 chr15_KI270851v1_alt
#      3 chr15_KI270852v1_alt
# 354248 chr16
# 425370 chr17
#     49 chr17_KI270857v1_alt
#    151 chr17_KI270909v1_alt
# 111802 chr18
# 506252 chr19
#    421 chr19_KI270938v1_alt
#      4 chr1_KI270711v1_random
#     86 chr1_KI270766v1_alt
# 512150 chr2
# 183316 chr20
#  96340 chr21
# 177231 chr22
#    127 chr22_KI270879v1_alt
#     14 chr22_KI270928v1_alt
# 401054 chr3
# 277407 chr4
# 310491 chr5
# 350948 chr6
# 357351 chr7
#    760 chr7_KI270803v1_alt
# 260681 chr8
# 315549 chr9
# 174450 chrX
#   2782 chrY

#Nothing too crazy.
#MT, X, and Y & the contigs we will discard.
#the rest we will place in pairs, 
#1 & 22, 2 & 21, 3 & 20 ... 11 & 12

   415937 chr10_chr13.tsv
   795585 chr11_chr12.tsv
   892669 chr1_chr22.tsv
   608490 chr2_chr21.tsv
   584370 chr3_chr20.tsv
   783659 chr4_chr19.tsv
   422293 chr5_chr18.tsv
   776318 chr6_chr17.tsv
   711599 chr7_chr16.tsv
   515727 chr8_chr15.tsv
   540359 chr9_chr14.tsv
   179329 default.tsv
  7226335 total

#module reset
#module load miniconda
conda activate speedracer

cat /home/mcn26/project_pi_skr2/mcn26/single_file_processed_variants_nostar.tsv | pypy separate_by_chromosome.py




