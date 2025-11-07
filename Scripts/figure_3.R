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

# 200_1800

plot_200_1800_simplified = ggplot(data=figure_3B_dataframe, aes(x=sample_size, y=value, color=variable)) +
  geom_point(aes(shape=msprime_shape), size=3) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Mean branch length') +
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
                       'Expansion'))  +
  theme(axis.title.x = element_text(size = 20))  +
  theme(axis.title.y = element_text(size = 20))  +
  theme(plot.title = element_text(size = 32))  +
  theme(legend.title = element_text(size = 18)) +
  theme(legend.text = element_text(size = 16))

plot_200_1800_simplified

# growth_contraction

mean_list_growth_contraction = c()
growth_coal_proportion_growth_contraction = c()
bottleneck_coal_proportion_growth_contraction = c()
ancestral_coal_proportion_growth_contraction = c()
msprime_time_growth_contraction = c()
msprime_nu_shape_growth_contraction = c()

growth_b_len_proportion_mean_growth_contraction = c()
bottleneck_b_len_proportion_mean_growth_contraction = c()
ancestral_b_len_proportion_mean_growth_contraction = c()

# Iterate through sample size and replicate
for (i in sample_size) {
  this_sample_size_distribution = c() # Initialize
  msprime_demography_growth_contraction = paste0(
    "../Analysis/msprime_3EpBGC_", i, '/two_epoch_demography.txt')
  msprime_nu_growth_contraction = nu_from_demography(msprime_demography_growth_contraction)
  msprime_time_growth_contraction = c(msprime_time_growth_contraction, time_from_demography(msprime_demography_growth_contraction))
  if (is.na(msprime_nu_growth_contraction)) {
    msprime_nu_shape_growth_contraction = c(msprime_nu_shape_growth_contraction, NA)
  } else if (msprime_nu_growth_contraction > 1) {
    msprime_nu_shape_growth_contraction = c(msprime_nu_shape_growth_contraction, 'msprime_expand')
  } else {
    msprime_nu_shape_growth_contraction = c(msprime_nu_shape_growth_contraction, 'msprime_contract')
  }  
  for (j in seq(from=1, to=20, by=1)) {
    this_replicate_distribution = paste0(
      "../Simulations/simple_simulations/ThreeEpochGrowthContraction_",
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
      "../Simulations/simple_simulations/ThreeEpochGrowthContraction_",
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
  mean_list_growth_contraction = c(mean_list_growth_contraction, mean(this_sample_size_distribution))
  # Similarly, take standard deviation
  # Lastly find the proportion of coalescent events in each epoch
  growth_coal_proportion_growth_contraction = c(growth_coal_proportion_growth_contraction, 
    mean(this_sample_size_distribution <= 200))
  bottleneck_coal_proportion_growth_contraction = c(bottleneck_coal_proportion_growth_contraction, 
    mean(this_sample_size_distribution <= 2000) - mean(this_sample_size_distribution < 200))
  ancestral_coal_proportion_growth_contraction = c(ancestral_coal_proportion_growth_contraction, 
    mean(this_sample_size_distribution > 2000))
  
  # Mean and sd of branch length proportions by epoch
  growth_b_len_proportion_mean_growth_contraction = c(growth_b_len_proportion_mean_growth_contraction, mean(this_b_len_growth))
  bottleneck_b_len_proportion_mean_growth_contraction = c(bottleneck_b_len_proportion_mean_growth_contraction, mean(this_b_len_bottleneck))
  ancestral_b_len_proportion_mean_growth_contraction = c(ancestral_b_len_proportion_mean_growth_contraction, mean(this_b_len_ancestral))
}

figure_SX_dataframe = data.frame(
  mean_list_growth_contraction,
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

figure_3A_dataframe_growth_contraction = melt(data.frame(
  growth_coal_proportion_growth_contraction,
  bottleneck_coal_proportion_growth_contraction,
  ancestral_coal_proportion_growth_contraction
))

figure_3A_dataframe_growth_contraction$msprime_time = msprime_time_growth_contraction
figure_3A_dataframe_growth_contraction$msprime_shape = msprime_nu_shape_growth_contraction
figure_3A_dataframe_growth_contraction$sample_size = sample_size

plot_3A_growth_contraction = ggplot(data=figure_3A_dataframe_growth_contraction, aes(x=sample_size, y=value, color=variable, shape=msprime_shape)) +
  geom_point(size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Proportion') +
  ggtitle('Coalescent events per epoch, [Anc., 2000 g.a., 200 g.a.]') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_coal_proportion_growth_contraction',
                       'bottleneck_coal_proportion_growth_contraction',
                       'ancestral_coal_proportion_growth_contraction'),
                     values=c('growth_coal_proportion_growth_contraction'='#1b9e77',
                       'bottleneck_coal_proportion_growth_contraction'='#d95f02',
                       'ancestral_coal_proportion_growth_contraction'='#7570b3'),
                     labels=c('Recent contraction [200 g.a.]', 'Ancient growth [2,000 g.a.]', 'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion'))

figure_3B_dataframe_growth_contraction = melt(data.frame(
  growth_b_len_proportion_mean_growth_contraction,
  bottleneck_b_len_proportion_mean_growth_contraction,
  ancestral_b_len_proportion_mean_growth_contraction
))
figure_3B_dataframe_growth_contraction$sample_size = sample_size
figure_3B_dataframe_growth_contraction$msprime_shape = msprime_nu_shape_growth_contraction

plot_3B_simplified_growth_contraction = ggplot(data=figure_3B_dataframe_growth_contraction, aes(x=sample_size, y=value, color=variable)) +
  geom_point(aes(shape=msprime_shape), size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Mean branch length') +
  ggtitle('Branch length per epoch') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_b_len_proportion_mean_growth_contraction',
                       'bottleneck_b_len_proportion_mean_growth_contraction',
                       'ancestral_b_len_proportion_mean_growth_contraction'),
                     values=c('growth_b_len_proportion_mean_growth_contraction'='#1b9e77',
                       'bottleneck_b_len_proportion_mean_growth_contraction'='#d95f02',
                       'ancestral_b_len_proportion_mean_growth_contraction'='#7570b3'),
                     labels=c('Recent contraction', 'Ancient growth', 'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion')) +
  guides(shape='none', color='none')

plot_3A_growth_contraction + plot_3B_simplified_growth_contraction + plot_layout(nrow=2)

# 1000_500

sample_size = seq(from=10, to=800, by=10)
mean_list_1000_500 = c()
growth_coal_proportion_1000_500 = c()
bottleneck_coal_proportion_1000_500 = c()
ancestral_coal_proportion_1000_500 = c()
msprime_time_1000_500 = c()
msprime_nu_shape_1000_500 = c()

growth_b_len_proportion_mean_1000_500 = c()
bottleneck_b_len_proportion_mean_1000_500 = c()
ancestral_b_len_proportion_mean_1000_500 = c()

# Iterate through sample size and replicate
for (i in sample_size) {
  this_sample_size_distribution = c() # Initialize
  msprime_demography_1000_500 = paste0(
    "../Analysis/msprime_3EpB_1000_500_", i, '/two_epoch_demography.txt')
  msprime_nu_1000_500 = nu_from_demography(msprime_demography_1000_500)
  msprime_time_1000_500 = c(msprime_time_1000_500, time_from_demography(msprime_demography_1000_500))
  if (is.na(msprime_nu_1000_500)) {
    msprime_nu_shape_1000_500 = c(msprime_nu_shape_1000_500, NA)
  } else if (msprime_nu_1000_500 > 1) {
    msprime_nu_shape_1000_500 = c(msprime_nu_shape_1000_500, 'msprime_expand')
  } else {
    msprime_nu_shape_1000_500 = c(msprime_nu_shape_1000_500, 'msprime_contract')
  }
  for (j in seq(from=1, to=5, by=1)) {
    this_replicate_distribution = paste0(
      "../Simulations/simple_simulations/ThreeEpochBottleneck_1000_500_",
      i, '_coal_dist_',
      j, '.csv')
    # Read in the appropriate file
    this_csv = read.csv(this_replicate_distribution, header=TRUE)
    this_sample_size_distribution = c(this_sample_size_distribution, this_csv$generations)
  }
  this_b_len_growth = c()
  this_b_len_bottleneck = c()
  this_b_len_ancestral = c()
  for (g in seq(from=1, to=5, by=1)) {
    this_branch_distribution = paste0(
      "../Simulations/simple_simulations/ThreeEpochBottleneck_1000_500_",
      i, '_branch_length_dist_',
      g, '.csv')
    if (file.exists(this_branch_distribution)) {
    } else {
      next
    }
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
  mean_list_1000_500 = c(mean_list_1000_500, mean(this_sample_size_distribution))
  # Similarly, take standard deviation
  # Lastly find the proportion of coalescent events in each epoch
  growth_coal_proportion_1000_500 = c(growth_coal_proportion_1000_500,
    mean(this_sample_size_distribution <= 200))
  bottleneck_coal_proportion_1000_500 = c(bottleneck_coal_proportion_1000_500,
    mean(this_sample_size_distribution <= 2000) - mean(this_sample_size_distribution < 200))
  ancestral_coal_proportion_1000_500 = c(ancestral_coal_proportion_1000_500,
    mean(this_sample_size_distribution > 2000))

  # Mean and sd of branch length proportions by epoch
  growth_b_len_proportion_mean_1000_500 = c(growth_b_len_proportion_mean_1000_500, mean(this_b_len_growth))
  bottleneck_b_len_proportion_mean_1000_500 = c(bottleneck_b_len_proportion_mean_1000_500, mean(this_b_len_bottleneck))
  ancestral_b_len_proportion_mean_1000_500 = c(ancestral_b_len_proportion_mean_1000_500, mean(this_b_len_ancestral))
}

figure_SX_dataframe = data.frame(
  mean_list_1000_500,
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

figure_3A_dataframe_1000_500 = melt(data.frame(
  growth_coal_proportion_1000_500,
  bottleneck_coal_proportion_1000_500,
  ancestral_coal_proportion_1000_500
))

figure_3A_dataframe_1000_500$msprime_time = msprime_time_1000_500
figure_3A_dataframe_1000_500$msprime_shape = msprime_nu_shape_1000_500
figure_3A_dataframe_1000_500$sample_size = sample_size

plot_3A_1000_500 = ggplot(data=figure_3A_dataframe_1000_500, aes(x=sample_size, y=value, color=variable, shape=msprime_shape)) +
  geom_point(size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Proportion') +
  ggtitle('Coalescent events per epoch, [Anc., 1500 g.a., 1000 g.a.]') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_coal_proportion_1000_500',
                       'bottleneck_coal_proportion_1000_500',
                       'ancestral_coal_proportion_1000_500'),
                     values=c('growth_coal_proportion_1000_500'='#1b9e77',
                       'bottleneck_coal_proportion_1000_500'='#d95f02',
                       'ancestral_coal_proportion_1000_500'='#7570b3'),
                     labels=c('Recent growth [1000 g.a.]', 
                       'Bottleneck [1500 g.a.]', 
                       'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion'))

figure_3B_dataframe_1000_500 = melt(data.frame(
  growth_b_len_proportion_mean_1000_500,
  bottleneck_b_len_proportion_mean_1000_500,
  ancestral_b_len_proportion_mean_1000_500
))
figure_3B_dataframe_1000_500$sample_size = sample_size
figure_3B_dataframe_1000_500$msprime_shape = msprime_nu_shape_1000_500

plot_3B_simplified_1000_500 = ggplot(data=figure_3B_dataframe_1000_500, aes(x=sample_size, y=value, color=variable)) +
  geom_point(aes(shape=msprime_shape), size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Mean branch length') +
  ggtitle('Branch length per epoch') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_b_len_proportion_mean_1000_500',
                       'bottleneck_b_len_proportion_mean_1000_500',
                       'ancestral_b_len_proportion_mean_1000_500'),
                     values=c('growth_b_len_proportion_mean_1000_500'='#1b9e77',
                       'bottleneck_b_len_proportion_mean_1000_500'='#d95f02',
                       'ancestral_b_len_proportion_mean_1000_500'='#7570b3'),
                     labels=c('Recent growth', 'Bottleneck', 'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion')) +
  guides(shape='none', color='none')

plot_3A_1000_500 + plot_3B_simplified_1000_500 + plot_layout(nrow=2)


# 1000_1000

sample_size = seq(from=10, to=800, by=10)
mean_list_1000_1000 = c()
growth_coal_proportion_1000_1000 = c()
bottleneck_coal_proportion_1000_1000 = c()
ancestral_coal_proportion_1000_1000 = c()
msprime_time_1000_1000 = c()
msprime_nu_shape_1000_1000 = c()

growth_b_len_proportion_mean_1000_1000 = c()
bottleneck_b_len_proportion_mean_1000_1000 = c()
ancestral_b_len_proportion_mean_1000_1000 = c()

# Iterate through sample size and replicate
for (i in sample_size) {
  this_sample_size_distribution = c() # Initialize
  msprime_demography_1000_1000 = paste0(
    "../Analysis/msprime_3EpB_1000_1000_", i, '/two_epoch_demography.txt')
  msprime_nu_1000_1000 = nu_from_demography(msprime_demography_1000_1000)
  msprime_time_1000_1000 = c(msprime_time_1000_1000, time_from_demography(msprime_demography_1000_1000))
  if (is.na(msprime_nu_1000_1000)) {
    msprime_nu_shape_1000_1000 = c(msprime_nu_shape_1000_1000, NA)
  } else if (msprime_nu_1000_1000 > 1) {
    msprime_nu_shape_1000_1000 = c(msprime_nu_shape_1000_1000, 'msprime_expand')
  } else {
    msprime_nu_shape_1000_1000 = c(msprime_nu_shape_1000_1000, 'msprime_contract')
  }
  for (j in seq(from=1, to=5, by=1)) {
    this_replicate_distribution = paste0(
      "../Simulations/simple_simulations/ThreeEpochBottleneck_1000_1000_",
      i, '_coal_dist_',
      j, '.csv')
    # Read in the appropriate file
    this_csv = read.csv(this_replicate_distribution, header=TRUE)
    this_sample_size_distribution = c(this_sample_size_distribution, this_csv$generations)
  }
  this_b_len_growth = c()
  this_b_len_bottleneck = c()
  this_b_len_ancestral = c()
  for (g in seq(from=1, to=5, by=1)) {
    this_branch_distribution = paste0(
      "../Simulations/simple_simulations/ThreeEpochBottleneck_1000_1000_",
      i, '_branch_length_dist_',
      g, '.csv')
    if (file.exists(this_branch_distribution)) {
    } else {
      next
    }
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
  mean_list_1000_1000 = c(mean_list_1000_1000, mean(this_sample_size_distribution))
  # Similarly, take standard deviation
  # Lastly find the proportion of coalescent events in each epoch
  growth_coal_proportion_1000_1000 = c(growth_coal_proportion_1000_1000,
    mean(this_sample_size_distribution <= 200))
  bottleneck_coal_proportion_1000_1000 = c(bottleneck_coal_proportion_1000_1000,
    mean(this_sample_size_distribution <= 2000) - mean(this_sample_size_distribution < 200))
  ancestral_coal_proportion_1000_1000 = c(ancestral_coal_proportion_1000_1000,
    mean(this_sample_size_distribution > 2000))

  # Mean and sd of branch length proportions by epoch
  growth_b_len_proportion_mean_1000_1000 = c(growth_b_len_proportion_mean_1000_1000, mean(this_b_len_growth))
  bottleneck_b_len_proportion_mean_1000_1000 = c(bottleneck_b_len_proportion_mean_1000_1000, mean(this_b_len_bottleneck))
  ancestral_b_len_proportion_mean_1000_1000 = c(ancestral_b_len_proportion_mean_1000_1000, mean(this_b_len_ancestral))
}

figure_SX_dataframe = data.frame(
  mean_list_1000_1000,
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

figure_3A_dataframe_1000_1000 = melt(data.frame(
  growth_coal_proportion_1000_1000,
  bottleneck_coal_proportion_1000_1000,
  ancestral_coal_proportion_1000_1000
))

figure_3A_dataframe_1000_1000$msprime_time = msprime_time_1000_1000
figure_3A_dataframe_1000_1000$msprime_shape = msprime_nu_shape_1000_1000
figure_3A_dataframe_1000_1000$sample_size = sample_size

plot_3A_1000_1000 = ggplot(data=figure_3A_dataframe_1000_1000, aes(x=sample_size, y=value, color=variable, shape=msprime_shape)) +
  geom_point(size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Proportion') +
  ggtitle('Coalescent events per epoch, [Anc., 2000 g.a., 1000 g.a.]') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_coal_proportion_1000_1000',
                       'bottleneck_coal_proportion_1000_1000',
                       'ancestral_coal_proportion_1000_1000'),
                     values=c('growth_coal_proportion_1000_1000'='#1b9e77',
                       'bottleneck_coal_proportion_1000_1000'='#d95f02',
                       'ancestral_coal_proportion_1000_1000'='#7570b3'),
                     labels=c('Recent growth [1000 g.a.]', 
                       'Bottleneck [2000 g.a.]', 
                       'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion'))

figure_3B_dataframe_1000_1000 = melt(data.frame(
  growth_b_len_proportion_mean_1000_1000,
  bottleneck_b_len_proportion_mean_1000_1000,
  ancestral_b_len_proportion_mean_1000_1000
))
figure_3B_dataframe_1000_1000$sample_size = sample_size
figure_3B_dataframe_1000_1000$msprime_shape = msprime_nu_shape_1000_1000

plot_3B_simplified_1000_1000 = ggplot(data=figure_3B_dataframe_1000_1000, aes(x=sample_size, y=value, color=variable)) +
  geom_point(aes(shape=msprime_shape), size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Mean branch length') +
  ggtitle('Branch length per epoch') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_b_len_proportion_mean_1000_1000',
                       'bottleneck_b_len_proportion_mean_1000_1000',
                       'ancestral_b_len_proportion_mean_1000_1000'),
                     values=c('growth_b_len_proportion_mean_1000_1000'='#1b9e77',
                       'bottleneck_b_len_proportion_mean_1000_1000'='#d95f02',
                       'ancestral_b_len_proportion_mean_1000_1000'='#7570b3'),
                     labels=c('Recent growth', 'Bottleneck', 'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion')) +
  guides(shape='none', color='none')

plot_3A_1000_1000 + plot_3B_simplified_1000_1000 + plot_layout(nrow=2)


# 1000_1500

sample_size = seq(from=10, to=800, by=10)
mean_list_1000_1500 = c()
growth_coal_proportion_1000_1500 = c()
bottleneck_coal_proportion_1000_1500 = c()
ancestral_coal_proportion_1000_1500 = c()
msprime_time_1000_1500 = c()
msprime_nu_shape_1000_1500 = c()

growth_b_len_proportion_mean_1000_1500 = c()
bottleneck_b_len_proportion_mean_1000_1500 = c()
ancestral_b_len_proportion_mean_1000_1500 = c()

# Iterate through sample size and replicate
for (i in sample_size) {
  this_sample_size_distribution = c() # Initialize
  msprime_demography_1000_1500 = paste0(
    "../Analysis/msprime_3EpB_1000_1500_", i, '/two_epoch_demography.txt')
  msprime_nu_1000_1500 = nu_from_demography(msprime_demography_1000_1500)
  msprime_time_1000_1500 = c(msprime_time_1000_1500, time_from_demography(msprime_demography_1000_1500))
  if (is.na(msprime_nu_1000_1500)) {
    msprime_nu_shape_1000_1500 = c(msprime_nu_shape_1000_1500, NA)
  } else if (msprime_nu_1000_1500 > 1) {
    msprime_nu_shape_1000_1500 = c(msprime_nu_shape_1000_1500, 'msprime_expand')
  } else {
    msprime_nu_shape_1000_1500 = c(msprime_nu_shape_1000_1500, 'msprime_contract')
  }
  for (j in seq(from=1, to=5, by=1)) {
    this_replicate_distribution = paste0(
      "../Simulations/simple_simulations/ThreeEpochBottleneck_1000_1500_",
      i, '_coal_dist_',
      j, '.csv')
    # Read in the appropriate file
    this_csv = read.csv(this_replicate_distribution, header=TRUE)
    this_sample_size_distribution = c(this_sample_size_distribution, this_csv$generations)
  }
  this_b_len_growth = c()
  this_b_len_bottleneck = c()
  this_b_len_ancestral = c()
  for (g in seq(from=1, to=5, by=1)) {
    this_branch_distribution = paste0(
      "../Simulations/simple_simulations/ThreeEpochBottleneck_1000_1500_",
      i, '_branch_length_dist_',
      g, '.csv')
    if (file.exists(this_branch_distribution)) {
    } else {
      next
    }
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
  mean_list_1000_1500 = c(mean_list_1000_1500, mean(this_sample_size_distribution))
  # Similarly, take standard deviation
  # Lastly find the proportion of coalescent events in each epoch
  growth_coal_proportion_1000_1500 = c(growth_coal_proportion_1000_1500,
    mean(this_sample_size_distribution <= 200))
  bottleneck_coal_proportion_1000_1500 = c(bottleneck_coal_proportion_1000_1500,
    mean(this_sample_size_distribution <= 2000) - mean(this_sample_size_distribution < 200))
  ancestral_coal_proportion_1000_1500 = c(ancestral_coal_proportion_1000_1500,
    mean(this_sample_size_distribution > 2000))

  # Mean and sd of branch length proportions by epoch
  growth_b_len_proportion_mean_1000_1500 = c(growth_b_len_proportion_mean_1000_1500, mean(this_b_len_growth))
  bottleneck_b_len_proportion_mean_1000_1500 = c(bottleneck_b_len_proportion_mean_1000_1500, mean(this_b_len_bottleneck))
  ancestral_b_len_proportion_mean_1000_1500 = c(ancestral_b_len_proportion_mean_1000_1500, mean(this_b_len_ancestral))
}

figure_SX_dataframe = data.frame(
  mean_list_1000_1500,
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

figure_3A_dataframe_1000_1500 = melt(data.frame(
  growth_coal_proportion_1000_1500,
  bottleneck_coal_proportion_1000_1500,
  ancestral_coal_proportion_1000_1500
))

figure_3A_dataframe_1000_1500$msprime_time = msprime_time_1000_1500
figure_3A_dataframe_1000_1500$msprime_shape = msprime_nu_shape_1000_1500
figure_3A_dataframe_1000_1500$sample_size = sample_size

plot_3A_1000_1500 = ggplot(data=figure_3A_dataframe_1000_1500, aes(x=sample_size, y=value, color=variable, shape=msprime_shape)) +
  geom_point(size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Proportion') +
  ggtitle('Coalescent events per epoch, [Anc., 2500 g.a., 1000 g.a.]') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_coal_proportion_1000_1500',
                       'bottleneck_coal_proportion_1000_1500',
                       'ancestral_coal_proportion_1000_1500'),
                     values=c('growth_coal_proportion_1000_1500'='#1b9e77',
                       'bottleneck_coal_proportion_1000_1500'='#d95f02',
                       'ancestral_coal_proportion_1000_1500'='#7570b3'),
                     labels=c('Recent growth [1000 g.a.]', 
                       'Bottleneck [2500 g.a.]', 
                       'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion'))

figure_3B_dataframe_1000_1500 = melt(data.frame(
  growth_b_len_proportion_mean_1000_1500,
  bottleneck_b_len_proportion_mean_1000_1500,
  ancestral_b_len_proportion_mean_1000_1500
))
figure_3B_dataframe_1000_1500$sample_size = sample_size
figure_3B_dataframe_1000_1500$msprime_shape = msprime_nu_shape_1000_1500

plot_3B_simplified_1000_1500 = ggplot(data=figure_3B_dataframe_1000_1500, aes(x=sample_size, y=value, color=variable)) +
  geom_point(aes(shape=msprime_shape), size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Mean branch length') +
  ggtitle('Branch length per epoch') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_b_len_proportion_mean_1000_1500',
                       'bottleneck_b_len_proportion_mean_1000_1500',
                       'ancestral_b_len_proportion_mean_1000_1500'),
                     values=c('growth_b_len_proportion_mean_1000_1500'='#1b9e77',
                       'bottleneck_b_len_proportion_mean_1000_1500'='#d95f02',
                       'ancestral_b_len_proportion_mean_1000_1500'='#7570b3'),
                     labels=c('Recent growth', 'Bottleneck', 'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion')) +
  guides(shape='none', color='none')

plot_3A_1000_1500 + plot_3B_simplified_1000_1500 + plot_layout(nrow=2)


# 1000_2000

sample_size = seq(from=10, to=800, by=10)
mean_list_1000_2000 = c()
growth_coal_proportion_1000_2000 = c()
bottleneck_coal_proportion_1000_2000 = c()
ancestral_coal_proportion_1000_2000 = c()
msprime_time_1000_2000 = c()
msprime_nu_shape_1000_2000 = c()

growth_b_len_proportion_mean_1000_2000 = c()
bottleneck_b_len_proportion_mean_1000_2000 = c()
ancestral_b_len_proportion_mean_1000_2000 = c()

# Iterate through sample size and replicate
for (i in sample_size) {
  this_sample_size_distribution = c() # Initialize
  msprime_demography_1000_2000 = paste0(
    "../Analysis/msprime_3EpB_1000_2000_", i, '/two_epoch_demography.txt')
  msprime_nu_1000_2000 = nu_from_demography(msprime_demography_1000_2000)
  msprime_time_1000_2000 = c(msprime_time_1000_2000, time_from_demography(msprime_demography_1000_2000))
  if (is.na(msprime_nu_1000_2000)) {
    msprime_nu_shape_1000_2000 = c(msprime_nu_shape_1000_2000, NA)
  } else if (msprime_nu_1000_2000 > 1) {
    msprime_nu_shape_1000_2000 = c(msprime_nu_shape_1000_2000, 'msprime_expand')
  } else {
    msprime_nu_shape_1000_2000 = c(msprime_nu_shape_1000_2000, 'msprime_contract')
  }
  for (j in seq(from=1, to=5, by=1)) {
    this_replicate_distribution = paste0(
      "../Simulations/simple_simulations/ThreeEpochBottleneck_1000_2000_",
      i, '_coal_dist_',
      j, '.csv')
    # Read in the appropriate file
    this_csv = read.csv(this_replicate_distribution, header=TRUE)
    this_sample_size_distribution = c(this_sample_size_distribution, this_csv$generations)
  }
  this_b_len_growth = c()
  this_b_len_bottleneck = c()
  this_b_len_ancestral = c()
  for (g in seq(from=1, to=5, by=1)) {
    this_branch_distribution = paste0(
      "../Simulations/simple_simulations/ThreeEpochBottleneck_1000_2000_",
      i, '_branch_length_dist_',
      g, '.csv')
    if (file.exists(this_branch_distribution)) {
    } else {
      next
    }
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
  mean_list_1000_2000 = c(mean_list_1000_2000, mean(this_sample_size_distribution))
  # Similarly, take standard deviation
  # Lastly find the proportion of coalescent events in each epoch
  growth_coal_proportion_1000_2000 = c(growth_coal_proportion_1000_2000,
    mean(this_sample_size_distribution <= 200))
  bottleneck_coal_proportion_1000_2000 = c(bottleneck_coal_proportion_1000_2000,
    mean(this_sample_size_distribution <= 2000) - mean(this_sample_size_distribution < 200))
  ancestral_coal_proportion_1000_2000 = c(ancestral_coal_proportion_1000_2000,
    mean(this_sample_size_distribution > 2000))

  # Mean and sd of branch length proportions by epoch
  growth_b_len_proportion_mean_1000_2000 = c(growth_b_len_proportion_mean_1000_2000, mean(this_b_len_growth))
  bottleneck_b_len_proportion_mean_1000_2000 = c(bottleneck_b_len_proportion_mean_1000_2000, mean(this_b_len_bottleneck))
  ancestral_b_len_proportion_mean_1000_2000 = c(ancestral_b_len_proportion_mean_1000_2000, mean(this_b_len_ancestral))
}

figure_SX_dataframe = data.frame(
  mean_list_1000_2000,
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

figure_3A_dataframe_1000_2000 = melt(data.frame(
  growth_coal_proportion_1000_2000,
  bottleneck_coal_proportion_1000_2000,
  ancestral_coal_proportion_1000_2000
))

figure_3A_dataframe_1000_2000$msprime_time = msprime_time_1000_2000
figure_3A_dataframe_1000_2000$msprime_shape = msprime_nu_shape_1000_2000
figure_3A_dataframe_1000_2000$sample_size = sample_size

plot_3A_1000_2000 = ggplot(data=figure_3A_dataframe_1000_2000, aes(x=sample_size, y=value, color=variable, shape=msprime_shape)) +
  geom_point(size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Proportion') +
  ggtitle('Coalescent events per epoch, [Anc., 3000 g.a., 1000 g.a.]') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_coal_proportion_1000_2000',
                       'bottleneck_coal_proportion_1000_2000',
                       'ancestral_coal_proportion_1000_2000'),
                     values=c('growth_coal_proportion_1000_2000'='#1b9e77',
                       'bottleneck_coal_proportion_1000_2000'='#d95f02',
                       'ancestral_coal_proportion_1000_2000'='#7570b3'),
                     labels=c('Recent growth [1000 g.a.]', 
                       'Bottleneck [3000 g.a.]', 
                       'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion'))

figure_3B_dataframe_1000_2000 = melt(data.frame(
  growth_b_len_proportion_mean_1000_2000,
  bottleneck_b_len_proportion_mean_1000_2000,
  ancestral_b_len_proportion_mean_1000_2000
))
figure_3B_dataframe_1000_2000$sample_size = sample_size
figure_3B_dataframe_1000_2000$msprime_shape = msprime_nu_shape_1000_2000

plot_3B_simplified_1000_2000 = ggplot(data=figure_3B_dataframe_1000_2000, aes(x=sample_size, y=value, color=variable)) +
  geom_point(aes(shape=msprime_shape), size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Mean branch length') +
  ggtitle('Branch length per epoch') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_b_len_proportion_mean_1000_2000',
                       'bottleneck_b_len_proportion_mean_1000_2000',
                       'ancestral_b_len_proportion_mean_1000_2000'),
                     values=c('growth_b_len_proportion_mean_1000_2000'='#1b9e77',
                       'bottleneck_b_len_proportion_mean_1000_2000'='#d95f02',
                       'ancestral_b_len_proportion_mean_1000_2000'='#7570b3'),
                     labels=c('Recent growth', 'Bottleneck', 'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion')) +
  guides(shape='none', color='none')

plot_3A_1000_2000 + plot_3B_simplified_1000_2000 + plot_layout(nrow=2)




# # 500_2000
# 
# sample_size = seq(from=10, to=800, by=10)
# mean_list_500_2000 = c()
# growth_coal_proportion_500_2000 = c()
# bottleneck_coal_proportion_500_2000 = c()
# ancestral_coal_proportion_500_2000 = c()
# msprime_time_500_2000 = c()
# msprime_nu_shape_500_2000 = c()
# 
# growth_b_len_proportion_mean_500_2000 = c()
# bottleneck_b_len_proportion_mean_500_2000 = c()
# ancestral_b_len_proportion_mean_500_2000 = c()
# 
# # Iterate through sample size and replicate
# for (i in sample_size) {
#   this_sample_size_distribution = c() # Initialize
#   msprime_demography_500_2000 = paste0(
#     "../Analysis/msprime_3EpB_500_2000_", i, '/two_epoch_demography.txt')
#   msprime_nu_500_2000 = nu_from_demography(msprime_demography_500_2000)
#   msprime_time_500_2000 = c(msprime_time_500_2000, time_from_demography(msprime_demography_500_2000))
#   if (is.na(msprime_nu_500_2000)) {
#     msprime_nu_shape_500_2000 = c(msprime_nu_shape_500_2000, NA)
#   } else if (msprime_nu_500_2000 > 1) {
#     msprime_nu_shape_500_2000 = c(msprime_nu_shape_500_2000, 'msprime_expand')
#   } else {
#     msprime_nu_shape_500_2000 = c(msprime_nu_shape_500_2000, 'msprime_contract')
#   }
#   for (j in seq(from=1, to=5, by=1)) {
#     this_replicate_distribution = paste0(
#       "../Simulations/simple_simulations/ThreeEpochBottleneck_500_2000_",
#       i, '_coal_dist_',
#       j, '.csv')
#     # Read in the appropriate file
#     this_csv = read.csv(this_replicate_distribution, header=TRUE)
#     this_sample_size_distribution = c(this_sample_size_distribution, this_csv$generations)
#   }
#   this_b_len_growth = c()
#   this_b_len_bottleneck = c()
#   this_b_len_ancestral = c()
#   for (g in seq(from=1, to=5, by=1)) {
#     this_branch_distribution = paste0(
#       "../Simulations/simple_simulations/ThreeEpochBottleneck_500_2000_",
#       i, '_branch_length_dist_',
#       g, '.csv')
#     if (file.exists(this_branch_distribution)) {
#     } else {
#       next
#     }
#     # Read in the appropriate file
#     this_b_len_csv = read.csv(this_branch_distribution, header=TRUE)
#     growth_sum = sum(this_b_len_csv[this_b_len_csv$node_generations <= 200, ]$branch_length)
#     bottleneck_sum = sum(this_b_len_csv[this_b_len_csv$node_generations > 200 &
#         this_b_len_csv$node_generations<= 2000, ]$branch_length)
#     ancestral_sum = sum(this_b_len_csv[this_b_len_csv$node_generations > 2000, ]$branch_length)
#     total_branch_length = growth_sum + bottleneck_sum + ancestral_sum
#     this_b_len_growth = c(this_b_len_growth, growth_sum / total_branch_length)
#     this_b_len_bottleneck = c(this_b_len_bottleneck, bottleneck_sum / total_branch_length)
#     this_b_len_ancestral = c(this_b_len_ancestral, ancestral_sum / total_branch_length)
#   }
#   # Take the mean of coalescent times for this sample size's distribution
#   mean_list_500_2000 = c(mean_list_500_2000, mean(this_sample_size_distribution))
#   # Similarly, take standard deviation
#   # Lastly find the proportion of coalescent events in each epoch
#   growth_coal_proportion_500_2000 = c(growth_coal_proportion_500_2000,
#     mean(this_sample_size_distribution <= 200))
#   bottleneck_coal_proportion_500_2000 = c(bottleneck_coal_proportion_500_2000,
#     mean(this_sample_size_distribution <= 2000) - mean(this_sample_size_distribution < 200))
#   ancestral_coal_proportion_500_2000 = c(ancestral_coal_proportion_500_2000,
#     mean(this_sample_size_distribution > 2000))
# 
#   # Mean and sd of branch length proportions by epoch
#   growth_b_len_proportion_mean_500_2000 = c(growth_b_len_proportion_mean_500_2000, mean(this_b_len_growth))
#   bottleneck_b_len_proportion_mean_500_2000 = c(bottleneck_b_len_proportion_mean_500_2000, mean(this_b_len_bottleneck))
#   ancestral_b_len_proportion_mean_500_2000 = c(ancestral_b_len_proportion_mean_500_2000, mean(this_b_len_ancestral))
# }
# 
# figure_SX_dataframe = data.frame(
#   mean_list_500_2000,
#   sample_size
# )
# 
# # figure_3A_dataframe$sample_size = sample_size
# 
# plot_SX = ggplot(data=figure_SX_dataframe, aes(x=sample_size, y=mean_list)) +
#   geom_line(linewidth=1) +
#   theme_bw() +
#   xlab('Sample size') +
#   ylab("Mean coalescent time (generations)") +
#   ggtitle("Mean coalescent time by sample size") +
#   geom_hline(yintercept = 1, linewidth = 1, linetype = 'dashed')
# 
# figure_3A_dataframe_500_2000 = melt(data.frame(
#   growth_coal_proportion_500_2000,
#   bottleneck_coal_proportion_500_2000,
#   ancestral_coal_proportion_500_2000
# ))
# 
# figure_3A_dataframe_500_2000$msprime_time = msprime_time_500_2000
# figure_3A_dataframe_500_2000$msprime_shape = msprime_nu_shape_500_2000
# figure_3A_dataframe_500_2000$sample_size = sample_size
# 
# plot_3A_500_2000 = ggplot(data=figure_3A_dataframe_500_2000, aes(x=sample_size, y=value, color=variable, shape=msprime_shape)) +
#   geom_point(size=1.5) +
#   theme_bw() +
#   xlab('Sample size') +
#   ylab('Proportion') +
#   ggtitle('Coalescent events per epoch, [Anc., 2500 g.a., 500 g.a.]') +
#   scale_color_manual(name='Epoch',
#                      breaks=c('growth_coal_proportion_500_2000',
#                        'bottleneck_coal_proportion_500_2000',
#                        'ancestral_coal_proportion_500_2000'),
#                      values=c('growth_coal_proportion_500_2000'='#1b9e77',
#                        'bottleneck_coal_proportion_500_2000'='#d95f02',
#                        'ancestral_coal_proportion_500_2000'='#7570b3'),
#                      labels=c('Recent growth [500 g.a.]', 
#                        'Bottleneck [2500 g.a.]', 
#                        'Ancestral population')) +
#   scale_shape_manual(name='Inferred two-epoch model',
#                      breaks=c('msprime_contract',
#                        'msprime_expand'),
#                      values=c('msprime_contract'=15,
#                        'msprime_expand'=22),
#                      labels=c('Contraction',
#                        'Expansion'))
# 
# figure_3B_dataframe_500_2000 = melt(data.frame(
#   growth_b_len_proportion_mean_500_2000,
#   bottleneck_b_len_proportion_mean_500_2000,
#   ancestral_b_len_proportion_mean_500_2000
# ))
# figure_3B_dataframe_500_2000$sample_size = sample_size
# figure_3B_dataframe_500_2000$msprime_shape = msprime_nu_shape_500_2000
# 
# plot_3B_simplified_500_2000 = ggplot(data=figure_3B_dataframe_500_2000, aes(x=sample_size, y=value, color=variable)) +
#   geom_point(aes(shape=msprime_shape), size=1.5) +
#   theme_bw() +
#   xlab('Sample size') +
#   ylab('Mean branch length') +
#   ggtitle('Branch length per epoch') +
#   scale_color_manual(name='Epoch',
#                      breaks=c('growth_b_len_proportion_mean_500_2000',
#                        'bottleneck_b_len_proportion_mean_500_2000',
#                        'ancestral_b_len_proportion_mean_500_2000'),
#                      values=c('growth_b_len_proportion_mean_500_2000'='#1b9e77',
#                        'bottleneck_b_len_proportion_mean_500_2000'='#d95f02',
#                        'ancestral_b_len_proportion_mean_500_2000'='#7570b3'),
#                      labels=c('Recent growth', 'Bottleneck', 'Ancestral population')) +
#   scale_shape_manual(name='Inferred two-epoch model',
#                      breaks=c('msprime_contract',
#                        'msprime_expand'),
#                      values=c('msprime_contract'=15,
#                        'msprime_expand'=22),
#                      labels=c('Contraction',
#                        'Expansion')) +
#   guides(shape='none', color='none')
# 
# plot_3A_500_2000 + plot_3B_simplified_500_2000 + plot_layout(nrow=2)


# 1500_2000

sample_size = seq(from=10, to=800, by=10)
mean_list_1500_2000 = c()
growth_coal_proportion_1500_2000 = c()
bottleneck_coal_proportion_1500_2000 = c()
ancestral_coal_proportion_1500_2000 = c()
msprime_time_1500_2000 = c()
msprime_nu_shape_1500_2000 = c()

growth_b_len_proportion_mean_1500_2000 = c()
bottleneck_b_len_proportion_mean_1500_2000 = c()
ancestral_b_len_proportion_mean_1500_2000 = c()

# Iterate through sample size and replicate
for (i in sample_size) {
  this_sample_size_distribution = c() # Initialize
  msprime_demography_1500_2000 = paste0(
    "../Analysis/msprime_3EpB_1500_2000_", i, '/two_epoch_demography.txt')
  msprime_nu_1500_2000 = nu_from_demography(msprime_demography_1500_2000)
  msprime_time_1500_2000 = c(msprime_time_1500_2000, time_from_demography(msprime_demography_1500_2000))
  if (is.na(msprime_nu_1500_2000)) {
    msprime_nu_shape_1500_2000 = c(msprime_nu_shape_1500_2000, NA)
  } else if (msprime_nu_1500_2000 > 1) {
    msprime_nu_shape_1500_2000 = c(msprime_nu_shape_1500_2000, 'msprime_expand')
  } else {
    msprime_nu_shape_1500_2000 = c(msprime_nu_shape_1500_2000, 'msprime_contract')
  }
  for (j in seq(from=1, to=5, by=1)) {
    this_replicate_distribution = paste0(
      "../Simulations/simple_simulations/ThreeEpochBottleneck_1500_2000_",
      i, '_coal_dist_',
      j, '.csv')
    # Read in the appropriate file
    this_csv = read.csv(this_replicate_distribution, header=TRUE)
    this_sample_size_distribution = c(this_sample_size_distribution, this_csv$generations)
  }
  this_b_len_growth = c()
  this_b_len_bottleneck = c()
  this_b_len_ancestral = c()
  for (g in seq(from=1, to=5, by=1)) {
    this_branch_distribution = paste0(
      "../Simulations/simple_simulations/ThreeEpochBottleneck_1500_2000_",
      i, '_branch_length_dist_',
      g, '.csv')
    if (file.exists(this_branch_distribution)) {
    } else {
      next
    }
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
  mean_list_1500_2000 = c(mean_list_1500_2000, mean(this_sample_size_distribution))
  # Similarly, take standard deviation
  # Lastly find the proportion of coalescent events in each epoch
  growth_coal_proportion_1500_2000 = c(growth_coal_proportion_1500_2000,
    mean(this_sample_size_distribution <= 200))
  bottleneck_coal_proportion_1500_2000 = c(bottleneck_coal_proportion_1500_2000,
    mean(this_sample_size_distribution <= 2000) - mean(this_sample_size_distribution < 200))
  ancestral_coal_proportion_1500_2000 = c(ancestral_coal_proportion_1500_2000,
    mean(this_sample_size_distribution > 2000))

  # Mean and sd of branch length proportions by epoch
  growth_b_len_proportion_mean_1500_2000 = c(growth_b_len_proportion_mean_1500_2000, mean(this_b_len_growth))
  bottleneck_b_len_proportion_mean_1500_2000 = c(bottleneck_b_len_proportion_mean_1500_2000, mean(this_b_len_bottleneck))
  ancestral_b_len_proportion_mean_1500_2000 = c(ancestral_b_len_proportion_mean_1500_2000, mean(this_b_len_ancestral))
}

figure_SX_dataframe = data.frame(
  mean_list_1500_2000,
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

figure_3A_dataframe_1500_2000 = melt(data.frame(
  growth_coal_proportion_1500_2000,
  bottleneck_coal_proportion_1500_2000,
  ancestral_coal_proportion_1500_2000
))

figure_3A_dataframe_1500_2000$msprime_time = msprime_time_1500_2000
figure_3A_dataframe_1500_2000$msprime_shape = msprime_nu_shape_1500_2000
figure_3A_dataframe_1500_2000$sample_size = sample_size

plot_3A_1500_2000 = ggplot(data=figure_3A_dataframe_1500_2000, aes(x=sample_size, y=value, color=variable, shape=msprime_shape)) +
  geom_point(size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Proportion') +
  ggtitle('Coalescent events per epoch, [Anc., 3500 g.a., 2000 g.a.]') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_coal_proportion_1500_2000',
                       'bottleneck_coal_proportion_1500_2000',
                       'ancestral_coal_proportion_1500_2000'),
                     values=c('growth_coal_proportion_1500_2000'='#1b9e77',
                       'bottleneck_coal_proportion_1500_2000'='#d95f02',
                       'ancestral_coal_proportion_1500_2000'='#7570b3'),
                     labels=c('Recent growth [2000 g.a.]', 
                       'Bottleneck [3500 g.a.]', 
                       'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion'))

figure_3B_dataframe_1500_2000 = melt(data.frame(
  growth_b_len_proportion_mean_1500_2000,
  bottleneck_b_len_proportion_mean_1500_2000,
  ancestral_b_len_proportion_mean_1500_2000
))
figure_3B_dataframe_1500_2000$sample_size = sample_size
figure_3B_dataframe_1500_2000$msprime_shape = msprime_nu_shape_1500_2000

plot_3B_simplified_1500_2000 = ggplot(data=figure_3B_dataframe_1500_2000, aes(x=sample_size, y=value, color=variable)) +
  geom_point(aes(shape=msprime_shape), size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Mean branch length') +
  ggtitle('Branch length per epoch') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_b_len_proportion_mean_1500_2000',
                       'bottleneck_b_len_proportion_mean_1500_2000',
                       'ancestral_b_len_proportion_mean_1500_2000'),
                     values=c('growth_b_len_proportion_mean_1500_2000'='#1b9e77',
                       'bottleneck_b_len_proportion_mean_1500_2000'='#d95f02',
                       'ancestral_b_len_proportion_mean_1500_2000'='#7570b3'),
                     labels=c('Recent growth', 'Bottleneck', 'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion')) +
  guides(shape='none', color='none')

plot_3A_1500_2000 + plot_3B_simplified_1500_2000 + plot_layout(nrow=2)



# 2000_2000

sample_size = seq(from=10, to=800, by=10)
mean_list_2000_2000 = c()
growth_coal_proportion_2000_2000 = c()
bottleneck_coal_proportion_2000_2000 = c()
ancestral_coal_proportion_2000_2000 = c()
msprime_time_2000_2000 = c()
msprime_nu_shape_2000_2000 = c()

growth_b_len_proportion_mean_2000_2000 = c()
bottleneck_b_len_proportion_mean_2000_2000 = c()
ancestral_b_len_proportion_mean_2000_2000 = c()

# Iterate through sample size and replicate
for (i in sample_size) {
  this_sample_size_distribution = c() # Initialize
  msprime_demography_2000_2000 = paste0(
    "../Analysis/msprime_3EpB_2000_2000_", i, '/two_epoch_demography.txt')
  msprime_nu_2000_2000 = nu_from_demography(msprime_demography_2000_2000)
  msprime_time_2000_2000 = c(msprime_time_2000_2000, time_from_demography(msprime_demography_2000_2000))
  if (is.na(msprime_nu_2000_2000)) {
    msprime_nu_shape_2000_2000 = c(msprime_nu_shape_2000_2000, NA)
  } else if (msprime_nu_2000_2000 > 1) {
    msprime_nu_shape_2000_2000 = c(msprime_nu_shape_2000_2000, 'msprime_expand')
  } else {
    msprime_nu_shape_2000_2000 = c(msprime_nu_shape_2000_2000, 'msprime_contract')
  }
  for (j in seq(from=1, to=5, by=1)) {
    this_replicate_distribution = paste0(
      "../Simulations/simple_simulations/ThreeEpochBottleneck_2000_2000_",
      i, '_coal_dist_',
      j, '.csv')
    # Read in the appropriate file
    this_csv = read.csv(this_replicate_distribution, header=TRUE)
    this_sample_size_distribution = c(this_sample_size_distribution, this_csv$generations)
  }
  this_b_len_growth = c()
  this_b_len_bottleneck = c()
  this_b_len_ancestral = c()
  for (g in seq(from=1, to=5, by=1)) {
    this_branch_distribution = paste0(
      "../Simulations/simple_simulations/ThreeEpochBottleneck_2000_2000_",
      i, '_branch_length_dist_',
      g, '.csv')
    if (file.exists(this_branch_distribution)) {
    } else {
      next
    }
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
  mean_list_2000_2000 = c(mean_list_2000_2000, mean(this_sample_size_distribution))
  # Similarly, take standard deviation
  # Lastly find the proportion of coalescent events in each epoch
  growth_coal_proportion_2000_2000 = c(growth_coal_proportion_2000_2000,
    mean(this_sample_size_distribution <= 200))
  bottleneck_coal_proportion_2000_2000 = c(bottleneck_coal_proportion_2000_2000,
    mean(this_sample_size_distribution <= 2000) - mean(this_sample_size_distribution < 200))
  ancestral_coal_proportion_2000_2000 = c(ancestral_coal_proportion_2000_2000,
    mean(this_sample_size_distribution > 2000))

  # Mean and sd of branch length proportions by epoch
  growth_b_len_proportion_mean_2000_2000 = c(growth_b_len_proportion_mean_2000_2000, mean(this_b_len_growth))
  bottleneck_b_len_proportion_mean_2000_2000 = c(bottleneck_b_len_proportion_mean_2000_2000, mean(this_b_len_bottleneck))
  ancestral_b_len_proportion_mean_2000_2000 = c(ancestral_b_len_proportion_mean_2000_2000, mean(this_b_len_ancestral))
}

figure_SX_dataframe = data.frame(
  mean_list_2000_2000,
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

figure_3A_dataframe_2000_2000 = melt(data.frame(
  growth_coal_proportion_2000_2000,
  bottleneck_coal_proportion_2000_2000,
  ancestral_coal_proportion_2000_2000
))

figure_3A_dataframe_2000_2000$msprime_time = msprime_time_2000_2000
figure_3A_dataframe_2000_2000$msprime_shape = msprime_nu_shape_2000_2000
figure_3A_dataframe_2000_2000$sample_size = sample_size

plot_3A_2000_2000 = ggplot(data=figure_3A_dataframe_2000_2000, aes(x=sample_size, y=value, color=variable, shape=msprime_shape)) +
  geom_point(size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Proportion') +
  ggtitle('Coalescent events per epoch, [Anc., 4000 g.a., 2000 g.a.]') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_coal_proportion_2000_2000',
                       'bottleneck_coal_proportion_2000_2000',
                       'ancestral_coal_proportion_2000_2000'),
                     values=c('growth_coal_proportion_2000_2000'='#1b9e77',
                       'bottleneck_coal_proportion_2000_2000'='#d95f02',
                       'ancestral_coal_proportion_2000_2000'='#7570b3'),
                     labels=c('Recent growth [2000 g.a.]', 
                       'Bottleneck [4000 g.a.]', 
                       'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion'))

figure_3B_dataframe_2000_2000 = melt(data.frame(
  growth_b_len_proportion_mean_2000_2000,
  bottleneck_b_len_proportion_mean_2000_2000,
  ancestral_b_len_proportion_mean_2000_2000
))
figure_3B_dataframe_2000_2000$sample_size = sample_size
figure_3B_dataframe_2000_2000$msprime_shape = msprime_nu_shape_2000_2000

plot_3B_simplified_2000_2000 = ggplot(data=figure_3B_dataframe_2000_2000, aes(x=sample_size, y=value, color=variable)) +
  geom_point(aes(shape=msprime_shape), size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Mean branch length') +
  ggtitle('Branch length per epoch') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_b_len_proportion_mean_2000_2000',
                       'bottleneck_b_len_proportion_mean_2000_2000',
                       'ancestral_b_len_proportion_mean_2000_2000'),
                     values=c('growth_b_len_proportion_mean_2000_2000'='#1b9e77',
                       'bottleneck_b_len_proportion_mean_2000_2000'='#d95f02',
                       'ancestral_b_len_proportion_mean_2000_2000'='#7570b3'),
                     labels=c('Recent growth', 'Bottleneck', 'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion')) +
  guides(shape='none', color='none')

plot_3A_2000_2000 + plot_3B_simplified_2000_2000 + plot_layout(nrow=2)

