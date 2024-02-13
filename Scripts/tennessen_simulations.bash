#!/bin/bash
#$ -N downsample_sfs.bash
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=60G
#$ -l h_rt=01:30:00

stdpopsim HomSap -L 1000000 -o ../Simulations/ooa_864.trees -s 1 -d OutOfAfrica_2T12 EUR:1000

outfile='../Simulations/ooa_864'

# Convert msprime .trees to .vcf format
tskit vcf ../Simulations/${outfile}.trees > ../Simulations/${outfile}.vcf

easySFS.py -a -f -i ../Simulations/${outfile}.vcf -p sample_1000_pops.txt -o ../Simulations/${outfile}_sfs --proj 864
