# Figure S3

[Figure S3](../Supplement/figure_s3.png) is comprised of two components.

Figure S3A depicts the proportion of SFS comprised of singletons, which serve as a proxy for rare variants. The x-axis depicts sample size while the y-axis depicts the proportion of singletons. The green line indicates simulated data using ∂a∂i while the black line indicates the standard neutral model (SNM)

Figure S3B depicts the ratio of the SFS comprised of singletons relative to the SNM. The x-axis depicts sample size while the y-axis depicts the ratio of singleton proportion relative to the SNM. The dotted black line indicates a ratio of 1; values above the line indicate that the ∂a∂i SFS has a greater proportion of singletons than the SNM while values below the line indicate a lesser proportion.

To recreate this figure, you must:

## [`dadi_simulations.bash`](../Scripts/dadi_simulations.bash)

This `.bash` script will run the following necessary python scripts.

### [`dadi_simulations.py`](../Scripts/dadi_simulations.py)

This `.py` script simulates the given three-epoch demographic scenario in `∂a∂i`.

## [`compute_sfs_summary_statistics.py`](../Scripts/compute_sfs_summary_statistics.py). 

This `.py` script computes a variety of SFS summary statistics.

## [`generate_supplemental_figures.R`](../Scripts/generate_supplemental_figures.R)
  This `.R` script generates Figure S1 and saves it to [`Supplement/figure_s3_output.svg`](../Supplement/figure_s3_output.svg).
