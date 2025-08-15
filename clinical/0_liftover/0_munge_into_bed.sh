#variants were provided as hg19, I need hg38. I'll just use the web interface.
#web interface says it wants "(BED or chrN:start-end in plain text format):"
#
#Chr1        T   A   C   G   T
#          | | | | | | | | | |
#1 based   | 1 | 2 | 3 | 4 | 5
#
#0 based   0   1   2   3   4
#VCFs are 1-based, BEDs are 0 based.
#So I will generate a file of chr, coord-1, coord, info
#info will function as an ID to merge everything back together.

cat ~/project_pi_skr2/mcn26/bale_freq_Jul2025.vcf \
    | grep -v "^#" \
    | awk -F'\t' 'BEGIN{OFS="\t"} {print "chr"$1, $2-1, $2, $8}' \
    > ~/project_pi_skr2/mcn26/bale_freq.bed
