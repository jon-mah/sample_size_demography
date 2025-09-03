#!/bin/bash
#$ -cwd
#$ -V
#$ -l h_data=25G
#$ -l h_rt=1:00:00
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -N msprime_demog
#$ -t 640

# SGE_TASK_ID=640

sample_size=$SGE_TASK_ID

# Dadi simulation
# python fit_demographic_model.py ../Simulations/dadi_simulations/ThreeEpochBottleneck_${sample_size}.sfs ../Analysis/dadi_3EpB_${sample_size}/

# MSPrime simulation
python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_${sample_size}/ --model_type three_epoch --input_params 0.19569195 12.10035785  0.13661302  0.01363705
