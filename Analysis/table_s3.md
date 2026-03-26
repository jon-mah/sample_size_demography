# Table S3

[Table S3](../Supplement/table_s3.csv) describes singleton proportion and ratio relative the standard neutral model for both MSPrime and dadi-simulated SFS.

Listed are the sample size, the SNM singleton proportion, the MSPrime singleton proportion, the ratio of MSPrime singletons to SNM singletons, the difference in proportion between the MSPrime SFS and the SNM, the ∂a∂i singleton proportion, the ratio of ∂a∂i singletons to SNM singletons, and the difference in proportion between the ∂a∂i SFS and the SNM.

To recreate this figure, you must:

## [`dadi_simulations.bash`](../Scripts/dadi_simulations.bash)

This `.bash` script will run the following necessary python scripts.

### [`dadi_simulations.py`](../Scripts/dadi_simulations.py)

This `.py` script simulates the given three-epoch demographic scenario in `∂a∂i`.

## [`compute_sfs_summary_statistics.py`](../Scripts/compute_sfs_summary_statistics.py). 

This `.py` script computes a variety of SFS summary statistics.

## [`generate_supplemental_tables.R`](../Scripts/generate_supplemental_tables.R)
  This `.R` script generates Table S3 and saves it to [`Supplement/table_s3.csv`](../Supplement/table_s3.csv).