# Table S4

[Table S4](../Supplement/table_s4.csv) describes the results of demographic inference from ∂a∂i simulated data.

Listed are the following: sample size, Tajima’s D, one-epoch log likelihood, one-epoch theta, 2Lambda between the two-epoch and one-epoch models, two-epoch log likelihood, two-epoch theta, two-epoch MLE demographic parameters Nu and Tau, 2Lambda between the three-epoch and two-epoch models, three-epoch log likelihood, three-epoch theta, three-epoch MLE demographic parameters of NuB, NuF, TauB, and TauF.

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

## [`generate_supplemental_tables.R`](../Scripts/generate_supplemental_tables.R)
  This `.R` script generates Table S4 and saves it to [`Supplement/table_s4.csv`](../Supplement/table_s4.csv).