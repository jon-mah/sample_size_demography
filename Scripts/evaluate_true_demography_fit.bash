#!/bin/bash
#$ -cwd
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=15G
#$ -l h_rt=00:30:00

python evaluate_true_demography_fit.py ../Analysis/TwoEpochContraction_10/syn_downsampled_sfs.txt two_epoch --params_list 0.5 0.1 ../Analysis/TwoEpochContraction_10/
python evaluate_true_demography_fit.py ../Analysis/TwoEpochContraction_20/syn_downsampled_sfs.txt two_epoch --params_list 0.5 0.1 ../Analysis/TwoEpochContraction_20/
python evaluate_true_demography_fit.py ../Analysis/TwoEpochContraction_30/syn_downsampled_sfs.txt two_epoch --params_list 0.5 0.1 ../Analysis/TwoEpochContraction_30/
python evaluate_true_demography_fit.py ../Analysis/TwoEpochContraction_50/syn_downsampled_sfs.txt two_epoch --params_list 0.5 0.1 ../Analysis/TwoEpochContraction_50/
python evaluate_true_demography_fit.py ../Analysis/TwoEpochContraction_100/syn_downsampled_sfs.txt two_epoch --params_list 0.5 0.1 ../Analysis/TwoEpochContraction_100/
python evaluate_true_demography_fit.py ../Analysis/TwoEpochContraction_150/syn_downsampled_sfs.txt two_epoch --params_list 0.5 0.1 ../Analysis/TwoEpochContraction_150/
python evaluate_true_demography_fit.py ../Analysis/TwoEpochContraction_200/syn_downsampled_sfs.txt two_epoch --params_list 0.5 0.1 ../Analysis/TwoEpochContraction_200/
python evaluate_true_demography_fit.py ../Analysis/TwoEpochContraction_300/syn_downsampled_sfs.txt two_epoch --params_list 0.5 0.1 ../Analysis/TwoEpochContraction_300/
python evaluate_true_demography_fit.py ../Analysis/TwoEpochContraction_500/syn_downsampled_sfs.txt two_epoch --params_list 0.5 0.1 ../Analysis/TwoEpochContraction_500/
python evaluate_true_demography_fit.py ../Analysis/TwoEpochContraction_700/syn_downsampled_sfs.txt two_epoch --params_list 0.5 0.1 ../Analysis/TwoEpochContraction_700/

python evaluate_true_demography_fit.py ../Analysis/TwoEpochExpansion_10/syn_downsampled_sfs.txt two_epoch --params_list 2.0 0.01 ../Analysis/TwoEpochExpansion_10/
python evaluate_true_demography_fit.py ../Analysis/TwoEpochExpansion_20/syn_downsampled_sfs.txt two_epoch --params_list 2.0 0.01 ../Analysis/TwoEpochExpansion_20/
python evaluate_true_demography_fit.py ../Analysis/TwoEpochExpansion_30/syn_downsampled_sfs.txt two_epoch --params_list 2.0 0.01 ../Analysis/TwoEpochExpansion_30/
python evaluate_true_demography_fit.py ../Analysis/TwoEpochExpansion_50/syn_downsampled_sfs.txt two_epoch --params_list 2.0 0.01 ../Analysis/TwoEpochExpansion_50/
python evaluate_true_demography_fit.py ../Analysis/TwoEpochExpansion_100/syn_downsampled_sfs.txt two_epoch --params_list 2.0 0.01 ../Analysis/TwoEpochExpansion_100/
python evaluate_true_demography_fit.py ../Analysis/TwoEpochExpansion_150/syn_downsampled_sfs.txt two_epoch --params_list 2.0 0.01 ../Analysis/TwoEpochExpansion_150/
python evaluate_true_demography_fit.py ../Analysis/TwoEpochExpansion_200/syn_downsampled_sfs.txt two_epoch --params_list 2.0 0.01 ../Analysis/TwoEpochExpansion_200/
python evaluate_true_demography_fit.py ../Analysis/TwoEpochExpansion_300/syn_downsampled_sfs.txt two_epoch --params_list 2.0 0.01 ../Analysis/TwoEpochExpansion_300/
python evaluate_true_demography_fit.py ../Analysis/TwoEpochExpansion_500/syn_downsampled_sfs.txt two_epoch --params_list 2.0 0.01 ../Analysis/TwoEpochExpansion_500/
python evaluate_true_demography_fit.py ../Analysis/TwoEpochExpansion_700/syn_downsampled_sfs.txt two_epoch --params_list 2.0 0.01 ../Analysis/TwoEpochExpansion_700/

