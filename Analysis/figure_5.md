# Figure 5

[Figure 5](../Summary/figure_5.png) is comprised of two components.

Figure 5A depicts the proportion of SFS comprised of singletons, which serve as a proxy for rare variants. The x-axis depicts sample size while the y-axis depicts the proportion of singletons. The blue line indicates simulated data using MSPrime while the black line indicates the standard neutral model (SNM)

Figure 5B depicts the ratio of the SFS comprised of singletons relative to the SNM. The x-axis depicts sample size while the y-axis depicts the ratio of singleton proportion relative to the SNM. The dotted black line indicates a ratio of 1; values above the line indicate that the MSPrime SFS has a greater proportion of singletons than the SNM while values below the line indicate a lesser proportion.

To recreate this figure, you must:

## [`msprime_simulations.bash`](../Scripts/msprime_simulations.bash)

This `.bash` script will run the following necessary python scripts.

### [`generate_pops_file.py`](../Scripts/generate_pops_file.py) 

This `.py` script generates an intermediate file necessary for SFS calculation. 

### [`msprime_simulations.py`](../Scripts/msprime_simulations.py)

This `.py` script simulates the given three-epoch demographic scenario in `MSPrime`.

### `easySFS`

This script uses `easySFS` to compute the SFS from intermediate output `.vcf` files.

### [`concat_sfs.py`](../Scripts/concat.py)

## [`dadi_simulations.bash`](../Scripts/dadi_simulations.bash)

This `.bash` script will run the following necessary python scripts.

### [`dadi_simulations.py`](../Scripts/dadi_simulations.py)

This `.py` script simulates the given three-epoch demographic scenario in `∂a∂i`.

## [`compute_sfs_summary_statistics.py`](../Scripts/compute_sfs_summary_statistics.py). 

This `.py` script computes a variety of SFS summary statistics.

## [`figure_5.R`](../Scripts/figure_5.R)
  This `.R` script generates Figure 5 and saves it to [`Summary/figure_5_output.svg`](../Summary/figure_1_output.svg).
