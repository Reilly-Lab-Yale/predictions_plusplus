#For each variant, We need to use the model trained where the held-out set a pair of chromosomes
#where the 


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

conda activate speedracer