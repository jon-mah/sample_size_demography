#!/bin/bash
#$ -cwd
#$ -V
#$ -N msprime_likelihood
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_rt=10:00:00
#$ -l h_data=30G
#$ -t 780

# 620, 720, 780
# SGE_TASK_ID=20

sample_size=$SGE_TASK_ID

## Tests

## Dadi
# python plot_likelihood.py ../Simulations/dadi_simulations/ThreeEpochBottleneck_${sample_size}.sfs ../Analysis/dadi_3EpB_${sample_size}/two_epoch_demography.txt ../Analysis/dadi_3EpB_${sample_size}/

## MSPrime
python plot_likelihood.py ../Simulations/simple_simulations/ThreeEpochBottleneck_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_${sample_size}/two_epoch_demography.txt ../Analysis/msprime_3EpB_${sample_size}/
