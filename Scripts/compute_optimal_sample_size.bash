#!/bin/bash
#$ -N filter_vcf
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=15G
#$ -l h_rt=00:05:00

python compute_optimal_sample_size.py ../Data/two_epoch_contraction_demography.csv --target_sample_size 11 ../Analysis/optimal_sample_size_test/2epC_11
python compute_optimal_sample_size.py ../Data/two_epoch_expansion_demography.csv --target_sample_size 11 ../Analysis/optimal_sample_size_test/2epE_11
python compute_optimal_sample_size.py ../Data/three_epoch_contraction_demography.csv --target_sample_size 11 ../Analysis/optimal_sample_size_test/3epC_11
python compute_optimal_sample_size.py ../Data/three_epoch_expansion_demography.csv --target_sample_size 11 ../Analysis/optimal_sample_size_test/3epE_11
python compute_optimal_sample_size.py ../Data/three_epoch_bottleneck_demography.csv --target_sample_size 11 ../Analysis/optimal_sample_size_test/3epB_11

python compute_optimal_sample_size.py ../Data/two_epoch_contraction_demography.csv --target_sample_size 21 ../Analysis/optimal_sample_size_test/2epC_21
python compute_optimal_sample_size.py ../Data/two_epoch_expansion_demography.csv --target_sample_size 21 ../Analysis/optimal_sample_size_test/2epE_21
python compute_optimal_sample_size.py ../Data/three_epoch_contraction_demography.csv --target_sample_size 21 ../Analysis/optimal_sample_size_test/3epC_21
python compute_optimal_sample_size.py ../Data/three_epoch_expansion_demography.csv --target_sample_size 21 ../Analysis/optimal_sample_size_test/3epE_21
python compute_optimal_sample_size.py ../Data/three_epoch_bottleneck_demography.csv --target_sample_size 21 ../Analysis/optimal_sample_size_test/3epB_21

python compute_optimal_sample_size.py ../Data/two_epoch_contraction_demography.csv --target_sample_size 31 ../Analysis/optimal_sample_size_test/2epC_31
python compute_optimal_sample_size.py ../Data/two_epoch_expansion_demography.csv --target_sample_size 31 ../Analysis/optimal_sample_size_test/2epE_31
python compute_optimal_sample_size.py ../Data/three_epoch_contraction_demography.csv --target_sample_size 31 ../Analysis/optimal_sample_size_test/3epC_31
python compute_optimal_sample_size.py ../Data/three_epoch_expansion_demography.csv --target_sample_size 31 ../Analysis/optimal_sample_size_test/3epE_31
python compute_optimal_sample_size.py ../Data/three_epoch_bottleneck_demography.csv --target_sample_size 31 ../Analysis/optimal_sample_size_test/3epB_31
