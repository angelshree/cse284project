# imports
import pandas as pd

# import full 1000 Genomes pop file and filter
igsr = "~/teams/group-4/project/1000GenomesAdmixture/igsr_samples.tsv"
igsr_df = pd.read_csv(igsr,sep='\t')
filtered_df = igsr_df[igsr_df['Data collections'].str.contains("phase 1", case=False, na=False)]
filtered_df = filtered_df.drop(["Sex", "Biosample ID", "Population name", "Population elastic ID", 
         "Superpopulation code","Superpopulation name"], axis=1)

# import past-pruning fam file to filter for correct subjects
fam = "~/teams/group-4/project/chr1.subjects.pruned.fam"
fam_df = pd.read_csv(fam,sep=' ', names=["Name1", "Name2", "a1", "a2", "a3", "a4"])

# extract all subjects present in fam file
correct_samples = fam_df["Name1"].tolist()

# filter 1000 Genomes sample list to only include samples in correct_samples
new = filtered_df[filtered_df['Sample name'].isin(correct_samples)]

# convert to correct population format for structure_threader
new = new.drop(["Sample name", "Data collections"], axis=1)
value_counts = new['Population code'].value_counts()

# Creating a new DataFrame for pop counts
counts_df = pd.DataFrame({'Population': value_counts.index, 'count': value_counts.values})
counts_df = counts_df.sort_values(by="Population", ascending=True)
counts_df['location'] = range(1, len(counts_df) + 1)
#counts_df['count'] = counts_df['count'].astype(int)
#counts_df['location'] = counts_df['location'].astype(int)

# export to csv
counts_df.to_csv('structure_pop_file.tsv', sep='\t', index=False)