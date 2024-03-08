# CSE 284 Final Project 
Anjali Srinivasan and Varshini Sathish

## Project Description
In this project, we are comparing the population structure modeling tools ADMIXTURE and STRUCTURE. ADMIXTURE, which was used in class, utilizes Maximum Likelihood Estimates to infer the population structure of a cohort. In contrast, STRUCTURE implements a Bayesian approach. We are using the 1000Genomes dataset as our input to both tools, and will be comparing the results across all individuals in the cohort as well as a specific ancestry subset.

## Repository Contents
This repository contains the following scripts/notebooks:

 - run_structure.sh : This script converts the 1000 Genomes input vcf.gz files into STRUCTURE format, as both tools require different input formats. Following this step, STRUCTURE is run on the population cohort. (not yet added)
 - run_admixture.sh : This script runs the ADMIXTURE program on the cohort. (not yet added)
 - K_vals.sh : This script contains the code to obtain the .P and .Q files for each K value analyzed
 - Visualizations.ipynb : This notebook contains all visualizations and downstream analysis for chromosomes 1,2,3, and 4 at this time (3/7/24)

## Notes
to install fastSTRUCTURE (the version of STRUCTURE we used in this analysis), view the instructions here: https://rajanil.github.io/fastStructure/

## Links

- ADMIXTURE tool page: https://dalexander.github.io/admixture/
- fastSTRUCTURE tool page (with install instructions): https://rajanil.github.io/fastStructure/
- 1000 Genomes webpage: https://www.internationalgenome.org/

## Remaining Work

- Finish running STRUCTURE on the dataset
- fix vcf merging for multiple chromosomes
- downsample to specific ancestries and compare
