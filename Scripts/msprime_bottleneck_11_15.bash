#!/bin/bash
#$ -N msprime_bottle_11_15
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=45G
#$ -l h_rt=01:00:00
#$ -t 10-800:10

# SGE_TASK_ID=10

sample_size=$SGE_TASK_ID

# python generate_pops_file.py ${sample_size} ./

for i in $(seq 11 15);
do
    python msprime_bottleneck_simulations.py ${sample_size} ${i} ../Simulations/simple_simulations/
    easySFS.py -a -f -i ../Simulations/simple_simulations/ThreeEpochBottleneck_1000_500_${sample_size}_${i}.vcf -p sample_${sample_size}_pops.txt -o ../Simulations/simple_simulations/ThreeEpochBottleneck_1000_500_${sample_size}_${i} --proj ${sample_size}
    easySFS.py -a -f -i ../Simulations/simple_simulations/ThreeEpochBottleneck_1000_1000_${sample_size}_${i}.vcf -p sample_${sample_size}_pops.txt -o ../Simulations/simple_simulations/ThreeEpochBottleneck_1000_1000_${sample_size}_${i} --proj ${sample_size}
    easySFS.py -a -f -i ../Simulations/simple_simulations/ThreeEpochBottleneck_1000_1500_${sample_size}_${i}.vcf -p sample_${sample_size}_pops.txt -o ../Simulations/simple_simulations/ThreeEpochBottleneck_1000_1500_${sample_size}_${i} --proj ${sample_size}
    easySFS.py -a -f -i ../Simulations/simple_simulations/ThreeEpochBottleneck_1000_2000_${sample_size}_${i}.vcf -p sample_${sample_size}_pops.txt -o ../Simulations/simple_simulations/ThreeEpochBottleneck_1000_2000_${sample_size}_${i} --proj ${sample_size}
    easySFS.py -a -f -i ../Simulations/simple_simulations/ThreeEpochBottleneck_500_2000_${sample_size}_${i}.vcf -p sample_${sample_size}_pops.txt -o ../Simulations/simple_simulations/ThreeEpochBottleneck_500_2000_${sample_size}_${i} --proj ${sample_size}
    easySFS.py -a -f -i ../Simulations/simple_simulations/ThreeEpochBottleneck_1500_2000_${sample_size}_${i}.vcf -p sample_${sample_size}_pops.txt -o ../Simulations/simple_simulations/ThreeEpochBottleneck_1500_2000_${sample_size}_${i} --proj ${sample_size}
    easySFS.py -a -f -i ../Simulations/simple_simulations/ThreeEpochBottleneck_2000_2000_${sample_size}_${i}.vcf -p sample_${sample_size}_pops.txt -o ../Simulations/simple_simulations/ThreeEpochBottleneck_2000_2000_${sample_size}_${i} --proj ${sample_size}
done

# python concat_sfs.py ${sample_size} ../Simulations/simple_simulations/ThreeEpochBottleneck_1000_500_${sample_size}
# python concat_sfs.py ${sample_size} ../Simulations/simple_simulations/ThreeEpochBottleneck_1000_1000_${sample_size}
# python concat_sfs.py ${sample_size} ../Simulations/simple_simulations/ThreeEpochBottleneck_1000_1500_${sample_size}
# python concat_sfs.py ${sample_size} ../Simulations/simple_simulations/ThreeEpochBottleneck_1000_2000_${sample_size}
# python concat_sfs.py ${sample_size} ../Simulations/simple_simulations/ThreeEpochBottleneck_500_2000_${sample_size}
# python concat_sfs.py ${sample_size} ../Simulations/simple_simulations/ThreeEpochBottleneck_1500_2000_${sample_size}
# python concat_sfs.py ${sample_size} ../Simulations/simple_simulations/ThreeEpochBottleneck_2000_2000_${sample_size}
