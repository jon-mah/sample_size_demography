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
  ggtitle('Coalescent events per epoch, [Anc., 2000 g.a., 200 g.a.]') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_coal_proportion',
                       'bottleneck_coal_proportion',
                       'ancestral_coal_proportion'),
                     values=c('growth_coal_proportion'='#1b9e77',
                       'bottleneck_coal_proportion'='#d95f02',
                       'ancestral_coal_proportion'='#7570b3'),
                     labels=c('Recent growth [200 g.a.]', 
                       'Bottleneck [1600 g.a.]', 
                       'Ancestral population')) +
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

# 1800_200

plot_1800_200_simplified = ggplot(data=figure_3B_dataframe, aes(x=sample_size, y=value, color=variable)) +
  geom_point(aes(shape=msprime_shape), size=1.5) +
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
                       'Expansion')) +
  guides(shape='none', color='none')
  # theme(axis.title.x = element_text(size = 20))  +
  # theme(axis.title.y = element_text(size = 20))  +
  # theme(plot.title = element_text(size = 32))  +
  # theme(legend.title = element_text(size = 18)) +
  # theme(legend.text = element_text(size = 16))

plot_3A + plot_1800_200_simplified + plot_layout(nrow=2)

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
  for (j in seq(from=1, to=20, by=1)) {
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
  for (g in seq(from=1, to=20, by=1)) {
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
    growth_sum = sum(this_b_len_csv[this_b_len_csv$node_generations <= 500, ]$branch_length)
    bottleneck_sum = sum(this_b_len_csv[this_b_len_csv$node_generations > 500 &
        this_b_len_csv$node_generations<= 1500, ]$branch_length)
    ancestral_sum = sum(this_b_len_csv[this_b_len_csv$node_generations > 1500, ]$branch_length)
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
    mean(this_sample_size_distribution <= 500))
  bottleneck_coal_proportion_1000_500 = c(bottleneck_coal_proportion_1000_500,
    mean(this_sample_size_distribution <= 1500) - mean(this_sample_size_distribution < 500))
  ancestral_coal_proportion_1000_500 = c(ancestral_coal_proportion_1000_500,
    mean(this_sample_size_distribution > 1500))

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
  for (j in seq(from=1, to=20, by=1)) {
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
  for (g in seq(from=1, to=20, by=1)) {
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
    growth_sum = sum(this_b_len_csv[this_b_len_csv$node_generations <= 1000, ]$branch_length)
    bottleneck_sum = sum(this_b_len_csv[this_b_len_csv$node_generations > 1000 &
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
    mean(this_sample_size_distribution <= 1000))
  bottleneck_coal_proportion_1000_1000 = c(bottleneck_coal_proportion_1000_1000,
    mean(this_sample_size_distribution <= 2000) - mean(this_sample_size_distribution < 1000))
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
  for (j in seq(from=1, to=20, by=1)) {
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
  for (g in seq(from=1, to=20, by=1)) {
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
    growth_sum = sum(this_b_len_csv[this_b_len_csv$node_generations <= 1500, ]$branch_length)
    bottleneck_sum = sum(this_b_len_csv[this_b_len_csv$node_generations > 1500 &
        this_b_len_csv$node_generations<= 2500, ]$branch_length)
    ancestral_sum = sum(this_b_len_csv[this_b_len_csv$node_generations > 2500, ]$branch_length)
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
    mean(this_sample_size_distribution <= 1500))
  bottleneck_coal_proportion_1000_1500 = c(bottleneck_coal_proportion_1000_1500,
    mean(this_sample_size_distribution <= 2500) - mean(this_sample_size_distribution < 1500))
  ancestral_coal_proportion_1000_1500 = c(ancestral_coal_proportion_1000_1500,
    mean(this_sample_size_distribution > 2500))

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
  for (j in seq(from=1, to=20, by=1)) {
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
  for (g in seq(from=1, to=20, by=1)) {
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
    growth_sum = sum(this_b_len_csv[this_b_len_csv$node_generations <= 2000, ]$branch_length)
    bottleneck_sum = sum(this_b_len_csv[this_b_len_csv$node_generations > 2000 &
        this_b_len_csv$node_generations<= 3000, ]$branch_length)
    ancestral_sum = sum(this_b_len_csv[this_b_len_csv$node_generations > 3000, ]$branch_length)
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
    mean(this_sample_size_distribution <= 2000))
  bottleneck_coal_proportion_1000_2000 = c(bottleneck_coal_proportion_1000_2000,
    mean(this_sample_size_distribution <= 3000) - mean(this_sample_size_distribution < 2000))
  ancestral_coal_proportion_1000_2000 = c(ancestral_coal_proportion_1000_2000,
    mean(this_sample_size_distribution > 3000))

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
#   for (j in seq(from=1, to=20, by=1)) {
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
#   for (g in seq(from=1, to=20, by=1)) {
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
#     growth_sum = sum(this_b_len_csv[this_b_len_csv$node_generations <= 500, ]$branch_length)
#     bottleneck_sum = sum(this_b_len_csv[this_b_len_csv$node_generations > 500 &
#         this_b_len_csv$node_generations<= 2500, ]$branch_length)
#     ancestral_sum = sum(this_b_len_csv[this_b_len_csv$node_generations > 2500, ]$branch_length)
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
#     mean(this_sample_size_distribution <= 500))
#   bottleneck_coal_proportion_500_2000 = c(bottleneck_coal_proportion_500_2000,
#     mean(this_sample_size_distribution <= 2500) - mean(this_sample_size_distribution < 500))
#   ancestral_coal_proportion_500_2000 = c(ancestral_coal_proportion_500_2000,
#     mean(this_sample_size_distribution > 2500))
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
# 

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
  for (j in seq(from=1, to=20, by=1)) {
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
  for (g in seq(from=1, to=20, by=1)) {
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
    growth_sum = sum(this_b_len_csv[this_b_len_csv$node_generations <= 1500, ]$branch_length)
    bottleneck_sum = sum(this_b_len_csv[this_b_len_csv$node_generations > 1500 &
        this_b_len_csv$node_generations<= 3500, ]$branch_length)
    ancestral_sum = sum(this_b_len_csv[this_b_len_csv$node_generations > 3500, ]$branch_length)
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
    mean(this_sample_size_distribution <= 1500))
  bottleneck_coal_proportion_1500_2000 = c(bottleneck_coal_proportion_1500_2000,
    mean(this_sample_size_distribution <= 3500) - mean(this_sample_size_distribution < 1500))
  ancestral_coal_proportion_1500_2000 = c(ancestral_coal_proportion_1500_2000,
    mean(this_sample_size_distribution > 3500))

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
  for (j in seq(from=1, to=20, by=1)) {
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
  for (g in seq(from=1, to=20, by=1)) {
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
    growth_sum = sum(this_b_len_csv[this_b_len_csv$node_generations <= 2000, ]$branch_length)
    bottleneck_sum = sum(this_b_len_csv[this_b_len_csv$node_generations > 2000 &
        this_b_len_csv$node_generations<= 4000, ]$branch_length)
    ancestral_sum = sum(this_b_len_csv[this_b_len_csv$node_generations > 4000, ]$branch_length)
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
    mean(this_sample_size_distribution <= 2000))
  bottleneck_coal_proportion_2000_2000 = c(bottleneck_coal_proportion_2000_2000,
    mean(this_sample_size_distribution <= 4000) - mean(this_sample_size_distribution < 2000))
  ancestral_coal_proportion_2000_2000 = c(ancestral_coal_proportion_2000_2000,
    mean(this_sample_size_distribution > 4000))

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


# Smaller magnitude

# 100_50

sample_size = seq(from=10, to=800, by=10)
mean_list_100_50 = c()
growth_coal_proportion_100_50 = c()
bottleneck_coal_proportion_100_50 = c()
ancestral_coal_proportion_100_50 = c()
msprime_time_100_50 = c()
msprime_nu_shape_100_50 = c()

growth_b_len_proportion_mean_100_50 = c()
bottleneck_b_len_proportion_mean_100_50 = c()
ancestral_b_len_proportion_mean_100_50 = c()

# Iterate through sample size and replicate
for (i in sample_size) {
  this_sample_size_distribution = c() # Initialize
  msprime_demography_100_50 = paste0(
    "../Analysis/msprime_3EpB_100_50_", i, '/two_epoch_demography.txt')
  msprime_nu_100_50 = nu_from_demography(msprime_demography_100_50)
  msprime_time_100_50 = c(msprime_time_100_50, time_from_demography(msprime_demography_100_50))
  if (is.na(msprime_nu_100_50)) {
    msprime_nu_shape_100_50 = c(msprime_nu_shape_100_50, NA)
  } else if (msprime_nu_100_50 > 1) {
    msprime_nu_shape_100_50 = c(msprime_nu_shape_100_50, 'msprime_expand')
  } else {
    msprime_nu_shape_100_50 = c(msprime_nu_shape_100_50, 'msprime_contract')
  }
  for (j in seq(from=1, to=20, by=1)) {
    this_replicate_distribution = paste0(
      "../Simulations/simple_simulations/ThreeEpochBottleneck_100_50_",
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
      "../Simulations/simple_simulations/ThreeEpochBottleneck_100_50_",
      i, '_branch_length_dist_',
      g, '.csv')
    if (file.exists(this_branch_distribution)) {
    } else {
      next
    }
    # Read in the appropriate file
    this_b_len_csv = read.csv(this_branch_distribution, header=TRUE)
    growth_sum = sum(this_b_len_csv[this_b_len_csv$node_generations <= 100, ]$branch_length)
    bottleneck_sum = sum(this_b_len_csv[this_b_len_csv$node_generations > 100 &
        this_b_len_csv$node_generations<= 150, ]$branch_length)
    ancestral_sum = sum(this_b_len_csv[this_b_len_csv$node_generations > 150, ]$branch_length)
    total_branch_length = growth_sum + bottleneck_sum + ancestral_sum
    this_b_len_growth = c(this_b_len_growth, growth_sum / total_branch_length)
    this_b_len_bottleneck = c(this_b_len_bottleneck, bottleneck_sum / total_branch_length)
    this_b_len_ancestral = c(this_b_len_ancestral, ancestral_sum / total_branch_length)
  }
  # Take the mean of coalescent times for this sample size's distribution
  mean_list_100_50 = c(mean_list_100_50, mean(this_sample_size_distribution))
  # Similarly, take standard deviation
  # Lastly find the proportion of coalescent events in each epoch
  growth_coal_proportion_100_50 = c(growth_coal_proportion_100_50,
    mean(this_sample_size_distribution <= 50))
  bottleneck_coal_proportion_100_50 = c(bottleneck_coal_proportion_100_50,
    mean(this_sample_size_distribution <= 150) - mean(this_sample_size_distribution < 50))
  ancestral_coal_proportion_100_50 = c(ancestral_coal_proportion_100_50,
    mean(this_sample_size_distribution > 150))

  # Mean and sd of branch length proportions by epoch
  growth_b_len_proportion_mean_100_50 = c(growth_b_len_proportion_mean_100_50, mean(this_b_len_growth))
  bottleneck_b_len_proportion_mean_100_50 = c(bottleneck_b_len_proportion_mean_100_50, mean(this_b_len_bottleneck))
  ancestral_b_len_proportion_mean_100_50 = c(ancestral_b_len_proportion_mean_100_50, mean(this_b_len_ancestral))
}

figure_SX_dataframe = data.frame(
  mean_list_100_50,
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

figure_3A_dataframe_100_50 = melt(data.frame(
  growth_coal_proportion_100_50,
  bottleneck_coal_proportion_100_50,
  ancestral_coal_proportion_100_50
))

figure_3A_dataframe_100_50$msprime_time = msprime_time_100_50
figure_3A_dataframe_100_50$msprime_shape = msprime_nu_shape_100_50
figure_3A_dataframe_100_50$sample_size = sample_size

plot_3A_100_50 = ggplot(data=figure_3A_dataframe_100_50, aes(x=sample_size, y=value, color=variable, shape=msprime_shape)) +
  geom_point(size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Proportion') +
  ggtitle('Coalescent events per epoch, [Anc., 150 g.a., 100 g.a.]') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_coal_proportion_100_50',
                       'bottleneck_coal_proportion_100_50',
                       'ancestral_coal_proportion_100_50'),
                     values=c('growth_coal_proportion_100_50'='#1b9e77',
                       'bottleneck_coal_proportion_100_50'='#d95f02',
                       'ancestral_coal_proportion_100_50'='#7570b3'),
                     labels=c('Recent growth [100 g.a.]', 
                       'Bottleneck [150 g.a.]', 
                       'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion'))

figure_3B_dataframe_100_50 = melt(data.frame(
  growth_b_len_proportion_mean_100_50,
  bottleneck_b_len_proportion_mean_100_50,
  ancestral_b_len_proportion_mean_100_50
))
figure_3B_dataframe_100_50$sample_size = sample_size
figure_3B_dataframe_100_50$msprime_shape = msprime_nu_shape_100_50

plot_3B_simplified_100_50 = ggplot(data=figure_3B_dataframe_100_50, aes(x=sample_size, y=value, color=variable)) +
  geom_point(aes(shape=msprime_shape), size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Mean branch length') +
  ggtitle('Branch length per epoch') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_b_len_proportion_mean_100_50',
                       'bottleneck_b_len_proportion_mean_100_50',
                       'ancestral_b_len_proportion_mean_100_50'),
                     values=c('growth_b_len_proportion_mean_100_50'='#1b9e77',
                       'bottleneck_b_len_proportion_mean_100_50'='#d95f02',
                       'ancestral_b_len_proportion_mean_100_50'='#7570b3'),
                     labels=c('Recent growth', 'Bottleneck', 'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion')) +
  guides(shape='none', color='none')

plot_3A_100_50 + plot_3B_simplified_100_50 + plot_layout(nrow=2)


# 100_100

sample_size = seq(from=10, to=800, by=10)
mean_list_100_100 = c()
growth_coal_proportion_100_100 = c()
bottleneck_coal_proportion_100_100 = c()
ancestral_coal_proportion_100_100 = c()
msprime_time_100_100 = c()
msprime_nu_shape_100_100 = c()

growth_b_len_proportion_mean_100_100 = c()
bottleneck_b_len_proportion_mean_100_100 = c()
ancestral_b_len_proportion_mean_100_100 = c()

# Iterate through sample size and replicate
for (i in sample_size) {
  this_sample_size_distribution = c() # Initialize
  msprime_demography_100_100 = paste0(
    "../Analysis/msprime_3EpB_100_100_", i, '/two_epoch_demography.txt')
  msprime_nu_100_100 = nu_from_demography(msprime_demography_100_100)
  msprime_time_100_100 = c(msprime_time_100_100, time_from_demography(msprime_demography_100_100))
  if (is.na(msprime_nu_100_100)) {
    msprime_nu_shape_100_100 = c(msprime_nu_shape_100_100, NA)
  } else if (msprime_nu_100_100 > 1) {
    msprime_nu_shape_100_100 = c(msprime_nu_shape_100_100, 'msprime_expand')
  } else {
    msprime_nu_shape_100_100 = c(msprime_nu_shape_100_100, 'msprime_contract')
  }
  for (j in seq(from=1, to=20, by=1)) {
    this_replicate_distribution = paste0(
      "../Simulations/simple_simulations/ThreeEpochBottleneck_100_100_",
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
      "../Simulations/simple_simulations/ThreeEpochBottleneck_100_100_",
      i, '_branch_length_dist_',
      g, '.csv')
    if (file.exists(this_branch_distribution)) {
    } else {
      next
    }
    # Read in the appropriate file
    this_b_len_csv = read.csv(this_branch_distribution, header=TRUE)
    growth_sum = sum(this_b_len_csv[this_b_len_csv$node_generations <= 100, ]$branch_length)
    bottleneck_sum = sum(this_b_len_csv[this_b_len_csv$node_generations > 100 &
        this_b_len_csv$node_generations<= 200, ]$branch_length)
    ancestral_sum = sum(this_b_len_csv[this_b_len_csv$node_generations > 200, ]$branch_length)
    total_branch_length = growth_sum + bottleneck_sum + ancestral_sum
    this_b_len_growth = c(this_b_len_growth, growth_sum / total_branch_length)
    this_b_len_bottleneck = c(this_b_len_bottleneck, bottleneck_sum / total_branch_length)
    this_b_len_ancestral = c(this_b_len_ancestral, ancestral_sum / total_branch_length)
  }
  # Take the mean of coalescent times for this sample size's distribution
  mean_list_100_100 = c(mean_list_100_100, mean(this_sample_size_distribution))
  # Similarly, take standard deviation
  # Lastly find the proportion of coalescent events in each epoch
  growth_coal_proportion_100_100 = c(growth_coal_proportion_100_100,
    mean(this_sample_size_distribution <= 100))
  bottleneck_coal_proportion_100_100 = c(bottleneck_coal_proportion_100_100,
    mean(this_sample_size_distribution <= 200) - mean(this_sample_size_distribution < 100))
  ancestral_coal_proportion_100_100 = c(ancestral_coal_proportion_100_100,
    mean(this_sample_size_distribution > 200))

  # Mean and sd of branch length proportions by epoch
  growth_b_len_proportion_mean_100_100 = c(growth_b_len_proportion_mean_100_100, mean(this_b_len_growth))
  bottleneck_b_len_proportion_mean_100_100 = c(bottleneck_b_len_proportion_mean_100_100, mean(this_b_len_bottleneck))
  ancestral_b_len_proportion_mean_100_100 = c(ancestral_b_len_proportion_mean_100_100, mean(this_b_len_ancestral))
}

figure_SX_dataframe = data.frame(
  mean_list_100_100,
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

figure_3A_dataframe_100_100 = melt(data.frame(
  growth_coal_proportion_100_100,
  bottleneck_coal_proportion_100_100,
  ancestral_coal_proportion_100_100
))

figure_3A_dataframe_100_100$msprime_time = msprime_time_100_100
figure_3A_dataframe_100_100$msprime_shape = msprime_nu_shape_100_100
figure_3A_dataframe_100_100$sample_size = sample_size

plot_3A_100_100 = ggplot(data=figure_3A_dataframe_100_100, aes(x=sample_size, y=value, color=variable, shape=msprime_shape)) +
  geom_point(size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Proportion') +
  ggtitle('Coalescent events per epoch, [Anc., 200 g.a., 100 g.a.]') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_coal_proportion_100_100',
                       'bottleneck_coal_proportion_100_100',
                       'ancestral_coal_proportion_100_100'),
                     values=c('growth_coal_proportion_100_100'='#1b9e77',
                       'bottleneck_coal_proportion_100_100'='#d95f02',
                       'ancestral_coal_proportion_100_100'='#7570b3'),
                     labels=c('Recent growth [100 g.a.]', 
                       'Bottleneck [200 g.a.]', 
                       'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion'))

figure_3B_dataframe_100_100 = melt(data.frame(
  growth_b_len_proportion_mean_100_100,
  bottleneck_b_len_proportion_mean_100_100,
  ancestral_b_len_proportion_mean_100_100
))
figure_3B_dataframe_100_100$sample_size = sample_size
figure_3B_dataframe_100_100$msprime_shape = msprime_nu_shape_100_100

plot_3B_simplified_100_100 = ggplot(data=figure_3B_dataframe_100_100, aes(x=sample_size, y=value, color=variable)) +
  geom_point(aes(shape=msprime_shape), size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Mean branch length') +
  ggtitle('Branch length per epoch') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_b_len_proportion_mean_100_100',
                       'bottleneck_b_len_proportion_mean_100_100',
                       'ancestral_b_len_proportion_mean_100_100'),
                     values=c('growth_b_len_proportion_mean_100_100'='#1b9e77',
                       'bottleneck_b_len_proportion_mean_100_100'='#d95f02',
                       'ancestral_b_len_proportion_mean_100_100'='#7570b3'),
                     labels=c('Recent growth', 'Bottleneck', 'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion')) +
  guides(shape='none', color='none')

plot_3A_100_100 + plot_3B_simplified_100_100 + plot_layout(nrow=2)


# 100_150

sample_size = seq(from=10, to=800, by=10)
mean_list_100_150 = c()
growth_coal_proportion_100_150 = c()
bottleneck_coal_proportion_100_150 = c()
ancestral_coal_proportion_100_150 = c()
msprime_time_100_150 = c()
msprime_nu_shape_100_150 = c()

growth_b_len_proportion_mean_100_150 = c()
bottleneck_b_len_proportion_mean_100_150 = c()
ancestral_b_len_proportion_mean_100_150 = c()

# Iterate through sample size and replicate
for (i in sample_size) {
  this_sample_size_distribution = c() # Initialize
  msprime_demography_100_150 = paste0(
    "../Analysis/msprime_3EpB_100_150_", i, '/two_epoch_demography.txt')
  msprime_nu_100_150 = nu_from_demography(msprime_demography_100_150)
  msprime_time_100_150 = c(msprime_time_100_150, time_from_demography(msprime_demography_100_150))
  if (is.na(msprime_nu_100_150)) {
    msprime_nu_shape_100_150 = c(msprime_nu_shape_100_150, NA)
  } else if (msprime_nu_100_150 > 1) {
    msprime_nu_shape_100_150 = c(msprime_nu_shape_100_150, 'msprime_expand')
  } else {
    msprime_nu_shape_100_150 = c(msprime_nu_shape_100_150, 'msprime_contract')
  }
  for (j in seq(from=1, to=20, by=1)) {
    this_replicate_distribution = paste0(
      "../Simulations/simple_simulations/ThreeEpochBottleneck_100_150_",
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
      "../Simulations/simple_simulations/ThreeEpochBottleneck_100_150_",
      i, '_branch_length_dist_',
      g, '.csv')
    if (file.exists(this_branch_distribution)) {
    } else {
      next
    }
    # Read in the appropriate file
    this_b_len_csv = read.csv(this_branch_distribution, header=TRUE)
    growth_sum = sum(this_b_len_csv[this_b_len_csv$node_generations <= 100, ]$branch_length)
    bottleneck_sum = sum(this_b_len_csv[this_b_len_csv$node_generations > 100 &
        this_b_len_csv$node_generations<= 250, ]$branch_length)
    ancestral_sum = sum(this_b_len_csv[this_b_len_csv$node_generations > 250, ]$branch_length)
    total_branch_length = growth_sum + bottleneck_sum + ancestral_sum
    this_b_len_growth = c(this_b_len_growth, growth_sum / total_branch_length)
    this_b_len_bottleneck = c(this_b_len_bottleneck, bottleneck_sum / total_branch_length)
    this_b_len_ancestral = c(this_b_len_ancestral, ancestral_sum / total_branch_length)
  }
  # Take the mean of coalescent times for this sample size's distribution
  mean_list_100_150 = c(mean_list_100_150, mean(this_sample_size_distribution))
  # Similarly, take standard deviation
  # Lastly find the proportion of coalescent events in each epoch
  growth_coal_proportion_100_150 = c(growth_coal_proportion_100_150,
    mean(this_sample_size_distribution <= 100))
  bottleneck_coal_proportion_100_150 = c(bottleneck_coal_proportion_100_150,
    mean(this_sample_size_distribution <= 250) - mean(this_sample_size_distribution < 100))
  ancestral_coal_proportion_100_150 = c(ancestral_coal_proportion_100_150,
    mean(this_sample_size_distribution > 250))

  # Mean and sd of branch length proportions by epoch
  growth_b_len_proportion_mean_100_150 = c(growth_b_len_proportion_mean_100_150, mean(this_b_len_growth))
  bottleneck_b_len_proportion_mean_100_150 = c(bottleneck_b_len_proportion_mean_100_150, mean(this_b_len_bottleneck))
  ancestral_b_len_proportion_mean_100_150 = c(ancestral_b_len_proportion_mean_100_150, mean(this_b_len_ancestral))
}

figure_SX_dataframe = data.frame(
  mean_list_100_150,
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

figure_3A_dataframe_100_150 = melt(data.frame(
  growth_coal_proportion_100_150,
  bottleneck_coal_proportion_100_150,
  ancestral_coal_proportion_100_150
))

figure_3A_dataframe_100_150$msprime_time = msprime_time_100_150
figure_3A_dataframe_100_150$msprime_shape = msprime_nu_shape_100_150
figure_3A_dataframe_100_150$sample_size = sample_size

plot_3A_100_150 = ggplot(data=figure_3A_dataframe_100_150, aes(x=sample_size, y=value, color=variable, shape=msprime_shape)) +
  geom_point(size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Proportion') +
  ggtitle('Coalescent events per epoch, [Anc., 250 g.a., 100 g.a.]') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_coal_proportion_100_150',
                       'bottleneck_coal_proportion_100_150',
                       'ancestral_coal_proportion_100_150'),
                     values=c('growth_coal_proportion_100_150'='#1b9e77',
                       'bottleneck_coal_proportion_100_150'='#d95f02',
                       'ancestral_coal_proportion_100_150'='#7570b3'),
                     labels=c('Recent growth [100 g.a.]', 
                       'Bottleneck [250 g.a.]', 
                       'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion'))

figure_3B_dataframe_100_150 = melt(data.frame(
  growth_b_len_proportion_mean_100_150,
  bottleneck_b_len_proportion_mean_100_150,
  ancestral_b_len_proportion_mean_100_150
))
figure_3B_dataframe_100_150$sample_size = sample_size
figure_3B_dataframe_100_150$msprime_shape = msprime_nu_shape_100_150

plot_3B_simplified_100_150 = ggplot(data=figure_3B_dataframe_100_150, aes(x=sample_size, y=value, color=variable)) +
  geom_point(aes(shape=msprime_shape), size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Mean branch length') +
  ggtitle('Branch length per epoch') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_b_len_proportion_mean_100_150',
                       'bottleneck_b_len_proportion_mean_100_150',
                       'ancestral_b_len_proportion_mean_100_150'),
                     values=c('growth_b_len_proportion_mean_100_150'='#1b9e77',
                       'bottleneck_b_len_proportion_mean_100_150'='#d95f02',
                       'ancestral_b_len_proportion_mean_100_150'='#7570b3'),
                     labels=c('Recent growth', 'Bottleneck', 'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion')) +
  guides(shape='none', color='none')

plot_3A_100_150 + plot_3B_simplified_100_150 + plot_layout(nrow=2)


# 100_200

sample_size = seq(from=10, to=800, by=10)
mean_list_100_200 = c()
growth_coal_proportion_100_200 = c()
bottleneck_coal_proportion_100_200 = c()
ancestral_coal_proportion_100_200 = c()
msprime_time_100_200 = c()
msprime_nu_shape_100_200 = c()

growth_b_len_proportion_mean_100_200 = c()
bottleneck_b_len_proportion_mean_100_200 = c()
ancestral_b_len_proportion_mean_100_200 = c()

# Iterate through sample size and replicate
for (i in sample_size) {
  this_sample_size_distribution = c() # Initialize
  msprime_demography_100_200 = paste0(
    "../Analysis/msprime_3EpB_100_200_", i, '/two_epoch_demography.txt')
  msprime_nu_100_200 = nu_from_demography(msprime_demography_100_200)
  msprime_time_100_200 = c(msprime_time_100_200, time_from_demography(msprime_demography_100_200))
  if (is.na(msprime_nu_100_200)) {
    msprime_nu_shape_100_200 = c(msprime_nu_shape_100_200, NA)
  } else if (msprime_nu_100_200 > 1) {
    msprime_nu_shape_100_200 = c(msprime_nu_shape_100_200, 'msprime_expand')
  } else {
    msprime_nu_shape_100_200 = c(msprime_nu_shape_100_200, 'msprime_contract')
  }
  for (j in seq(from=1, to=20, by=1)) {
    this_replicate_distribution = paste0(
      "../Simulations/simple_simulations/ThreeEpochBottleneck_100_200_",
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
      "../Simulations/simple_simulations/ThreeEpochBottleneck_100_200_",
      i, '_branch_length_dist_',
      g, '.csv')
    if (file.exists(this_branch_distribution)) {
    } else {
      next
    }
    # Read in the appropriate file
    this_b_len_csv = read.csv(this_branch_distribution, header=TRUE)
    growth_sum = sum(this_b_len_csv[this_b_len_csv$node_generations <= 100, ]$branch_length)
    bottleneck_sum = sum(this_b_len_csv[this_b_len_csv$node_generations > 100 &
        this_b_len_csv$node_generations<= 300, ]$branch_length)
    ancestral_sum = sum(this_b_len_csv[this_b_len_csv$node_generations > 300, ]$branch_length)
    total_branch_length = growth_sum + bottleneck_sum + ancestral_sum
    this_b_len_growth = c(this_b_len_growth, growth_sum / total_branch_length)
    this_b_len_bottleneck = c(this_b_len_bottleneck, bottleneck_sum / total_branch_length)
    this_b_len_ancestral = c(this_b_len_ancestral, ancestral_sum / total_branch_length)
  }
  # Take the mean of coalescent times for this sample size's distribution
  mean_list_100_200 = c(mean_list_100_200, mean(this_sample_size_distribution))
  # Similarly, take standard deviation
  # Lastly find the proportion of coalescent events in each epoch
  growth_coal_proportion_100_200 = c(growth_coal_proportion_100_200,
    mean(this_sample_size_distribution <= 100))
  bottleneck_coal_proportion_100_200 = c(bottleneck_coal_proportion_100_200,
    mean(this_sample_size_distribution <= 300) - mean(this_sample_size_distribution < 100))
  ancestral_coal_proportion_100_200 = c(ancestral_coal_proportion_100_200,
    mean(this_sample_size_distribution > 300))

  # Mean and sd of branch length proportions by epoch
  growth_b_len_proportion_mean_100_200 = c(growth_b_len_proportion_mean_100_200, mean(this_b_len_growth))
  bottleneck_b_len_proportion_mean_100_200 = c(bottleneck_b_len_proportion_mean_100_200, mean(this_b_len_bottleneck))
  ancestral_b_len_proportion_mean_100_200 = c(ancestral_b_len_proportion_mean_100_200, mean(this_b_len_ancestral))
}

figure_SX_dataframe = data.frame(
  mean_list_100_200,
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

figure_3A_dataframe_100_200 = melt(data.frame(
  growth_coal_proportion_100_200,
  bottleneck_coal_proportion_100_200,
  ancestral_coal_proportion_100_200
))

figure_3A_dataframe_100_200$msprime_time = msprime_time_100_200
figure_3A_dataframe_100_200$msprime_shape = msprime_nu_shape_100_200
figure_3A_dataframe_100_200$sample_size = sample_size

plot_3A_100_200 = ggplot(data=figure_3A_dataframe_100_200, aes(x=sample_size, y=value, color=variable, shape=msprime_shape)) +
  geom_point(size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Proportion') +
  ggtitle('Coalescent events per epoch, [Anc., 300 g.a., 100 g.a.]') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_coal_proportion_100_200',
                       'bottleneck_coal_proportion_100_200',
                       'ancestral_coal_proportion_100_200'),
                     values=c('growth_coal_proportion_100_200'='#1b9e77',
                       'bottleneck_coal_proportion_100_200'='#d95f02',
                       'ancestral_coal_proportion_100_200'='#7570b3'),
                     labels=c('Recent growth [100 g.a.]', 
                       'Bottleneck [300 g.a.]', 
                       'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion'))

figure_3B_dataframe_100_200 = melt(data.frame(
  growth_b_len_proportion_mean_100_200,
  bottleneck_b_len_proportion_mean_100_200,
  ancestral_b_len_proportion_mean_100_200
))
figure_3B_dataframe_100_200$sample_size = sample_size
figure_3B_dataframe_100_200$msprime_shape = msprime_nu_shape_100_200

plot_3B_simplified_100_200 = ggplot(data=figure_3B_dataframe_100_200, aes(x=sample_size, y=value, color=variable)) +
  geom_point(aes(shape=msprime_shape), size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Mean branch length') +
  ggtitle('Branch length per epoch') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_b_len_proportion_mean_100_200',
                       'bottleneck_b_len_proportion_mean_100_200',
                       'ancestral_b_len_proportion_mean_100_200'),
                     values=c('growth_b_len_proportion_mean_100_200'='#1b9e77',
                       'bottleneck_b_len_proportion_mean_100_200'='#d95f02',
                       'ancestral_b_len_proportion_mean_100_200'='#7570b3'),
                     labels=c('Recent growth', 'Bottleneck', 'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion')) +
  guides(shape='none', color='none')

plot_3A_100_200 + plot_3B_simplified_100_200 + plot_layout(nrow=2)

# 50_200

sample_size = seq(from=10, to=800, by=10)
mean_list_50_200 = c()
growth_coal_proportion_50_200 = c()
bottleneck_coal_proportion_50_200 = c()
ancestral_coal_proportion_50_200 = c()
msprime_time_50_200 = c()
msprime_nu_shape_50_200 = c()

growth_b_len_proportion_mean_50_200 = c()
bottleneck_b_len_proportion_mean_50_200 = c()
ancestral_b_len_proportion_mean_50_200 = c()

# Iterate through sample size and replicate
for (i in sample_size) {
  this_sample_size_distribution = c() # Initialize
  msprime_demography_50_200 = paste0(
    "../Analysis/msprime_3EpB_50_200_", i, '/two_epoch_demography.txt')
  msprime_nu_50_200 = nu_from_demography(msprime_demography_50_200)
  msprime_time_50_200 = c(msprime_time_50_200, time_from_demography(msprime_demography_50_200))
  if (is.na(msprime_nu_50_200)) {
    msprime_nu_shape_50_200 = c(msprime_nu_shape_50_200, NA)
  } else if (msprime_nu_50_200 > 1) {
    msprime_nu_shape_50_200 = c(msprime_nu_shape_50_200, 'msprime_expand')
  } else {
    msprime_nu_shape_50_200 = c(msprime_nu_shape_50_200, 'msprime_contract')
  }
  for (j in seq(from=1, to=20, by=1)) {
    this_replicate_distribution = paste0(
      "../Simulations/simple_simulations/ThreeEpochBottleneck_50_200_",
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
      "../Simulations/simple_simulations/ThreeEpochBottleneck_50_200_",
      i, '_branch_length_dist_',
      g, '.csv')
    if (file.exists(this_branch_distribution)) {
    } else {
      next
    }
    # Read in the appropriate file
    this_b_len_csv = read.csv(this_branch_distribution, header=TRUE)
    growth_sum = sum(this_b_len_csv[this_b_len_csv$node_generations <= 50, ]$branch_length)
    bottleneck_sum = sum(this_b_len_csv[this_b_len_csv$node_generations > 50 &
        this_b_len_csv$node_generations<= 250, ]$branch_length)
    ancestral_sum = sum(this_b_len_csv[this_b_len_csv$node_generations > 250, ]$branch_length)
    total_branch_length = growth_sum + bottleneck_sum + ancestral_sum
    this_b_len_growth = c(this_b_len_growth, growth_sum / total_branch_length)
    this_b_len_bottleneck = c(this_b_len_bottleneck, bottleneck_sum / total_branch_length)
    this_b_len_ancestral = c(this_b_len_ancestral, ancestral_sum / total_branch_length)
  }
  # Take the mean of coalescent times for this sample size's distribution
  mean_list_50_200 = c(mean_list_50_200, mean(this_sample_size_distribution))
  # Similarly, take standard deviation
  # Lastly find the proportion of coalescent events in each epoch
  growth_coal_proportion_50_200 = c(growth_coal_proportion_50_200,
    mean(this_sample_size_distribution <= 50))
  bottleneck_coal_proportion_50_200 = c(bottleneck_coal_proportion_50_200,
    mean(this_sample_size_distribution <= 250) - mean(this_sample_size_distribution < 50))
  ancestral_coal_proportion_50_200 = c(ancestral_coal_proportion_50_200,
    mean(this_sample_size_distribution > 250))

  # Mean and sd of branch length proportions by epoch
  growth_b_len_proportion_mean_50_200 = c(growth_b_len_proportion_mean_50_200, mean(this_b_len_growth))
  bottleneck_b_len_proportion_mean_50_200 = c(bottleneck_b_len_proportion_mean_50_200, mean(this_b_len_bottleneck))
  ancestral_b_len_proportion_mean_50_200 = c(ancestral_b_len_proportion_mean_50_200, mean(this_b_len_ancestral))
}

figure_SX_dataframe = data.frame(
  mean_list_50_200,
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

figure_3A_dataframe_50_200 = melt(data.frame(
  growth_coal_proportion_50_200,
  bottleneck_coal_proportion_50_200,
  ancestral_coal_proportion_50_200
))

figure_3A_dataframe_50_200$msprime_time = msprime_time_50_200
figure_3A_dataframe_50_200$msprime_shape = msprime_nu_shape_50_200
figure_3A_dataframe_50_200$sample_size = sample_size

plot_3A_50_200 = ggplot(data=figure_3A_dataframe_50_200, aes(x=sample_size, y=value, color=variable, shape=msprime_shape)) +
  geom_point(size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Proportion') +
  ggtitle('Coalescent events per epoch, [Anc., 250 g.a., 50 g.a.]') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_coal_proportion_50_200',
                       'bottleneck_coal_proportion_50_200',
                       'ancestral_coal_proportion_50_200'),
                     values=c('growth_coal_proportion_50_200'='#1b9e77',
                       'bottleneck_coal_proportion_50_200'='#d95f02',
                       'ancestral_coal_proportion_50_200'='#7570b3'),
                     labels=c('Recent growth [50 g.a.]',
                       'Bottleneck [250 g.a.]',
                       'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion'))

figure_3B_dataframe_50_200 = melt(data.frame(
  growth_b_len_proportion_mean_50_200,
  bottleneck_b_len_proportion_mean_50_200,
  ancestral_b_len_proportion_mean_50_200
))
figure_3B_dataframe_50_200$sample_size = sample_size
figure_3B_dataframe_50_200$msprime_shape = msprime_nu_shape_50_200

plot_3B_simplified_50_200 = ggplot(data=figure_3B_dataframe_50_200, aes(x=sample_size, y=value, color=variable)) +
  geom_point(aes(shape=msprime_shape), size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Mean branch length') +
  ggtitle('Branch length per epoch') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_b_len_proportion_mean_50_200',
                       'bottleneck_b_len_proportion_mean_50_200',
                       'ancestral_b_len_proportion_mean_50_200'),
                     values=c('growth_b_len_proportion_mean_50_200'='#1b9e77',
                       'bottleneck_b_len_proportion_mean_50_200'='#d95f02',
                       'ancestral_b_len_proportion_mean_50_200'='#7570b3'),
                     labels=c('Recent growth', 'Bottleneck', 'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion')) +
  guides(shape='none', color='none')

plot_3A_50_200 + plot_3B_simplified_50_200 + plot_layout(nrow=2)


# 150_200

sample_size = seq(from=10, to=800, by=10)
mean_list_150_200 = c()
growth_coal_proportion_150_200 = c()
bottleneck_coal_proportion_150_200 = c()
ancestral_coal_proportion_150_200 = c()
msprime_time_150_200 = c()
msprime_nu_shape_150_200 = c()

growth_b_len_proportion_mean_150_200 = c()
bottleneck_b_len_proportion_mean_150_200 = c()
ancestral_b_len_proportion_mean_150_200 = c()

# Iterate through sample size and replicate
for (i in sample_size) {
  this_sample_size_distribution = c() # Initialize
  msprime_demography_150_200 = paste0(
    "../Analysis/msprime_3EpB_150_200_", i, '/two_epoch_demography.txt')
  msprime_nu_150_200 = nu_from_demography(msprime_demography_150_200)
  msprime_time_150_200 = c(msprime_time_150_200, time_from_demography(msprime_demography_150_200))
  if (is.na(msprime_nu_150_200)) {
    msprime_nu_shape_150_200 = c(msprime_nu_shape_150_200, NA)
  } else if (msprime_nu_150_200 > 1) {
    msprime_nu_shape_150_200 = c(msprime_nu_shape_150_200, 'msprime_expand')
  } else {
    msprime_nu_shape_150_200 = c(msprime_nu_shape_150_200, 'msprime_contract')
  }
  for (j in seq(from=1, to=20, by=1)) {
    this_replicate_distribution = paste0(
      "../Simulations/simple_simulations/ThreeEpochBottleneck_150_200_",
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
      "../Simulations/simple_simulations/ThreeEpochBottleneck_150_200_",
      i, '_branch_length_dist_',
      g, '.csv')
    if (file.exists(this_branch_distribution)) {
    } else {
      next
    }
    # Read in the appropriate file
    this_b_len_csv = read.csv(this_branch_distribution, header=TRUE)
    growth_sum = sum(this_b_len_csv[this_b_len_csv$node_generations <= 150, ]$branch_length)
    bottleneck_sum = sum(this_b_len_csv[this_b_len_csv$node_generations > 150 &
        this_b_len_csv$node_generations<= 350, ]$branch_length)
    ancestral_sum = sum(this_b_len_csv[this_b_len_csv$node_generations > 350, ]$branch_length)
    total_branch_length = growth_sum + bottleneck_sum + ancestral_sum
    this_b_len_growth = c(this_b_len_growth, growth_sum / total_branch_length)
    this_b_len_bottleneck = c(this_b_len_bottleneck, bottleneck_sum / total_branch_length)
    this_b_len_ancestral = c(this_b_len_ancestral, ancestral_sum / total_branch_length)
  }
  # Take the mean of coalescent times for this sample size's distribution
  mean_list_150_200 = c(mean_list_150_200, mean(this_sample_size_distribution))
  # Similarly, take standard deviation
  # Lastly find the proportion of coalescent events in each epoch
  growth_coal_proportion_150_200 = c(growth_coal_proportion_150_200,
    mean(this_sample_size_distribution <= 150))
  bottleneck_coal_proportion_150_200 = c(bottleneck_coal_proportion_150_200,
    mean(this_sample_size_distribution <= 350) - mean(this_sample_size_distribution < 150))
  ancestral_coal_proportion_150_200 = c(ancestral_coal_proportion_150_200,
    mean(this_sample_size_distribution > 350))

  # Mean and sd of branch length proportions by epoch
  growth_b_len_proportion_mean_150_200 = c(growth_b_len_proportion_mean_150_200, mean(this_b_len_growth))
  bottleneck_b_len_proportion_mean_150_200 = c(bottleneck_b_len_proportion_mean_150_200, mean(this_b_len_bottleneck))
  ancestral_b_len_proportion_mean_150_200 = c(ancestral_b_len_proportion_mean_150_200, mean(this_b_len_ancestral))
}

figure_SX_dataframe = data.frame(
  mean_list_150_200,
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

figure_3A_dataframe_150_200 = melt(data.frame(
  growth_coal_proportion_150_200,
  bottleneck_coal_proportion_150_200,
  ancestral_coal_proportion_150_200
))

figure_3A_dataframe_150_200$msprime_time = msprime_time_150_200
figure_3A_dataframe_150_200$msprime_shape = msprime_nu_shape_150_200
figure_3A_dataframe_150_200$sample_size = sample_size

plot_3A_150_200 = ggplot(data=figure_3A_dataframe_150_200, aes(x=sample_size, y=value, color=variable, shape=msprime_shape)) +
  geom_point(size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Proportion') +
  ggtitle('Coalescent events per epoch, [Anc., 350 g.a., 200 g.a.]') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_coal_proportion_150_200',
                       'bottleneck_coal_proportion_150_200',
                       'ancestral_coal_proportion_150_200'),
                     values=c('growth_coal_proportion_150_200'='#1b9e77',
                       'bottleneck_coal_proportion_150_200'='#d95f02',
                       'ancestral_coal_proportion_150_200'='#7570b3'),
                     labels=c('Recent growth [200 g.a.]', 
                       'Bottleneck [350 g.a.]', 
                       'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion'))

figure_3B_dataframe_150_200 = melt(data.frame(
  growth_b_len_proportion_mean_150_200,
  bottleneck_b_len_proportion_mean_150_200,
  ancestral_b_len_proportion_mean_150_200
))
figure_3B_dataframe_150_200$sample_size = sample_size
figure_3B_dataframe_150_200$msprime_shape = msprime_nu_shape_150_200

plot_3B_simplified_150_200 = ggplot(data=figure_3B_dataframe_150_200, aes(x=sample_size, y=value, color=variable)) +
  geom_point(aes(shape=msprime_shape), size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Mean branch length') +
  ggtitle('Branch length per epoch') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_b_len_proportion_mean_150_200',
                       'bottleneck_b_len_proportion_mean_150_200',
                       'ancestral_b_len_proportion_mean_150_200'),
                     values=c('growth_b_len_proportion_mean_150_200'='#1b9e77',
                       'bottleneck_b_len_proportion_mean_150_200'='#d95f02',
                       'ancestral_b_len_proportion_mean_150_200'='#7570b3'),
                     labels=c('Recent growth', 'Bottleneck', 'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion')) +
  guides(shape='none', color='none')

plot_3A_150_200 + plot_3B_simplified_150_200 + plot_layout(nrow=2)

# 200_200

sample_size = seq(from=10, to=800, by=10)
mean_list_200_200 = c()
growth_coal_proportion_200_200 = c()
bottleneck_coal_proportion_200_200 = c()
ancestral_coal_proportion_200_200 = c()
msprime_time_200_200 = c()
msprime_nu_shape_200_200 = c()

growth_b_len_proportion_mean_200_200 = c()
bottleneck_b_len_proportion_mean_200_200 = c()
ancestral_b_len_proportion_mean_200_200 = c()

# Iterate through sample size and replicate
for (i in sample_size) {
  this_sample_size_distribution = c() # Initialize
  msprime_demography_200_200 = paste0(
    "../Analysis/msprime_3EpB_200_200_", i, '/two_epoch_demography.txt')
  msprime_nu_200_200 = nu_from_demography(msprime_demography_200_200)
  msprime_time_200_200 = c(msprime_time_200_200, time_from_demography(msprime_demography_200_200))
  if (is.na(msprime_nu_200_200)) {
    msprime_nu_shape_200_200 = c(msprime_nu_shape_200_200, NA)
  } else if (msprime_nu_200_200 > 1) {
    msprime_nu_shape_200_200 = c(msprime_nu_shape_200_200, 'msprime_expand')
  } else {
    msprime_nu_shape_200_200 = c(msprime_nu_shape_200_200, 'msprime_contract')
  }
  for (j in seq(from=1, to=20, by=1)) {
    this_replicate_distribution = paste0(
      "../Simulations/simple_simulations/ThreeEpochBottleneck_200_200_",
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
      "../Simulations/simple_simulations/ThreeEpochBottleneck_200_200_",
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
        this_b_len_csv$node_generations<= 400, ]$branch_length)
    ancestral_sum = sum(this_b_len_csv[this_b_len_csv$node_generations > 400, ]$branch_length)
    total_branch_length = growth_sum + bottleneck_sum + ancestral_sum
    this_b_len_growth = c(this_b_len_growth, growth_sum / total_branch_length)
    this_b_len_bottleneck = c(this_b_len_bottleneck, bottleneck_sum / total_branch_length)
    this_b_len_ancestral = c(this_b_len_ancestral, ancestral_sum / total_branch_length)
  }
  # Take the mean of coalescent times for this sample size's distribution
  mean_list_200_200 = c(mean_list_200_200, mean(this_sample_size_distribution))
  # Similarly, take standard deviation
  # Lastly find the proportion of coalescent events in each epoch
  growth_coal_proportion_200_200 = c(growth_coal_proportion_200_200,
    mean(this_sample_size_distribution <= 200))
  bottleneck_coal_proportion_200_200 = c(bottleneck_coal_proportion_200_200,
    mean(this_sample_size_distribution <= 400) - mean(this_sample_size_distribution < 200))
  ancestral_coal_proportion_200_200 = c(ancestral_coal_proportion_200_200,
    mean(this_sample_size_distribution > 400))

  # Mean and sd of branch length proportions by epoch
  growth_b_len_proportion_mean_200_200 = c(growth_b_len_proportion_mean_200_200, mean(this_b_len_growth))
  bottleneck_b_len_proportion_mean_200_200 = c(bottleneck_b_len_proportion_mean_200_200, mean(this_b_len_bottleneck))
  ancestral_b_len_proportion_mean_200_200 = c(ancestral_b_len_proportion_mean_200_200, mean(this_b_len_ancestral))
}

figure_SX_dataframe = data.frame(
  mean_list_200_200,
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

figure_3A_dataframe_200_200 = melt(data.frame(
  growth_coal_proportion_200_200,
  bottleneck_coal_proportion_200_200,
  ancestral_coal_proportion_200_200
))

figure_3A_dataframe_200_200$msprime_time = msprime_time_200_200
figure_3A_dataframe_200_200$msprime_shape = msprime_nu_shape_200_200
figure_3A_dataframe_200_200$sample_size = sample_size

plot_3A_200_200 = ggplot(data=figure_3A_dataframe_200_200, aes(x=sample_size, y=value, color=variable, shape=msprime_shape)) +
  geom_point(size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Proportion') +
  ggtitle('Coalescent events per epoch, [Anc., 400 g.a., 200 g.a.]') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_coal_proportion_200_200',
                       'bottleneck_coal_proportion_200_200',
                       'ancestral_coal_proportion_200_200'),
                     values=c('growth_coal_proportion_200_200'='#1b9e77',
                       'bottleneck_coal_proportion_200_200'='#d95f02',
                       'ancestral_coal_proportion_200_200'='#7570b3'),
                     labels=c('Recent growth [200 g.a.]', 
                       'Bottleneck [400 g.a.]', 
                       'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion'))

figure_3B_dataframe_200_200 = melt(data.frame(
  growth_b_len_proportion_mean_200_200,
  bottleneck_b_len_proportion_mean_200_200,
  ancestral_b_len_proportion_mean_200_200
))
figure_3B_dataframe_200_200$sample_size = sample_size
figure_3B_dataframe_200_200$msprime_shape = msprime_nu_shape_200_200

plot_3B_simplified_200_200 = ggplot(data=figure_3B_dataframe_200_200, aes(x=sample_size, y=value, color=variable)) +
  geom_point(aes(shape=msprime_shape), size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Mean branch length') +
  ggtitle('Branch length per epoch') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_b_len_proportion_mean_200_200',
                       'bottleneck_b_len_proportion_mean_200_200',
                       'ancestral_b_len_proportion_mean_200_200'),
                     values=c('growth_b_len_proportion_mean_200_200'='#1b9e77',
                       'bottleneck_b_len_proportion_mean_200_200'='#d95f02',
                       'ancestral_b_len_proportion_mean_200_200'='#7570b3'),
                     labels=c('Recent growth', 'Bottleneck', 'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion')) +
  guides(shape='none', color='none')

