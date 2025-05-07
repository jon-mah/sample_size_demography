#!/bin/bash
#$ -N lynch_easySFS
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=15G
#$ -l h_rt=0:30:00
#$ -t 1-1000

# SGE_TASK_ID=1

replicate=$SGE_TASK_ID

# python lynch_singletons_simulation.py ${replicate} ../Simulations/lynch_singletons/

# k=5
easySFS.py -a -f -i ../Simulations/lynch_singletons/msprime_simulations/k5_contraction_${replicate}.vcf -p sample_5_pops.txt -o ../Simulations/lynch_singletons/msprime_simulations/k5_contraction_${replicate} --proj 5 --unfolded
easySFS.py -a -f -i ../Simulations/lynch_singletons/msprime_simulations/k5_expansion_${replicate}.vcf -p sample_5_pops.txt -o ../Simulations/lynch_singletons/msprime_simulations/k5_expansion_${replicate} --proj 5 --unfolded
easySFS.py -a -f -i ../Simulations/lynch_singletons/msprime_simulations/k5_bottleneck_${replicate}.vcf -p sample_5_pops.txt -o ../Simulations/lynch_singletons/msprime_simulations/k5_bottleneck_${replicate} --proj 5 --unfolded

# Slim
# easySFS.py -a -f -i ../Simulations/lynch_singletons/slim_simulations/slim_contraction_${replicate}.vcf -p slim_sample_100_pops.txt -o ../Simulations/lynch_singletons/slim_simulations/slim_contraction_${replicate} --proj 100 --unfolded
# easySFS.py -a -f -i ../Simulations/lynch_singletons/slim_simulations/slim_expansion_${replicate}.vcf -p slim_sample_1000_pops.txt -o ../Simulations/lynch_singletons/slim_simulations/slim_expansion_${replicate} --proj 1000 --unfolded
# easySFS.py -a -f -i ../Simulations/lynch_singletons/slim_simulations/slim_bottleneck_${replicate}.vcf -p slim_sample_1000_pops.txt -o ../Simulations/lynch_singletons/slim_simulations/slim_bottleneck_${replicate} --proj 1000 --unfolded
