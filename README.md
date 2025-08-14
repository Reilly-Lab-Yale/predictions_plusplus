Extra predictions for revisions of [Identifying non-coding variant effects at scale via machine learning models of cis-regulatory reporter assays](https://www.biorxiv.org/content/10.1101/2025.04.16.648420v1).

Everything you need to replicate is in `1x_test.sh`. All of the other scripts are slightly modified versions of this script for different batches of predictions, with adjustments and optimizations to resource allocation to handle variable GPU availability on the Yale Bouchet cluster (and so are probably not useful to you, but kept just in case). 

All predictions performed on NVIDIA H200 GPUs.

Using : [a slightly modified version of boda2](https://github.com/saarantras/boda2). Currently modifications are all in branch "allow_untrusted" (will update if this is merged).

Using : https://www.encodeproject.org/files/GRCh38_no_alt_analysis_set_GCA_000001405.15/

'satmut' is saturation mutagenesis
