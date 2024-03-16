# CSE 284 Final Project 
 Varshini Sathish and Anjali Srinivasan

## Project Description
In this project, we are comparing the population structure modeling tools ADMIXTURE and fastSTRUCTURE. ADMIXTURE, which was used in class, utilizes Maximum Likelihood Estimates to infer the population structure of a cohort. In contrast, fastSTRUCTURE implements a Bayesian approach. We are using phase 1 of the 1000Genomes dataset as our input to both tools and will be applying both tools to both individual chromosomes and the combined SNPs from all chromosomes.

## Repository Contents
This repository contains the following scripts/notebooks:

 - run_structure.sh : This script filters and prunes the 1000 Genomes vcf files using plink. After this, STRUCTURE is run on each individual chromosome and a pruned file containing all the chromosome information combined.
 - run_admixture.sh : This script filters and prunes the 1000 Genomes vcf files using plink. After this, ADMIXTURE is run on each individual chromosome and a pruned file containing all the chromosome information combined.
 - time_benchmarking.sh: This script runs both fastStructure and ADMIXTURE for the ALL file and  outputs the start and end time to allow for timing estimates.
 - vcf_raws.txt : This text file contains the name of all raw vcf input files.
 - Visualizations_Admixture.ipynb : This notebook contains all visualizations and downstream analysis for ADMIXTURE.
 - Visualizations_fastStructure.ipynb : This notebook contains all visualizations and downstream analysis for fastStructure.
 - create_structure_pop_file.py : This python script creates the population file used as input in fastStructure.
 - chr1.subjects.pruned.fam : This is the .fam file we used to match samples to our 1000 Genomes samples for creation of the population file.

## Links
### ADMIXTURE
- [documentation](https://dalexander.github.io/admixture/)
- [software manual](https://dalexander.github.io/preprints/admixture-preprint.pdf)
- citation: Alexander, D. H., Novembre, J., & Lange, K. (2009). Fast model-based estimation of ancestry in unrelated individuals. Genome Research, 19(9), 1655–1664.

### STRUCTURE
- [Structure_threader documentation](https://structure-threader.readthedocs.io/en/latest/)
- [STRUCTURE software page](https://web.stanford.edu/group/pritchardlab/structure.html)
- [fastStructure documentation](https://rajanil.github.io/fastStructure/)
- citation: Pina-Martins, F., Silva, D. N., Fino, J., & Paulo, O. S. (2017). Structure_threader: An improved method for automation and parallelization of programs structure, fastStructure and MavericK on multicore CPU systems. Molecular Ecology Resources, 17(6), e268–e274.

### Misc.
- [1000 Genomes webpage](https://www.internationalgenome.org/)