plot_3A_200_200 + plot_3B_simplified_200_200 + plot_layout(nrow=2)


# 600_200

sample_size = seq(from=10, to=800, by=10)
mean_list_600_200 = c()
growth_coal_proportion_600_200 = c()
bottleneck_coal_proportion_600_200 = c()
ancestral_coal_proportion_600_200 = c()
msprime_time_600_200 = c()
msprime_nu_shape_600_200 = c()

growth_b_len_proportion_mean_600_200 = c()
bottleneck_b_len_proportion_mean_600_200 = c()
ancestral_b_len_proportion_mean_600_200 = c()

# Iterate through sample size and replicate
for (i in sample_size) {
  this_sample_size_distribution = c() # Initialize
  msprime_demography_600_200 = paste0(
    "../Analysis/msprime_3EpB_600_200_", i, '/two_epoch_demography.txt')
  msprime_nu_600_200 = nu_from_demography(msprime_demography_600_200)
  msprime_time_600_200 = c(msprime_time_600_200, time_from_demography(msprime_demography_600_200))
  if (is.na(msprime_nu_600_200)) {
    msprime_nu_shape_600_200 = c(msprime_nu_shape_600_200, NA)
  } else if (msprime_nu_600_200 > 1) {
    msprime_nu_shape_600_200 = c(msprime_nu_shape_600_200, 'msprime_expand')
  } else {
    msprime_nu_shape_600_200 = c(msprime_nu_shape_600_200, 'msprime_contract')
  }
  for (j in seq(from=1, to=20, by=1)) {
    this_replicate_distribution = paste0(
      "../Simulations/simple_simulations/ThreeEpochBottleneck_600_200_",
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
      "../Simulations/simple_simulations/ThreeEpochBottleneck_600_200_",
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
        this_b_len_csv$node_generations<= 800, ]$branch_length)
    ancestral_sum = sum(this_b_len_csv[this_b_len_csv$node_generations > 800, ]$branch_length)
    total_branch_length = growth_sum + bottleneck_sum + ancestral_sum
    this_b_len_growth = c(this_b_len_growth, growth_sum / total_branch_length)
    this_b_len_bottleneck = c(this_b_len_bottleneck, bottleneck_sum / total_branch_length)
    this_b_len_ancestral = c(this_b_len_ancestral, ancestral_sum / total_branch_length)
  }
  # Take the mean of coalescent times for this sample size's distribution
  mean_list_600_200 = c(mean_list_600_200, mean(this_sample_size_distribution))
  # Similarly, take standard deviation
  # Lastly find the proportion of coalescent events in each epoch
  growth_coal_proportion_600_200 = c(growth_coal_proportion_600_200,
    mean(this_sample_size_distribution <= 200))
  bottleneck_coal_proportion_600_200 = c(bottleneck_coal_proportion_600_200,
    mean(this_sample_size_distribution <= 800) - mean(this_sample_size_distribution < 200))
  ancestral_coal_proportion_600_200 = c(ancestral_coal_proportion_600_200,
    mean(this_sample_size_distribution > 800))

  # Mean and sd of branch length proportions by epoch
  growth_b_len_proportion_mean_600_200 = c(growth_b_len_proportion_mean_600_200, mean(this_b_len_growth))
  bottleneck_b_len_proportion_mean_600_200 = c(bottleneck_b_len_proportion_mean_600_200, mean(this_b_len_bottleneck))
  ancestral_b_len_proportion_mean_600_200 = c(ancestral_b_len_proportion_mean_600_200, mean(this_b_len_ancestral))
}

