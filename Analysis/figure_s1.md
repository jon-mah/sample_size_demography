# Figure S1

[Figure S1](../Supplement/figure_s1.png) is comprised of several components.

On each subfigure, the x-axis depicts the sample size while the y-axis depicts the proportion of coalescent branch length per epoch. Purple points indicate the ancestral epoch, orange points indicate the bottleneck epoch, and green points indicate the current epoch. Closed points indicate an inferred two-epoch demographic contraction, while open points indicate an expansion. Figures S1A through S1H display an altered bottleneck timing of 400, 600, 800, 1000, 1200, 1400, 1600, and 1800 generations ago; whereas the originally simulated scenario displayed a bottleneck 2,000 generations ago.

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

## [`generate_supplemental_figures.R`](../Scripts/generate_supplemental_figures.R)
  This `.R` script generates Figure S1 and saves it to [`Supplement/figure_s1_output.svg`](../Supplement/figure_s1_output.svg).
