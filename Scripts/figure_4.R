# figure_4.R

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

sample_size = seq(from=10, to=800, by=10)
dadi_nu_color = c()
dadi_time = c()
msprime_time = c()
msprime_nu_color = c()
growth_proportion = c()
bottleneck_proportion = c()
ancestral_proportion = c()
mean_list = c()
sd_list = c()

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
    dadi_nu_color = c(dadi_nu_color, NA)
  } else if (dadi_nu > 1) {
    dadi_nu_color = c(dadi_nu_color, '#E66100')
  } else {
    dadi_nu_color = c(dadi_nu_color, '#5D3A9B')
  }
  if (is.na(msprime_nu)) {
    msprime_nu_color = c(msprime_nu_color, NA)
  } else if (msprime_nu > 1) {
    msprime_nu_color = c(msprime_nu_color, '#1A85FF')
  } else {
    msprime_nu_color = c(msprime_nu_color, '#D41159')
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

figure_4_dataframe = data.frame(
  growth_proportion,
  bottleneck_proportion,
  ancestral_proportion,
  sample_size,
  dadi_nu_color,
  dadi_time,
  msprime_nu_color,
  msprime_time,
  mean_list
)

# figure_4_dataframe$nu_color = dadi_nu_color
# figure_4_dataframe$sample_size = sample_size

plot_4A = ggplot(data=figure_4_dataframe, aes(x=sample_size, y=growth_proportion, color=dadi_nu_color, shape=msprime_nu_color)) +
  geom_point(size=3) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Proportion') +
  scale_color_manual(name='Dadi, Sign of Nu',
                   breaks=c('#5D3A9B',
                     '#E66100'),
                   values=c('#5D3A9B' = '#5D3A9B',
                     '#E66100'='#E66100'
                     ),
                   labels=c('Dadi, contraction', 'Dadi, expansion')) +
  scale_shape_manual(name='MSPrime, Sign of Nu',
                   breaks=c('#1A85FF', '#D41159'),
                   values=c('#1A85FF'=15,
                     '#D41159'=17
                     ),
                   labels=c('MSPrime, contraction', 'MSPrime, expansion')) + 
  ggtitle('Proportion of coalescent events in recent growth epoch')

plot_4B = ggplot(data=figure_4_dataframe, aes(x=sample_size, y=bottleneck_proportion, color=dadi_nu_color, shape=msprime_nu_color)) +
  geom_point(size=3) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Proportion') +
  scale_color_manual(name='Dadi, Sign of Nu',
                   breaks=c('#5D3A9B',
                     '#E66100'),
                   values=c('#5D3A9B' = '#5D3A9B',
                     '#E66100'='#E66100'
                     ),
                   labels=c('Dadi, contraction', 'Dadi, expansion')) +
  scale_shape_manual(name='MSPrime, Sign of Nu',
                   breaks=c('#1A85FF', '#D41159'),
                   values=c('#1A85FF'=15,
                     '#D41159'=17
                     ),
                   labels=c('MSPrime, contraction', 'MSPrime, expansion')) + 
  ggtitle('Proportion of coalescent events in ancient bottleneck epoch') +
  theme(legend.position='none')


plot_4C = ggplot(data=figure_4_dataframe, aes(x=sample_size, y=ancestral_proportion, color=dadi_nu_color, shape=msprime_nu_color)) +
  geom_point(size=3) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Proportion') +
  scale_color_manual(name='Dadi, Sign of Nu',
                   breaks=c('#5D3A9B',
                     '#E66100'),
                   values=c('#5D3A9B' = '#5D3A9B',
                     '#E66100'='#E66100'
                     ),
                   labels=c('Dadi, contraction', 'Dadi, expansion')) +
  scale_shape_manual(name='MSPrime, Sign of Nu',
                   breaks=c('#1A85FF', '#D41159'),
                   values=c('#1A85FF'=15,
                     '#D41159'=17
                     ),
                   labels=c('MSPrime, contraction', 'MSPrime, expansion')) + 
  ggtitle('Proportion of coalescent events in ancestral epoch') +
  theme(legend.position='none')


figure_4D_dataframe = melt(data.frame(
  mean_list,
  dadi_time,
  msprime_time
))
figure_4D_dataframe$sample_size=sample_size

# figure_4D_dataframe$sample_size = sample_size

plot_4D = ggplot(data=figure_4D_dataframe, aes(x=sample_size, y=value, color=variable)) + 
  geom_line(size=2) +
  theme_bw() +
  xlab('Sample size') +
  ylab("Time in generations") +
  ggtitle("Mean coalescent time by sample size") +
  geom_hline(yintercept = 1, size = 1, linetype = 'dashed') +
  scale_y_log10() +
  scale_color_manual(name='Type of time',
                 breaks=c('mean_list', 
                   'dadi_time', 
                   'msprime_time'),
                 values=c(mean_list='#66c2a5',
                   dadi_time='#fc8d62',
                   msprime_time='#8da0cb'),
                 labels=c('Mean coalescent time',
                   'Inferred dadi time',
                   'Inferred msprime time')
                 )


plot_4A + plot_4B + plot_4C + plot_4D + plot_layout(nrow=4)
