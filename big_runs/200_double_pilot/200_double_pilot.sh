#!/bin/bash
#SBATCH --job-name=2_21
#SBATCH --partition=gpu_h200
#SBATCH --gpus 2
#SBATCH -c 4
#SBATCH --mem-per-cpu=32G
#SBATCH -t 6:00:00
#SBATCH --array=0-117

module load miniconda
conda activate boda_cu128

chr_pair="chr2_chr21"

#path to scratch dir
scratch_root="/home/mcn26/scratch_pi_skr2/mcn26"
#path where all the model artifact tgzs are
model_root="${scratch_root}/sumner_pulldown/boda_ensembl_models/${chr_pair}"
#get all model artifact tgzs
models=$(find $model_root -maxdepth 1 -type f -printf "%f\n" | sed "s|^|$model_root/|" | paste -sd " " -)
output_dir="${scratch_root}/output/${chr_pair}"
mkdir -p $output_dir

# Loop over the two chunks
for i in 0 1; do
    chunk=$((SLURM_ARRAY_TASK_ID * 2 + i))
    (
        export CUDA_VISIBLE_DEVICES=$i  # Assign GPU 0 to first chunk, GPU 1 to second
        mkdir -p "./${chr_pair}/chunk_${chunk}"
        cd "./${chr_pair}/chunk_${chunk}"

        vcf_file="${scratch_root}/sumner_pulldown/${chr_pair}/GRCh38-dELS-${chr_pair}chunk_${chunk}.tsv"
        fasta_file="${scratch_root}/GRCh38_no_alt_analysis_set_GCA_000001405.15.fasta"
        output="${output_dir}/chunk_${chunk}.vcf"

        echo "[*] Running chunk ${chunk} on GPU $i"
        python "${scratch_root}/sumner_pulldown/boda2/src/vcf_predict.py" \
            --artifact_path ${models} \
            --use_vmap TRUE \
            --vcf_file ${vcf_file} \
            --fasta_file ${fasta_file} \
            --output ${output} \
            --relative_start 9 \
            --relative_end 181 \
            --step_size 10 \
            --raw_predictions FALSE \
            --strand_reduction mean \
            --window_reduction mean \
            --feature_ids K562 HepG2 SKNSH
    ) &
done

wait

echo "[+] Finished!"