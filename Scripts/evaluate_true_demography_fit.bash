#!/bin/bash
#$ -cwd
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=15G
#$ -l h_rt=00:30:00

python evaluate_true_demography_fit.py ../Analysis/TwoEpochContraction_10/syn_downsampled_sfs.txt two_epoch ../Analysis/TwoEpochContraction_10/ --params_list 0.5 0.1 
python evaluate_true_demography_fit.py ../Analysis/TwoEpochContraction_20/syn_downsampled_sfs.txt two_epoch  ../Analysis/TwoEpochContraction_20/ --params_list 0.5 0.1
python evaluate_true_demography_fit.py ../Analysis/TwoEpochContraction_30/syn_downsampled_sfs.txt two_epoch ../Analysis/TwoEpochContraction_30/ --params_list 0.5 0.1
python evaluate_true_demography_fit.py ../Analysis/TwoEpochContraction_50/syn_downsampled_sfs.txt two_epoch ../Analysis/TwoEpochContraction_50/ --params_list 0.5 0.1
python evaluate_true_demography_fit.py ../Analysis/TwoEpochContraction_100/syn_downsampled_sfs.txt two_epoch ../Analysis/TwoEpochContraction_100/ --params_list 0.5 0.1
python evaluate_true_demography_fit.py ../Analysis/TwoEpochContraction_150/syn_downsampled_sfs.txt two_epoch ../Analysis/TwoEpochContraction_150/ --params_list 0.5 0.1
python evaluate_true_demography_fit.py ../Analysis/TwoEpochContraction_200/syn_downsampled_sfs.txt two_epoch ../Analysis/TwoEpochContraction_200/ --params_list 0.5 0.1
python evaluate_true_demography_fit.py ../Analysis/TwoEpochContraction_300/syn_downsampled_sfs.txt two_epoch ../Analysis/TwoEpochContraction_300/ --params_list 0.5 0.1
python evaluate_true_demography_fit.py ../Analysis/TwoEpochContraction_500/syn_downsampled_sfs.txt two_epoch ../Analysis/TwoEpochContraction_500/ --params_list 0.5 0.1
python evaluate_true_demography_fit.py ../Analysis/TwoEpochContraction_700/syn_downsampled_sfs.txt two_epoch ../Analysis/TwoEpochContraction_700/ --params_list 0.5 0.1

python evaluate_true_demography_fit.py ../Analysis/TwoEpochExpansion_10/syn_downsampled_sfs.txt two_epoch ../Analysis/TwoEpochExpansion_10/ --params_list 2.0 0.01
python evaluate_true_demography_fit.py ../Analysis/TwoEpochExpansion_20/syn_downsampled_sfs.txt two_epoch ../Analysis/TwoEpochExpansion_20/ --params_list 2.0 0.01
python evaluate_true_demography_fit.py ../Analysis/TwoEpochExpansion_30/syn_downsampled_sfs.txt two_epoch ../Analysis/TwoEpochExpansion_30/ --params_list 2.0 0.01
python evaluate_true_demography_fit.py ../Analysis/TwoEpochExpansion_50/syn_downsampled_sfs.txt two_epoch ../Analysis/TwoEpochExpansion_50/ --params_list 2.0 0.01
python evaluate_true_demography_fit.py ../Analysis/TwoEpochExpansion_100/syn_downsampled_sfs.txt two_epoch ../Analysis/TwoEpochExpansion_100/ --params_list 2.0 0.01
python evaluate_true_demography_fit.py ../Analysis/TwoEpochExpansion_150/syn_downsampled_sfs.txt two_epoch ../Analysis/TwoEpochExpansion_150/ --params_list 2.0 0.01
python evaluate_true_demography_fit.py ../Analysis/TwoEpochExpansion_200/syn_downsampled_sfs.txt two_epoch ../Analysis/TwoEpochExpansion_200/ --params_list 2.0 0.01
python evaluate_true_demography_fit.py ../Analysis/TwoEpochExpansion_300/syn_downsampled_sfs.txt two_epoch ../Analysis/TwoEpochExpansion_300/ --params_list 2.0 0.01
python evaluate_true_demography_fit.py ../Analysis/TwoEpochExpansion_500/syn_downsampled_sfs.txt two_epoch ../Analysis/TwoEpochExpansion_500/ --params_list 2.0 0.01
python evaluate_true_demography_fit.py ../Analysis/TwoEpochExpansion_700/syn_downsampled_sfs.txt two_epoch ../Analysis/TwoEpochExpansion_700/ --params_list 2.0 0.01

