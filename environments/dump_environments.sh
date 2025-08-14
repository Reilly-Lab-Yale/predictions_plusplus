for env in "boda_cu128" "speedracer"; do
    conda activate ${env}
    conda env export > ${env}_environment.yml
    ~/.conda/envs/${env}/bin/pip freeze > ${env}_requirements.txt
    conda env export --from-history > ${env}_environment_minimal.yml
    conda deactivate
done

