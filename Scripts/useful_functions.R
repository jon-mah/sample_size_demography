library(ggplot2)
library(ggrepel)
library(ggsignif)
#install.packages("ggpubr")
library(ggpubr)
library(dplyr)
library(fitdistrplus)
library(scales)
library(reshape2)
library(stringr)
library(ggridges)
library(forcats)
library("ggrepel")
library(ggallin)
library(patchwork)
library(ape)
library(ggtree)
library(treeio)
# install.packages('plotly')
library(plotly)
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
library(latex2exp)
library(ggvis)
library(pheatmap)
library(ComplexHeatmap)
library(phytools)
# BiocManager::install("ComplexHeatmap")
library(mdthemes)
library(ggborderline)


# BiocManager::install("treeio")
# BiocManager::install("ggtree")

fold_sfs = function(input_sfs) {
  input_length = length(input_sfs)
  folded_length = length(input_sfs) / 2
  if (input_length %% 2 == 1) {
    folded_length = folded_length + 1
  }
  output_sfs = c()
  for (i in 1:folded_length) {
    if (input_sfs[i] == input_sfs[input_length - i + 1]) {
      output_sfs[i] = input_sfs[i]
    } else {
      output_sfs[i] = input_sfs[i] + input_sfs[input_length - i + 1]
    }
  }
  return(output_sfs)
}

proportional_sfs = function(input_sfs) {
  return (input_sfs / sum(input_sfs))
}

read_input_sfs = function(input_file)  {
  ## Reads input SFS in Dadi Format
  this_file = file(input_file)
  on.exit(close(this_file))
  sfs_string = readLines(this_file)[2]
  output_sfs = as.numeric(unlist(strsplit(sfs_string, ' ')))
  output_sfs = output_sfs[-1] ## Remove 0-tons
  output_sfs = output_sfs[-length(output_sfs)]
  output_sfs = fold_sfs(output_sfs)
  return(output_sfs)
}

read_unfolded_input_sfs = function(input_file)  {
  ## Reads input SFS in Dadi Format
  this_file = file(input_file)
  on.exit(close(this_file))
  sfs_string = readLines(this_file)[2]
  output_sfs = as.numeric(unlist(strsplit(sfs_string, ' ')))
  output_sfs = output_sfs[-1] ## Remove 0-tons
  output_sfs = output_sfs[-length(output_sfs)]
  return(output_sfs)
}

sfs_from_demography = function(input_file) {
  ## Reads input SFS from output *demography.txt
  this_file = file(input_file)
  on.exit(close(this_file))
  sfs_string = readLines(this_file)[8]
  output_sfs = strsplit(sfs_string, '-- ')
  output_sfs = unlist(output_sfs)[2]
  output_sfs = unlist(strsplit(output_sfs, ' '))
  # output_sfs = output_sfs[-length(output_sfs)]
  ## output_sfs = output_sfs[-1]
  output_sfs = as.numeric(output_sfs)
  # output_sfs = fold_sfs(output_sfs)
  return(output_sfs)
}

calculate_rare_variant_proportion = function(sfs) {
  # Determine length of given SFS
  n = length(sfs)
  # Calculate proportion of SFS considered
  # to be rare variants.
  rare_variant_cutoff = ceiling(n / 10)
  # calculate total number of SNPs
  total_sum = sum(sfs)
  # Calculate number of rare variants
  rare_variant_sum = sum(sfs[1:rare_variant_cutoff])
  proportion = rare_variant_sum / total_sum
  return(proportion)
}

compare_one_two_three_sfs = function(empirical, one_epoch, two_epoch, three_epoch) {
  x_axis = 1:length(empirical)
  input_df = data.frame(empirical,
                        one_epoch,
                        two_epoch,
                        three_epoch,
                        x_axis)
  
  names(input_df) = c('Empirical',
                      'One-epoch',
                      'Two-epoch',
                      'Three-epoch',
                      'x_axis')
  
  p_input_comparison <- ggplot(data = melt(input_df, id='x_axis'),
                                                     aes(x=x_axis, 
                                                         y=value,
                                                         fill=variable)) +
    geom_bar(position='dodge2', stat='identity') +
    labs(x = "", fill = "") +
    scale_x_continuous(name='Minor allele frequency in sample', breaks=x_axis, limits=c(0.5, length(x_axis) + 0.5)) +
    ylab('Number of segregating sites') +
    theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
    ## scale_fill_manual(values=c("darkslateblue", "darkslategrey", "darkturquoise"))
  
  return(p_input_comparison)
}

