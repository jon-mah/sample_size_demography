# Notes from Chenlu

Here is a code snippet from Chenlu which provides the file location for a large `.vcf` file for 1K genome (30X sequencing) on `hoffman2`:

    # Specifiy the input directories and files
    dirvcf=/u/project/klohmuel/DataRepository/NYGC_1KG/genotype/
    ## Specify the input files
    inputvcf="20201028_CCDG_14151_B01_GRM_WGS_2020-08-05_"$chr".recalibrated_variants.vcf.gz"

The following pipeline may also be useful:

## Simplified pipeline
* chr11 took the longest time: 603 min.
* Settings in job submission: -l h_rt=23:59:59,h_data=16G; -pe shared 2

0. Inputs and Outputs
Inputs:
* 1kg30X unphased `vcf` files
* YRI sample name
* annotated states BED files
* Specifiying arguments: chr=21

    echo "Step 0: Specify inputs and outputs"
    # Specify the chromosome number. Different chromosomes take different time to run because of the size variation.
    chr='chr21'
    echo "Working on "$chr

    # Specifiy the input directories and files
    dirvcf=/u/project/klohmuel/DataRepository/NYGC_1KG/genotype/
    ## Specify the input files
    inputvcf="20201028_CCDG_14151_B01_GRM_WGS_2020-08-05_"$chr".recalibrated_variants.vcf.gz"
    inputsample='/u/home/c/cdi/project-klohmuel/noncdoingdfe/data/vcf_1kg220425/samples_YRI_2504_108.txt'
    maskfile='/u/home/c/cdi/project-klohmuel/noncdoingdfe/data/vcf_1kg220425/originalfile/20160622.allChr.mask.bed'

    #specify output directories and files
    ## output file
    dirout='/u/home/c/cdi/project-klohmuel/noncdoingdfe/data/vcf_1kg220425/'
    dirtemp='/u/home/c/cdi/project-klohmuel/noncdoingdfe/data/vcf_1kg220425/temp/'
    mkdir $dirtemp

    ## simplify the input names to write output names
    inputsample_fn=$(basename "$inputsample")
    inputsample_fn=${inputsample_fn%.*}
    inputsample_fn="${inputsample_fn#*_}"

    ### Name the output file by samples and chr.
    output1=$dirtemp$inputsample_fn".1kGP."$chr".vcf.gz"
    output2=$dirout'poly.'$input2_name
    output3=$dirout'mask.bisnp.'$inputsample_fn".1kGP."$chr".vcf.gz"
    output5=$dirout'csites.'$chr.tab

