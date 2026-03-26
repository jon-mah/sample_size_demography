# Figure 2

[Figure 2](../Summary/figure_2.png) is comprised of several components.

Figure 2A shows the calculated value of Tajima's D for an SFS simulated using MSPrime. The x-axis depicts sample size while the y-axis shows Tajima's D. A dashed black line indicates a Tajima's D of 0; positive values indicate an excess of intermediate frequency alleles, i.e., a bottleneck or contraction, while negative values indicate an excess of rare alleles, i.e., an expansion.

Figure 2B shows the maximum likelihood inferred `nu` parameter from two-epoch demographic inference. The x-axis depicts sample size while the y-axis shows the ratio of current to ancestral population size. The dashed black line indicates a `nu` value of 1; values greater than 1 are expansions and values less than 1 are contractions. Shaded-in regions indicate the 95% confidence interval, approximated by a 3 log likelihood difference from the MLE.

Figure 2C shows the maximum likelihood inferred `tau` parameter from two-epoch demographic inference. The x-axis depicts sample size while the y-axis shows the inferred timing of the instantaneous size change, given in units of generations per 2 times the ancestral population size. Shaded-in regions indicate the 95% confidence interval, approximated by a 3 log likelihood difference from the MLE.

Figure 2D depicts a demographic model fit criterion comparing the three-epoch and two-epoch models (pink) as well as the two-epoch vs. one-epoch models (purple). The x-axis depicts sample size while the y-axis depicts 2Lambda, where Lambda is defined as the difference in log likelihoods between a more complex model and a simpler model. At all sample sizes analyzed, the more complex models had a better fit to data than the less complex models.

Figure 2E depicts the effective population size between epochs. The x-axis depicts sample size while the y-axis shows the ratio of effective population size between epochs. The ancestral epoch has a ground truth population size of 10,000; the bottleneck epoch has a ground truth population size of 1,000; the current epoch has a ground truth population size of 50,000. At all sizes, the current epoch is inferred to have a greater population size than the bottleneck epoch (dark green), and the bottleneck epoch is inferred to have a lesser population size than the ancestral epoch (light green).


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

This `.py` script concatenates the SFS output by easySFS into a singular file.

## [`fit_demographic_model.bash`](../Scripts/fit_demographic_model.bash)

This `.bash` script is written to run [`fit_demographic_model.py`](../Scripts/fit_demographic_model.py). Note that the same bash script was used for multiple datasets for convenience; thus to recreate our analysis it is necessary to comment or uncomment the appropriate lines of the `.bash` script.

## [`plot_msprime_likelihood.bash`](../Scripts/plot_msprime_likelihood.bash)
This `.bash` script runs [`plot_likelihood.py`](../Scripts/plot_likelihood.py) to plot the likelihood surface of a given demographic model. This likelihood surface is used to calculate confidence intervals.

## [`compute_sfs_summary_statistics.bash`](../Scripts/compute_sfs_summary_statistics.bash)

This `.bash` script is written to run [`compute_sfs_summary_statistics.py`](../Scripts/compute_sfs_summary_statistics.py). Note that the same bash script was used for multiple datasets for convenience; thus to recreate our analysis it is necessary to comment or uncomment the appropriate lines of the `.bash script.

## [`figure_2.R`](../Scripts/figure_2.R)

This `.R` script generates Figure 2 and saves it to [`Summary/figure_2_output.svg`](../Summary/figure_2_output.svg).