figure_SX_dataframe = data.frame(
  mean_list_600_200,
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

figure_3A_dataframe_600_200 = melt(data.frame(
  growth_coal_proportion_600_200,
  bottleneck_coal_proportion_600_200,
  ancestral_coal_proportion_600_200
))

figure_3A_dataframe_600_200$msprime_time = msprime_time_600_200
figure_3A_dataframe_600_200$msprime_shape = msprime_nu_shape_600_200
figure_3A_dataframe_600_200$sample_size = sample_size

plot_3A_600_200 = ggplot(data=figure_3A_dataframe_600_200, aes(x=sample_size, y=value, color=variable, shape=msprime_shape)) +
  geom_point(size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Proportion') +
  ggtitle('Coalescent events per epoch, [Anc., 800 g.a., 200 g.a.]') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_coal_proportion_600_200',
                       'bottleneck_coal_proportion_600_200',
                       'ancestral_coal_proportion_600_200'),
                     values=c('growth_coal_proportion_600_200'='#1b9e77',
                       'bottleneck_coal_proportion_600_200'='#d95f02',
                       'ancestral_coal_proportion_600_200'='#7570b3'),
                     labels=c('Recent growth [200 g.a.]', 
                       'Bottleneck [800 g.a.]', 
                       'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion'))

