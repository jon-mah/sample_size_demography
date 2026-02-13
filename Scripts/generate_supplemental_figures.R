# Supplemental figures

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

## Figure S1


sample_size = seq(from=10, to=800, by=10)

dadi_nu = c()
dadi_time = c()
dadi_tau = c()
dadi_tajima_D = c()
dadi_lambda_32 = c()
dadi_lambda_21 = c()
dadi_one_LL = c()
dadi_two_LL = c()
dadi_three_LL = c()

dadi_nu_min = c()
dadi_nu_max = c()
dadi_tau_min = c()
dadi_tau_max = c()

dadi_nu_b = c()
dadi_nu_f = c()

for (i in sample_size) {
  dadi_sfs = paste0(
    "../Simulations/dadi_simulations/ThreeEpochBottleneck_", i, '.sfs')
  dadi_demography = paste0(
    "../Analysis/dadi_3EpB_", i, '/two_epoch_demography.txt')
  dadi_demography_1 = paste0(
    "../Analysis/dadi_3EpB_", i, '/one_epoch_demography.txt')
  dadi_demography_3 = paste0(
    "../Analysis/dadi_3EpB_", i, '/three_epoch_demography.txt')
  dadi_likelihood = paste0(
    "../Analysis/dadi_3EpB_", i, '/likelihood_surface.csv')
  # dadi_nu = c(dadi_nu, nu_from_demography(dadi_demography))
  dadi_time = c(dadi_time, time_from_demography(dadi_demography))
  dadi_summary = paste0(
    "../Simulations/dadi_simulations/ThreeEpochBottleneck_", i, '_summary.txt')
  
  dadi_tajima_D = c(dadi_tajima_D, read_summary_statistics(dadi_summary)[3])
  this_dadi_one_LL = LL_from_demography(dadi_demography_1)
  this_dadi_two_LL = LL_from_demography(dadi_demography)
  this_dadi_three_LL = LL_from_demography(dadi_demography_3)
  dadi_one_LL = c(dadi_one_LL, this_dadi_one_LL)
  dadi_two_LL = c(dadi_two_LL, this_dadi_two_LL)
  dadi_three_LL = c(dadi_three_LL, this_dadi_three_LL)
  dadi_LL_diff_32 = this_dadi_three_LL - this_dadi_two_LL
  dadi_lambda_32 = c(dadi_lambda_32, 2 * dadi_LL_diff_32)
  dadi_LL_diff_21 = this_dadi_two_LL - this_dadi_one_LL
  dadi_lambda_21 = c(dadi_lambda_21, 2 * dadi_LL_diff_21)
  
  dadi_nu = c(dadi_nu, find_CI_bounds(dadi_likelihood)$nu_MLE)
  dadi_nu_min = c(dadi_nu_min, find_CI_bounds(dadi_likelihood)$nu_min)
  dadi_nu_max = c(dadi_nu_max, find_CI_bounds(dadi_likelihood)$nu_max)
  dadi_tau = c(dadi_tau, find_CI_bounds(dadi_likelihood)$tau_MLE)
  dadi_tau_min = c(dadi_tau_min, find_CI_bounds(dadi_likelihood)$tau_min)  
  dadi_tau_max = c(dadi_tau_max, find_CI_bounds(dadi_likelihood)$tau_max)
  dadi_nu_b = c(dadi_nu_b, nuB_from_demography(dadi_demography_3))
  dadi_nu_f = c(dadi_nu_f, nuF_from_demography(dadi_demography_3))
}

nu_label_text = expression(nu == frac(N[current], N[ancestral]))
tau_label_text = expression(tau == frac(generations, 2 * N[ancestral]))
twoLambda_text = expression(2*Lambda)
nu_dataframe = melt(data.frame(
  dadi_nu
))
nu_dataframe$sample_size = sample_size
nu_dataframe$dadi_min = dadi_nu_min
nu_dataframe$dadi_max = dadi_nu_max

# Min nu for contractions
min(nu_dataframe[1:9, ]$value)
# Max nu for expansions
max(nu_dataframe[1:9, ]$value)


nu_dataframe_CI_bounds = melt(data.frame(
  dadi_nu_min,
  dadi_nu_max
))
nu_dataframe_CI_bounds$sample_size = sample_size

tau_dataframe = melt(data.frame(
  dadi_tau
))
tau_dataframe$sample_size = sample_size
tau_dataframe$dadi_min = dadi_tau_min
tau_dataframe$dadi_max = dadi_tau_max

tajima_D_dataframe = melt(data.frame(
  dadi_tajima_D
))
tajima_D_dataframe$sample_size = sample_size

lambda_dataframe = melt(data.frame(
  dadi_lambda_32,
  dadi_lambda_21
))
lambda_dataframe$sample_size = sample_size

dadi_nuF_nuB = dadi_nu_f / dadi_nu_b

