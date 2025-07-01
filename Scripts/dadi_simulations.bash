#!/bin/bash
#$ -N msprime_simulations
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=15G
#$ -l h_rt=02:00:00
#$ -t 10-800:10

# SGE_TASK_ID=970

sample_size=$SGE_TASK_ID

python msprime_simulations.py ${sample_size} ../Simulations/dadi_simulations/