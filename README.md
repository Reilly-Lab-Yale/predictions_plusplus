Extra predictions for revisions of [Identifying non-coding variant effects at scale via machine learning models of cis-regulatory reporter assays](https://www.biorxiv.org/content/10.1101/2025.04.16.648420v1).
Using : [a slightly modified version of boda2](https://github.com/saarantras/boda2). 
Using : https://www.encodeproject.org/files/GRCh38_no_alt_analysis_set_GCA_000001405.15/

Everything you need to replicate is in `1x_test.sh`. All of the other scripts are just modified versions of this script for different batches of predictions, with adjustments and optimizations to resource allocation to handle variable GPU availability on the Yale Bouchet cluster (and so are probably not useful to you, but kept just in case). 

see environments directory for all environment information.

All predictions performed on NVIDIA H200 GPUs.
Predictions were performed using `boda_cu128` environment, created as below:
```
conda create -n boda_cu128
conda activate boda_cu128
conda install python=3.11#ostensibly more compatible with newer cuda...
$CONDA_PREFIX/bin/pip3 install torch --index-url https://download.pytorch.org/whl/cu128
pip3 freeze | grep 'torch' > pinned.txt
$CONDA_PREFIX/bin/pip3 install --no-cache-dir -r requirements.txt -c pinned.txt
$CONDA_PREFIX/bin/pip3 install -e .
```

Some minor data carpentry tasks use the `speedracer` environment.





'satmut' is saturation mutagenesis
