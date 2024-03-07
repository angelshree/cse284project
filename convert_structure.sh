#!/usr/bin/bash

cd ~/project/
mkdir 1000GenomesStructure

# read in file with chr info to convert to structure format
readarray -t raw_vcf < 1000_genomes_files.txt

# loop through files and convert to STRUCTURE format
for file in ${raw_vcf[@]}
do
    file_raw=${file::-7}
    ad_file="./1000GenomesAdmixture/${file_raw}.vcf.gz"
    
    # convert to plink .ped format
    vcftools --gzvcf ${ad_file} --plink --out ./1000GenomesStructure/${file_raw}_plink
    
    # convert to bed to run structure
    plink --file ./1000GenomesPlink/${file_raw}_plink --make-bed --out ./1000GenomesStructure/${file_raw}_plink
    
done

plink --file 1000GenomesStructure/1000G_chr1_pruned_plink --merge-list structure_beds.txt --make-bed --out 1000G_Structure_compiled