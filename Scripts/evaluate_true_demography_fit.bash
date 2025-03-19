#!/bin/bash
#$ -cwd
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=15G
#$ -l h_rt=00:30:00

python evaluate_true_demography_fit.py ../Analysis/TwoEpochContraction_10/syn_downsampled_sfs.txt two_epoch 0.5 0.1
python evaluate_true_demography_fit.py ../Analysis/TwoEpochContraction_20/syn_downsampled_sfs.txt two_epoch 0.5 0.1
python evaluate_true_demography_fit.py ../Analysis/TwoEpochContraction_30/syn_downsampled_sfs.txt two_epoch 0.5 0.1
python evaluate_true_demography_fit.py ../Analysis/TwoEpochContraction_50/syn_downsampled_sfs.txt two_epoch 0.5 0.1
python evaluate_true_demography_fit.py ../Analysis/TwoEpochContraction_100/syn_downsampled_sfs.txt two_epoch 0.5 0.1
python evaluate_true_demography_fit.py ../Analysis/TwoEpochContraction_150/syn_downsampled_sfs.txt two_epoch 0.5 0.1
python evaluate_true_demography_fit.py ../Analysis/TwoEpochContraction_200/syn_downsampled_sfs.txt two_epoch 0.5 0.1
python evaluate_true_demography_fit.py ../Analysis/TwoEpochContraction_300/syn_downsampled_sfs.txt two_epoch 0.5 0.1
python evaluate_true_demography_fit.py ../Analysis/TwoEpochContraction_500/syn_downsampled_sfs.txt two_epoch 0.5 0.1
python evaluate_true_demography_fit.py ../Analysis/TwoEpochContraction_700/syn_downsampled_sfs.txt two_epoch 0.5 0.1

python evaluate_true_demography_fit.py ../Analysis/TwoEpochExpansion_10/syn_downsampled_sfs.txt two_epoch 2.0 0.01
python evaluate_true_demography_fit.py ../Analysis/TwoEpochExpansion_20/syn_downsampled_sfs.txt two_epoch 2.0 0.01
python evaluate_true_demography_fit.py ../Analysis/TwoEpochExpansion_30/syn_downsampled_sfs.txt two_epoch 2.0 0.01
python evaluate_true_demography_fit.py ../Analysis/TwoEpochExpansion_50/syn_downsampled_sfs.txt two_epoch 2.0 0.01
python evaluate_true_demography_fit.py ../Analysis/TwoEpochExpansion_100/syn_downsampled_sfs.txt two_epoch 2.0 0.01
python evaluate_true_demography_fit.py ../Analysis/TwoEpochExpansion_150/syn_downsampled_sfs.txt two_epoch 2.0 0.01
python evaluate_true_demography_fit.py ../Analysis/TwoEpochExpansion_200/syn_downsampled_sfs.txt two_epoch 2.0 0.01
python evaluate_true_demography_fit.py ../Analysis/TwoEpochExpansion_300/syn_downsampled_sfs.txt two_epoch 2.0 0.01
python evaluate_true_demography_fit.py ../Analysis/TwoEpochExpansion_500/syn_downsampled_sfs.txt two_epoch 2.0 0.01
python evaluate_true_demography_fit.py ../Analysis/TwoEpochExpansion_700/syn_downsampled_sfs.txt two_epoch 2.0 0.01

python evaluate_true_demography_fit.py ../Analysis/ThreeEpochContraction_10/syn_downsampled_sfs.txt three_epoch 0.5 0.25 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochContraction_20/syn_downsampled_sfs.txt three_epoch 0.5 0.25 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochContraction_30/syn_downsampled_sfs.txt three_epoch 0.5 0.25 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochContraction_50/syn_downsampled_sfs.txt three_epoch 0.5 0.25 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochContraction_100/syn_downsampled_sfs.txt three_epoch 0.5 0.25 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochContraction_150/syn_downsampled_sfs.txt three_epoch 0.5 0.25 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochContraction_200/syn_downsampled_sfs.txt three_epoch 0.5 0.25 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochContraction_300/syn_downsampled_sfs.txt three_epoch 0.5 0.25 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochContraction_500/syn_downsampled_sfs.txt three_epoch 0.5 0.25 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochContraction_700/syn_downsampled_sfs.txt three_epoch 0.5 0.25 0.09 0.01

python evaluate_true_demography_fit.py ../Analysis/ThreeEpochExpansion_10/syn_downsampled_sfs.txt three_epoch 2.0 4.0 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochExpansion_20/syn_downsampled_sfs.txt three_epoch 2.0 4.0 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochExpansion_30/syn_downsampled_sfs.txt three_epoch 2.0 4.0 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochExpansion_50/syn_downsampled_sfs.txt three_epoch 2.0 4.0 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochExpansion_1000/syn_downsampled_sfs.txt three_epoch 2.0 4.0 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochExpansion_150/syn_downsampled_sfs.txt three_epoch 2.0 4.0 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochExpansion_200/syn_downsampled_sfs.txt three_epoch 2.0 4.0 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochExpansion_300/syn_downsampled_sfs.txt three_epoch 2.0 4.0 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochExpansion_500/syn_downsampled_sfs.txt three_epoch 2.0 4.0 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochExpansion_700/syn_downsampled_sfs.txt three_epoch 2.0 4.0 0.09 0.01

python evaluate_true_demography_fit.py ../Analysis/ThreeEpochBotteleneck_10/syn_downsampled_sfs.txt three_epoch 0.1 5.0 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochBotteleneck_20/syn_downsampled_sfs.txt three_epoch 0.1 5.0 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochBotteleneck_30/syn_downsampled_sfs.txt three_epoch 0.1 5.0 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochBotteleneck_50/syn_downsampled_sfs.txt three_epoch 0.1 5.0 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochBotteleneck_100/syn_downsampled_sfs.txt three_epoch 0.1 5.0 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochBotteleneck_150/syn_downsampled_sfs.txt three_epoch 0.1 5.0 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochBotteleneck_200/syn_downsampled_sfs.txt three_epoch 0.1 5.0 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochBotteleneck_300/syn_downsampled_sfs.txt three_epoch 0.1 5.0 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochBotteleneck_500/syn_downsampled_sfs.txt three_epoch 0.1 5.0 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochBotteleneck_700/syn_downsampled_sfs.txt three_epoch 0.1 5.0 0.09 0.01