compare_one_two_three_proportional_sfs = function(empirical, one_epoch, two_epoch, three_epoch) {
  x_axis = 1:length(empirical)
  empirical = proportional_sfs(empirical)
  one_epoch = proportional_sfs(one_epoch)
  two_epoch = proportional_sfs(two_epoch)
  three_epoch = proportional_sfs(three_epoch)
  input_df = data.frame(empirical,
                        one_epoch,
                        two_epoch,
                        three_epoch,
                        x_axis)
  
  names(input_df) = c('Empirical',
                      'One-epoch',
                      'Two-epoch',
                      'Three-epoch',
                      'x_axis')
  
  p_input_comparison <- ggplot(data = melt(input_df, id='x_axis'),
                                                     aes(x=x_axis, 
                                                         y=value,
                                                         fill=variable)) +
    geom_bar(position='dodge2', stat='identity') +
    labs(x = "", fill = "") +
    scale_x_continuous(name='Minor allele frequency in sample', breaks=x_axis, limits=c(0.5, length(x_axis) + 0.5)) +
    ylab('Proportion of segregating sites') +
    theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
    ## scale_fill_manual(values=c("darkslateblue", "darkslategrey", "darkturquoise"))
  
  return(p_input_comparison)
}

compare_one_two_three_proportional_sfs_cutoff = function(empirical, one_epoch, two_epoch, three_epoch) {
  x_axis = 1:10
  empirical = proportional_sfs(empirical)[1:10]
  one_epoch = proportional_sfs(one_epoch)[1:10]
  two_epoch = proportional_sfs(two_epoch)[1:10]
  three_epoch = proportional_sfs(three_epoch)[1:10]
  input_df = data.frame(empirical,
                        one_epoch,
                        two_epoch,
                        three_epoch,
                        x_axis)
  
  names(input_df) = c('Empirical',
                      'One-epoch',
                      'Two-epoch',
                      'Three-epoch',
                      'x_axis')
  
  p_input_comparison <- ggplot(data = melt(input_df, id='x_axis'),
                                                     aes(x=x_axis, 
                                                         y=value,
                                                         fill=variable)) +
    geom_bar(position='dodge2', stat='identity') +
    labs(x = "", fill = "") +
    scale_x_continuous(name='Minor allele frequency in sample (up to 10)', breaks=x_axis, limits=c(0.5, length(x_axis) + 0.5)) +
    ylab('Proportion of segregating sites') +
    theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
    ## scale_fill_manual(values=c("darkslateblue", "darkslategrey", "darkturquoise"))
  
  return(p_input_comparison)
}

compare_two_three_true_proportional_sfs_cutoff = function(empirical, two_epoch, three_epoch, true_demography) {
  x_axis = 1:10
  empirical = proportional_sfs(empirical)[1:10]
  two_epoch = proportional_sfs(two_epoch)[1:10]
  three_epoch = proportional_sfs(three_epoch)[1:10]
  true_demography = proportional_sfs(true_demography)[1:10]
  input_df = data.frame(empirical,
                        two_epoch,
                        three_epoch,
                        true_demography,
                        x_axis)
  
  names(input_df) = c('Empirical',
                      'Two-epoch',
                      'Three-epoch',
                      'True demography',
                      'x_axis')
  
  p_input_comparison <- ggplot(data = melt(input_df, id='x_axis'),
                                                     aes(x=x_axis, 
                                                         y=value,
                                                         fill=variable)) +
    geom_bar(position='dodge2', stat='identity') +
    labs(x = "", fill = "") +
    scale_x_continuous(name='Minor allele frequency in sample (up to 10)', breaks=x_axis, limits=c(0.5, length(x_axis) + 0.5)) +
    ylab('Proportion of segregating sites') +
    theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
    scale_fill_manual(values=c("blue", "red", "green", "black"))
  
  return(p_input_comparison)
}