figure_3B_dataframe_600_200 = melt(data.frame(
  growth_b_len_proportion_mean_600_200,
  bottleneck_b_len_proportion_mean_600_200,
  ancestral_b_len_proportion_mean_600_200
))
figure_3B_dataframe_600_200$sample_size = sample_size
figure_3B_dataframe_600_200$msprime_shape = msprime_nu_shape_600_200

plot_3B_simplified_600_200 = ggplot(data=figure_3B_dataframe_600_200, aes(x=sample_size, y=value, color=variable)) +
  geom_point(aes(shape=msprime_shape), size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Mean branch length') +
  ggtitle('Branch length per epoch') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_b_len_proportion_mean_600_200',
                       'bottleneck_b_len_proportion_mean_600_200',
                       'ancestral_b_len_proportion_mean_600_200'),
                     values=c('growth_b_len_proportion_mean_600_200'='#1b9e77',
                       'bottleneck_b_len_proportion_mean_600_200'='#d95f02',
                       'ancestral_b_len_proportion_mean_600_200'='#7570b3'),
                     labels=c('Recent growth', 'Bottleneck', 'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion')) +
  guides(shape='none', color='none')

plot_3A_600_200 + plot_3B_simplified_600_200 + plot_layout(nrow=2)


# 1000_200

