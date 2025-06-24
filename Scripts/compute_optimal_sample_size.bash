#!/bin/bash
#$ -N compute_optimal_sample_size.bash
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=15G
#$ -l h_rt=00:05:00
#$ -t 11-1001:10

# sample_size=$SGE_TASK_ID

sample_size=751

# Simple demographic histories
# python compute_optimal_sample_size.py ../Data/two_epoch_contraction_demography.csv --target_sample_size ${sample_size} ../Analysis/optimal_sample_size_test/2epC_${sample_size}
# python compute_optimal_sample_size.py ../Data/two_epoch_expansion_demography.csv --target_sample_size ${sample_size} ../Analysis/optimal_sample_size_test/2epE_${sample_size}
# python compute_optimal_sample_size.py ../Data/three_epoch_contraction_demography.csv --target_sample_size ${sample_size} ../Analysis/optimal_sample_size_test/3epC_${sample_size}
# python compute_optimal_sample_size.py ../Data/three_epoch_expansion_demography.csv --target_sample_size ${sample_size} ../Analysis/optimal_sample_size_test/3epE_${sample_size}
# python compute_optimal_sample_size.py ../Data/three_epoch_bottleneck_demography.csv --target_sample_size ${sample_size} ../Analysis/optimal_sample_size_test/3epB_${sample_size}

# Complex demographic histories
# python compute_optimal_sample_size.py ../Data/tennessen_demography.csv --target_sample_size ${sample_size} ../Analysis/optimal_sample_size_test/tennessen_${sample_size}
# python compute_optimal_sample_size.py ../Data/1000_1000_bottleneck_demography.csv --target_sample_size ${sample_size} ../Analysis/optimal_sample_size_test/1000_1000_bottleneck_${sample_size}
python compute_optimal_sample_size.py ../Data/2000_2000_bottleneck_demography.csv --target_sample_size ${sample_size} ../Analysis/optimal_sample_size_test/2000_2000_bottleneck_${sample_size}
