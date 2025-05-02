#!/bin/bash
#$ -N singleton_simulations
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=45G
#$ -l h_rt=00:30:00
#$ -t 1-20:1

replicate=$SGE_TASK_ID

# python lynch_singletons_simulation.py ${replicate} ../Simulations/singleton_simulations_short/

easySFS.py -a -f -i ../Simulations/singleton_simulations_short/contraction_${replicate}.vcf -p sample_1000_pops.txt -o ../Simulations/singleton_simulations_short/contraction_${replicate} --proj 1000 --unfolded
easySFS.py -a -f -i ../Simulations/singleton_simulations_short/expansion_${replicate}.vcf -p sample_10000_pops.txt -o ../Simulations/singleton_simulations_short/expansion_${replicate} --proj 10000 --unfolded
easySFS.py -a -f -i ../Simulations/singleton_simulations_short/bottleneck_${replicate}.vcf -p sample_10000_pops.txt -o ../Simulations/singleton_simulations_short/bottleneck_${replicate} --proj 10000 --unfolded