sample_size = seq(from=10, to=800, by=10)
mean_list_1000_200 = c()
growth_coal_proportion_1000_200 = c()
bottleneck_coal_proportion_1000_200 = c()
ancestral_coal_proportion_1000_200 = c()
msprime_time_1000_200 = c()
msprime_nu_shape_1000_200 = c()

growth_b_len_proportion_mean_1000_200 = c()
bottleneck_b_len_proportion_mean_1000_200 = c()
ancestral_b_len_proportion_mean_1000_200 = c()

# Iterate through sample size and replicate
for (i in sample_size) {
  this_sample_size_distribution = c() # Initialize
  msprime_demography_1000_200 = paste0(
    "../Analysis/msprime_3EpB_1000_200_", i, '/two_epoch_demography.txt')
  msprime_nu_1000_200 = nu_from_demography(msprime_demography_1000_200)
  msprime_time_1000_200 = c(msprime_time_1000_200, time_from_demography(msprime_demography_1000_200))
  if (is.na(msprime_nu_1000_200)) {
    msprime_nu_shape_1000_200 = c(msprime_nu_shape_1000_200, NA)
  } else if (msprime_nu_1000_200 > 1) {
    msprime_nu_shape_1000_200 = c(msprime_nu_shape_1000_200, 'msprime_expand')
  } else {
    msprime_nu_shape_1000_200 = c(msprime_nu_shape_1000_200, 'msprime_contract')
  }
  for (j in seq(from=1, to=20, by=1)) {
    this_replicate_distribution = paste0(
      "../Simulations/simple_simulations/ThreeEpochBottleneck_1000_200_",
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
      "../Simulations/simple_simulations/ThreeEpochBottleneck_1000_200_",
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
        this_b_len_csv$node_generations<= 1200, ]$branch_length)
    ancestral_sum = sum(this_b_len_csv[this_b_len_csv$node_generations > 1200, ]$branch_length)
    total_branch_length = growth_sum + bottleneck_sum + ancestral_sum
    this_b_len_growth = c(this_b_len_growth, growth_sum / total_branch_length)
    this_b_len_bottleneck = c(this_b_len_bottleneck, bottleneck_sum / total_branch_length)
    this_b_len_ancestral = c(this_b_len_ancestral, ancestral_sum / total_branch_length)
  }
  # Take the mean of coalescent times for this sample size's distribution
  mean_list_1000_200 = c(mean_list_1000_200, mean(this_sample_size_distribution))
  # Similarly, take standard deviation
  # Lastly find the proportion of coalescent events in each epoch
  growth_coal_proportion_1000_200 = c(growth_coal_proportion_1000_200,
    mean(this_sample_size_distribution <= 200))
  bottleneck_coal_proportion_1000_200 = c(bottleneck_coal_proportion_1000_200,
    mean(this_sample_size_distribution <= 1200) - mean(this_sample_size_distribution < 200))
  ancestral_coal_proportion_1000_200 = c(ancestral_coal_proportion_1000_200,
    mean(this_sample_size_distribution > 1200))

  # Mean and sd of branch length proportions by epoch
  growth_b_len_proportion_mean_1000_200 = c(growth_b_len_proportion_mean_1000_200, mean(this_b_len_growth))
  bottleneck_b_len_proportion_mean_1000_200 = c(bottleneck_b_len_proportion_mean_1000_200, mean(this_b_len_bottleneck))
  ancestral_b_len_proportion_mean_1000_200 = c(ancestral_b_len_proportion_mean_1000_200, mean(this_b_len_ancestral))
}