compare_syn_nonsyn_count = function(empirical_syn, empirical_nonsyn) {
  x_axis = 1:20
  input_df = data.frame(empirical_syn[1:20],
                        empirical_nonsyn[1:20],
                        x_axis)
  
  names(input_df) = c('Empirical synonymous',
                      'Empirical nonsynonymous',
                      'x_axis')
  
  p_input_comparison <- ggplot(data = melt(input_df, id='x_axis'),
                                                     aes(x=x_axis, 
                                                         y=value,
                                                         fill=variable)) +
    geom_bar(position='dodge2', stat='identity') +
    labs(x = "", fill = "") +
    scale_x_continuous(name='Minor allele frequency in sample', breaks=x_axis, limits=c(0.5, length(x_axis) + 0.5)) +
    ylab('Number of segregating sites') +
    theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))

  return(p_input_comparison)
}

compare_null_sfs = function(empirical, one_epoch) {
  x_axis = 1:length(empirical)
  input_df = data.frame(empirical,
                        one_epoch,
                        x_axis)
  
  names(input_df) = c('Empirical',
                      'One-epoch',
                      'x_axis')
  
  p_input_comparison <- ggplot(data = melt(input_df, id='x_axis'),
                                                     aes(x=x_axis, 
                                                         y=value,
                                                         fill=variable)) +
    geom_bar(position='dodge2', stat='identity') +
    labs(x = "", fill = "") +
    scale_x_continuous(name='Minor allele frequency in sample', breaks=x_axis, limits=c(0.5, length(x_axis) + 0.5)) +
    ylab('Number of segregating sites') +
    theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))

  return(p_input_comparison)
}

compare_null_sfs_proportional = function(empirical, one_epoch) {
  x_axis = 1:length(empirical)
  empirical = proportional_sfs(empirical)
  one_epoch = proportional_sfs(one_epoch)
  input_df = data.frame(empirical,
                        one_epoch,
                        x_axis)
  
  names(input_df) = c('Empirical',
                      'One-epoch',
                      'x_axis')
  
  p_input_comparison <- ggplot(data = melt(input_df, id='x_axis'),
                                                     aes(x=x_axis, 
                                                         y=value,
                                                         fill=variable)) +
    geom_bar(position='dodge2', stat='identity') +
    labs(x = "", fill = "") +
    scale_x_continuous(name='Minor allele frequency in sample', breaks=x_axis, limits=c(0.5, length(x_axis) + 0.5)) +
    ylab('Proportion of segregating sites') +
    theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))

  return(p_input_comparison)
}

compare_1kg_gnomad_null_proportional_cutoff = function(empirical_1kg, empirical_gnomad, one_epoch) {
  x_axis = 1:10
  empirical_1kg = proportional_sfs(empirical_1kg)[1:10]
  empirical_gnomad = proportional_sfs(empirical_gnomad)[1:10]
  one_epoch = proportional_sfs(one_epoch)[1:10]
  input_df = data.frame(empirical_1kg,
                        empirical_gnomad,
                        one_epoch,
                        x_axis)
  
  names(input_df) = c('Empirical 1KG',
                      'Empirical gnomAD',
                      'One-epoch',
                      'x_axis')
  
  p_input_comparison <- ggplot(data = melt(input_df, id='x_axis'),
                                                     aes(x=x_axis, 
                                                         y=value,
                                                         fill=variable)) +
    geom_bar(position='dodge2', stat='identity') +
    labs(x = "", fill = "") +
    scale_x_continuous(name='Minor allele frequency in sample (up to 10)', breaks=x_axis, limits=c(0.5, length(x_axis) + 0.5)) +
    ylab('Proportion of segregating sites') +
    theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
    ## scale_fill_manual(values=c("darkslateblue", "darkslategrey", "darkturquoise"))
  
  return(p_input_comparison)
}

