#!/bin/bash
#$ -N downsample_sfs.bash
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=1G
#$ -l h_rt=00:10:00
#$ -t 11-1001:10

# SGE_TASK_ID=10

sample_size=$SGE_TASK_ID

# Simple simulations
# python compute_sfs_summary_statistics.py ../Simulations/simple_simulations/TwoEpochContraction_${sample_size}_concat.sfs ../Simulations/simple_simulations/TwoEpochContraction_${sample_size}_concat
# python compute_sfs_summary_statistics.py ../Simulations/simple_simulations/ThreeEpochContraction_${sample_size}_concat.sfs ../Simulations/simple_simulations/ThreeEpochContraction_${sample_size}_concat
# python compute_sfs_summary_statistics.py ../Simulations/simple_simulations/TwoEpochExpansion_${sample_size}_concat.sfs ../Simulations/simple_simulations/TwoEpochExpansion_${sample_size}_concat
# python compute_sfs_summary_statistics.py ../Simulations/simple_simulations/ThreeEpochExpansion_${sample_size}_concat.sfs ../Simulations/simple_simulations/ThreeEpochExpansion_${sample_size}_concat
# python compute_sfs_summary_statistics.py ../Simulations/simple_simulations/ThreeEpochBottleneck_${sample_size}_concat.sfs ../Simulations/simple_simulations/ThreeEpochBottleneck_${sample_size}_concat

# Lynch theoretical SFS
python compute_sfs_summary_statistics.py ../Analysis/optimal_sample_size_test/2epC_${sample_size}_expected_sfs.txt ../Analysis/optimal_sample_size_test/2epC_${sample_size}
python compute_sfs_summary_statistics.py ../Analysis/optimal_sample_size_test/2epE_${sample_size}_expected_sfs.txt ../Analysis/optimal_sample_size_test/2epE_${sample_size}
python compute_sfs_summary_statistics.py ../Analysis/optimal_sample_size_test/3epC_${sample_size}_expected_sfs.txt ../Analysis/optimal_sample_size_test/3epC_${sample_size}
python compute_sfs_summary_statistics.py ../Analysis/optimal_sample_size_test/3epE_${sample_size}_expected_sfs.txt ../Analysis/optimal_sample_size_test/3epE_${sample_size}
python compute_sfs_summary_statistics.py ../Analysis/optimal_sample_size_test/3epB_${sample_size}_expected_sfs.txt ../Analysis/optimal_sample_size_test/3epB_${sample_size}
