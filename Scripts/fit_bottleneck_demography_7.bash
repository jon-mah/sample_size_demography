#!/bin/bash
#$ -cwd
#$ -V
#$ -l h_data=10G
#$ -l h_rt=1:00:00
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -N bottle_demog_7
#$ -t 10-800:10

SGE_TASK_ID=690

sample_size=$SGE_TASK_ID

# python fit_demographic_model.py ../Analysis/p_copri_core_${sample_size}/syn_downsampled_sfs.txt ../Analysis/p_copri_core_${sample_size}/
# python fit_demographic_model.py ../Analysis/1kg_EUR_${sample_size}/syn_downsampled_sfs.txt ../Analysis/1kg_EUR_${sample_size}/
# python fit_demographic_model.py ../Analysis/ooa_simulated_${sample_size}/syn_downsampled_sfs.txt ../Analysis/ooa_simulated_${sample_size}/
# python fit_demographic_model.py ../Analysis/gnomAD_${sample_size}/syn_downsampled_sfs.txt ../Analysis/gnomAD_${sample_size}/ --L_syn 7505993.0
# python fit_demographic_model.py ../Data/1KG_2020/${sample_size}_syn_downsampled_sfs.txt ../Analysis/1kg_EUR_2020_${sample_size}/

# Dadi simulation
# python fit_demographic_model.py ../Simulations/dadi_simulations/ThreeEpochBottleneck_${sample_size}.sfs ../Analysis/dadi_3EpB_${sample_size}/


# MSPrime simulation
# python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_${sample_size}/

# MSPrime Growth Contraction
# python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochGrowthContraction_${sample_size}_concat.sfs ../Analysis/msprime_3EpBGC_${sample_size}/ --model_type two_epoch

# MSPrime Bottleneck
# python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_1000_500_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_1000_500_${sample_size}/ --model_type one_epoch
# python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_1000_1000_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_1000_1000_${sample_size}/ --model_type one_epoch
# python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_1000_1500_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_1000_1500_${sample_size}/ --model_type one_epoch
# python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_1000_2000_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_1000_2000_${sample_size}/ --model_type one_epoch
# python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_500_2000_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_500_2000_${sample_size}/ --model_type one_epoch
# python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_1500_2000_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_1500_2000_${sample_size}/ --model_type one_epoch
# python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_2000_2000_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_2000_2000_${sample_size}/ --model_type two_epoch

# python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_100_50_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_100_50_${sample_size}/ --model_type two_epoch
# python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_100_100_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_100_100_${sample_size}/ --model_type two_epoch
# python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_100_150_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_100_150_${sample_size}/ --model_type two_epoch
# python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_100_200_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_100_200_${sample_size}/ --model_type two_epoch
# python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_50_200_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_50_200_${sample_size}/ --model_type two_epoch
# python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_150_200_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_150_200_${sample_size}/ --model_type two_epoch
python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_200_200_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_200_200_${sample_size}/ --model_type two_epoch
