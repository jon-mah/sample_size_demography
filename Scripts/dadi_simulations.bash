#!/bin/bash
#$ -N dadi_simulations
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=15G
#$ -l h_rt=00:30:00
#$ -t 10-800:10

# SGE_TASK_ID=10

sample_size=$SGE_TASK_ID

python dadi_simulations.py ${sample_size} ../Simulations/dadi_simulations/