epoch_ratio_dataframe = melt(data.frame(
  dadi_nu_b,
  dadi_nuF_nuB
))
epoch_ratio_dataframe$sample_size = sample_size

plot_A = ggplot(data=nu_dataframe, aes(x=sample_size, y=value, color=variable)) + geom_line(size=2) +
  theme_bw() + guides(color=guide_legend(title="Type of SFS")) +
  geom_ribbon(aes(ymin = dadi_min, ymax = dadi_max), fill = "#a6d96a", color="#a6d96a", alpha = 0.2) +
  xlab('Sample size') +
  ylab(nu_label_text) +
  ggtitle("Ratio of Effective to Ancestral population size") +
  scale_colour_manual(
    values = c("#a6d96a"),
    labels = c("Dadi")
  ) +
  scale_y_log10() +
  geom_hline(yintercept = 1, size = 2, linetype = 'dashed')

plot_B = ggplot(data=tau_dataframe, aes(x=sample_size, y=value, color=variable)) + geom_line(size=2) +
  theme_bw() + guides(color=guide_legend(title="Type of SFS")) +
  geom_ribbon(aes(ymin = dadi_min, ymax = dadi_max), fill = "#a6d96a", color="#a6d96a", alpha = 0.2) +
  xlab('Sample size') +
  ylab(tau_label_text) +
  ggtitle('Timing of inferred instantaneous size change') +
  scale_y_log10() +
  scale_colour_manual(
    values = c("#a6d96a"),
    labels = c("Dadi")
  ) +
  theme(legend.position='none')

plot_C = ggplot(data=tajima_D_dataframe, aes(x=sample_size, y=value, color=variable)) + geom_line(size=2) +
  theme_bw() + guides(color=guide_legend(title="Type of SFS")) +
  xlab('Sample size') +
  ylab("Tajima's D") +
  ggtitle("Tajima's D for simulated SFS") +
  scale_colour_manual(
    values = c("#a6d96a"),
    labels = c("Dadi")
  ) +
  geom_hline(yintercept = 0, size = 2, linetype = 'dashed') +
  theme(legend.position='none')

plot_D = ggplot(data=lambda_dataframe, aes(x=sample_size, y=value, color=variable)) + geom_line(size=2) +
  theme_bw() + guides(color=guide_legend(title="Demographic model comparison")) +
  xlab('Sample size') +
  ylab(twoLambda_text) +
  ggtitle("Demographic model fit criterion, three-epoch vs. two-epoch") +
  scale_colour_manual(
    values = c("#0C7BDC", "#999ED9"),
    labels = c("Dadi, three-epoch vs. two-epoch", "Dadi, two-epoch vs. one-epoch")
  ) +
  geom_hline(yintercept = 14.75552, size = 1, linetype = 'dashed', color='red')

# 2Lambda is approximately chi-squared distributed.
# 80 comparisons for 10-800:10, so critical value is 14.76 with Bonferroni correction
qchisq(1 - 0.05/80, df=2)

plot_E = ggplot(data=epoch_ratio_dataframe, aes(x=sample_size, y=value, color=variable)) + geom_line(size=2) +
  theme_bw() + guides(color=guide_legend(title="Epoch Comparison")) +
  xlab('Sample size') +
  ylab("Ratio of effective population size") +
  ggtitle("Effective population size between epochs") +
  scale_y_log10() +
  scale_colour_manual(
    values = c("#FFC20A", "#CA5A08"),
    labels = c("Dadi, Bottleneck vs. Ancestral", "Dadi, Current vs. Bottleneck")
  ) +
  geom_hline(yintercept = 1, size = 1, linetype = 'dashed', color='red')

design = "
  CCDD
  AAEE
  BBEE
"

## Figure S1

# 1200 x 800
plot_A + 
  plot_B + 
  plot_C + 
  plot_D + 
  plot_E +
  plot_layout(design=design)


## Figure S2

##### Supplement

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
                     labels=c('Current [200 g.a.]', 
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
  ggtitle('Branch length per epoch, [Anc., 400 g.a., 200 g.a.]') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_b_len_proportion_mean_200_200',
                       'bottleneck_b_len_proportion_mean_200_200',
                       'ancestral_b_len_proportion_mean_200_200'),
                     values=c('growth_b_len_proportion_mean_200_200'='#1b9e77',
                       'bottleneck_b_len_proportion_mean_200_200'='#d95f02',
                       'ancestral_b_len_proportion_mean_200_200'='#7570b3'),
                     labels=c('Current', 'Bottleneck', 'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion')) +
  guides(shape='none', color='none')

# plot_3A_200_200 + plot_3B_simplified_200_200 + plot_layout(nrow=2)

# 400_200

sample_size = seq(from=10, to=800, by=10)
mean_list_400_200 = c()
growth_coal_proportion_400_200 = c()
bottleneck_coal_proportion_400_200 = c()
ancestral_coal_proportion_400_200 = c()
msprime_time_400_200 = c()
msprime_nu_shape_400_200 = c()

