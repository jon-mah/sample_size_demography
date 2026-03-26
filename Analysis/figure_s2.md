# Figure S2

[Figure S2](../Supplement/figure_s2.png) is comprised of several components.

Figure S2A shows the calculated value of Tajima's D for an SFS simulated using ∂a∂i. The x-axis depicts sample size while the y-axis shows Tajima's D. A dashed black line indicates a Tajima's D of 0; positive values indicate an excess of intermediate frequency alleles, i.e., a bottleneck or contraction, while negative values indicate an excess of rare alleles, i.e., an expansion.

Figure S2B shows the maximum likelihood inferred `nu` parameter from two-epoch demographic inference. The x-axis depicts sample size while the y-axis shows the ratio of current to ancestral population size. The dashed black line indicates a `nu` value of 1; values greater than 1 are expansions and values less than 1 are contractions. Shaded-in regions indicate the 95% confidence interval, approximated by a 3 log likelihood difference from the MLE.

Figure S2C shows the maximum likelihood inferred `tau` parameter from two-epoch demographic inference. The x-axis depicts sample size while the y-axis shows the inferred timing of the instantaneous size change, given in units of generations per 2 times the ancestral population size. Shaded-in regions indicate the 95% confidence interval, approximated by a 3 log likelihood difference from the MLE.

Figure S2D depicts a demographic model fit criterion comparing the three-epoch and two-epoch models (dark blue) as well as the two-epoch vs. one-epoch models (light blue). The x-axis depicts sample size while the y-axis depicts 2Lambda, where Lambda is defined as the difference in log likelihoods between a more complex model and a simpler model. At all sample sizes analyzed, the more complex models had a better fit to data than the less complex models.

Figure S2E depicts the effective population size between epochs. The x-axis depicts sample size while the y-axis shows the ratio of effective population size between epochs. The ancestral epoch has a ground truth population size of 10,000; the bottleneck epoch has a ground truth population size of 1,000; the current epoch has a ground truth population size of 50,000. At all but one sample size (n=10), the current epoch is inferred to have a greater population size than the bottleneck epoch (brown), while at all sample sizes, the bottleneck epoch is inferred to have a lesser population size than the ancestral epoch (yellow).



To recreate this figure, you must:

## [`dadi_simulations.bash`](../Scripts/dadi_simulations.bash)

This `.bash` script will run the following necessary python scripts.

### [`dadi_simulations.py`](../Scripts/dadi_simulations.py)

This `.py` script simulates the given three-epoch demographic scenario in `∂a∂i`.

## [`fit_demographic_model.bash`](../Scripts/fit_demographic_model.bash)

This `.bash` script is written to run [`fit_demographic_model.py`](../Scripts/fit_demographic_model.py). Note that the same bash script was used for multiple datasets for convenience; thus to recreate our analysis it is necessary to comment or uncomment the appropriate lines of the `.bash` script.

## [`plot_dadi_likelihood.bash`](../Scripts/plot_dadi_likelihood.bash)
This `.bash` script runs [`plot_likelihood.py`](../Scripts/plot_likelihood.py) to plot the likelihood surface of a given demographic model. This likelihood surface is used to calculate confidence intervals.

## [`compute_sfs_summary_statistics.bash`](../Scripts/compute_sfs_summary_statistics.bash)

This `.bash` script is written to run [`compute_sfs_summary_statistics.py`](../Scripts/compute_sfs_summary_statistics.py). Note that the same bash script was used for multiple datasets for convenience; thus to recreate our analysis it is necessary to comment or uncomment the appropriate lines of the `.bash script.

## [`generate_supplemental_figures.R`](../Scripts/generate_supplemental_figures.R)
  This `.R` script generates Figure S1 and saves it to [`Supplement/figure_s2_output.svg`](../Supplement/figure_s2_output.svg).
