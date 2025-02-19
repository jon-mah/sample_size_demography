#!/bin/bash
#$ -N vcf_to_sfs
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=25G
#$ -l h_rt=04:00:00
#$ -t 1-22

# SGE_TASK_ID=22

VCF=$SGE_TASK_ID

python vcf_to_sfs.py ../Data/temp_bisnp.EUR.1kGP.chr${VCF}.vcf.gz ../Data/popfile_EUR_masked.txt ../Data/1KG_2020/chr${VCF}

