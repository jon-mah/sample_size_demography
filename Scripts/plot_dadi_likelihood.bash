#!/bin/bash
#$ -cwd
#$ -V
#$ -N dadi_likelihood
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_rt=8:00:00
#$ -l highp
#$ -t 10-200:10

# SGE_TASK_ID=20

sample_size=$SGE_TASK_ID

## Tests

# python plot_likelihood.py ../Analysis/gnomAD_10/syn_downsampled_sfs.txt ../Analysis/gnomAD_10/two_epoch_demography.txt ../Analysis/gnomad_10/
# python plot_likelihood.py ../Analysis/gnomAD_20/syn_downsampled_sfs.txt ../Analysis/gnomAD_20/two_epoch_demography.txt ../Analysis/gnomad_20/
# python plot_likelihood.py ../Analysis/gnomAD_30/syn_downsampled_sfs.txt ../Analysis/gnomAD_30/two_epoch_demography.txt ../Analysis/gnomad_30/
# python plot_likelihood.py ../Analysis/${species}_downsampled_14/core_empirical_syn_downsampled_sfs.txt ../Analysis/${species}_downsampled_14/core_two_epoch_demography.txt ../Analysis/${species}_downsampled_14/core
# python plot_likelihood.py ../Analysis/${species}_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt ../Analysis/${species}_downsampled_14/accessory_two_epoch_demography.txt ../Analysis/${species}_downsampled_14/accessory
# python plot_likelihood.py ../HighRecombinationAnalysis/${species}/core_0.5_empirical_syn_14_downsampled_sfs.txt ../HighRecombinationAnalysis/${species}/core_0.5_two_epoch_demography.txt ../HighRecombinationAnalysis/${species}/
# python plot_likelihood.py ../SupplementaryAnalysis/${species}/core_empirical_syn_downsampled_sfs.txt ../SupplementaryAnalysis/${species}/two_epoch_demography.txt ../SupplementaryAnalysis/${species}/
# python plot_likelihood.py ../SupplementaryAnalysis/${species}/accessory_empirical_syn_downsampled_sfs.txt ../SupplementaryAnalysis/${species}/accessory_two_epoch_demography.txt ../SupplementaryAnalysis/${species}/accessory

## Dadi
python plot_likelihood.py ../Simulations/dadi_simulations/ThreeEpochBottleneck_${sample_size}.sfs ../Analysis/dadi_3EpB_${sample_size}/two_epoch_demography.txt ../Analysis/dadi_3EpB_${sample_size}/

## MSPrime
# python plot_likelihood.py ../Simulations/simple_simulations/ThreeEpochBottleneck_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_${sample_size}/two_epoch_demography.txt ../Analysis/msprime_3EpB_${sample_size}/
