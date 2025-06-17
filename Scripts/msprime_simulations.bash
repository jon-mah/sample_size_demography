#!/bin/bash
#$ -N msprime_simulations
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=45G
#$ -l h_rt=00:30:00
#$ -t 1-1000:10

sample_size=$SGE_TASK_ID

python msprime_simulations.py ${sample_size} ../Simulations/simple_simulations/

python generate_pops_file.py ${sample_size} ./

easySFS.py -a -f -i ../Simulations/simple_simulations/TwoEpochContraction_${sample_size}.vcf -p sample_1000_pops.txt -o ../Simulations/simple_simulations/TwoEpochContraction_${sample_size} --proj ${sample_size}
easySFS.py -a -f -i ../Simulations/simple_simulations/TwoEpochExpansion_${sample_size}.vcf -p sample_1000_pops.txt -o ../Simulations/simple_simulations/TwoEpochExpansion_${sample_size} --proj ${sample_size}
easySFS.py -a -f -i ../Simulations/simple_simulations/ThreeEpochContraction_${sample_size}.vcf -p sample_1000_pops.txt -o ../Simulations/simple_simulations/ThreeEpochContraction_${sample_size} --proj ${sample_size}
easySFS.py -a -f -i ../Simulations/simple_simulations/ThreeEpochExpansion_${sample_size}.vcf -p sample_1000_pops.txt -o ../Simulations/simple_simulations/ThreeEpochExpansion_${sample_size} --proj ${sample_size}
easySFS.py -a -f -i ../Simulations/simple_simulations/ThreeEpochBottleneck_${sample_size}.vcf -p sample_1000_pops.txt -o ../Simulations/simple_simulations/ThreeEpochBottleneck_${sample_size} --proj ${sample_size}