figure_SX_dataframe = data.frame(
  mean_list_1000_200,
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

figure_3A_dataframe_1000_200 = melt(data.frame(
  growth_coal_proportion_1000_200,
  bottleneck_coal_proportion_1000_200,
  ancestral_coal_proportion_1000_200
))

figure_3A_dataframe_1000_200$msprime_time = msprime_time_1000_200
figure_3A_dataframe_1000_200$msprime_shape = msprime_nu_shape_1000_200
figure_3A_dataframe_1000_200$sample_size = sample_size

plot_3A_1000_200 = ggplot(data=figure_3A_dataframe_1000_200, aes(x=sample_size, y=value, color=variable, shape=msprime_shape)) +
  geom_point(size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Proportion') +
  ggtitle('Coalescent events per epoch, [Anc., 1200 g.a., 200 g.a.]') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_coal_proportion_1000_200',
                       'bottleneck_coal_proportion_1000_200',
                       'ancestral_coal_proportion_1000_200'),
                     values=c('growth_coal_proportion_1000_200'='#1b9e77',
                       'bottleneck_coal_proportion_1000_200'='#d95f02',
                       'ancestral_coal_proportion_1000_200'='#7570b3'),
                     labels=c('Recent growth [200 g.a.]', 
                       'Bottleneck [1200 g.a.]', 
                       'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion'))

