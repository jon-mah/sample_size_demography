#!/bin/bash
#$ -cwd
#$ -V
#$ -l h_data=50G
#$ -l h_rt=4:00:00
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -N fit_3EpE
#$ -t 490

## -t 10-800:20

# SGE_TASK_ID=15

sample_size=$SGE_TASK_ID

# python fit_demographic_model.py ../Analysis/p_copri_core_${sample_size}/syn_downsampled_sfs.txt ../Analysis/p_copri_core_${sample_size}/
# python fit_demographic_model.py ../Analysis/1kg_EUR_${sample_size}/syn_downsampled_sfs.txt ../Analysis/1kg_EUR_${sample_size}/
# python fit_demographic_model.py ../Analysis/ooa_simulated_${sample_size}/syn_downsampled_sfs.txt ../Analysis/ooa_simulated_${sample_size}/
python fit_demographic_model.py ../Analysis/ThreeEpochExpansion_${sample_size}/syn_downsampled_sfs.txt ../Analysis/ThreeEpochExpansion_${sample_size}/
