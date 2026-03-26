# Figure 6

[Figure 6](../Summary/figure_6.png) is comprised of several components.

Figure 6A shows the calculated value of Tajima's D for an SFS computed from empirical human whole-genome data. The x-axis depicts sample size while the y-axis shows Tajima's D. A dashed black line indicates a Tajima's D of 0; positive values indicate an excess of intermediate frequency alleles, i.e., a bottleneck or contraction, while negative values indicate an excess of rare alleles, i.e., an expansion.

Figure 6B shows the maximum likelihood inferred `nu` parameter from two-epoch demographic inference. The x-axis depicts sample size while the y-axis shows the ratio of current to ancestral population size. The dashed black line indicates a `nu` value of 1; values greater than 1 are expansions and values less than 1 are contractions. Shaded-in regions indicate the 95% confidence interval, approximated by a 3 log likelihood difference from the MLE.

Figure 6C shows the maximum likelihood inferred `tau` parameter from two-epoch demographic inference. The x-axis depicts sample size while the y-axis shows the inferred timing of the instantaneous size change, given in units of generations per 2 times the ancestral population size. Shaded-in regions indicate the 95% confidence interval, approximated by a 3 log likelihood difference from the MLE.

Figure 6D depicts a demographic model fit criterion comparing the three-epoch and two-epoch models (blue) as well as the two-epoch vs. one-epoch models (yellow). The x-axis depicts sample size while the y-axis depicts 2Lambda, where Lambda is defined as the difference in log likelihoods between a more complex model and a simpler model. At all sample sizes analyzed, the more complex models had a better fit to data than the less complex models.

Figure 6E depicts the effective population size between epochs. The x-axis depicts sample size while the y-axis shows the ratio of effective population size between epochs. At all sizes, the current epoch is inferred to have a greater population size than the bottleneck epoch (yellow), and the bottleneck epoch is inferred to have a lesser population size than the ancestral epoch (blue).

To recreate this figure, you must:

## [`run_chen_lu_sfs.bash`](../Scripts/run_chen_lu_sfs.bash)
This `.bash` script calls the following bash script with appropriate environment variables:

### [`uti_human_snps_SFS.bash`](../Scripts/uti_human_snps_SFS.bash)
This `.bash` script performs the following steps in order:

* Generate the whole chromosome, unmasked, biallelic `.vcf` file for each chromosome.
* Remove monomorphic sites whilst retaining snps.
* Filter to retain only biallelic snps.
* Filter to retain only masked biallelic snps

## [`filter_vep.bash`](../Scripts/filter_vep.bash)
This `.bash` script filters a `.vcf` file using `VEP` with the `--ontology` and `--filter` flags to ensure that only variants with verbatim synonymous and nonsynonymous indicators are retained.

## [`vcf_to_sfs.bash`](../vcf_to_sfs.bash)
This `.bash` script converts `.vcf` files to SFS.

## [`downsample_sfs.bash`](../Scripts/downsample_sfs.bash)
This `.bash` script downsamples an SFS using a hypergeometric distribution. Note that the same bash script was used for multiple datasets for convenience; thus to recreate our analysis it is necessary to comment or uncomment the appropriate lines of the `.bash` script.

## [`fit_EUR_2020_demography.bash`](../Scripts/fit_EUR_2020_demography.bash)
This `.bash` script is written to run [`fit_demographic_model.py`](../Scripts/fit_demographic_model.py). Note that the same bash script was used for multiple datasets for convenience; thus to recreate our analysis it is necessary to comment or uncomment the appropriate lines of the `.bash` script.

## [`plot_EUR_likelihood.bash`](../Scripts/plot_EUR_likelihood.bash)
This `.bash` script runs [`plot_likelihood.py`](../Scripts/plot_likelihood.py) to plot the likelihood surface of a given demographic model. This likelihood surface is used to calculate confidence intervals.

## [`figure_6.R`](../Scripts/figure_6.R)
  This `.R` script generates Figure 6 and saves it to [`Summary/figure_6_output.svg`](../Summary/figure_6_output.svg).
