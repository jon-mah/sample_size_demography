#!/bin/bash
#$ -N msprime_simulations
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=10G
#$ -l h_rt=01:00:00
#$ -t 110:800:10

# SGE_TASK_ID=200

# 10, 20, 100, 200

sample_size=$SGE_TASK_ID
sample_size_one_less=$((sample_size - 1))
# echo $sample_size
# echo $sample_size_one_less

python generate_pops_file.py ${sample_size} ./

for i in $(seq 1 20);
do
    python msprime_simulations.py ${sample_size} ${i} ../Simulations/simple_simulations/
    # easySFS.py -a -f -i ../Simulations/simple_simulations/TwoEpochContraction_${sample_size}_${i}.vcf -p sample_${sample_size}_pops.txt -o ../Simulations/simple_simulations/TwoEpochContraction_${sample_size}_${i} --proj ${sample_size}
    # easySFS.py -a -f -i ../Simulations/simple_simulations/TwoEpochExpansion_${sample_size}_${i}.vcf -p sample_${sample_size}_pops.txt -o ../Simulations/simple_simulations/TwoEpochExpansion_${sample_size}_${i} --proj ${sample_size}
    # easySFS.py -a -f -i ../Simulations/simple_simulations/ThreeEpochContraction_${sample_size}_${i}.vcf -p sample_${sample_size}_pops.txt -o ../Simulations/simple_simulations/ThreeEpochContraction_${sample_size}_${i} --proj ${sample_size}
    # easySFS.py -a -f -i ../Simulations/simple_simulations/ThreeEpochExpansion_${sample_size}_${i}.vcf -p sample_${sample_size}_pops.txt -o ../Simulations/simple_simulations/ThreeEpochExpansion_${sample_size}_${i} --proj ${sample_size}
    easySFS.py -a -f -i ../Simulations/simple_simulations/ThreeEpochBottleneck_${sample_size}_${i}.vcf -p sample_${sample_size}_pops.txt -o ../Simulations/simple_simulations/ThreeEpochBottleneck_${sample_size}_${i} --proj ${sample_size}
    # easySFS.py -a -f -i ../Simulations/simple_simulations/ThreeEpochBottleneck_${sample_size}_${i}.vcf -p sample_${sample_size}_pops.txt -o ../Simulations/simple_simulations/ThreeEpochBottleneck_${sample_size_one_less}_${i} --proj ${sample_size_one_less}
done

# python concat_sfs.py ${sample_size} ../Simulations/simple_simulations/TwoEpochContraction_${sample_size}_
# python concat_sfs.py ${sample_size} ../Simulations/simple_simulations/TwoEpochExpansion_${sample_size}_
# python concat_sfs.py ${sample_size} ../Simulations/simple_simulations/ThreeEpochContraction_${sample_size}_
# python concat_sfs.py ${sample_size} ../Simulations/simple_simulations/ThreeEpochExpansion_${sample_size}_
python concat_sfs.py ${sample_size} ../Simulations/simple_simulations/ThreeEpochBottleneck_${sample_size}_
# python concat_sfs.py ${sample_size_one_less} ../Simulations/simple_simulations/ThreeEpochBottleneck_${sample_size_one_less}_
