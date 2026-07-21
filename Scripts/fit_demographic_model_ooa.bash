#!/bin/bash
#$ -cwd
#$ -V
#$ -l h_data=50G
#$ -l h_rt=4:00:00
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -N fit_ooa
#$ -t 10-800:10

SGE_TASK_ID=770

sample_size=$SGE_TASK_ID

python fit_demographic_model.py ../Simulations/tennessen/ooa_${sample_size}_sfs/dadi/pop1.sfs ../Analysis/tennessen_ooa_${sample_size}/ --model_type two_epoch
