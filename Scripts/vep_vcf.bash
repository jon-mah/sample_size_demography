#!/bin/bash
#$ -N vep_vcf
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=25G
#$ -l h_rt=01:00:00
#$ -t 1-22

# SGE_TASK_ID=7

VCF=$SGE_TASK_ID

gzip -d ../Data/mask.bisnp.EUR.1kGP.chr${VCF}.vcf.gz

vep -i ../Data/mask.bisnp.EUR.1kGP.chr${VCF}.vcf -o ../Data/vep.bisnp.EUR.1kGP.chr${VCF}.vcf --vcf --offline --format vcf --force_overwrite

gzip ../Data/mask.bisnp.EUR.1kGP.chr${VCF}.vcf
gzip ../Data/vep.bisnp.EUR.1kGP.chr${VCF}.vcf