python evaluate_true_demography_fit.py ../Analysis/ThreeEpochContraction_10/syn_downsampled_sfs.txt three_epoch ../Analysis/ThreeEpochContraction_10/ --params_list 0.5 0.25 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochContraction_20/syn_downsampled_sfs.txt three_epoch ../Analysis/ThreeEpochContraction_20/ --params_list 0.5 0.25 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochContraction_30/syn_downsampled_sfs.txt three_epoch ../Analysis/ThreeEpochContraction_30/ --params_list 0.5 0.25 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochContraction_50/syn_downsampled_sfs.txt three_epoch ../Analysis/ThreeEpochContraction_50/ --params_list 0.5 0.25 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochContraction_100/syn_downsampled_sfs.txt three_epoch ../Analysis/ThreeEpochContraction_100/ --params_list 0.5 0.25 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochContraction_150/syn_downsampled_sfs.txt three_epoch ../Analysis/ThreeEpochContraction_150/ --params_list 0.5 0.25 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochContraction_200/syn_downsampled_sfs.txt three_epoch ../Analysis/ThreeEpochContraction_200/ --params_list 0.5 0.25 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochContraction_300/syn_downsampled_sfs.txt three_epoch ../Analysis/ThreeEpochContraction_300/ --params_list 0.5 0.25 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochContraction_500/syn_downsampled_sfs.txt three_epoch ../Analysis/ThreeEpochContraction_500/ --params_list 0.5 0.25 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochContraction_700/syn_downsampled_sfs.txt three_epoch ../Analysis/ThreeEpochContraction_700/ --params_list 0.5 0.25 0.09 0.01

python evaluate_true_demography_fit.py ../Analysis/ThreeEpochExpansion_10/syn_downsampled_sfs.txt three_epoch ../Analysis/ThreeEpochExpansion_10/ --params_list 2.0 4.0 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochExpansion_20/syn_downsampled_sfs.txt three_epoch ../Analysis/ThreeEpochExpansion_20/ --params_list 2.0 4.0 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochExpansion_30/syn_downsampled_sfs.txt three_epoch ../Analysis/ThreeEpochExpansion_30/ --params_list 2.0 4.0 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochExpansion_50/syn_downsampled_sfs.txt three_epoch ../Analysis/ThreeEpochExpansion_50/ --params_list 2.0 4.0 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochExpansion_1000/syn_downsampled_sfs.txt three_epoch ../Analysis/ThreeEpochExpansion_100/ --params_list 2.0 4.0 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochExpansion_150/syn_downsampled_sfs.txt three_epoch ../Analysis/ThreeEpochExpansion_150/ --params_list 2.0 4.0 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochExpansion_200/syn_downsampled_sfs.txt three_epoch ../Analysis/ThreeEpochExpansion_200/ --params_list 2.0 4.0 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochExpansion_300/syn_downsampled_sfs.txt three_epoch ../Analysis/ThreeEpochExpansion_300/ --params_list 2.0 4.0 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochExpansion_500/syn_downsampled_sfs.txt three_epoch ../Analysis/ThreeEpochExpansion_500/ --params_list 2.0 4.0 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochExpansion_700/syn_downsampled_sfs.txt three_epoch ../Analysis/ThreeEpochExpansion_700/ --params_list 2.0 4.0 0.09 0.01

python evaluate_true_demography_fit.py ../Analysis/ThreeEpochBottleneck_10/syn_downsampled_sfs.txt three_epoch ../Analysis/ThreeEpochBottleneck_10/ --params_list 0.1 5.0 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochBottleneck_20/syn_downsampled_sfs.txt three_epoch ../Analysis/ThreeEpochBottleneck_20/ --params_list 0.1 5.0 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochBottleneck_30/syn_downsampled_sfs.txt three_epoch ../Analysis/ThreeEpochBottleneck_30/ --params_list 0.1 5.0 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochBottleneck_50/syn_downsampled_sfs.txt three_epoch ../Analysis/ThreeEpochBottleneck_50/ --params_list 0.1 5.0 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochBottleneck_100/syn_downsampled_sfs.txt three_epoch ../Analysis/ThreeEpochBottleneck_100/ --params_list 0.1 5.0 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochBottleneck_150/syn_downsampled_sfs.txt three_epoch ../Analysis/ThreeEpochBottleneck_150/ --params_list 0.1 5.0 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochBottleneck_200/syn_downsampled_sfs.txt three_epoch ../Analysis/ThreeEpochBottleneck_200/ --params_list 0.1 5.0 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochBottleneck_300/syn_downsampled_sfs.txt three_epoch ../Analysis/ThreeEpochBottleneck_300/ --params_list 0.1 5.0 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochBottleneck_500/syn_downsampled_sfs.txt three_epoch ../Analysis/ThreeEpochBottleneck_500/ --params_list 0.1 5.0 0.09 0.01
python evaluate_true_demography_fit.py ../Analysis/ThreeEpochBottleneck_700/syn_downsampled_sfs.txt three_epoch ../Analysis/ThreeEpochBottleneck_700/ --params_list 0.1 5.0 0.09 0.01