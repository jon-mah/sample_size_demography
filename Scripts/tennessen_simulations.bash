#!/bin/bash
#$ -N tennessen_sim.bash
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=60G
#$ -l h_rt=02:00:00
#$ -t 10-800:10

# SGE_TASK_ID=10

sample_size=$SGE_TASK_ID

stdpopsim HomSap -L 1000000 -o ../Simulations/tennessen/ooa_${sample_size}.trees -s 1 -d OutOfAfrica_2T12 EUR:1000

# Convert msprime .trees to .vcf format
tskit vcf ../Simulations/tennessen/ooa_${sample_size}.trees > ../Simulations/tennessen/ooa_${sample_size}.vcf

easySFS.py -a -f -i ../Simulations/tennessen/ooa_${sample_size}.vcf -p sample_${sample_size}_pops.txt -o ../Simulations/tennessen/ooa_${sample_size}_sfs --proj ${sample_size}
