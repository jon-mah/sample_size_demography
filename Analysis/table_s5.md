# Table S5

[Table S5](../Supplement/table_s5.csv) describes the results of demographic inference from empirical data.

Listed are the following: sample size, Tajima’s D, one-epoch log likelihood, one-epoch theta, 2Lambda between the two-epoch and one-epoch models, two-epoch log likelihood, two-epoch theta, two-epoch MLE demographic parameters Nu and Tau, 2Lambda between the three-epoch and two-epoch models, three-epoch log likelihood, three-epoch theta, three-epoch MLE demographic parameters of NuB, NuF, TauB, and TauF.

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


## [`generate_supplemental_tables.R`](../Scripts/generate_supplemental_tables.R)
  This `.R` script generates Table S5 and saves it to [`Supplement/table_s5.csv`](../Supplement/table_s5.csv).