compare_1kg_gnomad_null_proportional_cutoff = function(old_1kg, empirical_1kg, empirical_gnomad, one_epoch) {
  x_axis = 1:10
  old_1kg = proportional_sfs(old_1kg)[1:10]
  empirical_1kg = proportional_sfs(empirical_1kg)[1:10]
  empirical_gnomad = proportional_sfs(empirical_gnomad)[1:10]
  one_epoch = proportional_sfs(one_epoch)[1:10]
  input_df = data.frame(old_1kg,
                        empirical_1kg,
                        empirical_gnomad,
                        one_epoch,
                        x_axis)
  
  names(input_df) = c('Empirical 1KG (2017)',
                      'Empirical 1KG (2020',
                      'Empirical gnomAD',
                      'One-epoch',
                      'x_axis')
  
  p_input_comparison <- ggplot(data = melt(input_df, id='x_axis'),
                                                     aes(x=x_axis, 
                                                         y=value,
                                                         fill=variable)) +
    geom_bar(position='dodge2', stat='identity') +
    labs(x = "", fill = "") +
    scale_x_continuous(name='Minor allele frequency in sample (up to 10)', breaks=x_axis, limits=c(0.5, length(x_axis) + 0.5)) +
    ylab('Proportion of segregating sites') +
    theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
    ## scale_fill_manual(values=c("darkslateblue", "darkslategrey", "darkturquoise"))
  
  return(p_input_comparison)
}

compare_demographic_models_proportional_cutoff = function(old_1kg, model_1kg, model_gnomad) {
  x_axis = 1:10
  old_1kg = proportional_sfs(old_1kg)[1:10]
  model_1kg = proportional_sfs(model_1kg)[1:10]
  model_gnomad = proportional_sfs(model_gnomad)[1:10]
  input_df = data.frame(old_1kg,
                        model_1kg,
                        model_gnomad,
                        x_axis)
  
  names(input_df) = c('1KG (2017) best-fit',
                      '1KG (2020) best-fit',
                      'gnomAD best-fit',
                      'x_axis')
  
  p_input_comparison <- ggplot(data = melt(input_df, id='x_axis'),
                                                     aes(x=x_axis, 
                                                         y=value,
                                                         fill=variable)) +
    geom_bar(position='dodge2', stat='identity') +
    labs(x = "", fill = "") +
    scale_x_continuous(name='Minor allele frequency in sample (up to 10)', breaks=x_axis, limits=c(0.5, length(x_axis) + 0.5)) +
    ylab('Proportion of segregating sites') +
    theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
    ## scale_fill_manual(values=c("darkslateblue", "darkslategrey", "darkturquoise"))
  
  return(p_input_comparison)
}

compare_1kg_gnomad_proportional_cutoff = function(empirical_1kg, empirical_gnomad) {
  x_axis = 1:10
  empirical_1kg = proportional_sfs(empirical_1kg)[1:10]
  empirical_gnomad = proportional_sfs(empirical_gnomad)[1:10]
  input_df = data.frame(empirical_1kg,
                        empirical_gnomad,
                        x_axis)
  
  names(input_df) = c('1000Genomes',
                      'gnomAD',
                      'x_axis')
  
  p_input_comparison <- ggplot(data = melt(input_df, id='x_axis'),
                                                     aes(x=x_axis, 
                                                         y=value,
                                                         fill=variable)) +
    geom_bar(position='dodge2', stat='identity') +
    labs(x = "", fill = "") +
    scale_x_continuous(name='Minor allele frequency in sample (up to 10)', breaks=x_axis, limits=c(0.5, length(x_axis) + 0.5)) +
    ylab('Proportion of segregating sites') +
    theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
    ## scale_fill_manual(values=c("darkslateblue", "darkslategrey", "darkturquoise"))
  
  return(p_input_comparison)
}

