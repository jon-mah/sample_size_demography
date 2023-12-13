#!/bin/bash
#$ -cwd
#$ -V
#$ -l h_data=30G
#$ -l h_rt=2:00:00
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -N fit_demographic_model
#$ -t 5

# SGE_TASK_ID=5

sample_size=$SGE_TASK_ID

python fit_demographic_model.py ../Analysis/p_copri_core_${sample_size}/syn_downsampled_sfs.txt ../Analysis/p_copri_core_${sample_size}/
