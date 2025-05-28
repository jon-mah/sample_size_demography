#!/bin/bash
#$ -N filter_vcf
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=15G
#$ -l h_rt=00:05:00

python compute_optimal_sample_size.py ../Data/compute_optimal_sample_size_example_input.csv 500 ../Analysis/compute_optimal_sample_size_example/
