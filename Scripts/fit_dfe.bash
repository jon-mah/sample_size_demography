#!/bin/bash
#$ -cwd
#$ -V
#$ -l h_data=50G
#$ -l h_rt=72:00:00
#$ -l highp
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -N fit_updated_1KG_300
#$ -t 10

SGE_TASK_ID=300

sample_size=$SGE_TASK_ID

## 1KG EUR (2017)
# python fit_dfe.py ../Analysis/1kg_EUR_${sample_size}/syn_downsampled_sfs.txt ../Analysis/1kg_EUR_${sample_size}/nonsyn_downsampled_sfs.txt ../Analysis/1kg_EUR_${sample_size}/two_epoch_demography.txt two_epoch ../Analysis/1kg_EUR_${sample_size}/
# python fit_dfe.py ../Analysis/1kg_EUR_${sample_size}/syn_downsampled_sfs.txt ../Analysis/1kg_EUR_${sample_size}/nonsyn_downsampled_sfs.txt ../Analysis/1kg_EUR_${sample_size}/three_epoch_demography.txt three_epoch ../Analysis/1kg_EUR_${sample_size}/

## 1KG EUR (2020)
# python fit_dfe.py ../Analysis/1kg_EUR_2020_${sample_size}/syn_downsampled_sfs.txt ../Analysis/1kg_EUR_2020_${sample_size}/nonsyn_downsampled_sfs.txt ../Analysis/1kg_EUR_2020_${sample_size}/two_epoch_demography.txt two_epoch ../Analysis/1kg_EUR_2020_${sample_size}/
# python fit_dfe.py ../Analysis/1kg_EUR_2020_${sample_size}/syn_downsampled_sfs.txt ../Analysis/1kg_EUR_2020_${sample_size}/nonsyn_downsampled_sfs.txt ../Analysis/1kg_EUR_2020_${sample_size}/three_epoch_demography.txt three_epoch ../Analysis/1kg_EUR_2020_${sample_size}/

## gnomAD
# python fit_dfe.py ../Analysis/gnomAD_${sample_size}/syn_downsampled_sfs.txt ../Analysis/gnomAD_${sample_size}/nonsyn_downsampled_sfs.txt ../Analysis/gnomAD_${sample_size}/two_epoch_demography.txt two_epoch ../Analysis/gnomAD_${sample_size}/ --L_syn 18343593
# python fit_dfe.py ../Analysis/gnomAD_${sample_size}/syn_downsampled_sfs.txt ../Analysis/gnomAD_${sample_size}/nonsyn_downsampled_sfs.txt ../Analysis/gnomAD_${sample_size}/three_epoch_demography.txt three_epoch ../Analysis/gnomAD_${sample_size}/ --L_syn 18343593
