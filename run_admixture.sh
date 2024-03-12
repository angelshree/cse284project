#!/bin/bash
# adapted from ps2 run_admixture.sh

mkdir admixture_out

# removing and remaking filenames file just in case running again
rm admixture_filenames.txt
touch admixture_filenames.txt

cd ~/teams/group-4/project

vcf_files='vcf_raws.txt'
sample_info='/home/a1sriniv/teams/group-4/project/1000GenomesAdmixture/igsr_samples.tsv'
PREFIX='admixture'

readarray -t vcfs < vcf_raws.txt

# extract samples from phase 1 release
cat $sample_info | grep "1000 Genomes phase 1 release" | awk '{print $1 "\t" $1}' > ${PREFIX}_samples.txt

# running admixture separately for each chr (due to memory constraints)
for vcf in ${vcfs[@]}
do
    file_raw=${vcf:27:-14}
    echo $vcf
    echo ${file_raw}
    
    # preprocessing with plink
    echo "preprocessing ${vcf}"
    plink --vcf $vcf --maf 0.01 --keep ${PREFIX}_samples.txt --double-id --make-bed --out admixture_out/${PREFIX}_${file_raw}
    
    # LD pruning
    echo "pruning ${vcf}"
    plink --bfile admixture_out/${PREFIX}_${file_raw} --indep-pairwise 50 10 0.1
    plink --bfile admixture_out/${PREFIX}_${file_raw} --extract plink.prune.in --make-bed --out admixture_out/${PREFIX}_${file_raw}.pruned
    
    echo "$PREFIX_${file_raw}.pruned" >> admixture_filenames.txt
    
done

# merging bed files of each chrom for ADMIXTURE
for i in $(seq 2 22)
do
echo "admixture_out/$PREFIX_${file_raw}.pruned.bed admixture_out/$PREFIX_${file_raw}.pruned.bim admixture_out/$PREFIX_${file_raw}.pruned.fam" >> admixture_filenames.txt
done

plink -bfile admixture_out/admixture_chr1.pruned --merge-list admixture_filenames.txt --make-bed --out admixture_out/${PREFIX}_ALL.pruned





