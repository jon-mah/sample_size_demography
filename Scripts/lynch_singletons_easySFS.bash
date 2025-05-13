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
# easySFS.py -a -f -i ../Simulations/lynch_singletons/msprime_simulations/k5_contraction_${replicate}.vcf -p sample_5_pops.txt -o ../Simulations/lynch_singletons/msprime_simulations/k5_contraction_${replicate} --proj 5 --unfolded
# easySFS.py -a -f -i ../Simulations/lynch_singletons/msprime_simulations/k5_expansion_${replicate}.vcf -p sample_5_pops.txt -o ../Simulations/lynch_singletons/msprime_simulations/k5_expansion_${replicate} --proj 5 --unfolded
# easySFS.py -a -f -i ../Simulations/lynch_singletons/msprime_simulations/k5_bottleneck_${replicate}.vcf -p sample_5_pops.txt -o ../Simulations/lynch_singletons/msprime_simulations/k5_bottleneck_${replicate} --proj 5 --unfolded
# easySFS.py -a -f -i ../Simulations/lynch_singletons/msprime_simulations/k5_snm_${replicate}.vcf -p sample_5_pops.txt -o ../Simulations/lynch_singletons/msprime_simulations/k5_snm_${replicate} --proj 5 --unfolded

# k=10
# easySFS.py -a -f -i ../Simulations/lynch_singletons/msprime_simulations/k10_contraction_${replicate}.vcf -p sample_10_pops.txt -o ../Simulations/lynch_singletons/msprime_simulations/k10_contraction_${replicate} --proj 10 --unfolded
# easySFS.py -a -f -i ../Simulations/lynch_singletons/msprime_simulations/k10_expansion_${replicate}.vcf -p sample_10_pops.txt -o ../Simulations/lynch_singletons/msprime_simulations/k10_expansion_${replicate} --proj 10 --unfolded
# easySFS.py -a -f -i ../Simulations/lynch_singletons/msprime_simulations/k10_bottleneck_${replicate}.vcf -p sample_10_pops.txt -o ../Simulations/lynch_singletons/msprime_simulations/k10_bottleneck_${replicate} --proj 10 --unfolded
# easySFS.py -a -f -i ../Simulations/lynch_singletons/msprime_simulations/k10_snm_${replicate}.vcf -p sample_10_pops.txt -o ../Simulations/lynch_singletons/msprime_simulations/k10_snm_${replicate} --proj 10 --unfolded

# k=15
# easySFS.py -a -f -i ../Simulations/lynch_singletons/msprime_simulations/k15_contraction_${replicate}.vcf -p sample_15_pops.txt -o ../Simulations/lynch_singletons/msprime_simulations/k15_contraction_${replicate} --proj 15 --unfolded
# easySFS.py -a -f -i ../Simulations/lynch_singletons/msprime_simulations/k15_expansion_${replicate}.vcf -p sample_15_pops.txt -o ../Simulations/lynch_singletons/msprime_simulations/k15_expansion_${replicate} --proj 15 --unfolded
# easySFS.py -a -f -i ../Simulations/lynch_singletons/msprime_simulations/k15_bottleneck_${replicate}.vcf -p sample_15_pops.txt -o ../Simulations/lynch_singletons/msprime_simulations/k15_bottleneck_${replicate} --proj 15 --unfolded
# easySFS.py -a -f -i ../Simulations/lynch_singletons/msprime_simulations/k15_snm_${replicate}.vcf -p sample_15_pops.txt -o ../Simulations/lynch_singletons/msprime_simulations/k15_snm_${replicate} --proj 15 --unfolded

# k=20
easySFS.py -a -f -i ../Simulations/lynch_singletons/msprime_simulations/k20_contraction_${replicate}.vcf -p sample_20_pops.txt -o ../Simulations/lynch_singletons/msprime_simulations/k20_contraction_${replicate} --proj 20 --unfolded
easySFS.py -a -f -i ../Simulations/lynch_singletons/msprime_simulations/k20_expansion_${replicate}.vcf -p sample_20_pops.txt -o ../Simulations/lynch_singletons/msprime_simulations/k20_expansion_${replicate} --proj 20 --unfolded
easySFS.py -a -f -i ../Simulations/lynch_singletons/msprime_simulations/k20_bottleneck_${replicate}.vcf -p sample_20_pops.txt -o ../Simulations/lynch_singletons/msprime_simulations/k20_bottleneck_${replicate} --proj 20 --unfolded
easySFS.py -a -f -i ../Simulations/lynch_singletons/msprime_simulations/k20_snm_${replicate}.vcf -p sample_20_pops.txt -o ../Simulations/lynch_singletons/msprime_simulations/k20_snm_${replicate} --proj 20 --unfolded

# Slim
# easySFS.py -a -f -i ../Simulations/lynch_singletons/slim_simulations/slim_contraction_${replicate}.vcf -p slim_sample_100_pops.txt -o ../Simulations/lynch_singletons/slim_simulations/slim_contraction_${replicate} --proj 100 --unfolded
# easySFS.py -a -f -i ../Simulations/lynch_singletons/slim_simulations/slim_expansion_${replicate}.vcf -p slim_sample_1000_pops.txt -o ../Simulations/lynch_singletons/slim_simulations/slim_expansion_${replicate} --proj 1000 --unfolded
# easySFS.py -a -f -i ../Simulations/lynch_singletons/slim_simulations/slim_bottleneck_${replicate}.vcf -p slim_sample_1000_pops.txt -o ../Simulations/lynch_singletons/slim_simulations/slim_bottleneck_${replicate} --proj 1000 --unfolded
