#!/bin/bash
#$ -cwd
#$ -V
#$ -l h_data=30G
#$ -l h_rt=2:00:00
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -N fit_demographic_model
#$ -t 10-100

## -t 10-800:20

# SGE_TASK_ID=530

sample_size=$SGE_TASK_ID

# python fit_demographic_model.py ../Analysis/p_copri_core_${sample_size}/syn_downsampled_sfs.txt ../Analysis/p_copri_core_${sample_size}/
python fit_demographic_model.py ../Analysis/1kg_EUR_${sample_size}/syn_downsampled_sfs.txt ../Analysis/1kg_EUR_${sample_size}/
