#!/bin/bash
#$ -N downsample_sfs.bash
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=15G
#$ -l h_rt=00:20:00

python downsample_sfs.py ../Data/p_copri_core_empirical_syn_sfs.txt 14 ../Analysis/p_copri_core_14
python downsample_sfs.py ../Data/p_copri_core_empirical_syn_sfs.txt 13 ../Analysis/p_copri_core_13
python downsample_sfs.py ../Data/p_copri_core_empirical_syn_sfs.txt 12 ../Analysis/p_copri_core_12
python downsample_sfs.py ../Data/p_copri_core_empirical_syn_sfs.txt 11 ../Analysis/p_copri_core_11
python downsample_sfs.py ../Data/p_copri_core_empirical_syn_sfs.txt 10 ../Analysis/p_copri_core_10
python downsample_sfs.py ../Data/p_copri_core_empirical_syn_sfs.txt 9 ../Analysis/p_copri_core_9
python downsample_sfs.py ../Data/p_copri_core_empirical_syn_sfs.txt 8 ../Analysis/p_copri_core_8
python downsample_sfs.py ../Data/p_copri_core_empirical_syn_sfs.txt 7 ../Analysis/p_copri_core_7
python downsample_sfs.py ../Data/p_copri_core_empirical_syn_sfs.txt 6 ../Analysis/p_copri_core_6
python downsample_sfs.py ../Data/p_copri_core_empirical_syn_sfs.txt 5 ../Analysis/p_copri_core_5

python downsample_sfs.py ../Data/p_copri_core_empirical_nonsyn_sfs.txt 14 ../Analysis/p_copri_core_14
python downsample_sfs.py ../Data/p_copri_core_empirical_nonsyn_sfs.txt 13 ../Analysis/p_copri_core_13
python downsample_sfs.py ../Data/p_copri_core_empirical_nonsyn_sfs.txt 12 ../Analysis/p_copri_core_12
python downsample_sfs.py ../Data/p_copri_core_empirical_nonsyn_sfs.txt 11 ../Analysis/p_copri_core_11
python downsample_sfs.py ../Data/p_copri_core_empirical_nonsyn_sfs.txt 10 ../Analysis/p_copri_core_10
python downsample_sfs.py ../Data/p_copri_core_empirical_nonsyn_sfs.txt 9 ../Analysis/p_copri_core_9
python downsample_sfs.py ../Data/p_copri_core_empirical_nonsyn_sfs.txt 8 ../Analysis/p_copri_core_8
python downsample_sfs.py ../Data/p_copri_core_empirical_nonsyn_sfs.txt 7 ../Analysis/p_copri_core_7
python downsample_sfs.py ../Data/p_copri_core_empirical_nonsyn_sfs.txt 6 ../Analysis/p_copri_core_6
python downsample_sfs.py ../Data/p_copri_core_empirical_nonsyn_sfs.txt 5 ../Analysis/p_copri_core_5