growth_b_len_proportion_mean_400_200 = c()
bottleneck_b_len_proportion_mean_400_200 = c()
ancestral_b_len_proportion_mean_400_200 = c()

# Iterate through sample size and replicate
for (i in sample_size) {
  this_sample_size_distribution = c() # Initialize
  msprime_demography_400_200 = paste0(
    "../Analysis/msprime_3EpB_400_200_", i, '/two_epoch_demography.txt')
  msprime_nu_400_200 = nu_from_demography(msprime_demography_400_200)
  msprime_time_400_200 = c(msprime_time_400_200, time_from_demography(msprime_demography_400_200))
  if (is.na(msprime_nu_400_200)) {
    msprime_nu_shape_400_200 = c(msprime_nu_shape_400_200, NA)
  } else if (msprime_nu_400_200 > 1) {
    msprime_nu_shape_400_200 = c(msprime_nu_shape_400_200, 'msprime_expand')
  } else {
    msprime_nu_shape_400_200 = c(msprime_nu_shape_400_200, 'msprime_contract')
  }
  for (j in seq(from=1, to=20, by=1)) {
    this_replicate_distribution = paste0(
      "../Simulations/simple_simulations/ThreeEpochBottleneck_400_200_",
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
      "../Simulations/simple_simulations/ThreeEpochBottleneck_400_200_",
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
  mean_list_400_200 = c(mean_list_400_200, mean(this_sample_size_distribution))
  # Similarly, take standard deviation
  # Lastly find the proportion of coalescent events in each epoch
  growth_coal_proportion_400_200 = c(growth_coal_proportion_400_200,
    mean(this_sample_size_distribution <= 200))
  bottleneck_coal_proportion_400_200 = c(bottleneck_coal_proportion_400_200,
    mean(this_sample_size_distribution <= 400) - mean(this_sample_size_distribution < 200))
  ancestral_coal_proportion_400_200 = c(ancestral_coal_proportion_400_200,
    mean(this_sample_size_distribution > 400))

  # Mean and sd of branch length proportions by epoch
  growth_b_len_proportion_mean_400_200 = c(growth_b_len_proportion_mean_400_200, mean(this_b_len_growth))
  bottleneck_b_len_proportion_mean_400_200 = c(bottleneck_b_len_proportion_mean_400_200, mean(this_b_len_bottleneck))
  ancestral_b_len_proportion_mean_400_200 = c(ancestral_b_len_proportion_mean_400_200, mean(this_b_len_ancestral))
}

figure_SX_dataframe = data.frame(
  mean_list_400_200,
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

figure_3A_dataframe_400_200 = melt(data.frame(
  growth_coal_proportion_400_200,
  bottleneck_coal_proportion_400_200,
  ancestral_coal_proportion_400_200
))

figure_3A_dataframe_400_200$msprime_time = msprime_time_400_200
figure_3A_dataframe_400_200$msprime_shape = msprime_nu_shape_400_200
figure_3A_dataframe_400_200$sample_size = sample_size

plot_3A_400_200 = ggplot(data=figure_3A_dataframe_400_200, aes(x=sample_size, y=value, color=variable, shape=msprime_shape)) +
  geom_point(size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Proportion') +
  ggtitle('Coalescent events per epoch, [Anc., 600 g.a., 200 g.a.]') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_coal_proportion_400_200',
                       'bottleneck_coal_proportion_400_200',
                       'ancestral_coal_proportion_400_200'),
                     values=c('growth_coal_proportion_400_200'='#1b9e77',
                       'bottleneck_coal_proportion_400_200'='#d95f02',
                       'ancestral_coal_proportion_400_200'='#7570b3'),
                     labels=c('Current [200 g.a.]', 
                       'Bottleneck [600 g.a.]', 
                       'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion'))

figure_3B_dataframe_400_200 = melt(data.frame(
  growth_b_len_proportion_mean_400_200,
  bottleneck_b_len_proportion_mean_400_200,
  ancestral_b_len_proportion_mean_400_200
))
figure_3B_dataframe_400_200$sample_size = sample_size
figure_3B_dataframe_400_200$msprime_shape = msprime_nu_shape_400_200

plot_3B_simplified_400_200 = ggplot(data=figure_3B_dataframe_400_200, aes(x=sample_size, y=value, color=variable)) +
  geom_point(aes(shape=msprime_shape), size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Mean branch length') +
  ggtitle('Branch length per epoch, [Anc., 600 g.a., 200 g.a.]') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_b_len_proportion_mean_400_200',
                       'bottleneck_b_len_proportion_mean_400_200',
                       'ancestral_b_len_proportion_mean_400_200'),
                     values=c('growth_b_len_proportion_mean_400_200'='#1b9e77',
                       'bottleneck_b_len_proportion_mean_400_200'='#d95f02',
                       'ancestral_b_len_proportion_mean_400_200'='#7570b3'),
                     labels=c('Current', 'Bottleneck', 'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion')) +
  guides(shape='none', color='none')

# plot_3A_400_200 + plot_3B_simplified_400_200 + plot_layout(nrow=2)


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
                     labels=c('Current [200 g.a.]', 
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
  ggtitle('Branch length per epoch, [Anc., 800 g.a., 200 g.a.]') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_b_len_proportion_mean_600_200',
                       'bottleneck_b_len_proportion_mean_600_200',
                       'ancestral_b_len_proportion_mean_600_200'),
                     values=c('growth_b_len_proportion_mean_600_200'='#1b9e77',
                       'bottleneck_b_len_proportion_mean_600_200'='#d95f02',
                       'ancestral_b_len_proportion_mean_600_200'='#7570b3'),
                     labels=c('Current', 'Bottleneck', 'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion')) +
  guides(shape='none', color='none')

