Sorted and indexed the VCF files generated in the last step.

```
bgzip *.vcf
```

Then
```
for f in *.vcf.gz; do
    bcftools sort -Oz -o "${f%.vcf.gz}.sorted.vcf.gz" "$f"
    tabix -p vcf "${f%.vcf.gz}.sorted.vcf.gz"
done
```