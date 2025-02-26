#!/bin/bash
#$ -N filter_vcf
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=25G
#$ -l h_rt=01:00:00
#$ -t 1-22

# SGE_TASK_ID=22

VCF=$SGE_TASK_ID

# filter_vep -i ../Data/vep.bisnp.EUR.1kGP.chr${VCF}.vcf -o ../Data/syn.bisnp.EUR.1kGP.chr${VCF}.vcf --vcf --ontology --filter "Consequence is synonymous_variant" --force_overwrite
# filter_vep -i ../Data/vep.bisnp.EUR.1kGP.chr${VCF}.vcf -o ../Data/nonsyn.bisnp.EUR.1kGP.chr${VCF}.vcf --vcf --ontology --filter "Consequence is missense_variant" --force_overwrite

gzip ../Data/syn.bisnp.EUR.1kGP.chr${VCF}.vcf
gzip ../Data/nonsyn.bisnp.EUR.1kGP.chr${VCF}.vcf
