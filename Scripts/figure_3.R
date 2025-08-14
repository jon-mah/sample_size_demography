# figure_3.R

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

sample_size = seq(from=10, to=800, by=10)
mean_list = c()
sd_list = c()
growth_proportion = c()
bottleneck_proportion = c()
ancestral_proportion = c()
dadi_nu_shape = c()
dadi_time = c()
msprime_time = c()
msprime_nu_shape = c()

# Iterate through sample size and replicate
for (i in sample_size) {
  this_sample_size_distribution = c() # Initialize
  dadi_demography = paste0(
    "../Analysis/dadi_3EpB_", i, '/two_epoch_demography.txt')
  dadi_nu = nu_from_demography(dadi_demography)
  dadi_time = c(dadi_time, time_from_demography(dadi_demography))
  msprime_demography = paste0(
    "../Analysis/msprime_3EpB_", i, '/two_epoch_demography.txt')
  msprime_nu = nu_from_demography(msprime_demography)
  msprime_time = c(msprime_time, time_from_demography(msprime_demography))
  if (is.na(dadi_nu)) {
    dadi_nu_shape = c(dadi_nu_shape, NA)
  } else if (dadi_nu > 1) {
    dadi_nu_shape = c(dadi_nu_shape, 'dadi_expand')
  } else {
    dadi_nu_shape = c(dadi_nu_shape, 'dadi_contract')
  }
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
  sd_list = c(sd_list, sd(this_sample_size_distribution))
  # Lastly find the proportion of coalescent events in each epoch
  growth_proportion = c(growth_proportion, 
    mean(this_sample_size_distribution < 200))
  bottleneck_proportion = c(bottleneck_proportion, 
    mean(this_sample_size_distribution <= 2000) - mean(this_sample_size_distribution < 200))
  ancestral_proportion = c(ancestral_proportion, 
    mean(this_sample_size_distribution > 2000))
}

figure_3A_dataframe = data.frame(
  mean_list,
  sd_list,
  sample_size
)

# figure_3A_dataframe$sample_size = sample_size

plot_3A = ggplot(data=figure_3A_dataframe, aes(x=sample_size, y=mean_list)) + 
  geom_line(linewidth=1) +
  geom_ribbon(aes(ymin = mean_list - sd_list, ymax = mean_list + sd_list), alpha=0.2) +
  theme_bw() +
  xlab('Sample size') +
  ylab("Mean coalescent time (generations)") +
  ggtitle("Mean coalescent time by sample size") +
  geom_hline(yintercept = 1, size = 1, linetype = 'dashed')

figure_3B_dataframe = melt(data.frame(
  growth_proportion,
  bottleneck_proportion,
  ancestral_proportion
))

figure_3B_dataframe$nu_time = dadi_time
figure_3B_dataframe$dadi_shape = dadi_nu_shape
figure_3B_dataframe$msprime_time = msprime_time
figure_3B_dataframe$msprime_shape = msprime_nu_shape
figure_3B_dataframe$sample_size = sample_size

plot_3B = ggplot(data=figure_3B_dataframe, aes(x=sample_size, y=value, color=variable, shape=dadi_shape)) +
  geom_point(size=2) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Proportion') +
  ggtitle('Proportion of coalescent events per epoch') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_proportion',
                       'bottleneck_proportion',
                       'ancestral_proportion'),
                     values=c('growth_proportion'='#1b9e77',
                       'bottleneck_proportion'='#d95f02',
                       'ancestral_proportion'='#7570b3'),
                     labels=c('Recent growth', 'Bottleneck', 'Ancestral population')) +
  scale_shape_manual(name='Dadi, inferred demographic event',
                     breaks=c('dadi_contract',
                       'dadi_expand'),
                     values=c('dadi_contract'=15,
                       'dadi_expand'=22),
                     labels=c('Dadi, contraction',
                       'Dadi, expansion')) +
  geom_vline(xintercept=115, size=1, linetype = 'dotted', color='#0C7BDC')

plot_3C = ggplot(data=figure_3B_dataframe, aes(x=sample_size, y=value, color=variable, shape=msprime_shape)) +
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
  scale_shape_manual(name='MSPrime, inferred demographic event',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('MSPrime, contraction',
                       'MSPrime, expansion')) +
  guides(color='none') +
  geom_vline(xintercept=95, size=1, linetype = 'dotted', color='#FFC20A')

figure_3D_dataframe = melt(data.frame(
  dadi_time,
  msprime_time
))
figure_3D_dataframe$sample_size=sample_size

# figure_3D_dataframe$sample_size = sample_size

plot_3D = ggplot(data=figure_3D_dataframe, aes(x=sample_size, y=value, color=variable)) + 
  geom_line(size=2) +
  theme_bw() +
  xlab('Sample size') +
  ylab("Time in generations") +
  ggtitle("Inferred time of instantaneous size change by sample size") +
  geom_hline(yintercept = 1, size = 1, linetype = 'dashed') +
  scale_y_log10() +
  scale_color_manual(name='Type of time',
                 breaks=c('dadi_time', 
                   'msprime_time'),
                 values=c(dadi_time='#0C7BDC',
                   msprime_time='#FFC20A'),
                 labels=c('Inferred dadi time',
                   'Inferred msprime time')
                 ) +
  geom_vline(xintercept=115, size=1, linetype = 'dotted', color='#0C7BDC') +
  geom_vline(xintercept=95, size=1, linetype = 'dotted', color='#FFC20A')

plot_3A + plot_3B + plot_3C + plot_3D + plot_layout(nrow=4)

