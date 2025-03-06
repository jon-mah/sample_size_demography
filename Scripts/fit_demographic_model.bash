#!/bin/bash
#$ -cwd
#$ -V
#$ -l h_data=50G
#$ -l h_rt=72:00:00
#$ -l highp
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -N fit_updated_1KG_300
#$ -t 300

# SGE_TASK_ID=300

sample_size=$SGE_TASK_ID

# python fit_demographic_model.py ../Analysis/p_copri_core_${sample_size}/syn_downsampled_sfs.txt ../Analysis/p_copri_core_${sample_size}/
# python fit_demographic_model.py ../Analysis/1kg_EUR_${sample_size}/syn_downsampled_sfs.txt ../Analysis/1kg_EUR_${sample_size}/
# python fit_demographic_model.py ../Analysis/ooa_simulated_${sample_size}/syn_downsampled_sfs.txt ../Analysis/ooa_simulated_${sample_size}/
# python fit_demographic_model.py ../Analysis/gnomAD_${sample_size}/syn_downsampled_sfs.txt ../Analysis/gnomAD_${sample_size}/
python fit_demographic_model.py ../Data/1KG_2020/${sample_size}_syn_downsampled_sfs.txt ../Analysis/updated_1KG_EUR_${sample_size}/
