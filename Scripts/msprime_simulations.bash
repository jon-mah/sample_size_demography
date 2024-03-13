#!/bin/bash
#$ -N msprime_simulations
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=45G
#$ -l h_rt=00:30:00
#$ -t 1:20

replicate=$SGE_TASK_ID

python msprime_simulations.py ${replicate} ../Simulations/simple_simulations/

easySFS.py -a -f -i ../Simulations/simple_simulations/TwoEpochContraction_${replicate}.vcf -p sample_1000_pops.txt -o ../Simulations/simple_simulations/TwoEpochContraction_${replicate} --proj 864
easySFS.py -a -f -i ../Simulations/simple_simulations/TwoEpochExpansion_${replicate}.vcf -p sample_1000_pops.txt -o ../Simulations/simple_simulations/TwoEpochExpansion_${replicate} --proj 864
easySFS.py -a -f -i ../Simulations/simple_simulations/ThreeEpochContraction_${replicate}.vcf -p sample_1000_pops.txt -o ../Simulations/simple_simulations/ThreeEpochContraction_${replicate} --proj 864
easySFS.py -a -f -i ../Simulations/simple_simulations/ThreeEpochExpansion_${replicate}.vcf -p sample_1000_pops.txt -o ../Simulations/simple_simulations/ThreeEpochExpansion_${replicate} --proj 864