figure_3B_dataframe_1000_200 = melt(data.frame(
  growth_b_len_proportion_mean_1000_200,
  bottleneck_b_len_proportion_mean_1000_200,
  ancestral_b_len_proportion_mean_1000_200
))
figure_3B_dataframe_1000_200$sample_size = sample_size
figure_3B_dataframe_1000_200$msprime_shape = msprime_nu_shape_1000_200

plot_3B_simplified_1000_200 = ggplot(data=figure_3B_dataframe_1000_200, aes(x=sample_size, y=value, color=variable)) +
  geom_point(aes(shape=msprime_shape), size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Mean branch length') +
  ggtitle('Branch length per epoch') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_b_len_proportion_mean_1000_200',
                       'bottleneck_b_len_proportion_mean_1000_200',
                       'ancestral_b_len_proportion_mean_1000_200'),
                     values=c('growth_b_len_proportion_mean_1000_200'='#1b9e77',
                       'bottleneck_b_len_proportion_mean_1000_200'='#d95f02',
                       'ancestral_b_len_proportion_mean_1000_200'='#7570b3'),
                     labels=c('Recent growth', 'Bottleneck', 'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion')) +
  guides(shape='none', color='none')

plot_3A_1000_200 + plot_3B_simplified_1000_200 + plot_layout(nrow=2)



