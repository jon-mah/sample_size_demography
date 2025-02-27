#!/bin/bash
#$ -N msprime_simulations
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=45G
#$ -l h_rt=00:15:00

# python concat_sfs.py ../Simulations/simple_simulations/TwoEpochContraction
# python concat_sfs.py ../Simulations/simple_simulations/TwoEpochExpansion
# python concat_sfs.py ../Simulations/simple_simulations/ThreeEpochContraction
# python concat_sfs.py ../Simulations/simple_simulations/ThreeEpochExpansion
# python concat_sfs.py ../Simulations/simple_simulations/ThreeEpochBottleneck
python concat_sfs.py ../Data/1KG_2020/syn_chr
python concat_sfs.py ../Data/1KG_2020/nonsyn_chr
