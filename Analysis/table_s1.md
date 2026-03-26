# Table S1

[Table S1](../Supplement/table_s1.csv) describes the results of demographic inference from MSPrime simulated data.

Listed are the following: sample size, Tajima’s D, one-epoch log likelihood, one-epoch theta, 2Lambda between the two-epoch and one-epoch models, two-epoch log likelihood, two-epoch theta, two-epoch MLE demographic parameters Nu and Tau, 2Lambda between the three-epoch and two-epoch models, three-epoch log likelihood, three-epoch theta, three-epoch MLE demographic parameters of NuB, NuF, TauB, and TauF.

To recreate this table, you must:

## [`msprime_simulations.bash`](../Scripts/msprime_simulations.bash)

This `.bash` script will run the following necessary python scripts.

### [`generate_pops_file.py`](../Scripts/generate_pops_file.py) 

This `.py` script generates an intermediate file necessary for SFS calculation. 

### [`msprime_simulations.py`](../Scripts/msprime_simulations.py)

This `.py` script simulates the given three-epoch demographic scenario in `MSPrime`.

### `easySFS`

This script uses `easySFS` to compute the SFS from intermediate output `.vcf` files.

### [`concat_sfs.py`](../Scripts/concat.py)

This `.py` script concatenates the SFS output by easySFS into a singular file.

## [`fit_demographic_model.bash`](../Scripts/fit_demographic_model.bash)

This `.bash` script is written to run [`fit_demographic_model.py`](../Scripts/fit_demographic_model.py). Note that the same bash script was used for multiple datasets for convenience; thus to recreate our analysis it is necessary to comment or uncomment the appropriate lines of the `.bash` script.

## [`plot_msprime_likelihood.bash`](../Scripts/plot_msprime_likelihood.bash)
This `.bash` script runs [`plot_likelihood.py`](../Scripts/plot_likelihood.py) to plot the likelihood surface of a given demographic model. This likelihood surface is used to calculate confidence intervals.

## [`compute_sfs_summary_statistics.bash`](../Scripts/compute_sfs_summary_statistics.bash)

This `.bash` script is written to run [`compute_sfs_summary_statistics.py`](../Scripts/compute_sfs_summary_statistics.py). Note that the same bash script was used for multiple datasets for convenience; thus to recreate our analysis it is necessary to comment or uncomment the appropriate lines of the `.bash script.

## [`generate_supplemental_tables.R`](../Scripts/generate_supplemental_tables.R)
  This `.R` script generates Table S1 and saves it to [`Supplement/table_s1.csv`](../Supplement/table_s1.csv).
