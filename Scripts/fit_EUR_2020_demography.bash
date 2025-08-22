#!/bin/bash
#$ -cwd
#$ -V
#$ -l h_data=50G
#$ -l h_rt=72:00:00
#$ -l highp
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -N EUR_demog
#$ -t 200-300:10

# SGE_TASK_ID=10

sample_size=$SGE_TASK_ID

# Dadi simulation
# python fit_demographic_model.py ../Simulations/dadi_simulations/ThreeEpochBottleneck_${sample_size}.sfs ../Analysis/dadi_3EpB_${sample_size}/

# MSPrime simulation
# python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_${sample_size}/

# 1KG EUR 2020
python fit_demographic_model.py ../Analysis/1kg_EUR_2020_${sample_size}/syn_downsampled_sfs.txt ../Analysis/1kg_EUR_2020_${sample_size}/ --sum_alleles --model_type two_epoch
