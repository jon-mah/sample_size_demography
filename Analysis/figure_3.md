# Figure 3

[Figure 3](../Summary/figure_3.png) is comprised of two components.

Figure 3A shows the proportion of coalescent events that occur in each epoch. The x-axis depicts sample size while the y-axis depicts the proportion of coalescent events. Purple points indicate the ancestral epoch, orange points indicate the bottleneck epoch, and green points indicate the current epoch. Closed points indicate sample sizes for which the dominant evolutionary signal was a contraction, while open points indicate expansions.

Figure 3B shows the proportion of coalescent branch length per epoch. The x-axis depicts sample size while the y-axis depicts the proportion of total branch length. Points are color-coded and filled in per the same scheme as figure 3A. Of note, the point tat which the current epoch overtakes the bottleneck epoch in total coalescent branch length approximately coincides with the shift in dominant evolutionary signal.

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

## [`figure_3.R`](../Scripts/figure_3.R)
This `.R` script generates Figure 3 and saves it to [`Summary/figure_3_output.svg`](../Summary/figure_3_output.svg).
