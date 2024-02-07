#!/bin/bash
#$ -N downsample_sfs.bash
#$ -cwd # Run qsub script from desired working directory
#$ -V
#$ -e /u/home/j/jonmah/postproc_error
#$ -o /u/home/j/jonmah/postproc_output
#$ -l h_data=15G
#$ -l h_rt=00:30:00
#$ -t 1-24

SGE_TASK_ID=1

# Define the path to the file
file="stdpopsim_simulations.txt"

# Get the line number i from SGE_TASK_ID
i=$SGE_TASK_ID

# Check if SGE_TASK_ID is set
if [ -z "$i" ]; then
  echo "SGE_TASK_ID is not set. Please run this script in a Sun Grid Engine environment."
  exit 1
fi

# Check if the file exists
if [ ! -e "$file" ]; then
  echo "File $file not found."
  exit 1
fi

# Read the ith line from the file
line=$(sed -n "${i}p" "$file")

# Check if the line is empty
if [ -z "$line" ]; then
  echo "No line found at index $i."
  exit 1
fi

# Execute the command
# eval "$line"
substring=$(echo "$line" | grep -oP '\-o\s+\K[^ ]+')
extracted=$(echo "$substring" | sed 's/.*\/Simulations\///')
outfile="${extracted%.trees}"

# Convert msprime .trees to .vcf format
tskit vcf ../Simulations/${outfile}.trees > ../Simulations/${outfile}.vcf

easySFS.py -a -f -i ../Simulations/${outfile}.vcf -p sample_10_pops.txt -o ../Simulations/${outfile}_sfs --proj 10
