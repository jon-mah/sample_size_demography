#!/bin/bash
#$ -N downsample_sfs.bash
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=15G
#$ -l h_rt=00:10:00
#$ -t 10-800:20

# SGE_TASK_ID=10

sample_size=$SGE_TASK_ID

# P. copri
# python downsample_sfs.py ../Data/p_copri_core_empirical_syn_sfs.txt ${sample_size} ../Analysis/p_copri_core_${sample_size}/syn
# python downsample_sfs.py ../Data/p_copri_core_empirical_nonsyn_sfs.txt ${sample_size} ../Analysis/p_copri_core_${sample_size}/nonsyn

# 1000Genomes EUR data
python downsample_sfs.py ../Data/kim_et_al_2017_1kg_syn.txt ${sample_size} ../Analysis/1kg_EUR_${sample_size}/syn
python downsample_sfs.py ../Data/kim_et_al_2017_1kg_nonsyn.txt ${sample_size} ../Analysis/1kg_EUR_${sample_size}/nonsyn