1. Get whole chromosome biallelic unmasked `.vcf` for dadi

    # 1.1 only Keep YRI samples in VCF file to speed up
    echo "Step 1.1 only Keep YRI samples in VCF file to speed up"

    ## Use bcftools to get samples in inputsample file.
    echo "Load bcftools"
    module load bcftools
    echo "time bcftools view -S $inputsample $dirvcf$inputvcf --force-samples | gzip -c > $output1"
    echo "This step takes a long time. Make sure to allocate enough time and memory. For reference, chr21 took 30-50 minutes, tested in using 10G memory but could work using less memory."
    time bcftools view -S $inputsample $dirvcf$inputvcf --force-samples | gzip -c > $output1

    ## Check if the process has finished correctly.
    echo "Check if the process has finished correctly."
    ## The lines of output1 should be same or very clsose to the input.
    ## If the difference is large, kill the script.

    ### Count the number of lines in inputvcf and output1.
    lines_inputvcf=$(zcat $dirvcf$inputvcf | wc -l)
    lines_output1=$(zcat $output1 | wc -l)

    ### Calculate the absolute difference in line counts
    diff_lines=$((lines_inputvcf - lines_output1))
    absolute_diff_lines=${diff_lines#-}

    ### Check if the absolute difference is greater than 10
    if [ "$absolute_diff_lines" -gt 10 ]; then
        echo "Error: erros in step1 in getting samples. The difference in line counts between 1kgp input vcf file and output sample.vcf file is more than 10 lines. Maybe increasing time and memory.Exiting."
        exit 1
    fi


    ###output file is YRI_2504_108.1kGP.chr21.vcf.gz

    # 1.2 Only keep biallelic SNPs by using bcftools
    echo "Step 1.2 Only keep biallelic SNPs by using bcftools.This took 6-10 min for chr21."
    input2=$output1
    input2_name=$(basename "$input2")

    ## Remove monomorphic sites in the population
    ### I think if a site will be considered as monomorphic if it is 0 or 1 at all samples except for missing samples. That is only having '0' and '.' is monomorphic, same as '1' and '.'
    echo "Remove monomorphic sites in the population."
    bcftools view -c 1 $input2 -Oz -o $output2

    ## This only keeps SNPs but not sites that are both indels and SNPs.
    echo "only keeps SNPs: no indels or others"
    bcftools view -i 'TYPE="snp"' $output2 -Oz -o $dirtemp'temp_snp.'$input2_name

    ## Only keep biallelic SNPs
    echo "Only keep biallelic SNPs"
    bcftools view -m2 -M2 -v snps $dirtemp'temp_snp.'$input2_name -Oz -o $dirtemp'temp_bisnp.'$input2_name


    # 1.3 Only keep masked sites using bedtools and maskfile
    ## load bedtools
    echo "Step 1.3 Only keep masked sites using bedtools and maskfile"
    echo "Load bedtools"
    module load bedtools

    ## grep chr.maskfile to speed up
    chrmask=$chr.$(basename "$maskfile")
    ###!!!!! use grep $chr will grep more than needed.
    ###For example, chr1, chr11, chr12 will all be included if grep chr1. But this mistake is okay in this step. It just slows down the process.
    ###grep $chr $maskfile>$chrmask
    grep "^$chr[[:space:]]" $maskfile>$chrmask
    echo "Get mask file for "$chr" :"$chrmask

    ##
    input3=$dirtemp'temp_bisnp.'$input2_name
    gzip -d $input3
    input3="${input3%.*}"
    bedtools intersect -a $input3 -b $chrmask -header | gzip > $output3
    gzip $input3
    echo "Get vcf file pass maskfile :"$output3

    # 1.4 Check if there are duplicated sites in the mask.biallelic.vcf.gz file

    echo "Step 1.4 Check if there are duplicated sites in the mask.biallelic.vcf.gz file: "$output3

    ## remove .vcf.gz extension from $output3 to name the simplified position txt file.
    output3_name=$(basename "$output3")
    output3_namenoext="${output3_name%.*}"
    output3_namenoext="${output3_namenoext%.*}"
    simppos=$dirtemp'temp_pos.'$output3_namenoext'.txt'
    posdup=$dirtemp'temp_dupsites.'$output3_namenoext'.txt'

    bcftools query -f '%CHROM\ %POS\n' $output3 >$simppos

    sort $simppos | uniq -d > $posdup

    if [ "$(cat $posdup| wc -l)" = 0 ]
    then
    echo "No duplicate sites in "$dirout$output3_name
    rm $simppos $posdup
    else
    echo "Warning: duplicated sites in "$dirout$output3_name
    echo "Please find duplicated sites in $posdup"
    rm $simppos
    fi

    # 1.5 Record the number of sites in different steps

    ## If there is no duplicates. Record the number and file names.

    ### It's better to count the number of sites instead of number of lines by removing lines start with "#"
    ### The lines start with "#" for vcf.gz file can be countted by  zgrep -c '^#' $file
    Linputvcf=$lines_inputvcf
    Lsamples=$lines_output1

    f3=$output2
    L3="$(zcat $output2| wc -l)"
    f4='temp_snp.'$input2_name
    L4="$(zcat $dirtemp$f4| wc -l)"
    f5='temp_bisnp.'$input2_name
    L5="$(zcat $dirtemp$f5| wc -l)"

    LmaskbiSNPs="$(zcat $output3| wc -l)"

    cisite_counts="$inputvcf\t$Linputvcf\t$(basename "$output1")\t$Lsamples\t$f2\t$L2\t$f3\t$L3\t$f4\t$L4\t$f5\t$L5\t$output3\t$LmaskbiSNPs"
    if [ "$(cat $dirtemp'temp_dupsites.'$output3_name| wc -l)" = 0 ]
    then
    echo -e "$chr\t$cisite_counts\t'no duplicated sites'" >>$output5
    else
    echo -e $chr\t$csites\t"check duplicated sites in "temp_dupsites.$output3_name >>$output5
    fi
