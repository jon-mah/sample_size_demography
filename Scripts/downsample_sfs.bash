#!/bin/bash
#$ -N downsample_sfs.bash
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=15G
#$ -l h_rt=00:10:00
#$ -t 10-800:10
#$ -tc 25

SGE_TASK_ID=10

sample_size=$SGE_TASK_ID

# P. copri
# python downsample_sfs.py ../Data/p_copri_core_empirical_syn_sfs.txt ${sample_size} ../Analysis/p_copri_core_${sample_size}/syn
# python downsample_sfs.py ../Data/p_copri_core_empirical_nonsyn_sfs.txt ${sample_size} ../Analysis/p_copri_core_${sample_size}/nonsyn

# 1000Genomes EUR data
# python downsample_sfs.py ../Data/kim_et_al_2017_1kg_syn.txt ${sample_size} ../Analysis/1kg_EUR_${sample_size}/syn
# python downsample_sfs.py ../Data/kim_et_al_2017_1kg_nonsyn.txt ${sample_size} ../Analysis/1kg_EUR_${sample_size}/nonsyn

# gnomAD EUR data
python downsample_sfs.py ../Data/gnomAD_empirical_syn_sfs.txt ${sample_size} ../Analysis/gnomAD_${sample_size}/syn


# Simulated Tennessen data
# python downsample_sfs.py ../Simulations/ooa_864_sfs/dadi/pop1.sfs ${sample_size} ../Analysis/ooa_simulated_${sample_size}/syn

# Simple simulations
# python downsample_sfs.py ../Simulations/simple_simulations/TwoEpochContraction_concat.sfs ${sample_size} ../Analysis/TwoEpochContraction_${sample_size}/syn
# python downsample_sfs.py ../Simulations/simple_simulations/ThreeEpochContraction_concat.sfs ${sample_size} ../Analysis/ThreeEpochContraction_${sample_size}/syn
# python downsample_sfs.py ../Simulations/simple_simulations/TwoEpochExpansion_concat.sfs ${sample_size} ../Analysis/TwoEpochExpansion_${sample_size}/syn
# python downsample_sfs.py ../Simulations/simple_simulations/ThreeEpochExpansion_concat.sfs ${sample_size} ../Analysis/ThreeEpochExpansion_${sample_size}/syn
# python downsample_sfs.py ../Simulations/simple_simulations/ThreeEpochBottleneck_concat.sfs ${sample_size} ../Analysis/ThreeEpochBottleneck_${sample_size}/syn
