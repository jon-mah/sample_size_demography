#!/bin/bash
#$ -N trees_tskit
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=10G
#$ -l h_rt=00:20:00
#$ -t 10:800:10

# SGE_TASK_ID=200

sample_size=$SGE_TASK_ID

python trees_to_tskit.py ../Simulations/tennessen/ooa_${sample_size}.trees --outprefix ../Analysis/tennessen_ooa_${sample_size}/ooa_${sample_size}
