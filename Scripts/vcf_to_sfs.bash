#!/bin/bash
#$ -N downsample_sfs.bash
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=15G
#$ -l h_rt=04:00:00
#$ -t 1

# 1000Genomes EUR data
python vcf_to_sfs.py ../mask.bisnp.EUR.1kGP.chr1.vcf.gz popfile_EUR_305.txt ../Analysis/1KG/chr1
python vcf_to_sfs.py ../mask.bisnp.EUR.1kGP.chr1.vcf.gz popfile_EUR_305.txt ../Analysis/1KG/chr2
python vcf_to_sfs.py ../mask.bisnp.EUR.1kGP.chr1.vcf.gz popfile_EUR_305.txt ../Analysis/1KG/chr3
python vcf_to_sfs.py ../mask.bisnp.EUR.1kGP.chr1.vcf.gz popfile_EUR_305.txt ../Analysis/1KG/chr4
python vcf_to_sfs.py ../mask.bisnp.EUR.1kGP.chr1.vcf.gz popfile_EUR_305.txt ../Analysis/1KG/chr5
python vcf_to_sfs.py ../mask.bisnp.EUR.1kGP.chr1.vcf.gz popfile_EUR_305.txt ../Analysis/1KG/chr6
python vcf_to_sfs.py ../mask.bisnp.EUR.1kGP.chr1.vcf.gz popfile_EUR_305.txt ../Analysis/1KG/chr7
python vcf_to_sfs.py ../mask.bisnp.EUR.1kGP.chr1.vcf.gz popfile_EUR_305.txt ../Analysis/1KG/chr8
python vcf_to_sfs.py ../mask.bisnp.EUR.1kGP.chr1.vcf.gz popfile_EUR_305.txt ../Analysis/1KG/chr9
python vcf_to_sfs.py ../mask.bisnp.EUR.1kGP.chr1.vcf.gz popfile_EUR_305.txt ../Analysis/1KG/chr10
python vcf_to_sfs.py ../mask.bisnp.EUR.1kGP.chr1.vcf.gz popfile_EUR_305.txt ../Analysis/1KG/chr11
python vcf_to_sfs.py ../mask.bisnp.EUR.1kGP.chr1.vcf.gz popfile_EUR_305.txt ../Analysis/1KG/chr12
python vcf_to_sfs.py ../mask.bisnp.EUR.1kGP.chr1.vcf.gz popfile_EUR_305.txt ../Analysis/1KG/chr13
python vcf_to_sfs.py ../mask.bisnp.EUR.1kGP.chr1.vcf.gz popfile_EUR_305.txt ../Analysis/1KG/chr14
python vcf_to_sfs.py ../mask.bisnp.EUR.1kGP.chr1.vcf.gz popfile_EUR_305.txt ../Analysis/1KG/chr15
python vcf_to_sfs.py ../mask.bisnp.EUR.1kGP.chr1.vcf.gz popfile_EUR_305.txt ../Analysis/1KG/chr16
python vcf_to_sfs.py ../mask.bisnp.EUR.1kGP.chr1.vcf.gz popfile_EUR_305.txt ../Analysis/1KG/chr17
python vcf_to_sfs.py ../mask.bisnp.EUR.1kGP.chr1.vcf.gz popfile_EUR_305.txt ../Analysis/1KG/chr18
python vcf_to_sfs.py ../mask.bisnp.EUR.1kGP.chr1.vcf.gz popfile_EUR_305.txt ../Analysis/1KG/chr19
python vcf_to_sfs.py ../mask.bisnp.EUR.1kGP.chr1.vcf.gz popfile_EUR_305.txt ../Analysis/1KG/chr20
python vcf_to_sfs.py ../mask.bisnp.EUR.1kGP.chr1.vcf.gz popfile_EUR_305.txt ../Analysis/1KG/chr21
python vcf_to_sfs.py ../mask.bisnp.EUR.1kGP.chr1.vcf.gz popfile_EUR_305.txt ../Analysis/1KG/chr22