compare_1kg_gnomad_syn_proportional_cutoff = function(empirical_1kg_2017, empirical_1kg_2020, empirical_gnomad) {
  x_axis = 1:10
  empirical_1kg_2017 = proportional_sfs(empirical_1kg_2017)[1:10]
  empirical_1kg_2020 = proportional_sfs(empirical_1kg_2020)[1:10]
  empirical_gnomad = proportional_sfs(empirical_gnomad)[1:10]
  input_df = data.frame(empirical_1kg_2017,
                        empirical_1kg_2020,
                        empirical_gnomad,
                        x_axis)
  
  names(input_df) = c('1KG (2017), syn',
                      '1KG (2020), syn',
                      'gnomAD, syn',
                      'x_axis')
  
  p_input_comparison <- ggplot(data = melt(input_df, id='x_axis'),
                                                     aes(x=x_axis, 
                                                         y=value,
                                                         fill=variable)) +
    geom_bar(position='dodge2', stat='identity') +
    labs(x = "", fill = "") +
    scale_x_continuous(name='Minor allele frequency in sample (up to 10)', breaks=x_axis, limits=c(0.5, length(x_axis) + 0.5)) +
    ylab('Proportion of segregating sites') +
    theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))

  return(p_input_comparison)
}

compare_1kg_gnomad_nonsyn_proportional_cutoff = function(empirical_1kg_2017, empirical_1kg_2020, empirical_gnomad) {
  x_axis = 1:10
  empirical_1kg_2017 = proportional_sfs(empirical_1kg_2017)[1:10]
  empirical_1kg_2020 = proportional_sfs(empirical_1kg_2020)[1:10]
  empirical_gnomad = proportional_sfs(empirical_gnomad)[1:10]
  input_df = data.frame(empirical_1kg_2017,
                        empirical_1kg_2020,
                        empirical_gnomad,
                        x_axis)
  
  names(input_df) = c('1KG (2017), nonsyn',
                      '1KG (2020), nonsyn',
                      'gnomAD, nonsyn',
                      'x_axis')
  
  p_input_comparison <- ggplot(data = melt(input_df, id='x_axis'),
                                                     aes(x=x_axis, 
                                                         y=value,
                                                         fill=variable)) +
    geom_bar(position='dodge2', stat='identity') +
    labs(x = "", fill = "") +
    scale_x_continuous(name='Minor allele frequency in sample (up to 10)', breaks=x_axis, limits=c(0.5, length(x_axis) + 0.5)) +
    ylab('Proportion of segregating sites') +
    theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))

  return(p_input_comparison)
}

AIC_from_demography = function(input_file) {
  ## Reads input SFS from output *demography.txt
  if(grepl("one_epoch", input_file)) {
    k=2
  } else if(grepl("two_epoch", input_file)) {
    k=4
  } else {
    k=8
  }
  this_file = file(input_file)
  on.exit(close(this_file))
  ll_string = readLines(this_file)[2]
  loglik <- as.numeric(str_extract(ll_string, "-?\\d+\\.\\d+"))
  return(k - 2*loglik)
}

LL_from_demography = function(input_file) {
  this_file = file(input_file)
  on.exit(close(this_file))
  ll_string = readLines(this_file)[2]
  loglik <- as.numeric(str_extract(ll_string, "-?\\d+\\.\\d+"))
  return(loglik)
}

compute_residual = function(empirical, model) {
  if (length(empirical) != length(model)) {
    stop("Vectors must be of equal length")
  }
  
  abs_diff <- abs(empirical - model)
  return(sum(abs_diff))
}

theta_from_demography = function(input_file) {
  this_file = file(input_file)
  on.exit(close(this_file))
  theta_string = readLines(this_file)[5]
  theta <- as.numeric(str_extract(theta_string, "-?\\d+\\.\\d+"))
  return(theta)
}

nu_from_demography = function(input_file) {
  this_file = file(input_file)
  on.exit(close(this_file))
  nu_string = readLines(this_file)[1]
  floats <- as.numeric(str_extract_all(nu_string, "\\d+\\.\\d+")[[1]])
  nu = floats[1]
  return(nu)
}

tau_from_demography = function(input_file) {
  this_file = file(input_file)
  on.exit(close(this_file))
  tau_string = readLines(this_file)[1]
  floats <- as.numeric(str_extract_all(tau_string, "\\d+\\.\\d+")[[1]])
  tau = floats[2]
  return(tau)
}

nuB_from_demography = function(input_file) {
  this_file = file(input_file)
  on.exit(close(this_file))
  nuB_string = readLines(this_file)[1]
  floats <- as.numeric(str_extract_all(nuB_string, "\\d+\\.\\d+")[[1]])
  nuB = floats[1]
  return(nuB)
}

