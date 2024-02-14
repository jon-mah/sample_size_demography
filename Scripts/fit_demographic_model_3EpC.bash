#!/bin/bash
#$ -cwd
#$ -V
#$ -l h_data=50G
#$ -l h_rt=4:00:00
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -N fit_3EpC
#$ -t 170

## -t 10-800:20

SGE_TASK_ID=170

sample_size=$SGE_TASK_ID

# python fit_demographic_model.py ../Analysis/p_copri_core_${sample_size}/syn_downsampled_sfs.txt ../Analysis/p_copri_core_${sample_size}/
# python fit_demographic_model.py ../Analysis/1kg_EUR_${sample_size}/syn_downsampled_sfs.txt ../Analysis/1kg_EUR_${sample_size}/
# python fit_demographic_model.py ../Analysis/ooa_simulated_${sample_size}/syn_downsampled_sfs.txt ../Analysis/ooa_simulated_${sample_size}/
python fit_demographic_model.py ../Analysis/ThreeEpochContraction_${sample_size}/syn_downsampled_sfs.txt ../Analysis/ThreeEpochContraction_${sample_size}/
