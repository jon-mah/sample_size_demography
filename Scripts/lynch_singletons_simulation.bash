#!/bin/bash
#$ -N singleton_simulations
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=45G
#$ -l h_rt=01:30:00
#$ -t 1-20:1
#$ -tc 1

replicate=$SGE_TASK_ID

python lynch_singletons_simulation.py ${replicate} ../Simulations/lynch_singletons/

# easySFS.py -a -f -i ../Simulations/lynch_singletons/T500/contration_${replicate}.vcf -p sample_1000_pops.txt -o ../Simulations/lynch_singletons/T500/contraction_${replication} --proj 1000 --unfolded
# easySFS.py -a -f -i ../Simulations/lynch_singletons/T500/expansion_${replicate}.vcf -p sample_10000_pops.txt -o ../Simulations/lynch_singletons/T500/expansion_${replication} --proj 10000 --unfolded
# easySFS.py -a -f -i ../Simulations/lynch_singletons/T500/bottleneck_${replicate}.vcf -p sample_10000_pops.txt -o ../Simulations/lynch_singletons/T500/bottleneck_${replication} --proj 10000 --unfolded

# Short time frame T_k = 50 generations
# easySFS.py -a -f -i ../Simulations/lynch_singletons/T50/contration_${replicate}.vcf -p sample_1000_pops.txt -o ../Simulations/lynch_singletons/T50/contraction_${replication} --proj 1000 --unfolded
# easySFS.py -a -f -i ../Simulations/lynch_singletons/T50/expansion_${replicate}.vcf -p sample_10000_pops.txt -o ../Simulations/lynch_singletons/T50/expansion_${replication} --proj 10000 --unfolded
# easySFS.py -a -f -i ../Simulations/lynch_singletons/T50/bottleneck_${replicate}.vcf -p sample_10000_pops.txt -o ../Simulations/lynch_singletons/T50/bottleneck_${replication} --proj 10000 --unfolded

# No recombination
# easySFS.py -a -f -i ../Simulations/lynch_singletons/no_r/contration_${replicate}.vcf -p sample_1000_pops.txt -o ../Simulations/lynch_singletons/no_r/contraction_${replication} --proj 1000 --unfolded
# easySFS.py -a -f -i ../Simulations/lynch_singletons/no_r/expansion_${replicate}.vcf -p sample_10000_pops.txt -o ../Simulations/lynch_singletons/no_r/expansion_${replication} --proj 10000 --unfolded
# easySFS.py -a -f -i ../Simulations/lynch_singletons/no_r/bottleneck_${replicate}.vcf -p sample_10000_pops.txt -o ../Simulations/lynch_singletons/no_r/bottleneck_${replication} --proj 10000 --unfolded

# Small nu
# easySFS.py -a -f -i ../Simulations/lynch_singletons/small_nu/contration_${replicate}.vcf -p sample_5000_pops.txt -o ../Simulations/lynch_singletons/small_nu/contraction_${replication} --proj 5000 --unfolded
# easySFS.py -a -f -i ../Simulations/lynch_singletons/small_nu/expansion_${replicate}.vcf -p sample_10000_pops.txt -o ../Simulations/lynch_singletons/small_nu/expansion_${replication} --proj 10000 --unfolded
# easySFS.py -a -f -i ../Simulations/lynch_singletons/small_nu/bottleneck_${replicate}.vcf -p sample_7500_pops.txt -o ../Simulations/lynch_singletons/small_nu/bottleneck_${replication} --proj 7500 --unfolded

# Large nu
# easySFS.py -a -f -i ../Simulations/lynch_singletons/large_nu/contration_${replicate}.vcf -p sample_100_pops.txt -o ../Simulations/lynch_singletons/large_nu/contraction_${replication} --proj 100 --unfolded
# easySFS.py -a -f -i ../Simulations/lynch_singletons/large_nu/expansion_${replicate}.vcf -p sample_10000_pops.txt -o ../Simulations/lynch_singletons/large_nu/expansion_${replication} --proj 10000 --unfolded
# easySFS.py -a -f -i ../Simulations/lynch_singletons/large_nu/bottleneck_${replicate}.vcf -p sample_10000_pops.txt -o ../Simulations/lynch_singletons/large_nu/bottleneck_${replication} --proj 10000 --unfolded
