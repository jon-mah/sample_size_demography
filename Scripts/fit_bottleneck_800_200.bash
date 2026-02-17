#!/bin/bash
#$ -cwd
#$ -V
#$ -l h_data=30G
#$ -l h_rt=23:00:00
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -N fit_800_200
#$ -t 800

# SGE_TASK_ID=90

sample_size=$SGE_TASK_ID

python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_800_200_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_800_200_${sample_size}/ --model_type three_epoch
