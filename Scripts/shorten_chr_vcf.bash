#!/bin/bash
#$ -cwd
#$ -V
#$ -l h_data=15G
#$ -l h_rt=2:00:00
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -N fix_chr_2

module load bedtools

bedtools intersect -a ../Data/chr2_test_vcf -b chr2.20160622.allChr.mask.bed -header | gzip > ../Data/test_mask.bisnp.EUR.1kGP.chr2.vcf.gz
bedtools intersect -a ../Data/chr1_test_vcf -b chr1.20160622.allChr.mask.bed -header | gzip > ../Data/test_mask.bisnp.EUR.1kGP.chr1.vcf.gz
