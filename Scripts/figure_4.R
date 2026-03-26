# figure_4.R

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

sample_size = seq(from=10, to=800, by=10)
mean_list = c()
growth_coal_proportion = c()
bottleneck_coal_proportion = c()
ancestral_coal_proportion = c()
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
  # Lastly find the proportion of coalescent events in each epoch
  growth_coal_proportion = c(growth_coal_proportion, 
    mean(this_sample_size_distribution <= 200))
  bottleneck_coal_proportion = c(bottleneck_coal_proportion, 
    mean(this_sample_size_distribution <= 2000) - mean(this_sample_size_distribution < 200))
  ancestral_coal_proportion = c(ancestral_coal_proportion, 
    mean(this_sample_size_distribution > 2000))
}

# figure_3A_dataframe$sample_size = sample_size

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
  # xlab('Sample size') +
  ylab('Proportion of coalescent events') +
  # ggtitle('Coalescent events per epoch, [Anc., 2000 g.a., 200 g.a.]') +
  ggtitle('Coalescent events per epoch') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_coal_proportion',
                       'bottleneck_coal_proportion',
                       'ancestral_coal_proportion'),
                     values=c('growth_coal_proportion'='#1b9e77',
                       'bottleneck_coal_proportion'='#d95f02',
                       'ancestral_coal_proportion'='#7570b3'),
                     labels=c('Current [200 g.a.]', 
                       'Bottleneck [2000 g.a.]', 
                       'Ancestral [>2000 g.a.]')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion'))

sample_size = seq(10, 800, by=10)

# Mean of proportions
mean_prop_growth = c()
mean_prop_bottleneck = c()
mean_prop_ancestral = c()

# Ratio of sums
prop_sum_growth = c()
prop_sum_bottleneck = c()
prop_sum_ancestral = c()

for (i in sample_size) {

  # Proportions for each replicate
  prop_growth = numeric(20)
  prop_bottleneck = numeric(20)
  prop_ancestral = numeric(20)

  # Sum across replicates
  sum_growth = numeric(20)
  sum_bottleneck = numeric(20)
  sum_ancestral = numeric(20)
  sum_total = numeric(20)

  for (g in seq_len(20)) {
    this_branch_distribution = paste0(
      "../Simulations/simple_simulations/ThreeEpochBottleneck_",
      i, '_branch_length_dist_',
      g, '.csv')

    this_b_len_csv = read.csv(this_branch_distribution, header = TRUE)

    start <- this_b_len_csv$node_generations
    end   <- start + this_b_len_csv$branch_length

    # Overlap

    growth_overlap <- pmax(0, pmin(end, 200) - start)
    bottleneck_overlap <- pmax(0, pmin(end, 2000) - pmax(start, 200))
    ancestral_overlap <- pmax(0, end - pmax(start, 2000))

    # Raw sums
    sum_growth[g]      <- sum(growth_overlap)
    sum_bottleneck[g]  <- sum(bottleneck_overlap)
    sum_ancestral[g]   <- sum(ancestral_overlap)
    sum_total[g]       <- sum(this_b_len_csv$branch_length)

    # Per-replicate proportions
    prop_growth[g]     <- sum_growth[g]     / sum_total[g]
    prop_bottleneck[g] <- sum_bottleneck[g] / sum_total[g]
    prop_ancestral[g]  <- sum_ancestral[g]  / sum_total[g]
  }

  # Mean of proportions, calculation
  mean_prop_growth      <- c(mean_prop_growth, mean(prop_growth))
  mean_prop_bottleneck  <- c(mean_prop_bottleneck, mean(prop_bottleneck))
  mean_prop_ancestral   <- c(mean_prop_ancestral, mean(prop_ancestral))

  # Ratio of sums, calculation
  prop_sum_growth      <- c(prop_sum_growth, sum(sum_growth)     / sum(sum_total))
  prop_sum_bottleneck  <- c(prop_sum_bottleneck, sum(sum_bottleneck) / sum(sum_total))
  prop_sum_ancestral   <- c(prop_sum_ancestral, sum(sum_ancestral)  / sum(sum_total))
}

branch_proportion_df = data.frame(
  prop_sum_ancestral,
  prop_sum_bottleneck,
  prop_sum_growth
)

names(branch_proportion_df) = c('Proportion of sums, Anc.', 
  'Proportion of sums, Bot.',
  'Proportion of sums, Cur.')
branch_proportion_df = melt(branch_proportion_df)
branch_proportion_df$sample_size = sample_size
branch_proportion_df$shape = msprime_nu_shape

branch_proportion_df$epoch =
  ifelse(grepl("Anc", branch_proportion_df$variable), "Ancestral",
  ifelse(grepl("Bot", branch_proportion_df$variable), "Bottleneck", "Current"))

## Temp figure for cartoon
figure_4A = ggplot(branch_proportion_df,
                     aes(x = sample_size,
                         y = value,
                         color = epoch,
                       shape=shape)) +
  geom_smooth(method = "lm", aes(shape = NA), se = FALSE) +
  theme_bw() +
  scale_color_manual(name='Epoch',
    values = c(
    "Ancestral" = '#7570b3',
    "Bottleneck" = '#d95f02',
    "Current" = '#1b9e77'
  )) +
    scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion')) +
  xlab('') +
  theme(axis.ticks.x = element_blank()) +
  ylab('Proportion of branch length') +
  ggtitle('Distribution of branch lengths acoss epochs') +
  geom_vline(xintercept=50, linetype='dashed', color='blue', size=1.5)

figure_4B = ggplot(branch_proportion_df,
                     aes(x = sample_size,
                         y = value,
                         color = epoch,
                       shape=shape)) +
  geom_smooth(method = "lm", aes(shape = NA), se = FALSE) +
  theme_bw() +
  scale_color_manual(name='Epoch',
    values = c(
    "Ancestral" = '#7570b3',
    "Bottleneck" = '#d95f02',
    "Current" = '#1b9e77'
  )) +
    scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion')) +
  guides(color = "none") +
  xlab('Sample size') +
  ylab('Proportion of branch length') +
  ggtitle('Distribution of branch lengths acoss epochs') +
  geom_vline(xintercept=600, linetype='dashed', color='green', size=1.5)

# 500 x 500
figure_4 = figure_4A + figure_4B + plot_layout(nrow=2)

ggsave('../Summary/figure_4_output.svg', figure_4, width=5, height=5, units='in', dpi=100)

