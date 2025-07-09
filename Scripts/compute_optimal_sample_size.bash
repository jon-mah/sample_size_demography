#!/bin/bash
#$ -N lynch_theory.bash
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=15G
#$ -l h_rt=00:30:00
#$ -t 11-801:10

sample_size=$SGE_TASK_ID

# sample_size=751

# Simple demographic histories
python compute_optimal_sample_size.py ../Data/two_epoch_contraction_demography.csv --target_sample_size ${sample_size} ../Simulations/lynch_theory/TwoEpochContraction_${sample_size}
python compute_optimal_sample_size.py ../Data/two_epoch_expansion_demography.csv --target_sample_size ${sample_size} ../Simulations/lynch_theory/TwoEpochExpansion_${sample_size}
python compute_optimal_sample_size.py ../Data/three_epoch_contraction_demography.csv --target_sample_size ${sample_size} ../Simulations/lynch_theory/ThreeEpochContraction_${sample_size}
python compute_optimal_sample_size.py ../Data/three_epoch_expansion_demography.csv --target_sample_size ${sample_size} ../Simulations/lynch_theory/ThreeEpochExpansion_${sample_size}
python compute_optimal_sample_size.py ../Data/three_epoch_bottleneck_demography.csv --target_sample_size ${sample_size} ../Simulations/lynch_theory/ThreeEpochBottleneck_${sample_size}

# Complex demographic histories
python compute_optimal_sample_size.py ../Data/tennessen_demography.csv --target_sample_size ${sample_size} ../Simulations/lynch_theory/tennessen_${sample_size}

# Bottleneck demographic histories
python compute_optimal_sample_size.py ../Data/500_2000_bottleneck_demography.csv --target_sample_size ${sample_size} ../Simulations/lynch_theory/500_2000_bottleneck_${sample_size}
python compute_optimal_sample_size.py ../Data/1000_2000_bottleneck_demography.csv --target_sample_size ${sample_size} ../Simulations/lynch_theory/1000_2000_bottleneck_${sample_size}
python compute_optimal_sample_size.py ../Data/1500_2000_bottleneck_demography.csv --target_sample_size ${sample_size} ../Simulations/lynch_theory/1500_2000_bottleneck_${sample_size}
python compute_optimal_sample_size.py ../Data/2000_2000_bottleneck_demography.csv --target_sample_size ${sample_size} ../Simulations/lynch_theory/2000_2000_bottleneck_${sample_size}
python compute_optimal_sample_size.py ../Data/2500_2000_bottleneck_demography.csv --target_sample_size ${sample_size} ../Simulations/lynch_theory/2500_2000_bottleneck_${sample_size}

python compute_optimal_sample_size.py ../Data/1000_500_bottleneck_demography.csv --target_sample_size ${sample_size} ../Simulations/lynch_theory/1000_500_bottleneck_${sample_size}
python compute_optimal_sample_size.py ../Data/1000_1000_bottleneck_demography.csv --target_sample_size ${sample_size} ../Simulations/lynch_theory/1000_1000_bottleneck_${sample_size}
python compute_optimal_sample_size.py ../Data/1000_1500_bottleneck_demography.csv --target_sample_size ${sample_size} ../Simulations/lynch_theory/1000_1500_bottleneck_${sample_size}
python compute_optimal_sample_size.py ../Data/1000_2500_bottleneck_demography.csv --target_sample_size ${sample_size} ../Simulations/lynch_theory/1000_2500_bottleneck_${sample_size}