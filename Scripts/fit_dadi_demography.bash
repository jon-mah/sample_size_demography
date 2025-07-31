#!/bin/bash
#$ -cwd
#$ -V
#$ -l h_data=25G
#$ -l h_rt=4:00:00
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -N dadi_demog
#$ -t 10-800:10

SGE_TASK_ID=650

sample_size=$SGE_TASK_ID

# python fit_demographic_model.py ../Analysis/p_copri_core_${sample_size}/syn_downsampled_sfs.txt ../Analysis/p_copri_core_${sample_size}/
# python fit_demographic_model.py ../Analysis/1kg_EUR_${sample_size}/syn_downsampled_sfs.txt ../Analysis/1kg_EUR_${sample_size}/
# python fit_demographic_model.py ../Analysis/ooa_simulated_${sample_size}/syn_downsampled_sfs.txt ../Analysis/ooa_simulated_${sample_size}/
# python fit_demographic_model.py ../Analysis/gnomAD_${sample_size}/syn_downsampled_sfs.txt ../Analysis/gnomAD_${sample_size}/ --L_syn 7505993.0
# python fit_demographic_model.py ../Data/1KG_2020/${sample_size}_syn_downsampled_sfs.txt ../Analysis/1kg_EUR_2020_${sample_size}/

# Dadi simulation
python fit_demographic_model.py ../Simulations/dadi_simulations/ThreeEpochBottleneck_${sample_size}.sfs ../Analysis/dadi_3EpB_${sample_size}/

# MSPrime simulation
# python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_${sample_size}/
