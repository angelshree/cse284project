#!/bin/bash
# adapted from ps2 run_admixture.sh
# note: allow ~10-20 minutes for this script to run fully

rm -r admixture_out
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
    
    # running admixture on different values of K for each vcf individually
    # going into admixture_out directory so results stay there
    cd ~/teams/group-4/project/admixture_out
    for K in 2 3 5
    do
        echo "ADMIXTURE for K=$K and vcf=$vcf"
        admixture ${PREFIX}_${file_raw}.pruned.bed $K
    done
    cd ~/teams/group-4/project
    
done

# merging bed files of each chrom for ADMIXTURE
echo "merging chr files into one bed file"
for i in $(seq 2 22)
do
echo "admixture_out/${PREFIX}_chr${i}.pruned.bed admixture_out/${PREFIX}_chr${i}.pruned.bim admixture_out/${PREFIX}_chr${i}.pruned.fam" >> admixture_filenames.txt
done

plink -bfile admixture_out/admixture_chr1.pruned --merge-list admixture_filenames.txt --make-bed --out admixture_out/${PREFIX}_ALL.pruned

cd ~/teams/group-4/project/admixture_out/
# running admixture on different values of K for combined chrs
echo "all file: admixture_out/${PREFIX}_ALL.pruned.bed"
for K in 2 3 5
do
    echo "ADMIXTURE for ALL, K=$K"
    admixture ${PREFIX}_ALL.pruned.bed $K
done
