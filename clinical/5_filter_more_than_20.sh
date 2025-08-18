#creates a copy of the predictions filtered to those with indels <20bp
module load miniconda
conda activate speedracer
zcat /home/mcn26/project_pi_skr2/mcn26/clinical_pred.tsv.gz | pypy3 filter_more_than_20.py > /home/mcn26/project_pi_skr2/mcn26/clinical_pred_short_indels.tsv
gzip /home/mcn26/project_pi_skr2/mcn26/clinical_pred_short_indels.tsv