python evaluate_true_demography_fit.py ../Analysis/ThreeEpochContraction_10/syn_downsampled_sfs.txt three_epoch --params_list 0.5 0.25 0.09 0.01 ../Analysis/ThreeEpochContraction_10/
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochContraction_20/syn_downsampled_sfs.txt three_epoch --params_list 0.5 0.25 0.09 0.01 ../Analysis/ThreeEpochContraction_20/
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochContraction_30/syn_downsampled_sfs.txt three_epoch --params_list 0.5 0.25 0.09 0.01 ../Analysis/ThreeEpochContraction_30/
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochContraction_50/syn_downsampled_sfs.txt three_epoch --params_list 0.5 0.25 0.09 0.01 ../Analysis/ThreeEpochContraction_50/
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochContraction_100/syn_downsampled_sfs.txt three_epoch --params_list 0.5 0.25 0.09 0.01 ../Analysis/ThreeEpochContraction_100/
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochContraction_150/syn_downsampled_sfs.txt three_epoch --params_list 0.5 0.25 0.09 0.01 ../Analysis/ThreeEpochContraction_150/
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochContraction_200/syn_downsampled_sfs.txt three_epoch --params_list 0.5 0.25 0.09 0.01 ../Analysis/ThreeEpochContraction_200/
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochContraction_300/syn_downsampled_sfs.txt three_epoch --params_list 0.5 0.25 0.09 0.01 ../Analysis/ThreeEpochContraction_300/
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochContraction_500/syn_downsampled_sfs.txt three_epoch --params_list 0.5 0.25 0.09 0.01 ../Analysis/ThreeEpochContraction_500/
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochContraction_700/syn_downsampled_sfs.txt three_epoch --params_list 0.5 0.25 0.09 0.01 ../Analysis/ThreeEpochContraction_700/

python evaluate_true_demography_fit.py ../Analysis/ThreeEpochExpansion_10/syn_downsampled_sfs.txt three_epoch --params_list 2.0 4.0 0.09 0.01 ../Analysis/ThreeEpochExpansion_10/
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochExpansion_20/syn_downsampled_sfs.txt three_epoch --params_list 2.0 4.0 0.09 0.01 ../Analysis/ThreeEpochExpansion_20/
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochExpansion_30/syn_downsampled_sfs.txt three_epoch --params_list 2.0 4.0 0.09 0.01 ../Analysis/ThreeEpochExpansion_30/
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochExpansion_50/syn_downsampled_sfs.txt three_epoch --params_list 2.0 4.0 0.09 0.01 ../Analysis/ThreeEpochExpansion_50/
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochExpansion_1000/syn_downsampled_sfs.txt three_epoch --params_list 2.0 4.0 0.09 0.01 ../Analysis/ThreeEpochExpansion_100/
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochExpansion_150/syn_downsampled_sfs.txt three_epoch --params_list 2.0 4.0 0.09 0.01 ../Analysis/ThreeEpochExpansion_150/
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochExpansion_200/syn_downsampled_sfs.txt three_epoch --params_list 2.0 4.0 0.09 0.01 ../Analysis/ThreeEpochExpansion_200/
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochExpansion_300/syn_downsampled_sfs.txt three_epoch --params_list 2.0 4.0 0.09 0.01 ../Analysis/ThreeEpochExpansion_300/
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochExpansion_500/syn_downsampled_sfs.txt three_epoch --params_list 2.0 4.0 0.09 0.01 ../Analysis/ThreeEpochExpansion_500/
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochExpansion_700/syn_downsampled_sfs.txt three_epoch --params_list 2.0 4.0 0.09 0.01 ../Analysis/ThreeEpochExpansion_700/

python evaluate_true_demography_fit.py ../Analysis/ThreeEpochBottleneck_10/syn_downsampled_sfs.txt three_epoch --params_list 0.1 5.0 0.09 0.01 ../Analysis/ThreeEpochBottleneck_10/
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochBottleneck_20/syn_downsampled_sfs.txt three_epoch --params_list 0.1 5.0 0.09 0.01 ../Analysis/ThreeEpochBottleneck_20/
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochBottleneck_30/syn_downsampled_sfs.txt three_epoch --params_list 0.1 5.0 0.09 0.01 ../Analysis/ThreeEpochBottleneck_30/
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochBottleneck_50/syn_downsampled_sfs.txt three_epoch --params_list 0.1 5.0 0.09 0.01 ../Analysis/ThreeEpochBottleneck_50/
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochBottleneck_100/syn_downsampled_sfs.txt three_epoch --params_list 0.1 5.0 0.09 0.01 ../Analysis/ThreeEpochBottleneck_100/
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochBottleneck_150/syn_downsampled_sfs.txt three_epoch --params_list 0.1 5.0 0.09 0.01 ../Analysis/ThreeEpochBottleneck_150/
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochBottleneck_200/syn_downsampled_sfs.txt three_epoch --params_list 0.1 5.0 0.09 0.01 ../Analysis/ThreeEpochBottleneck_200/
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochBottleneck_300/syn_downsampled_sfs.txt three_epoch --params_list 0.1 5.0 0.09 0.01 ../Analysis/ThreeEpochBottleneck_300/
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochBottleneck_500/syn_downsampled_sfs.txt three_epoch --params_list 0.1 5.0 0.09 0.01 ../Analysis/ThreeEpochBottleneck_500/
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochBottleneck_700/syn_downsampled_sfs.txt three_epoch --params_list 0.1 5.0 0.09 0.01 ../Analysis/ThreeEpochBottleneck_700/