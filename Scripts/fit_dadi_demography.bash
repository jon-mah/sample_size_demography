#!/bin/bash
#$ -cwd
#$ -V
#$ -l h_data=25G
#$ -l h_rt=2:00:00
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -N dadi_demog
#$ -t 590

# SGE_TASK_ID=740

sample_size=$SGE_TASK_ID

# Dadi simulation
python fit_demographic_model.py ../Simulations/dadi_simulations/ThreeEpochBottleneck_${sample_size}.sfs ../Analysis/dadi_3EpB_${sample_size}/

# MSPrime simulation
# python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_${sample_size}/
