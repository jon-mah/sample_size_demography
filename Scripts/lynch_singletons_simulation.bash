#!/bin/bash
#$ -N singleton_simulations
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=45G
#$ -l h_rt=01:30:00
#$ -t 1-20:1

replicate=$SGE_TASK_ID

# python msprime_simulations.py ${replicate} ../Simulations/singleton_simulations/

easySFS.py -a -f -i ../Simulations/singleton_simulations/TwoEpochContraction_${replicate}.vcf -p sample_1000_pops.txt -o ../Simulations/singleton_simulations/TwoEpochContraction_${replicate}
easySFS.py -a -f -i ../Simulations/singleton_simulations/TwoEpochExpansion_${replicate}.vcf -p sample_10000_pops.txt -o ../Simulations/singleton_simulations/TwoEpochExpansion_${replicate}
easySFS.py -a -f -i ../Simulations/singleton_simulations/ThreeEpochBottleneck_${replicate}.vcf -p sample_50000_pops.txt -o ../Simulations/singleton_simulations/ThreeEpochBottleneck_${replicate}
