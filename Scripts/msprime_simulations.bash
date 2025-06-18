#!/bin/bash
#$ -N msprime_simulations
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=45G
#$ -l h_rt=00:30:00
#$ -t 10-40:10

SGE_TASK_ID=10

sample_size=$SGE_TASK_ID

python generate_pops_file.py ${sample_size} ./

# for i in $(seq 1 20);
# do
#     python msprime_simulations.py ${sample_size} ${i} ../Simulations/simple_simulations/
#     easySFS.py -a -f -i ../Simulations/simple_simulations/TwoEpochContraction_${sample_size}_${i}.vcf -p sample_${sample_size}_pops.txt -o ../Simulations/simple_simulations/TwoEpochContraction_${sample_size}_${i} --proj ${sample_size}
#     easySFS.py -a -f -i ../Simulations/simple_simulations/TwoEpochExpansion_${sample_size}_${i}.vcf -p sample_${sample_size}_pops.txt -o ../Simulations/simple_simulations/TwoEpochExpansion_${sample_size}_${i} --proj ${sample_size}
#     easySFS.py -a -f -i ../Simulations/simple_simulations/ThreeEpochContraction_${sample_size}_${i}.vcf -p sample_${sample_size}_pops.txt -o ../Simulations/simple_simulations/ThreeEpochContraction_${sample_size}_${i} --proj ${sample_size}
#     easySFS.py -a -f -i ../Simulations/simple_simulations/ThreeEpochExpansion_${sample_size}_${i}.vcf -p sample_${sample_size}_pops.txt -o ../Simulations/simple_simulations/ThreeEpochExpansion_${sample_size}_${i} --proj ${sample_size}
#     easySFS.py -a -f -i ../Simulations/simple_simulations/ThreeEpochBottleneck_${sample_size}_${i}.vcf -p sample_${sample_size}_pops.txt -o ../Simulations/simple_simulations/ThreeEpochBottleneck_${sample_size}_${i} --proj ${sample_size}
# done

python concat_sfs.py ${sample_size} ../Simulations/simple_simulations/TwoEpochContraction_${sample_size}
python concat_sfs.py ${sample_size} ../Simulations/simple_simulations/TwoEpochExpansion_${sample_size}
python concat_sfs.py ${sample_size} ../Simulations/simple_simulations/ThreeEpochContraction_${sample_size}
python concat_sfs.py ${sample_size} ../Simulations/simple_simulations/ThreeEpochExpansion_${sample_size}
python concat_sfs.py ${sample_size} ../Simulations/simple_simulations/ThreeEpochBottleneck_${sample_size}
