#!/bin/bash
#$ -N lynch_slim_bash
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=45G
#$ -l h_rt=0:30:00
#$ -t 1-20

# replicate=1

replicate=$SGE_TASK_ID

slim -d replicate=$replicate lynch_singletons.slim
