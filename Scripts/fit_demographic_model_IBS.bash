#!/bin/bash
#$ -cwd
#$ -V
#$ -l h_data=25G
#$ -l h_rt=04:00:00
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -N fit_IBS
#$ -t 10-160:10

# SGE_TASK_ID=140

sample_size=$SGE_TASK_ID

python fit_demographic_model.py ../Analysis/1KG_IBS_${sample_size}/syn_downsampled_sfs.txt ../Analysis/1KG_IBS_${sample_size}/ --model_type three_epoch
