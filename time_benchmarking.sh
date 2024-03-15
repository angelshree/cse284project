#!/usr/bin/bash


# timing for admixture
cd ~/teams/group-4/project/admixture_out/

echo -n "admixture k=2 "
date
admixture admixture_ALL.pruned.bed 2
date
echo
echo

echo -n "admixture k=3 "
date
admixture admixture_ALL.pruned.bed 3
date
echo
echo

echo -n "admixture k=5 "
date
admixture admixture_ALL.pruned.bed 5
date
echo
echo


# timing for structure
cd ~/teams/group-4/project/structure_out/
export PATH="/home/a1sriniv/.local/bin:$PATH"

echo -n "structure k=2 "
date
structure_threader run -Klist 2 -R 1 -i structure_ALL.pruned.bed -o structure_ALL -t 5 --pop ../structure_pop_file.tsv -fs /home/a1sriniv/.local/bin/fastStructure
date
echo
echo

echo -n "structure k=3 "
date
structure_threader run -Klist 3 -R 1 -i structure_ALL.pruned.bed -o structure_ALL -t 5 --pop ../structure_pop_file.tsv -fs /home/a1sriniv/.local/bin/fastStructure
date

echo -n "structure k=5 "
date
structure_threader run -Klist 5 -R 1 -i structure_ALL.pruned.bed -o structure_ALL -t 5 --pop ../structure_pop_file.tsv -fs /home/a1sriniv/.local/bin/fastStructure
date




