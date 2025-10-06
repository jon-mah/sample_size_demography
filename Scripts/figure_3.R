# figure_3.R

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

sample_size = seq(from=10, to=800, by=10)
mean_list = c()
growth_coal_proportion = c()
bottleneck_coal_proportion = c()
ancestral_coal_proportion = c()
msprime_time = c()
msprime_nu_shape = c()

growth_b_len_proportion_mean = c()
growth_b_len_proportion_sd = c()
bottleneck_b_len_proportion_mean = c()
bottleneck_b_len_proportion_sd = c()
ancestral_b_len_proportion_mean = c()
ancestral_b_len_proportion_sd = c()

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
  this_b_len_growth = c()
  this_b_len_bottleneck = c()
  this_b_len_ancestral = c()
  for (g in seq(from=1, to=20, by=1)) {
    this_branch_distribution = paste0(
      "../Simulations/simple_simulations/ThreeEpochBottleneck_",
      i, '_branch_length_dist_',
      g, '.csv')
    # Read in the appropriate file
    this_b_len_csv = read.csv(this_branch_distribution, header=TRUE)
    growth_sum = sum(this_b_len_csv[this_b_len_csv$node_generations <= 200, ]$branch_length)
    bottleneck_sum = sum(this_b_len_csv[this_b_len_csv$node_generations > 200 & 
        this_b_len_csv$node_generations<= 2000, ]$branch_length)
    ancestral_sum = sum(this_b_len_csv[this_b_len_csv$node_generations > 2000, ]$branch_length)
    total_branch_length = growth_sum + bottleneck_sum + ancestral_sum
    this_b_len_growth = c(this_b_len_growth, growth_sum / total_branch_length)
    this_b_len_bottleneck = c(this_b_len_bottleneck, bottleneck_sum / total_branch_length)
    this_b_len_ancestral = c(this_b_len_ancestral, ancestral_sum / total_branch_length)
  }
  # Take the mean of coalescent times for this sample size's distribution
  mean_list = c(mean_list, mean(this_sample_size_distribution))
  # Similarly, take standard deviation
  # Lastly find the proportion of coalescent events in each epoch
  growth_coal_proportion = c(growth_coal_proportion, 
    mean(this_sample_size_distribution <= 200))
  bottleneck_coal_proportion = c(bottleneck_coal_proportion, 
    mean(this_sample_size_distribution <= 2000) - mean(this_sample_size_distribution < 200))
  ancestral_coal_proportion = c(ancestral_coal_proportion, 
    mean(this_sample_size_distribution > 2000))
  
  # Mean and sd of branch length proportions by epoch
  growth_b_len_proportion_mean = c(growth_b_len_proportion_mean, mean(this_b_len_growth))
  growth_b_len_proportion_sd = c(growth_b_len_proportion_sd, sd(this_b_len_growth))
  bottleneck_b_len_proportion_mean = c(bottleneck_b_len_proportion_mean, mean(this_b_len_bottleneck))
  bottleneck_b_len_proportion_sd = c(bottleneck_b_len_proportion_sd, sd(this_b_len_bottleneck))
  ancestral_b_len_proportion_mean = c(ancestral_b_len_proportion_mean, mean(this_b_len_ancestral))
  ancestral_b_len_proportion_sd = c(ancestral_b_len_proportion_sd, sd(this_b_len_ancestral))
}

figure_SX_dataframe = data.frame(
  mean_list,
  sample_size
)

# figure_3A_dataframe$sample_size = sample_size

plot_SX = ggplot(data=figure_SX_dataframe, aes(x=sample_size, y=mean_list)) + 
  geom_line(linewidth=1) +
  theme_bw() +
  xlab('Sample size') +
  ylab("Mean coalescent time (generations)") +
  ggtitle("Mean coalescent time by sample size") +
  geom_hline(yintercept = 1, linewidth = 1, linetype = 'dashed')

figure_3A_dataframe = melt(data.frame(
  growth_coal_proportion,
  bottleneck_coal_proportion,
  ancestral_coal_proportion
))

figure_3A_dataframe$msprime_time = msprime_time
figure_3A_dataframe$msprime_shape = msprime_nu_shape
figure_3A_dataframe$sample_size = sample_size

plot_3A = ggplot(data=figure_3A_dataframe, aes(x=sample_size, y=value, color=variable, shape=msprime_shape)) +
  geom_point(size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Proportion') +
  ggtitle('Proportion of coalescent events per epoch') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_coal_proportion',
                       'bottleneck_coal_proportion',
                       'ancestral_coal_proportion'),
                     values=c('growth_coal_proportion'='#1b9e77',
                       'bottleneck_coal_proportion'='#d95f02',
                       'ancestral_coal_proportion'='#7570b3'),
                     labels=c('Recent growth', 'Bottleneck', 'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion'))

figure_3B_dataframe = melt(data.frame(
  growth_b_len_proportion_mean,
  # growth_b_len_proportion_sd,
  bottleneck_b_len_proportion_mean,
  # bottleneck_b_len_proportion_sd,
  ancestral_b_len_proportion_mean
  # ancestral_b_len_proportion_sd
))
figure_3B_dataframe$sample_size = sample_size
figure_3B_dataframe$msprime_shape = msprime_nu_shape
figure_3B_dataframe$growth_min = growth_b_len_proportion_mean - growth_b_len_proportion_sd
figure_3B_dataframe$growth_max = growth_b_len_proportion_mean + growth_b_len_proportion_sd
figure_3B_dataframe$bottleneck_min = bottleneck_b_len_proportion_mean - bottleneck_b_len_proportion_sd
figure_3B_dataframe$bottleneck_max = bottleneck_b_len_proportion_mean + bottleneck_b_len_proportion_sd
figure_3B_dataframe$ancestral_min = ancestral_b_len_proportion_mean - ancestral_b_len_proportion_sd
figure_3B_dataframe$ancestral_max = ancestral_b_len_proportion_mean + ancestral_b_len_proportion_sd

proportion_plus_minus_sd_label = expression('Mean proportion '%+-%' 1 s.d.')

plot_3B = ggplot(data=figure_3B_dataframe, aes(x=sample_size, y=value, color=variable)) +
  geom_point(aes(shape=msprime_shape), size=1.5) +
  theme_bw() +
  geom_ribbon(aes(ymin = growth_min, ymax = growth_max), 
    fill = "#1b9e77", color="#1b9e77", alpha = 0.1) +
  geom_ribbon(aes(ymin = bottleneck_min, ymax = bottleneck_max), 
    fill = "#d95f02", color="#d95f02", alpha = 0.1) +
  geom_ribbon(aes(ymin = ancestral_min, ymax = ancestral_max), 
    fill = "#7570b3", color="#7570b3", alpha = 0.1) +
  xlab('Sample size') +
  ylab(proportion_plus_minus_sd_label) +
  ggtitle('Proportion of branch length per epoch') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_b_len_proportion_mean',
                       'bottleneck_b_len_proportion_mean',
                       'ancestral_b_len_proportion_mean'),
                     values=c('growth_b_len_proportion_mean'='#1b9e77',
                       'bottleneck_b_len_proportion_mean'='#d95f02',
                       'ancestral_b_len_proportion_mean'='#7570b3'),
                     labels=c('Recent growth', 'Bottleneck', 'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion')) +
  guides(shape='none', color='none')

# 700 x 600
plot_3A + plot_3B + plot_layout(nrow=2)
