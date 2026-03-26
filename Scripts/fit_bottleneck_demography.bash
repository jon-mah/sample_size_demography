#!/bin/bash
#$ -cwd
#$ -V
#$ -l h_data=30G
#$ -l h_rt=23:00:00
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -N bot_dem
#$ -t 10-800:10

# SGE_TASK_ID=200

sample_size=$SGE_TASK_ID

# MSPrime Bottleneck
python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_200_200_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_200_200_${sample_size}/ --model_type two_epoch
# python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_400_200_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_400_200_${sample_size}/ --model_type two_epoch
# python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_600_200_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_600_200_${sample_size}/ --model_type two_epoch
# python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_800_200_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_800_200_${sample_size}/ --model_type two_epoch
# python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_1000_200_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_1000_200_${sample_size}/ --model_type two_epoch
# python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_1200_200_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_1200_200_${sample_size}/ --model_type two_epoch
# python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_1400_200_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_1400_200_${sample_size}/ --model_type two_epoch
# python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_1600_200_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_1600_200_${sample_size}/ --model_type two_epoch

# python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_200_200_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_200_200_${sample_size}/ --model_type three_epoch
# python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_400_200_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_400_200_${sample_size}/ --model_type three_epoch
# python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_600_200_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_600_200_${sample_size}/ --model_type three_epoch
# python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_800_200_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_800_200_${sample_size}/ --model_type three_epoch
# python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_1000_200_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_1000_200_${sample_size}/ --model_type three_epoch
# python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_1200_200_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_1200_200_${sample_size}/ --model_type three_epoch
# python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_1400_200_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_1400_200_${sample_size}/ --model_type three_epoch
# python fit_demographic_model.py ../Simulations/simple_simulations/ThreeEpochBottleneck_1600_200_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_1600_200_${sample_size}/ --model_type three_epoch