# plot_3A_600_200 + plot_3B_simplified_600_200 + plot_layout(nrow=2)

# 800_200

sample_size = seq(from=10, to=800, by=10)
mean_list_800_200 = c()
growth_coal_proportion_800_200 = c()
bottleneck_coal_proportion_800_200 = c()
ancestral_coal_proportion_800_200 = c()
msprime_time_800_200 = c()
msprime_nu_shape_800_200 = c()

growth_b_len_proportion_mean_800_200 = c()
bottleneck_b_len_proportion_mean_800_200 = c()
ancestral_b_len_proportion_mean_800_200 = c()

# Iterate through sample size and replicate
for (i in sample_size) {
  this_sample_size_distribution = c() # Initialize
  msprime_demography_800_200 = paste0(
    "../Analysis/msprime_3EpB_800_200_", i, '/two_epoch_demography.txt')
  msprime_nu_800_200 = nu_from_demography(msprime_demography_800_200)
  msprime_time_800_200 = c(msprime_time_800_200, time_from_demography(msprime_demography_800_200))
  if (is.na(msprime_nu_800_200)) {
    msprime_nu_shape_800_200 = c(msprime_nu_shape_800_200, NA)
  } else if (msprime_nu_800_200 > 1) {
    msprime_nu_shape_800_200 = c(msprime_nu_shape_800_200, 'msprime_expand')
  } else {
    msprime_nu_shape_800_200 = c(msprime_nu_shape_800_200, 'msprime_contract')
  }
  for (j in seq(from=1, to=20, by=1)) {
    this_replicate_distribution = paste0(
      "../Simulations/simple_simulations/ThreeEpochBottleneck_800_200_",
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
      "../Simulations/simple_simulations/ThreeEpochBottleneck_800_200_",
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
        this_b_len_csv$node_generations<= 1000, ]$branch_length)
    ancestral_sum = sum(this_b_len_csv[this_b_len_csv$node_generations > 1000, ]$branch_length)
    total_branch_length = growth_sum + bottleneck_sum + ancestral_sum
    this_b_len_growth = c(this_b_len_growth, growth_sum / total_branch_length)
    this_b_len_bottleneck = c(this_b_len_bottleneck, bottleneck_sum / total_branch_length)
    this_b_len_ancestral = c(this_b_len_ancestral, ancestral_sum / total_branch_length)
  }
  # Take the mean of coalescent times for this sample size's distribution
  mean_list_800_200 = c(mean_list_800_200, mean(this_sample_size_distribution))
  # Similarly, take standard deviation
  # Lastly find the proportion of coalescent events in each epoch
  growth_coal_proportion_800_200 = c(growth_coal_proportion_800_200,
    mean(this_sample_size_distribution <= 200))
  bottleneck_coal_proportion_800_200 = c(bottleneck_coal_proportion_800_200,
    mean(this_sample_size_distribution <= 1000) - mean(this_sample_size_distribution < 200))
  ancestral_coal_proportion_800_200 = c(ancestral_coal_proportion_800_200,
    mean(this_sample_size_distribution > 1000))

  # Mean and sd of branch length proportions by epoch
  growth_b_len_proportion_mean_800_200 = c(growth_b_len_proportion_mean_800_200, mean(this_b_len_growth))
  bottleneck_b_len_proportion_mean_800_200 = c(bottleneck_b_len_proportion_mean_800_200, mean(this_b_len_bottleneck))
  ancestral_b_len_proportion_mean_800_200 = c(ancestral_b_len_proportion_mean_800_200, mean(this_b_len_ancestral))
}

