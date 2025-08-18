# figure_3.R

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

sample_size = seq(from=10, to=800, by=10)
mean_list = c()
growth_proportion = c()
bottleneck_proportion = c()
ancestral_proportion = c()
msprime_time = c()
msprime_nu_shape = c()

# Iterate through sample size and replicate
for (i in sample_size) {
  this_sample_size_distribution = c() # Initialize
  msprime_demography = paste0(
    "../Analysis/msprime_3EpB_", i, '/two_epoch_demography.txt')
  msprime_nu = nu_from_demography(msprime_demography)
  msprime_time = c(msprime_time, time_from_demography(msprime_demography))
  if (is.na(msprime_nu)) {
    msprime_nu_shape = c(msprime_nu_shape, NA)
  } else if (msprime_nu > 1) {
    msprime_nu_shape = c(msprime_nu_shape, 'msprime_expand')
  } else {
    msprime_nu_shape = c(msprime_nu_shape, 'msprime_contract')
  }  
  for (j in seq(from=1, to=20, by=1)) {
    this_replicate_distribution = paste0(
      "../Simulations/simple_simulations/ThreeEpochBottleneck_",
      i, '_coal_dist_',
      j, '.csv')
    # Read in the appropriate file
    this_csv = read.csv(this_replicate_distribution, header=TRUE)
    this_sample_size_distribution = c(this_sample_size_distribution, this_csv$generations)
  }
  # Take the mean of coalescent times for this sample size's distribution
  mean_list = c(mean_list, mean(this_sample_size_distribution))
  # Similarly, take standard deviation
  # Lastly find the proportion of coalescent events in each epoch
  growth_proportion = c(growth_proportion, 
    mean(this_sample_size_distribution < 200))
  bottleneck_proportion = c(bottleneck_proportion, 
    mean(this_sample_size_distribution <= 2000) - mean(this_sample_size_distribution < 200))
  ancestral_proportion = c(ancestral_proportion, 
    mean(this_sample_size_distribution > 2000))
}

figure_SX_dataframe = data.frame(
  mean_list,
  sample_size
)

# figure_3A_dataframe$sample_size = sample_size

plot_SX = ggplot(data=figure_3A_dataframe, aes(x=sample_size, y=mean_list)) + 
  geom_line(linewidth=1) +
  theme_bw() +
  xlab('Sample size') +
  ylab("Mean coalescent time (generations)") +
  ggtitle("Mean coalescent time by sample size") +
  geom_hline(yintercept = 1, size = 1, linetype = 'dashed')

figure_3A_dataframe = melt(data.frame(
  growth_proportion,
  bottleneck_proportion,
  ancestral_proportion
))

figure_3A_dataframe$msprime_time = msprime_time
figure_3A_dataframe$msprime_shape = msprime_nu_shape
figure_3A_dataframe$sample_size = sample_size

plot_3A = ggplot(data=figure_3A_dataframe, aes(x=sample_size, y=value, color=variable, shape=msprime_shape)) +
  geom_point(size=2) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Proportion') +
  # ggtitle('Proportion of coalescent events per epoch') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_proportion',
                       'bottleneck_proportion',
                       'ancestral_proportion'),
                     values=c('growth_proportion'='#1b9e77',
                       'bottleneck_proportion'='#d95f02',
                       'ancestral_proportion'='#7570b3'),
                     labels=c('Recent growth', 'Bottleneck', 'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion')) +
  geom_vline(xintercept=95, linewidth=1, linetype = 'dotted', color='#FFC20A')

plot_3A
