# Notes from Diana

Here is a `.bash` script which downloads genome data from 1000genomes by chromosomes, which downloads "the whole panel":

  #!/bin/bash
  for i in {1..22};
  do echo $i
  chr=chr$i
  echo $chr
  wget http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/1000_genomes_project/release/20181203_biallelic_SNV/ALL.${chr}.shapeit2_integrated_v1a.GRCh38.20181129.phased.vcf.gz{,.tbi};
  done

Here is a `.bash` script which extracts samples:

  for i in {1..22};
  do echo $i
  chr=chr$i
  echo $chr
  bcftools view -S indvsamples1000genomes -o $chr.female1000genomes.vcf.gz --force-samples -Oz ALL.${chr}.shapeit2_integrated_v1a.GRCh38.20181129.phased.vcf.gz &
  done

The following file would contain individual ID's:

  indvsamples1000genomes

Depending on which population we want, we can get a list from 1000genomes and then `grep` the population that we want. The website can be found [here](https://www.internationalgenome.org/data-portal/sample).

We can download the list of all populations in `.tsv` format.

From here, we can:

  grep “EUR” igsr_samples.tsv |cut -f1 > EURindividuals
