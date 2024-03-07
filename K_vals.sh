#!/bin/bash

cd ~/teams/group-4/project/admixture_out

sample_info='/home/v1sathis/teams/group-4/project/1000GenomesAdmixture/igsr_samples.tsv'
#PREFIX='admixture_chr'


#start with first 4 chromosomes
for CHROM in 1 2 3 4
do
   # Set the prefix for the current chromosome
   PREFIX="admixture_chr${CHROM}"

   # Loop for running admixture on different values of K
   for K in 2 3 5
   do
      echo "ADMIXTURE for chromosome ${CHROM} and K=${K}"
      admixture ${PREFIX}.pruned.bed $K
   done
done

#running admixture on different values of K
# for K in 2 3 5
# do
#    echo "ADMIXTURE for K=$K"
#    admixture ${PREFIX}.pruned.bed $K
# done