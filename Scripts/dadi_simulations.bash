#!/bin/bash
#$ -N dadi_simulations
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=15G
#$ -l h_rt=00:30:00
#$ -t 10-800:10

# SGE_TASK_ID=10

sample_size=$SGE_TASK_ID

python dadi_simulations.py ${sample_size} ../Simulations/dadi_simulations/

python compute_sfs_summary_statistics.py ../Simulations/dadi_simulations/TwoEpochContraction_${sample_size}.sfs ../Simulations/dadi_simulations/TwoEpochContraction_${sample_size}
python compute_sfs_summary_statistics.py ../Simulations/dadi_simulations/ThreeEpochContraction_${sample_size}.sfs ../Simulations/dadi_simulations/ThreeEpochContraction_${sample_size}
python compute_sfs_summary_statistics.py ../Simulations/dadi_simulations/TwoEpochExpansion_${sample_size}.sfs ../Simulations/dadi_simulations/TwoEpochExpansion_${sample_size}
python compute_sfs_summary_statistics.py ../Simulations/dadi_simulations/ThreeEpochExpansion_${sample_size}.sfs ../Simulations/dadi_simulations/ThreeEpochExpansion_${sample_size}
python compute_sfs_summary_statistics.py ../Simulations/dadi_simulations/ThreeEpochBottleneck_${sample_size}.sfs ../Simulations/dadi_simulations/ThreeEpochBottleneck_${sample_size}

python compute_sfs_summary_statistics.py ../Simulations/dadi_simulations/500_2000_${sample_size}.sfs ../Simulations/dadi_simulations/500_2000_${sample_size{}}
python compute_sfs_summary_statistics.py ../Simulations/dadi_simulations/1000_2000_${sample_size}.sfs ../Simulations/dadi_simulations/1000_2000_${sample_size}
python compute_sfs_summary_statistics.py ../Simulations/dadi_simulations/1500_2000_${sample_size}.sfs ../Simulations/dadi_simulations/1500_2000_${sample_size}
oython compute_sfs_summary_statistics.py ../Simulations/dadi_simulations/2000_2000_${sample_size}.sfs ../Simulations/dadi_simulations/2000_2000_${sample_size}
python compute_sfs_summary_statistics.py ../Simulations/dadi_simulations/2500_2000_${sample_size}.sfs ../Simulations/dadi_simulations/2500_2000_${sample_size}

python compute_sfs_summary_statistics.py ../Simulations/dadi_simulations/1000_500_${sample_size}.sfs ../Simulations/dadi_simulations/1000_500_${sample_size}
python compute_sfs_summary_statistics.py ../Simulations/dadi_simulations/1000_1000_${sample_size}.sfs ../Simulations/dadi_simulations/1000_1000_${sample_size}
python compute_sfs_summary_statistics.py ../Simulations/dadi_simulations/1000_1500_${sample_size}.sfs ../Simulations/dadi_simulations/1000_1500_${sample_size}
python compute_sfs_summary_statistics.py ../Simulations/dadi_simulations/1000_2000_${sample_size}.sfs ../Simulations/dadi_simulations/1000_2000_${sample_size}
python compute_sfs_summary_statistics.py ../Simulations/dadi_simulations/1000_2500_${sample_size}.sfs ../Simulations/dadi_simulations/1000_2500_${sample_size}