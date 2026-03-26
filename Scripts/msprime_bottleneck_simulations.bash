#!/bin/bash
#$ -N bottle_1
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=75G
#$ -l h_rt=23:00:00
#$ -t 10-800:10

# SGE_TASK_ID=230

sample_size=$SGE_TASK_ID

# python generate_pops_file.py ${sample_size} ./

for i in $(seq 1 1);
do
    python msprime_bottleneck_simulations.py ${sample_size} ${i} ../Simulations/simple_simulations/
    easySFS.py -a -f -i ../Simulations/simple_simulations/ThreeEpochBottleneck_200_200_${sample_size}_${i}.vcf -p sample_${sample_size}_pops.txt -o ../Simulations/simple_simulations/ThreeEpochBottleneck_200_200_${sample_size}_${i} --proj ${sample_size}
    easySFS.py -a -f -i ../Simulations/simple_simulations/ThreeEpochBottleneck_400_200_${sample_size}_${i}.vcf -p sample_${sample_size}_pops.txt -o ../Simulations/simple_simulations/ThreeEpochBottleneck_400_200_${sample_size}_${i} --proj ${sample_size}
    easySFS.py -a -f -i ../Simulations/simple_simulations/ThreeEpochBottleneck_600_200_${sample_size}_${i}.vcf -p sample_${sample_size}_pops.txt -o ../Simulations/simple_simulations/ThreeEpochBottleneck_600_200_${sample_size}_${i} --proj ${sample_size}
    easySFS.py -a -f -i ../Simulations/simple_simulations/ThreeEpochBottleneck_800_200_${sample_size}_${i}.vcf -p sample_${sample_size}_pops.txt -o ../Simulations/simple_simulations/ThreeEpochBottleneck_800_200_${sample_size}_${i} --proj ${sample_size}
    easySFS.py -a -f -i ../Simulations/simple_simulations/ThreeEpochBottleneck_1000_200_${sample_size}_${i}.vcf -p sample_${sample_size}_pops.txt -o ../Simulations/simple_simulations/ThreeEpochBottleneck_1000_200_${sample_size}_${i} --proj ${sample_size}
    easySFS.py -a -f -i ../Simulations/simple_simulations/ThreeEpochBottleneck_1200_200_${sample_size}_${i}.vcf -p sample_${sample_size}_pops.txt -o ../Simulations/simple_simulations/ThreeEpochBottleneck_1200_200_${sample_size}_${i} --proj ${sample_size}
    easySFS.py -a -f -i ../Simulations/simple_simulations/ThreeEpochBottleneck_1400_200_${sample_size}_${i}.vcf -p sample_${sample_size}_pops.txt -o ../Simulations/simple_simulations/ThreeEpochBottleneck_1400_200_${sample_size}_${i} --proj ${sample_size}
    easySFS.py -a -f -i ../Simulations/simple_simulations/ThreeEpochBottleneck_1600_200_${sample_size}_${i}.vcf -p sample_${sample_size}_pops.txt -o ../Simulations/simple_simulations/ThreeEpochBottleneck_1600_200_${sample_size}_${i} --proj ${sample_size}
done