#!/bin/bash
#$ -N downsample_sfs.bash
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=15G
#$ -l h_rt=00:10:00


python msprime_simulations.py ../Simulations/simple_simulations/

easySFS.py -a -f -i ../Simulations/simple_simulations/TwoEpochContraction.vcf -p sample_1000_pops.txt -o ../Simulations/simple_simulations/TwoEpochContraction --proj 864
easySFS.py -a -f -i ../Simulations/simple_simulations/TwoEpochExpansion.vcf -p sample_1000_pops.txt -o ../Simulations/simple_simulations/TwoEpochExpansion --proj 864
easySFS.py -a -f -i ../Simulations/simple_simulations/ThreeEpochContraction.vcf -p sample_1000_pops.txt -o ../Simulations/simple_simulations/ThreeEpochContraction --proj 864
easySFS.py -a -f -i ../Simulations/simple_simulations/ThreeEpochExpansion.vcf -p sample_1000_pops.txt -o ../Simulations/simple_simulations/ThreeEpochExpansion --proj 864
