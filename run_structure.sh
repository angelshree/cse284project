#!/usr/bin/bash

# need to pip install
# path to local install of structure_threader
export PATH="/home/a1sriniv/.local/bin:$PATH"

rm -r structure_out
mkdir structure_out

cd ~/teams/group-4/project

vcf_files='vcf_raws.txt'
sample_info='/home/a1sriniv/teams/group-4/project/1000GenomesAdmixture/igsr_samples.tsv'
PREFIX='structure'

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
    plink --vcf $vcf --maf 0.01 --keep ${PREFIX}_samples.txt --double-id --make-bed --out structure_out/${PREFIX}_${file_raw}
    
    # LD pruning
    echo "pruning ${vcf}"
    plink --bfile structure_out/${PREFIX}_${file_raw} --indep-pairwise 50 10 0.1
    plink --bfile structure_out/${PREFIX}_${file_raw} --extract plink.prune.in --make-bed --out structure_out/${PREFIX}_${file_raw}.pruned
    
    # running admixture on different values of K for each vcf individually
    echo "STRUCTURE for K=2,3,5 and vcf=$vcf"
    # make sure to change the path to fastStructure in your machine in this command
    structure_threader run -Klist 2 3 5 -R 1 -i structure_out/${PREFIX}_${file_raw}.pruned.bed -o structure_out/${PREFIX}_${file_raw} -t 5 --pop structure_pop_file.tsv -fs /home/a1sriniv/.local/bin/fastStructure
    
done

echo "merging chr files into one bed file"
for i in $(seq 2 22)
do
echo "structure_out/${PREFIX}_chr${i}.pruned.bed structure_out/${PREFIX}_chr${i}.pruned.bim structure_out/${PREFIX}_chr${i}.pruned.fam" >> structure_filenames.txt
done

plink -bfile structure_out/structure_chr1.pruned --merge-list structure_filenames.txt --make-bed --out structure_out/${PREFIX}_ALL.pruned

# running structure on different values of K for combined chrs
echo "all file: structure_out/${PREFIX}_ALL.pruned.bed"
structure_threader run -Klist 2 3 5 -R 1 -i structure_out/${PREFIX}_ALL.pruned.bed -o structure_out/${PREFIX}_ALL -t 5 --pop structure_pop_file.tsv -fs /home/a1sriniv/.local/bin/fastStructure


# structure_threader run -Klist $K -R 1 -i structure_out/structure}_${file_raw}.pruned.bed -o structure_out/${PREFIX}_${file_raw} -t 1 --pop 1000GenomesAdmixture/correct_pop_file.tsv -fs /home/a1sriniv/.local/bin/fastStructure