figure_SX_dataframe = data.frame(
  mean_list_800_200,
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

figure_3A_dataframe_800_200 = melt(data.frame(
  growth_coal_proportion_800_200,
  bottleneck_coal_proportion_800_200,
  ancestral_coal_proportion_800_200
))

figure_3A_dataframe_800_200$msprime_time = msprime_time_800_200
figure_3A_dataframe_800_200$msprime_shape = msprime_nu_shape_800_200
figure_3A_dataframe_800_200$sample_size = sample_size

plot_3A_800_200 = ggplot(data=figure_3A_dataframe_800_200, aes(x=sample_size, y=value, color=variable, shape=msprime_shape)) +
  geom_point(size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Proportion') +
  ggtitle('Coalescent events per epoch, [Anc., 1000 g.a., 200 g.a.]') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_coal_proportion_800_200',
                       'bottleneck_coal_proportion_800_200',
                       'ancestral_coal_proportion_800_200'),
                     values=c('growth_coal_proportion_800_200'='#1b9e77',
                       'bottleneck_coal_proportion_800_200'='#d95f02',
                       'ancestral_coal_proportion_800_200'='#7570b3'),
                     labels=c('Current [200 g.a.]', 
                       'Bottleneck [1000 g.a.]', 
                       'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion'))

figure_3B_dataframe_800_200 = melt(data.frame(
  growth_b_len_proportion_mean_800_200,
  bottleneck_b_len_proportion_mean_800_200,
  ancestral_b_len_proportion_mean_800_200
))
figure_3B_dataframe_800_200$sample_size = sample_size
figure_3B_dataframe_800_200$msprime_shape = msprime_nu_shape_800_200

plot_3B_simplified_800_200 = ggplot(data=figure_3B_dataframe_800_200, aes(x=sample_size, y=value, color=variable)) +
  geom_point(aes(shape=msprime_shape), size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Mean branch length') +
  ggtitle('Branch length per epoch, [Anc., 1000 g.a., 200 g.a.]') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_b_len_proportion_mean_800_200',
                       'bottleneck_b_len_proportion_mean_800_200',
                       'ancestral_b_len_proportion_mean_800_200'),
                     values=c('growth_b_len_proportion_mean_800_200'='#1b9e77',
                       'bottleneck_b_len_proportion_mean_800_200'='#d95f02',
                       'ancestral_b_len_proportion_mean_800_200'='#7570b3'),
                     labels=c('Current', 'Bottleneck', 'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion')) +
  guides(shape='none', color='none')

# plot_3A_800_200 + plot_3B_simplified_800_200 + plot_layout(nrow=2)


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
                     labels=c('Current [200 g.a.]', 
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
  ggtitle('Branch length per epoch, [Anc., 1200 g.a., 200 g.a.]') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_b_len_proportion_mean_1000_200',
                       'bottleneck_b_len_proportion_mean_1000_200',
                       'ancestral_b_len_proportion_mean_1000_200'),
                     values=c('growth_b_len_proportion_mean_1000_200'='#1b9e77',
                       'bottleneck_b_len_proportion_mean_1000_200'='#d95f02',
                       'ancestral_b_len_proportion_mean_1000_200'='#7570b3'),
                     labels=c('Current', 'Bottleneck', 'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion')) +
  guides(shape='none', color='none')

# plot_3A_1000_200 + plot_3B_simplified_1000_200 + plot_layout(nrow=2)

# 1200_200

sample_size = seq(from=10, to=800, by=10)
mean_list_1200_200 = c()
growth_coal_proportion_1200_200 = c()
bottleneck_coal_proportion_1200_200 = c()
ancestral_coal_proportion_1200_200 = c()
msprime_time_1200_200 = c()
msprime_nu_shape_1200_200 = c()

growth_b_len_proportion_mean_1200_200 = c()
bottleneck_b_len_proportion_mean_1200_200 = c()
ancestral_b_len_proportion_mean_1200_200 = c()

