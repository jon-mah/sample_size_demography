#!/bin/bash
#$ -N sfs_summary_statistics
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=1G
#$ -l h_rt=00:10:00
#$ -t 10-300:10

# SGE_TASK_ID=10

sample_size=$SGE_TASK_ID

## 1KG EUR 2020
python compute_sfs_summary_statistics.py ../Analysis/1kg_EUR_2020_${sample_size}/syn_downsampled_sfs.txt ../Analysis/1kg_EUR_2020_${sample_size}/syn_downsampled_sfs

## Simple simulations
# python compute_sfs_summary_statistics.py ../Simulations/simple_simulations/TwoEpochContraction_${sample_size}_concat.sfs ../Simulations/simple_simulations/TwoEpochContraction_${sample_size}_concat
# python compute_sfs_summary_statistics.py ../Simulations/simple_simulations/ThreeEpochContraction_${sample_size}_concat.sfs ../Simulations/simple_simulations/ThreeEpochContraction_${sample_size}_concat
# python compute_sfs_summary_statistics.py ../Simulations/simple_simulations/TwoEpochExpansion_${sample_size}_concat.sfs ../Simulations/simple_simulations/TwoEpochExpansion_${sample_size}_concat
# python compute_sfs_summary_statistics.py ../Simulations/simple_simulations/ThreeEpochExpansion_${sample_size}_concat.sfs ../Simulations/simple_simulations/ThreeEpochExpansion_${sample_size}_concat
# python compute_sfs_summary_statistics.py ../Simulations/simple_simulations/ThreeEpochBottleneck_${sample_size}_concat.sfs ../Simulations/simple_simulations/ThreeEpochBottleneck_${sample_size}_concat
# python compute_sfs_summary_statistics.py ../Simulations/simple_simulations/ThreeEpochBottleneck_1000_1000_${sample_size}_concat.sfs ../Simulations/simple_simulations/ThreeEpochBottleneck_1000_1000_${sample_size}_concat
# python compute_sfs_summary_statistics.py ../Simulations/simple_simulations/ThreeEpochBottleneck_2000_2000_${sample_size}_concat.sfs ../Simulations/simple_simulations/ThreeEpochBottleneck_2000_2000_${sample_size}_concat
# python compute_sfs_summary_statistics.py ../Simulations/simple_simulations/ThreeEpochBottleneck_${sample_size}_concat.sfs ../Analysis/msprime_3EpB_${sample_size}/

## Lynch theoretical SFS
# python compute_sfs_summary_statistics.py ../Simulations/lynch_theory/TwoEpochContraction_${sample_size}_expected_sfs.txt ../Simulations/lynch_theory/TwoEpochContraction_${sample_size}
# python compute_sfs_summary_statistics.py ../Simulations/lynch_theory/TwoEpochExpansion_${sample_size}_expected_sfs.txt ../Simulations/lynch_theory/TwoEpochExpansion_${sample_size}
# python compute_sfs_summary_statistics.py ../Simulations/lynch_theory/ThreeEpochContraction_${sample_size}_expected_sfs.txt ../Simulations/lynch_theory/ThreeEpochContraction_${sample_size}
# python compute_sfs_summary_statistics.py ../Simulations/lynch_theory/ThreeEpochExpansion_${sample_size}_expected_sfs.txt ../Simulations/lynch_theory/ThreeEpochExpansion_${sample_size}
# python compute_sfs_summary_statistics.py ../Simulations/lynch_theory/ThreeEpochBottleneck_${sample_size}_expected_sfs.txt ../Simulations/lynch_theory/ThreeEpochBottleneck_${sample_size}
# python compute_sfs_summary_statistics.py ../Simulations/lynch_theory/tennessen_${sample_size}_expected_sfs.txt ../Simulations/lynch_theory/tennessen_${sample_size}

## Dadi simulations
# python compute_sfs_summary_statistics.py ../Simulations/dadi_simulations/TwoEpochContraction_${sample_size}.sfs ../Simulations/dadi_simulations/TwoEpochContraction_${sample_size}
# python compute_sfs_summary_statistics.py ../Simulations/dadi_simulations/ThreeEpochContraction_${sample_size}.sfs ../Simulations/dadi_simulations/ThreeEpochContraction_${sample_size}
# python compute_sfs_summary_statistics.py ../Simulations/dadi_simulations/TwoEpochExpansion_${sample_size}.sfs ../Simulations/dadi_simulations/TwoEpochExpansion_${sample_size}
# python compute_sfs_summary_statistics.py ../Simulations/dadi_simulations/ThreeEpochExpansion_${sample_size}.sfs ../Simulations/dadi_simulations/ThreeEpochExpansion_${sample_size}
# python compute_sfs_summary_statistics.py ../Simulations/dadi_simulations/ThreeEpochBottleneck_${sample_size}.sfs ../Simulations/dadi_simulations/ThreeEpochBottleneck_${sample_size}
# python compute_sfs_summary_statistics.py ../Simulations/dadi_simulations/1000_1000_${sample_size}.sfs ../Simulations/dadi_simulations/ThreeEpochBottleneck_1000_1000_${sample_size}
# python compute_sfs_summary_statistics.py ../Simulations/dadi_simulations/2000_2000_${sample_size}.sfs ../Simulations/dadi_simulations/ThreeEpochBottleneck_2000_2000_${sample_size}
# python compute_sfs_summary_statistics.py ../Simulations/dadi_simulations/snm_${sample_size}.sfs ../Simulations/dadi_simulations/snm_${sample_size}
# python compute_sfs_summary_statistics.py ../Simulations/dadi_simulations/ThreeEpochBottleneck_${sample_size}.sfs ../Analysis/dadi_3EpB_${sample_size}/
