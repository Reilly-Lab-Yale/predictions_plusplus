Code in this directory performs predictions using John Butts's updated version of MPAC which can handle indels properly.

Input data are from [MPAC_gnomAD_and_satmut](https://github.com/Reilly-Lab-Yale/MPAC_gnomAD_and_satmut).
Specifically, the output of the `MPAC_gnomAD_preprocessing/helper/split_off_indels` step was copied to `/home/mcn26/project_pi_skr2/mcn26/indel`.

Since this repository is only for generating supplemental predictions, the remainder of the filtering steps can be found under the `indel_filtering` branch of [the processsing in this repository](https://github.com/Reilly-Lab-Yale/MPAC_gnomAD_and_satmut).