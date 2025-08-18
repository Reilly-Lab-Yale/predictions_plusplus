#recombining the multiple chromosome files into one vcf file
cat /home/mcn26/project_pi_skr2/mcn26/clinical_predictions/* | grep -v "^chrom" > /home/mcn26/project_pi_skr2/mcn26/clinical_pred.tsv
gzip /home/mcn26/project_pi_skr2/mcn26/clinical_pred.tsv
