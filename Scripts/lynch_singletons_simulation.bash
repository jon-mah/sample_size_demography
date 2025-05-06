#!/bin/bash
#$ -N singleton_simulations
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=45G
#$ -l h_rt=00:30:00
#$ -t 2-20:1
#$ -tc 1

# SGE_TASK_ID=1

replicate=$SGE_TASK_ID

python lynch_singletons_simulation.py ${replicate} ../Simulations/lynch_singletons/
