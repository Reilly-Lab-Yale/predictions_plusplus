Clinical variants retrieved from mccleary /home/skr2/project/Bale_preds/bale_freq_Jul2025.vcf

Total variants:
```
cat bale_freq_Jul2025.vcf | grep -v '^#' | wc -l
```


```
cat bale_freq_Jul2025.vcf | cut -f1 | sort | uniq -c
```

```
 716570 1
 289046 10
 418624 11
 377613 12
 127351 13
 225196 14
 255814 15
 354499 16
 426026 17
 111917 18
 507502 19
 512527 2
 183463 20
  96494 21
 177641 22
 401406 3
 277717 4
 310771 5
 351396 6
 358945 7
 261139 8
 315982 9
      1 #CHROM
      1 ##fileformat=VCFv4.2
   7300 MT
      1 ##reference=hg19
      1 ##source=bale_freq
 174948 X
   2784 Y
```

7300+174948+2784=185032 variants lost (on chromosomes we don't have models for)

