# CSE 284 Final Project 
Anjali Srinivasan and Varshini Sathish

## Project Description
In this project, we are comparing the population structure modeling tools ADMIXTURE and fastSTRUCTURE. ADMIXTURE, which was used in class, utilizes Maximum Likelihood Estimates to infer the population structure of a cohort. In contrast, fastSTRUCTURE implements a Bayesian approach. We are using the 1000Genomes dataset as our input to both tools, and will be comparing the results across all individuals in the cohort as well as a specific ancestry subset.

## Repository Contents
This repository contains the following scripts/notebooks:

 - run_structure.sh : This script converts the 1000 Genomes input vcf.gz files into STRUCTURE format, as both tools require different input formats. Following this step, STRUCTURE is run on the population cohort. (not yet added)
 - run_admixture.sh : This script runs the ADMIXTURE program on the cohort.
 - vcf_raws.txt : This text file contains the name of all the pruned chromosome vcfs
 - Visualizations_Admixture.ipynb : This notebook contains all visualizations and downstream analysis for ADMIXTURE
 - Visualizations_fastStructure.ipynb : This notebook contains all visualizations and downstream analysis for fastStructure
 - create_structure_pop_file.py : This python script contains the code used to create the population file in the correct format for fastStructure
 - chr1.subjects.pruned.fam : This is the .fam file we used to match samples to our 1000 Genomes samples for creation of the population file

## Notes
to install Structure_threader (the wrapper program used to run fastStructure), view the instructions here: https://github.com/StuntsPT/Structure_threader

## Links

- ADMIXTURE tool page: https://dalexander.github.io/admixture/
- Structure_threader installation page: https://structure-threader.readthedocs.io/en/latest/install/
- 1000 Genomes webpage: https://www.internationalgenome.org/

## Remaining Work

- Finish running STRUCTURE on the dataset
- fix vcf merging for multiple chromosomes
- downsample to specific ancestries and compare
