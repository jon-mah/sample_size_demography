# Figure 4

[Figure 4](../Summary/figure_4.png) is comprised of several components.

Figure 1A decpits an example three-epoch demographic scenario with a small sample size. A coalescent tree is partitioned by epoch, yielding a distribution of branch lengths weighted towards the ancestral epoch. The resulting two-epoch inference captures a contraction.

Figure 1B depicts the same three-epoch demographic scenario with a larger sample size. the coalescent tree is still partitioned by epoch, but the greater number of samples now yields a distribution of branch lengths distributed towards the current epoch. The resulting two-epoch inference captures an expansion, despite being drawn from the same underlying ground truth simulation as 1A.

This figure was mostly made in Microsoft Powerpoint. Figure components can be found in [`../Summary/figures.pptx`](../Summary/figures.pptx). The example distribution of coalescent branch lengths was drawn from a linear regression of our real data.

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

## [`figure_4.R`](../Scripts/generate_figure_4.R)
  This `.R` script generates the example distribution of coalescent branch lengths and saves it to [`Summary/figure_4_output.svg`](../Summary/figure_4_output.svg).