nuF_from_demography = function(input_file) {
  this_file = file(input_file)
  on.exit(close(this_file))
  nuF_string = readLines(this_file)[1]
  floats <- as.numeric(str_extract_all(nuF_string, "\\d+\\.\\d+")[[1]])
  nuF = floats[2]
  return(nuF)
}

tauB_from_demography = function(input_file) {
  this_file = file(input_file)
  on.exit(close(this_file))
  tauB_string = readLines(this_file)[1]
  floats <- as.numeric(str_extract_all(tauB_string, "\\d+\\.\\d+")[[1]])
  tauB = floats[3]
  return(tauB)
}

tauF_from_demography = function(input_file) {
  this_file = file(input_file)
  on.exit(close(this_file))
  tauF_string = readLines(this_file)[1]
  floats <- as.numeric(str_extract_all(tauF_string, "\\d+\\.\\d+")[[1]])
  tauF = floats[4]
  return(tauF)
}

watterson_theta_from_sfs = function(input_file) {
  this_file = file(input_file)
  on.exit(close(this_file))
  watterson_theta_string = readLines(this_file)[13]
  floats <- as.numeric(str_extract_all(watterson_theta_string, "\\d+\\.\\d+")[[1]])
  watterson_theta = floats[1]
  return(watterson_theta)
}

heterozygosity_from_sfs = function(input_file) {
  this_file = file(input_file)
  on.exit(close(this_file))
  heterozygosity_string = readLines(this_file)[14]
  floats <- as.numeric(str_extract_all(heterozygosity_string, "\\d+\\.\\d+")[[1]])
  heterozygosity = floats[1]
  return(heterozygosity)
}

tajima_D_from_sfs = function(input_file) {
  this_file = file(input_file)
  on.exit(close(this_file))
  tajima_D_string = readLines(this_file)[15]
  
  # Extract the float that comes after "Tajima's D: "
  match <- str_match(tajima_D_string, "Tajima's D:\\s*([+-]?\\d*\\.?\\d+(?:[eE][+-]?\\d+)?)")
  tajima_D <- as.numeric(match[2])
  
  return(tajima_D)
}

zeng_E_from_sfs = function(input_file) {
  this_file = file(input_file)
  on.exit(close(this_file))
  zeng_E_string = readLines(this_file)[16]
  floats <- as.numeric(str_extract_all(zeng_E_string, "[+-]?\\d+\\.\\d+")[[1]])
  zeng_E = floats[1]
  return(zeng_E)
}

zeng_theta_L_from_sfs = function(input_file) {
  this_file = file(input_file)
  on.exit(close(this_file))
  zeng_theta_L_string = readLines(this_file)[17]
  floats <- as.numeric(str_extract_all(zeng_theta_L_string, "[+-]?\\d+\\.\\d+")[[1]])
  zeng_theta_L = floats[1]
  return(zeng_theta_L)
}

gamma_sfs_from_dfe = function(input_file) {
  ## Reads input SFS from output *demography.txt
  this_file = file(input_file)
  on.exit(close(this_file))
  sfs_string = readLines(this_file)[6]
  output_sfs = strsplit(sfs_string, '-- ')
  output_sfs = unlist(output_sfs)[2]
  output_sfs = unlist(strsplit(output_sfs, ' '))
  # output_sfs = output_sfs[-length(output_sfs)]
  ## output_sfs = output_sfs[-1]
  output_sfs = as.numeric(output_sfs)
  return(output_sfs)
}

neugamma_sfs_from_dfe = function(input_file) {
  ## Reads input SFS from output *demography.txt
  this_file = file(input_file)
  on.exit(close(this_file))
  sfs_string = readLines(this_file)[12]
  output_sfs = strsplit(sfs_string, '-- ')
  output_sfs = unlist(output_sfs)[2]
  output_sfs = unlist(strsplit(output_sfs, ' '))
  # output_sfs = output_sfs[-length(output_sfs)]
  ## output_sfs = output_sfs[-1]
  output_sfs = as.numeric(output_sfs)
  return(output_sfs)
}

