# Table S2

[Table S2](../Supplement/table_s2.csv) describes the coalescent summary statistics of our modulated bottleneck simulations depicted in [Figure S1](../Supplement/figure_s1.png).

Listed are the sample size, and then respectively the outcome of two-epoch demographic inference (contraction vs. expansion), followed by the proportion of branch lengths contributed by the ancestral, bottleneck, and current epochs for each set of simulations. Simulations are denoted as “[Anc, X00, 200]”, where “X00” indicates the timing of the bottleneck for that set of simulations.

To recreate this figure, you must:

## [`msprime_bottleneck_simulations.bash`](../Scripts/msprime_bottleneck_simulations.bash)

This `.bash` script will run the following necessary python scripts.

### [`generate_pops_file.py`](../Scripts/generate_pops_file.py) 

This `.py` script generates an intermediate file necessary for SFS calculation. 

### [`msprime_bottleneck_simulations.py`](../Scripts/msprime_simulations.py)

This `.py` script simulates eight different three-epoch demographic scenarios in `MSPrime`, each with an altered bottleneck timing.

### `easySFS`

This script uses `easySFS` to compute the SFS from intermediate output `.vcf` files.

## [`msprime_bottleneck_concat.bash](msprime_bottleneck_concat.bash)
This `.bash` script makes several calls to [`concat_sfs.py`](../Scripts/concat.py) in order to concatenate the SFS output by easySFS into a singular file for each demographic scenario and sample size.

## [`fit_bottleneck_demography.bash`](../Scripts/fit_bottleneck_demography.bash)

This `.bash` script is written to run [`fit_demographic_model.py`](../Scripts/fit_demographic_model.py). Note that the same bash script was used for multiple datasets for convenience; thus to recreate our analysis it is necessary to comment or uncomment the appropriate lines of the `.bash` script.

## [`generate_supplemental_tables.R`](../Scripts/generate_supplemental_tables.R)
  This `.R` script generates Table S2 and saves it to [`Supplement/table_s2.csv`](../Supplement/table_s2.csv).