# Iterate through sample size and replicate
for (i in sample_size) {
  this_sample_size_distribution = c() # Initialize
  msprime_demography_1200_200 = paste0(
    "../Analysis/msprime_3EpB_1200_200_", i, '/two_epoch_demography.txt')
  msprime_nu_1200_200 = nu_from_demography(msprime_demography_1200_200)
  msprime_time_1200_200 = c(msprime_time_1200_200, time_from_demography(msprime_demography_1200_200))
  if (is.na(msprime_nu_1200_200)) {
    msprime_nu_shape_1200_200 = c(msprime_nu_shape_1200_200, NA)
  } else if (msprime_nu_1200_200 > 1) {
    msprime_nu_shape_1200_200 = c(msprime_nu_shape_1200_200, 'msprime_expand')
  } else {
    msprime_nu_shape_1200_200 = c(msprime_nu_shape_1200_200, 'msprime_contract')
  }
  for (j in seq(from=1, to=20, by=1)) {
    this_replicate_distribution = paste0(
      "../Simulations/simple_simulations/ThreeEpochBottleneck_1200_200_",
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
      "../Simulations/simple_simulations/ThreeEpochBottleneck_1200_200_",
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
        this_b_len_csv$node_generations<= 1400, ]$branch_length)
    ancestral_sum = sum(this_b_len_csv[this_b_len_csv$node_generations > 1400, ]$branch_length)
    total_branch_length = growth_sum + bottleneck_sum + ancestral_sum
    this_b_len_growth = c(this_b_len_growth, growth_sum / total_branch_length)
    this_b_len_bottleneck = c(this_b_len_bottleneck, bottleneck_sum / total_branch_length)
    this_b_len_ancestral = c(this_b_len_ancestral, ancestral_sum / total_branch_length)
  }
  # Take the mean of coalescent times for this sample size's distribution
  mean_list_1200_200 = c(mean_list_1200_200, mean(this_sample_size_distribution))
  # Similarly, take standard deviation
  # Lastly find the proportion of coalescent events in each epoch
  growth_coal_proportion_1200_200 = c(growth_coal_proportion_1200_200,
    mean(this_sample_size_distribution <= 200))
  bottleneck_coal_proportion_1200_200 = c(bottleneck_coal_proportion_1200_200,
    mean(this_sample_size_distribution <= 1400) - mean(this_sample_size_distribution < 200))
  ancestral_coal_proportion_1200_200 = c(ancestral_coal_proportion_1200_200,
    mean(this_sample_size_distribution > 1400))

  # Mean and sd of branch length proportions by epoch
  growth_b_len_proportion_mean_1200_200 = c(growth_b_len_proportion_mean_1200_200, mean(this_b_len_growth))
  bottleneck_b_len_proportion_mean_1200_200 = c(bottleneck_b_len_proportion_mean_1200_200, mean(this_b_len_bottleneck))
  ancestral_b_len_proportion_mean_1200_200 = c(ancestral_b_len_proportion_mean_1200_200, mean(this_b_len_ancestral))
}

figure_SX_dataframe = data.frame(
  mean_list_1200_200,
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

figure_3A_dataframe_1200_200 = melt(data.frame(
  growth_coal_proportion_1200_200,
  bottleneck_coal_proportion_1200_200,
  ancestral_coal_proportion_1200_200
))

figure_3A_dataframe_1200_200$msprime_time = msprime_time_1200_200
figure_3A_dataframe_1200_200$msprime_shape = msprime_nu_shape_1200_200
figure_3A_dataframe_1200_200$sample_size = sample_size

plot_3A_1200_200 = ggplot(data=figure_3A_dataframe_1200_200, aes(x=sample_size, y=value, color=variable, shape=msprime_shape)) +
  geom_point(size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Proportion') +
  ggtitle('Coalescent events per epoch, [Anc., 1400 g.a., 200 g.a.]') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_coal_proportion_1200_200',
                       'bottleneck_coal_proportion_1200_200',
                       'ancestral_coal_proportion_1200_200'),
                     values=c('growth_coal_proportion_1200_200'='#1b9e77',
                       'bottleneck_coal_proportion_1200_200'='#d95f02',
                       'ancestral_coal_proportion_1200_200'='#7570b3'),
                     labels=c('Current [200 g.a.]', 
                       'Bottleneck [1400 g.a.]', 
                       'Ancestral')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion'))

figure_3B_dataframe_1200_200 = melt(data.frame(
  growth_b_len_proportion_mean_1200_200,
  bottleneck_b_len_proportion_mean_1200_200,
  ancestral_b_len_proportion_mean_1200_200
))
figure_3B_dataframe_1200_200$sample_size = sample_size
figure_3B_dataframe_1200_200$msprime_shape = msprime_nu_shape_1200_200

plot_3B_simplified_1200_200 = ggplot(data=figure_3B_dataframe_1200_200, aes(x=sample_size, y=value, color=variable)) +
  geom_point(aes(shape=msprime_shape), size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Mean branch length') +
  ggtitle('Branch length per epoch, [Anc., 1400 g.a., 200 g.a.]') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_b_len_proportion_mean_1200_200',
                       'bottleneck_b_len_proportion_mean_1200_200',
                       'ancestral_b_len_proportion_mean_1200_200'),
                     values=c('growth_b_len_proportion_mean_1200_200'='#1b9e77',
                       'bottleneck_b_len_proportion_mean_1200_200'='#d95f02',
                       'ancestral_b_len_proportion_mean_1200_200'='#7570b3'),
                     labels=c('Current', 'Bottleneck', 'Ancestral')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion'))
  # guides(shape='none', color='none')

# plot_3A_1200_200 + plot_3B_simplified_1200_200 + plot_layout(nrow=2)

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
                     labels=c('Current [200 g.a.]', 
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
  ggtitle('Branch length per epoch, [Anc., 1600 g.a., 200 g.a.]') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_b_len_proportion_mean_1400_200',
                       'bottleneck_b_len_proportion_mean_1400_200',
                       'ancestral_b_len_proportion_mean_1400_200'),
                     values=c('growth_b_len_proportion_mean_1400_200'='#1b9e77',
                       'bottleneck_b_len_proportion_mean_1400_200'='#d95f02',
                       'ancestral_b_len_proportion_mean_1400_200'='#7570b3'),
                     labels=c('Current', 'Bottleneck', 'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion')) +
  guides(shape='none', color='none')