empirical_sfs_from_dfe = function(input_file) {
  ## Reads input SFS from output *demography.txt
  this_file = file(input_file)
  on.exit(close(this_file))
  sfs_string = readLines(this_file)[6]
  output_sfs = strsplit(sfs_string, '-- ')
  output_sfs = unlist(output_sfs)[2]
  output_sfs = unlist(strsplit(output_sfs, ' '))
  # output_sfs = output_sfs[-length(output_sfs)]
  ## output_sfs = output_sfs[-1]
  output_sfs = as.numeric(output_sfs)
  return(output_sfs)
}

pi_from_sfs_array <- function(sfs) {
  n = length(sfs) * 2 # Remember that input is folded
  i_vals <- 1:(n/2)
  pi <- sum(2 * i_vals * (n - i_vals) * sfs) / (n * (n - 1))
  return(pi)
}

calculate_fu_li_D = function(pi, num_singletons) {
  numerator = pi - num_singletons
  denominator = sqrt(var(pi - num_singletons))
  return(numerator / denominator)
}

calculate_fu_li_F = function(theta_w, num_singletons) {
  numerator = theta_w - num_singletons
  denominator = sqrt(var(theta_w - num_singletons))
  return(numerator / denominator)
}

compare_dfe_sfs_cutoff = function(empirical_nonsyn_sfs, model_nonsyn_sfs, neugamma_nonsyn_sfs) {
  x_axis = 1:10
  
  input_df = data.frame(proportional_sfs(empirical_nonsyn_sfs)[1:10],
                        proportional_sfs(model_nonsyn_sfs)[1:10],
                        proportional_sfs(neugamma_nonsyn_sfs)[1:10],
                        x_axis)
  
  names(input_df) = c('Empirical nonsynonymous',
                      'Gamma-distributed DFE',
                      'Neu-gamma-distributed DFE',
                      'x_axis')
  
  p_input_comparison <- ggplot(data = melt(input_df, id='x_axis'),
                               aes(x=x_axis, 
                                   y=value,
                                   fill=variable)) +
    geom_bar(position='dodge2', stat='identity') +
    labs(x = "", fill = "") +
    scale_x_continuous(name='Minor allele frequency in sample', breaks=x_axis, limits=c(0.5, length(x_axis) + 0.5)) +
    ylab('Proportion of segregating sites') +
    theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))

  return(p_input_comparison)  
}

read_gamma_dfe_params = function(input_dfe_file) {
  ## Reads input DFE from output *inferred_DFE.txt
  this_file = file(input_dfe_file) # Open file
  on.exit(close(this_file)) # Close when done
  # Parse file and string manipulation
  param_string = readLines(this_file)[4]

  # Extract the two floats using regular expression
  floats <- str_extract_all(param_string, "[+-]?\\d*\\.?\\d+(?:[eE][+-]?\\d+)?")
  
  # Convert the extracted strings to numeric values
  gamma_shape <- as.numeric(floats[[1]][1])
  gamma_scale <- as.numeric(floats[[1]][2])

  return_data_frame = rgamma(100000, shape=gamma_shape, scale=gamma_scale)
  return_data_frame = data.frame(return_data_frame)
  return(return_data_frame)
}

read_neugamma_dfe_params = function(input_dfe_file) {
  ## Reads input DFE from output *inferred_DFE.txt
  this_file = file(input_dfe_file) # Open file
  on.exit(close(this_file)) # Close when done
  # Parse file and string manipulation
  param_string = readLines(this_file)[10]
  # Extract the two floats using regular expression
  floats <- str_extract_all(param_string, "[+-]?\\d*\\.?\\d+(?:[eE][+-]?\\d+)?")
  
  # Convert the extracted strings to numeric values
  neugamma_proportion = as.numeric(floats[[1]][1])
  neugamma_shape = as.numeric(floats[[1]][2])
  neugamma_scale = as.numeric(floats[[1]][3])

  return_data_frame = rgamma(100000, shape=neugamma_shape, scale=neugamma_scale)
  
  zeroed_sites = as.integer(100000 * neugamma_proportion)
  
  return_data_frame[1:zeroed_sites] = 0
  return_data_frame = data.frame(return_data_frame)
  return(return_data_frame)
}
