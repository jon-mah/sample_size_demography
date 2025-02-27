#!/bin/bash
#$ -cwd
#$ -V
#$ -N EUR_vcf_sfs
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_rt=12:00:00
#$ -l highp
#$ -t 1-22

# SGE_TASK_ID='21'

chr='chr'$SGE_TASK_ID
dirvcf='/u/project/klohmuel/DataRepository/NYGC_1KG/genotype'
inputvcf=$dirvcf"/20201028_CCDG_14151_B01_GRM_WGS_2020-08-05_"$chr".recalibrated_variants.vcf.gz"
maskfile='/u/project/klohmuel/cdi/noncdoingdfe/data/vcf_1kg220425/originalfile/20160622.allChr.mask.bed'
inputsample='../Data/samples_EUR.txt'
dirout='../Data/'

bash ./uti_human_snps_SFS.bash -c $chr -v $inputvcf -s $inputsample -m $maskfile -o $dirout