# plot_3A_1400_200 + plot_3B_simplified_1400_200 + plot_layout(nrow=2)

# 1600_200

sample_size = seq(from=10, to=800, by=10)
mean_list_1600_200 = c()
growth_coal_proportion_1600_200 = c()
bottleneck_coal_proportion_1600_200 = c()
ancestral_coal_proportion_1600_200 = c()
msprime_time_1600_200 = c()
msprime_nu_shape_1600_200 = c()

growth_b_len_proportion_mean_1600_200 = c()
bottleneck_b_len_proportion_mean_1600_200 = c()
ancestral_b_len_proportion_mean_1600_200 = c()

# Iterate through sample size and replicate
for (i in sample_size) {
  this_sample_size_distribution = c() # Initialize
  msprime_demography_1600_200 = paste0(
    "../Analysis/msprime_3EpB_1600_200_", i, '/two_epoch_demography.txt')
  msprime_nu_1600_200 = nu_from_demography(msprime_demography_1600_200)
  msprime_time_1600_200 = c(msprime_time_1600_200, time_from_demography(msprime_demography_1600_200))
  if (is.na(msprime_nu_1600_200)) {
    msprime_nu_shape_1600_200 = c(msprime_nu_shape_1600_200, NA)
  } else if (msprime_nu_1600_200 > 1) {
    msprime_nu_shape_1600_200 = c(msprime_nu_shape_1600_200, 'msprime_expand')
  } else {
    msprime_nu_shape_1600_200 = c(msprime_nu_shape_1600_200, 'msprime_contract')
  }
  for (j in seq(from=1, to=20, by=1)) {
    this_replicate_distribution = paste0(
      "../Simulations/simple_simulations/ThreeEpochBottleneck_1600_200_",
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
      "../Simulations/simple_simulations/ThreeEpochBottleneck_1600_200_",
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
        this_b_len_csv$node_generations<= 1800, ]$branch_length)
    ancestral_sum = sum(this_b_len_csv[this_b_len_csv$node_generations > 1800, ]$branch_length)
    total_branch_length = growth_sum + bottleneck_sum + ancestral_sum
    this_b_len_growth = c(this_b_len_growth, growth_sum / total_branch_length)
    this_b_len_bottleneck = c(this_b_len_bottleneck, bottleneck_sum / total_branch_length)
    this_b_len_ancestral = c(this_b_len_ancestral, ancestral_sum / total_branch_length)
  }
  # Take the mean of coalescent times for this sample size's distribution
  mean_list_1600_200 = c(mean_list_1600_200, mean(this_sample_size_distribution))
  # Similarly, take standard deviation
  # Lastly find the proportion of coalescent events in each epoch
  growth_coal_proportion_1600_200 = c(growth_coal_proportion_1600_200,
    mean(this_sample_size_distribution <= 200))
  bottleneck_coal_proportion_1600_200 = c(bottleneck_coal_proportion_1600_200,
    mean(this_sample_size_distribution <= 1800) - mean(this_sample_size_distribution < 200))
  ancestral_coal_proportion_1600_200 = c(ancestral_coal_proportion_1600_200,
    mean(this_sample_size_distribution > 1800))

  # Mean and sd of branch length proportions by epoch
  growth_b_len_proportion_mean_1600_200 = c(growth_b_len_proportion_mean_1600_200, mean(this_b_len_growth))
  bottleneck_b_len_proportion_mean_1600_200 = c(bottleneck_b_len_proportion_mean_1600_200, mean(this_b_len_bottleneck))
  ancestral_b_len_proportion_mean_1600_200 = c(ancestral_b_len_proportion_mean_1600_200, mean(this_b_len_ancestral))
}

figure_SX_dataframe = data.frame(
  mean_list_1600_200,
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

figure_3A_dataframe_1600_200 = melt(data.frame(
  growth_coal_proportion_1600_200,
  bottleneck_coal_proportion_1600_200,
  ancestral_coal_proportion_1600_200
))

figure_3A_dataframe_1600_200$msprime_time = msprime_time_1600_200
figure_3A_dataframe_1600_200$msprime_shape = msprime_nu_shape_1600_200
figure_3A_dataframe_1600_200$sample_size = sample_size

plot_3A_1600_200 = ggplot(data=figure_3A_dataframe_1600_200, aes(x=sample_size, y=value, color=variable, shape=msprime_shape)) +
  geom_point(size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Proportion') +
  ggtitle('Coalescent events per epoch, [Anc., 1800 g.a., 200 g.a.]') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_coal_proportion_1600_200',
                       'bottleneck_coal_proportion_1600_200',
                       'ancestral_coal_proportion_1600_200'),
                     values=c('growth_coal_proportion_1600_200'='#1b9e77',
                       'bottleneck_coal_proportion_1600_200'='#d95f02',
                       'ancestral_coal_proportion_1600_200'='#7570b3'),
                     labels=c('Current [200 g.a.]', 
                       'Bottleneck [1800 g.a.]', 
                       'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion'))

