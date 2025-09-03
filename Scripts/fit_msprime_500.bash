#!/bin/bash
#$ -cwd
#$ -V
#$ -l h_data=25G
#$ -l h_rt=1:00:00
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -N msprime_demog
#$ -t 500

# SGE_TASK_ID=640

sample_size=$SGE_TASK_ID

# Dadi simulation
# python fit_demographic_model.py ../Simulations/dadi_simulations/ThreeEpochBottleneck_${sample_size}.sfs ../Analysis/dadi_3EpB_${sample_size}/

# MSPrime simulation
python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_${sample_size}/ --model_type three_epoch --input_params 2.95100240e-01 2.19839647e+01 1.13185579e-01 1.77089779e-02