# 1400_200

sample_size = seq(from=10, to=800, by=10)
mean_list_1400_200 = c()
growth_coal_proportion_1400_200 = c()
bottleneck_coal_proportion_1400_200 = c()
ancestral_coal_proportion_1400_200 = c()
msprime_time_1400_200 = c()
msprime_nu_shape_1400_200 = c()

growth_b_len_proportion_mean_1400_200 = c()
bottleneck_b_len_proportion_mean_1400_200 = c()
ancestral_b_len_proportion_mean_1400_200 = c()

# Iterate through sample size and replicate
for (i in sample_size) {
  this_sample_size_distribution = c() # Initialize
  msprime_demography_1400_200 = paste0(
    "../Analysis/msprime_3EpB_1400_200_", i, '/two_epoch_demography.txt')
  msprime_nu_1400_200 = nu_from_demography(msprime_demography_1400_200)
  msprime_time_1400_200 = c(msprime_time_1400_200, time_from_demography(msprime_demography_1400_200))
  if (is.na(msprime_nu_1400_200)) {
    msprime_nu_shape_1400_200 = c(msprime_nu_shape_1400_200, NA)
  } else if (msprime_nu_1400_200 > 1) {
    msprime_nu_shape_1400_200 = c(msprime_nu_shape_1400_200, 'msprime_expand')
  } else {
    msprime_nu_shape_1400_200 = c(msprime_nu_shape_1400_200, 'msprime_contract')
  }
  for (j in seq(from=1, to=20, by=1)) {
    this_replicate_distribution = paste0(
      "../Simulations/simple_simulations/ThreeEpochBottleneck_1400_200_",
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
      "../Simulations/simple_simulations/ThreeEpochBottleneck_1400_200_",
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
        this_b_len_csv$node_generations<= 1600, ]$branch_length)
    ancestral_sum = sum(this_b_len_csv[this_b_len_csv$node_generations > 1600, ]$branch_length)
    total_branch_length = growth_sum + bottleneck_sum + ancestral_sum
    this_b_len_growth = c(this_b_len_growth, growth_sum / total_branch_length)
    this_b_len_bottleneck = c(this_b_len_bottleneck, bottleneck_sum / total_branch_length)
    this_b_len_ancestral = c(this_b_len_ancestral, ancestral_sum / total_branch_length)
  }
  # Take the mean of coalescent times for this sample size's distribution
  mean_list_1400_200 = c(mean_list_1400_200, mean(this_sample_size_distribution))
  # Similarly, take standard deviation
  # Lastly find the proportion of coalescent events in each epoch
  growth_coal_proportion_1400_200 = c(growth_coal_proportion_1400_200,
    mean(this_sample_size_distribution <= 200))
  bottleneck_coal_proportion_1400_200 = c(bottleneck_coal_proportion_1400_200,
    mean(this_sample_size_distribution <= 1600) - mean(this_sample_size_distribution < 200))
  ancestral_coal_proportion_1400_200 = c(ancestral_coal_proportion_1400_200,
    mean(this_sample_size_distribution > 1600))

  # Mean and sd of branch length proportions by epoch
  growth_b_len_proportion_mean_1400_200 = c(growth_b_len_proportion_mean_1400_200, mean(this_b_len_growth))
  bottleneck_b_len_proportion_mean_1400_200 = c(bottleneck_b_len_proportion_mean_1400_200, mean(this_b_len_bottleneck))
  ancestral_b_len_proportion_mean_1400_200 = c(ancestral_b_len_proportion_mean_1400_200, mean(this_b_len_ancestral))
}

figure_SX_dataframe = data.frame(
  mean_list_1400_200,
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

figure_3A_dataframe_1400_200 = melt(data.frame(
  growth_coal_proportion_1400_200,
  bottleneck_coal_proportion_1400_200,
  ancestral_coal_proportion_1400_200
))

figure_3A_dataframe_1400_200$msprime_time = msprime_time_1400_200
figure_3A_dataframe_1400_200$msprime_shape = msprime_nu_shape_1400_200
figure_3A_dataframe_1400_200$sample_size = sample_size

plot_3A_1400_200 = ggplot(data=figure_3A_dataframe_1400_200, aes(x=sample_size, y=value, color=variable, shape=msprime_shape)) +
  geom_point(size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Proportion') +
  ggtitle('Coalescent events per epoch, [Anc., 1600 g.a., 200 g.a.]') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_coal_proportion_1400_200',
                       'bottleneck_coal_proportion_1400_200',
                       'ancestral_coal_proportion_1400_200'),
                     values=c('growth_coal_proportion_1400_200'='#1b9e77',
                       'bottleneck_coal_proportion_1400_200'='#d95f02',
                       'ancestral_coal_proportion_1400_200'='#7570b3'),
                     labels=c('Recent growth [200 g.a.]', 
                       'Bottleneck [1600 g.a.]', 
                       'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion'))

figure_3B_dataframe_1400_200 = melt(data.frame(
  growth_b_len_proportion_mean_1400_200,
  bottleneck_b_len_proportion_mean_1400_200,
  ancestral_b_len_proportion_mean_1400_200
))
figure_3B_dataframe_1400_200$sample_size = sample_size
figure_3B_dataframe_1400_200$msprime_shape = msprime_nu_shape_1400_200

plot_3B_simplified_1400_200 = ggplot(data=figure_3B_dataframe_1400_200, aes(x=sample_size, y=value, color=variable)) +
  geom_point(aes(shape=msprime_shape), size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Mean branch length') +
  ggtitle('Branch length per epoch') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_b_len_proportion_mean_1400_200',
                       'bottleneck_b_len_proportion_mean_1400_200',
                       'ancestral_b_len_proportion_mean_1400_200'),
                     values=c('growth_b_len_proportion_mean_1400_200'='#1b9e77',
                       'bottleneck_b_len_proportion_mean_1400_200'='#d95f02',
                       'ancestral_b_len_proportion_mean_1400_200'='#7570b3'),
                     labels=c('Recent growth', 'Bottleneck', 'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion')) +
  guides(shape='none', color='none')

plot_3A_1400_200 + plot_3B_simplified_1400_200 + plot_layout(nrow=2)