figure_3B_dataframe_1600_200 = melt(data.frame(
  growth_b_len_proportion_mean_1600_200,
  bottleneck_b_len_proportion_mean_1600_200,
  ancestral_b_len_proportion_mean_1600_200
))
figure_3B_dataframe_1600_200$sample_size = sample_size
figure_3B_dataframe_1600_200$msprime_shape = msprime_nu_shape_1600_200

plot_3B_simplified_1600_200 = ggplot(data=figure_3B_dataframe_1600_200, aes(x=sample_size, y=value, color=variable)) +
  geom_point(aes(shape=msprime_shape), size=1.5) +
  theme_bw() +
  xlab('Sample size') +
  ylab('Mean branch length') +
  ggtitle('Branch length per epoch, [Anc., 1800 g.a., 200 g.a.]') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_b_len_proportion_mean_1600_200',
                       'bottleneck_b_len_proportion_mean_1600_200',
                       'ancestral_b_len_proportion_mean_1600_200'),
                     values=c('growth_b_len_proportion_mean_1600_200'='#1b9e77',
                       'bottleneck_b_len_proportion_mean_1600_200'='#d95f02',
                       'ancestral_b_len_proportion_mean_1600_200'='#7570b3'),
                     labels=c('Current', 'Bottleneck', 'Ancestral population')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion')) +
  guides(shape='none', color='none')

# plot_3A_1600_200 + plot_3B_simplified_1600_200 + plot_layout(nrow=2)

### 1600 x 1600

plot_3B_simplified_200_200 + plot_3B_simplified_1000_200 +
  plot_3B_simplified_400_200 + plot_3B_simplified_1200_200 +
  plot_3B_simplified_600_200 + plot_3B_simplified_1400_200 +
  plot_3B_simplified_800_200 + plot_3B_simplified_1600_200 +
  plot_layout(nrow=4, ncol=2)


### Figure S3 Singleton proportion (Dadi)
sample_size = seq(from=10, to=800, by=10)

dadi_sfs_singletons = c()
dadi_snm_singletons = c()
dadi_singleton_ratio = c()
dadi_singleton_diff = c()

for (i in sample_size) {
  dadi_sfs = proportional_sfs(read_input_sfs(paste0(
    "../Simulations/dadi_simulations/ThreeEpochBottleneck_", i, '.sfs')))
  dadi_snm_sfs = proportional_sfs(sfs_from_demography(paste0(
    "../Analysis/dadi_3EpB_", i, '/one_epoch_demography.txt')))
  dadi_sfs_singletons = c(dadi_sfs_singletons, dadi_sfs[1])
  dadi_snm_singletons = c(dadi_snm_singletons, dadi_snm_sfs[1])
  dadi_singleton_ratio = c(dadi_singleton_ratio, dadi_sfs[1] / dadi_snm_sfs[1])
  dadi_singleton_diff = c(dadi_singleton_diff, (dadi_sfs[1] - dadi_snm_sfs[1]))
}

singleton_ratio_dataframe = melt(data.frame(
  dadi_singleton_ratio
))
singleton_ratio_dataframe$sample_size = sample_size

nu_label_text = expression(nu == frac(N[current], N[ancestral]))
ratio_label_text = expression(frac('Proportion of singletons in data', 'Proportion of singletons in SNM'))

singleton_proportion_dataframe = melt(data.frame(
  dadi_sfs_singletons,
  dadi_snm_singletons
))
singleton_proportion_dataframe$sample_size = sample_size

singleton_diff_dataframe = melt(data.frame(
  dadi_singleton_diff
))
singleton_diff_dataframe$sample_size = sample_size

plot_S3A = ggplot(data=singleton_proportion_dataframe, aes(x=sample_size, y=value, color=variable)) + geom_line(linewidth=1) +
  theme_bw() + guides(color=guide_legend(title="Type of SFS")) +
  xlab('Sample size') +
  ylab('Proportion') +
  ggtitle('Proportion of SFS comprised of singletons') +
  scale_colour_manual(
    values = c("#a6d96a",'black'),
    labels = c("Dadi", "SNM")
  ) 

plot_S3B = ggplot(data=singleton_ratio_dataframe, aes(x=sample_size, y=value, color=variable)) + geom_line(linewidth=1) +
  theme_bw() + guides(color=guide_legend(title="Type of SFS")) +
  xlab('Sample size') +
  ylab(ratio_label_text) +
  ggtitle('Ratio of singleton proportion between data and SNM') +
  scale_colour_manual(
    values = c("#a6d96a"),
    labels = c("Dadi")
  ) +
  scale_y_log10() +
  geom_hline(yintercept = 1, linewidth = 1, linetype = 'dotted') +
  theme(legend.position='none')

# 800 x 800
plot_S3A + plot_S3B + plot_layout(nrow=2)

