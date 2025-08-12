#!/bin/bash
#$ -cwd
#$ -V
#$ -l h_data=5G
#$ -l h_rt=00:10:00
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -N dadi_demog
#$ -t 10-800:10

SGE_TASK_ID=710

sample_size=$SGE_TASK_ID

# Dadi simulation
python fit_demographic_model.py ../Simulations/dadi_simulations/ThreeEpochBottleneck_${sample_size}.sfs ../Analysis/dadi_3EpB_${sample_size}/ --input_params 0.11259639 6.50865923 0.06243505 0.01393351

# MSPrime simulation
# python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_${sample_size}/
