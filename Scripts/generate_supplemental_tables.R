# Supplemental tables

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

sample_size = seq(from=10, to=800, by=10)

msprime_nu = c()
msprime_time = c()
msprime_tau = c()
msprime_tajima_D = c()
msprime_lambda_32 = c()
msprime_lambda_21 = c()
msprime_one_LL = c()
msprime_one_theta = c()
msprime_two_LL = c()
msprime_two_theta = c()
msprime_three_LL = c()
msprime_three_theta = c()
msprime_nu_b = c()
msprime_nu_f = c()
msprime_tau_b = c()
msprime_tau_f = c()

dadi_nu = c()
dadi_time = c()
dadi_tau = c()
dadi_tajima_D = c()
dadi_lambda_32 = c()
dadi_lambda_21 = c()
dadi_one_LL = c()
dadi_one_theta = c()
dadi_two_LL = c()
dadi_two_theta = c()
dadi_three_LL = c()
dadi_three_theta = c()
dadi_nu_b = c()
dadi_nu_f = c()
dadi_tau_b = c()
dadi_tau_f = c()



for (i in sample_size) {
  msprime_sfs = paste0(
    "../Simulations/simple_simulations/ThreeEpochBottleneck_", i, '_concat.sfs')
  msprime_demography = paste0(
    "../Analysis/msprime_3EpB_", i, '/two_epoch_demography.txt')
  msprime_demography_1 = paste0(
    "../Analysis/msprime_3EpB_", i, '/one_epoch_demography.txt')
  msprime_demography_3 = paste0(
    "../Analysis/msprime_3EpB_", i, '/three_epoch_demography.txt')
  # msprime_nu = c(msprime_nu, nu_from_demography(msprime_demography))
  msprime_time = c(msprime_time, time_from_demography(msprime_demography))
  msprime_summary = paste0(
    "../Simulations/simple_simulations/ThreeEpochBottleneck_", i, '_concat_summary.txt')
  msprime_likelihood = paste0(
   "../Analysis/msprime_3EpB_", i, '/likelihood_surface.csv')
  msprime_nu = c(msprime_nu, find_CI_bounds(msprime_likelihood)$nu_MLE)
  msprime_tau = c(msprime_tau, find_CI_bounds(msprime_likelihood)$tau_MLE)
  msprime_tajima_D = c(msprime_tajima_D, read_summary_statistics(msprime_summary)[3])
  this_msprime_one_LL = LL_from_demography(msprime_demography_1)
  this_msprime_two_LL = LL_from_demography(msprime_demography)
  this_msprime_three_LL = LL_from_demography(msprime_demography_3)
  msprime_one_LL = c(msprime_one_LL, this_msprime_one_LL)
  msprime_one_theta = c(msprime_one_theta, theta_from_demography(msprime_demography_1))
  msprime_two_LL = c(msprime_two_LL, this_msprime_two_LL)
  msprime_two_theta = c(msprime_two_theta, theta_from_demography(msprime_demography))
  msprime_three_LL = c(msprime_three_LL, this_msprime_three_LL)
  msprime_three_theta = c(msprime_three_theta, theta_from_demography(msprime_demography_3))
  msprime_LL_diff_32 = this_msprime_three_LL - this_msprime_two_LL
  msprime_lambda_32 = c(msprime_lambda_32, 2 * msprime_LL_diff_32)
  msprime_LL_diff_21 = this_msprime_two_LL - this_msprime_one_LL
  msprime_lambda_21 = c(msprime_lambda_21, 2 * msprime_LL_diff_21)
  msprime_nu_b = c(msprime_nu_b, nuB_from_demography(msprime_demography_3))
  msprime_nu_f = c(msprime_nu_f, nuF_from_demography(msprime_demography_3))
  msprime_tau_b = c(msprime_tau_b, tauB_from_demography(msprime_demography_3))
  msprime_tau_f = c(msprime_tau_f, tauF_from_demography(msprime_demography_3))
  
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
  dadi_time = c(dadi_time, time_from_demography(dadi_demography))
  dadi_summary = paste0(
    "../Simulations/dadi_simulations/ThreeEpochBottleneck_", i, '_summary.txt')
  dadi_tajima_D = c(dadi_tajima_D, read_summary_statistics(dadi_summary)[3])
  this_dadi_one_LL = LL_from_demography(dadi_demography_1)
  this_dadi_two_LL = LL_from_demography(dadi_demography)
  this_dadi_three_LL = LL_from_demography(dadi_demography_3)
  dadi_one_LL = c(dadi_one_LL, this_dadi_one_LL)
  dadi_one_theta = c(dadi_one_theta, theta_from_demography(dadi_demography_1))
  dadi_two_LL = c(dadi_two_LL, this_dadi_two_LL)
  dadi_two_theta = c(dadi_two_theta, theta_from_demography(dadi_demography))
  dadi_three_LL = c(dadi_three_LL, this_dadi_three_LL)
  dadi_three_theta = c(dadi_three_theta, theta_from_demography(dadi_demography_3))
  dadi_LL_diff_32 = this_dadi_three_LL - this_dadi_two_LL
  dadi_lambda_32 = c(dadi_lambda_32, 2 * dadi_LL_diff_32)
  dadi_LL_diff_21 = this_dadi_two_LL - this_dadi_one_LL
  dadi_lambda_21 = c(dadi_lambda_21, 2 * dadi_LL_diff_21)
  dadi_nu = c(dadi_nu, find_CI_bounds(dadi_likelihood)$nu_MLE)
  dadi_tau = c(dadi_tau, find_CI_bounds(dadi_likelihood)$tau_MLE)
  dadi_nu_b = c(dadi_nu_b, nuB_from_demography(dadi_demography_3))
  dadi_nu_f = c(dadi_nu_f, nuF_from_demography(dadi_demography_3))
  dadi_tau_b = c(dadi_tau_b, tauB_from_demography(dadi_demography_3))
  dadi_tau_f = c(dadi_tau_f, tauF_from_demography(dadi_demography_3))
}

## Supplemental Table 1 (MSPrime results)
table_s1 = data.frame(sample_size, msprime_tajima_D, msprime_one_LL, 
  msprime_one_theta, msprime_lambda_21,
  msprime_two_LL, msprime_two_theta, msprime_nu,
  msprime_tau, msprime_lambda_32, msprime_three_LL,
  msprime_nu_b, msprime_nu_f, msprime_tau_b, msprime_tau_f)

names(table_s1) = c("Sample size", "Tajima's D", "One-epoch LL", "One-epoch Theta",
  "Lambda Two vs. One", "Two-epoch LL", "Two-epoch Theta", "Two-epoch Nu",
  "Two-epoch Tau", "Lambda Three vs. Two", "Three-epoch LL", "Three-epoch NuB",
  "Three-epoch NuF", "Three-epoch TauB", "Three-epoch TauF")

table_s1
write.csv(table_s1, "../Supplement/table_s1.csv", row.names=FALSE)

## Supplemental Table 2 (Dadi results)
table_s2 = data.frame(sample_size, dadi_tajima_D, dadi_one_LL, 
  dadi_one_theta, dadi_lambda_21,
  dadi_two_LL, dadi_two_theta, dadi_nu,
  dadi_tau, dadi_lambda_32, dadi_three_LL,
  dadi_nu_b, dadi_nu_f, dadi_tau_b, dadi_tau_f)

names(table_s2) = c("Sample size", "Tajima's D", "One-epoch LL", "One-epoch Theta",
  "Lambda Two vs. One", "Two-epoch LL", "Two-epoch Theta", "Two-epoch Nu",
  "Two-epoch Tau", "Lambda Three vs. Two", "Three-epoch LL", "Three-epoch NuB",
  "Three-epoch NuF", "Three-epoch TauB", "Three-epoch TauF")

table_s2
write.csv(table_s2, "../Supplement/table_s2.csv", row.names=FALSE)


## Supplmenetal Table 3

# sample_size = seq(from=10, to=800, by=10)
# 
# bottle_200_200_lambda = c()
# bottle_400_200_lambda = c()
# bottle_600_200_lambda = c()
# bottle_800_200_lambda = c()
# bottle_1000_200_lambda = c()
# bottle_1200_200_lambda = c()
# bottle_1400_200_lambda = c()
# bottle_1600_200_lambda = c()
# 
# for (i in sample_size) {
#   bottle_200_200_one = paste0(
#     "../Analysis/msprime_3EpB_200_200_", i, '/one_epoch_demography.txt')
#   bottle_200_200_two = paste0(
#     "../Analysis/msprime_3EpB_200_200_", i, '/two_epoch_demography.txt')
#   bottle_200_200_one_LL = LL_from_demography(bottle_200_200_one)
#   bottle_200_200_two_LL = LL_from_demography(bottle_200_200_two)
#   bottle_200_200_LL_diff = bottle_200_200_two_LL - bottle_200_200_one_LL
#   bottle_200_200_lambda = c(bottle_200_200_lambda, 2 * bottle_200_200_LL_diff)
# 
#   bottle_400_200_one = paste0(
#     "../Analysis/msprime_3EpB_400_200_", i, '/one_epoch_demography.txt')
#   bottle_400_200_two = paste0(
#     "../Analysis/msprime_3EpB_400_200_", i, '/two_epoch_demography.txt')
#   bottle_400_200_one_LL = LL_from_demography(bottle_400_200_one)
#   bottle_400_200_two_LL = LL_from_demography(bottle_400_200_two)
#   bottle_400_200_LL_diff = bottle_400_200_two_LL - bottle_400_200_one_LL
#   bottle_400_200_lambda = c(bottle_400_200_lambda, 2 * bottle_400_200_LL_diff)
#   
#   bottle_600_200_one = paste0(
#     "../Analysis/msprime_3EpB_600_200_", i, '/one_epoch_demography.txt')
#   bottle_600_200_two = paste0(
#     "../Analysis/msprime_3EpB_600_200_", i, '/two_epoch_demography.txt')
#   bottle_600_200_one_LL = LL_from_demography(bottle_600_200_one)
#   bottle_600_200_two_LL = LL_from_demography(bottle_600_200_two)
#   bottle_600_200_LL_diff = bottle_600_200_two_LL - bottle_600_200_one_LL
#   bottle_600_200_lambda = c(bottle_600_200_lambda, 2 * bottle_600_200_LL_diff)
#   
#   bottle_800_200_one = paste0(
#     "../Analysis/msprime_3EpB_800_200_", i, '/one_epoch_demography.txt')
#   bottle_800_200_two = paste0(
#     "../Analysis/msprime_3EpB_800_200_", i, '/two_epoch_demography.txt')
#   bottle_800_200_one_LL = LL_from_demography(bottle_800_200_one)
#   bottle_800_200_two_LL = LL_from_demography(bottle_800_200_two)
#   bottle_800_200_LL_diff = bottle_800_200_two_LL - bottle_800_200_one_LL
#   bottle_800_200_lambda = c(bottle_800_200_lambda, 2 * bottle_800_200_LL_diff)
#   
#   bottle_1000_200_one = paste0(
#     "../Analysis/msprime_3EpB_1000_200_", i, '/one_epoch_demography.txt')
#   bottle_1000_200_two = paste0(
#     "../Analysis/msprime_3EpB_1000_200_", i, '/two_epoch_demography.txt')
#   bottle_1000_200_one_LL = LL_from_demography(bottle_1000_200_one)
#   bottle_1000_200_two_LL = LL_from_demography(bottle_1000_200_two)
#   bottle_1000_200_LL_diff = bottle_1000_200_two_LL - bottle_1000_200_one_LL
#   bottle_1000_200_lambda = c(bottle_1000_200_lambda, 2 * bottle_1000_200_LL_diff)
#   
#   bottle_1200_200_one = paste0(
#     "../Analysis/msprime_3EpB_1200_200_", i, '/one_epoch_demography.txt')
#   bottle_1200_200_two = paste0(
#     "../Analysis/msprime_3EpB_1200_200_", i, '/two_epoch_demography.txt')
#   bottle_1200_200_one_LL = LL_from_demography(bottle_1200_200_one)
#   bottle_1200_200_two_LL = LL_from_demography(bottle_1200_200_two)
#   bottle_1200_200_LL_diff = bottle_1200_200_two_LL - bottle_1200_200_one_LL
#   bottle_1200_200_lambda = c(bottle_1200_200_lambda, 2 * bottle_1200_200_LL_diff)
#   
#   bottle_1400_200_one = paste0(
#     "../Analysis/msprime_3EpB_1400_200_", i, '/one_epoch_demography.txt')
#   bottle_1400_200_two = paste0(
#     "../Analysis/msprime_3EpB_1400_200_", i, '/two_epoch_demography.txt')
#   bottle_1400_200_one_LL = LL_from_demography(bottle_1400_200_one)
#   bottle_1400_200_two_LL = LL_from_demography(bottle_1400_200_two)
#   bottle_1400_200_LL_diff = bottle_1400_200_two_LL - bottle_1400_200_one_LL
#   bottle_1400_200_lambda = c(bottle_1400_200_lambda, 2 * bottle_1400_200_LL_diff)
#   
#   bottle_1600_200_one = paste0(
#     "../Analysis/msprime_3EpB_1600_200_", i, '/one_epoch_demography.txt')
#   bottle_1600_200_two = paste0(
#     "../Analysis/msprime_3EpB_1600_200_", i, '/two_epoch_demography.txt')
#   bottle_1600_200_one_LL = LL_from_demography(bottle_1600_200_one)
#   bottle_1600_200_two_LL = LL_from_demography(bottle_1600_200_two)
#   bottle_1600_200_LL_diff = bottle_1600_200_two_LL - bottle_1600_200_one_LL
#   bottle_1600_200_lambda = c(bottle_1600_200_lambda, 2 * bottle_1600_200_LL_diff)
# }
# 
# table_temp = data.frame(bottle_200_200_lambda, bottle_400_200_lambda,
#   bottle_600_200_lambda, bottle_800_200_lambda,
#   bottle_1000_200_lambda, bottle_1200_200_lambda,
#   bottle_1400_200_lambda, bottle_1600_200_lambda)
# 
# names(table_temp) = c(
#   "[Anc., 400 g.a., 200 g.a.]",
#   "[Anc., 600 g.a., 200 g.a.]",
#   "[Anc., 800 g.a., 200 g.a.]",
#   "[Anc., 1000 g.a., 200 g.a.]",
#   "[Anc., 1200 g.a., 200 g.a.]",
#   "[Anc., 1400 g.a., 200 g.a.]",
#   "[Anc., 1600 g.a., 200 g.a.]",
#   "[Anc., 1800 g.a., 200 g.a.]"
# )
# 
# table_temp = melt(table_temp)
# 
# table_temp$sample_size = sample_size
# 
# ggplot(data=table_temp, aes(x=sample_size, y=value, color=variable)) + geom_line(linewidth=1) +
#   theme_bw() + guides(color=guide_legend(title="2Lambda")) +
#   scale_y_log10() +
#   ggtitle('2Lambda for modulated bottleneck simulations')

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
    msprime_nu_shape_200_200 = c(msprime_nu_shape_200_200, 'Expansion')
  } else {
    msprime_nu_shape_200_200 = c(msprime_nu_shape_200_200, 'Contraction')
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

figure_3B_dataframe_200_200 = melt(data.frame(
  growth_b_len_proportion_mean_200_200,
  bottleneck_b_len_proportion_mean_200_200,
  ancestral_b_len_proportion_mean_200_200
))
figure_3B_dataframe_200_200$sample_size = sample_size
figure_3B_dataframe_200_200$msprime_shape = msprime_nu_shape_200_200

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
    msprime_nu_shape_400_200 = c(msprime_nu_shape_400_200, 'Expansion')
  } else {
    msprime_nu_shape_400_200 = c(msprime_nu_shape_400_200, 'Contraction')
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

figure_3B_dataframe_400_200 = melt(data.frame(
  growth_b_len_proportion_mean_400_200,
  bottleneck_b_len_proportion_mean_400_200,
  ancestral_b_len_proportion_mean_400_200
))
figure_3B_dataframe_400_200$sample_size = sample_size
figure_3B_dataframe_400_200$msprime_shape = msprime_nu_shape_400_200

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
    msprime_nu_shape_600_200 = c(msprime_nu_shape_600_200, 'Expansion')
  } else {
    msprime_nu_shape_600_200 = c(msprime_nu_shape_600_200, 'Contraction')
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
                     breaks=c('Contraction',
                       'Expansion'),
                     values=c('Contraction'=15,
                       'Expansion'=22),
                     labels=c('Contraction',
                       'Expansion'))

figure_3B_dataframe_600_200 = melt(data.frame(
  growth_b_len_proportion_mean_600_200,
  bottleneck_b_len_proportion_mean_600_200,
  ancestral_b_len_proportion_mean_600_200
))
figure_3B_dataframe_600_200$sample_size = sample_size
figure_3B_dataframe_600_200$msprime_shape = msprime_nu_shape_600_200

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
    msprime_nu_shape_800_200 = c(msprime_nu_shape_800_200, 'Expansion')
  } else {
    msprime_nu_shape_800_200 = c(msprime_nu_shape_800_200, 'Contraction')
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

figure_3B_dataframe_800_200 = melt(data.frame(
  growth_b_len_proportion_mean_800_200,
  bottleneck_b_len_proportion_mean_800_200,
  ancestral_b_len_proportion_mean_800_200
))
figure_3B_dataframe_800_200$sample_size = sample_size
figure_3B_dataframe_800_200$msprime_shape = msprime_nu_shape_800_200

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
    msprime_nu_shape_1000_200 = c(msprime_nu_shape_1000_200, 'Expansion')
  } else {
    msprime_nu_shape_1000_200 = c(msprime_nu_shape_1000_200, 'Contraction')
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

figure_3A_dataframe_1000_200 = melt(data.frame(
  growth_coal_proportion_1000_200,
  bottleneck_coal_proportion_1000_200,
  ancestral_coal_proportion_1000_200
))

figure_3A_dataframe_1000_200$msprime_time = msprime_time_1000_200
figure_3A_dataframe_1000_200$msprime_shape = msprime_nu_shape_1000_200
figure_3A_dataframe_1000_200$sample_size = sample_size

figure_3B_dataframe_1000_200 = melt(data.frame(
  growth_b_len_proportion_mean_1000_200,
  bottleneck_b_len_proportion_mean_1000_200,
  ancestral_b_len_proportion_mean_1000_200
))
figure_3B_dataframe_1000_200$sample_size = sample_size
figure_3B_dataframe_1000_200$msprime_shape = msprime_nu_shape_1000_200

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
    msprime_nu_shape_1200_200 = c(msprime_nu_shape_1200_200, 'Expansion')
  } else {
    msprime_nu_shape_1200_200 = c(msprime_nu_shape_1200_200, 'Contraction')
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

figure_3A_dataframe_1200_200 = melt(data.frame(
  growth_coal_proportion_1200_200,
  bottleneck_coal_proportion_1200_200,
  ancestral_coal_proportion_1200_200
))

figure_3A_dataframe_1200_200$msprime_time = msprime_time_1200_200
figure_3A_dataframe_1200_200$msprime_shape = msprime_nu_shape_1200_200
figure_3A_dataframe_1200_200$sample_size = sample_size

figure_3B_dataframe_1200_200 = melt(data.frame(
  growth_b_len_proportion_mean_1200_200,
  bottleneck_b_len_proportion_mean_1200_200,
  ancestral_b_len_proportion_mean_1200_200
))
figure_3B_dataframe_1200_200$sample_size = sample_size
figure_3B_dataframe_1200_200$msprime_shape = msprime_nu_shape_1200_200

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
    msprime_nu_shape_1400_200 = c(msprime_nu_shape_1400_200, 'Expansion')
  } else {
    msprime_nu_shape_1400_200 = c(msprime_nu_shape_1400_200, 'Contraction')
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

figure_3A_dataframe_1400_200 = melt(data.frame(
  growth_coal_proportion_1400_200,
  bottleneck_coal_proportion_1400_200,
  ancestral_coal_proportion_1400_200
))

figure_3A_dataframe_1400_200$msprime_time = msprime_time_1400_200
figure_3A_dataframe_1400_200$msprime_shape = msprime_nu_shape_1400_200
figure_3A_dataframe_1400_200$sample_size = sample_size

figure_3B_dataframe_1400_200 = melt(data.frame(
  growth_b_len_proportion_mean_1400_200,
  bottleneck_b_len_proportion_mean_1400_200,
  ancestral_b_len_proportion_mean_1400_200
))
figure_3B_dataframe_1400_200$sample_size = sample_size
figure_3B_dataframe_1400_200$msprime_shape = msprime_nu_shape_1400_200

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
    msprime_nu_shape_1600_200 = c(msprime_nu_shape_1600_200, 'Expansion')
  } else {
    msprime_nu_shape_1600_200 = c(msprime_nu_shape_1600_200, 'Contraction')
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

figure_3A_dataframe_1600_200 = melt(data.frame(
  growth_coal_proportion_1600_200,
  bottleneck_coal_proportion_1600_200,
  ancestral_coal_proportion_1600_200
))

figure_3A_dataframe_1600_200$msprime_time = msprime_time_1600_200
figure_3A_dataframe_1600_200$msprime_shape = msprime_nu_shape_1600_200
figure_3A_dataframe_1600_200$sample_size = sample_size

figure_3B_dataframe_1600_200 = melt(data.frame(
  growth_b_len_proportion_mean_1600_200,
  bottleneck_b_len_proportion_mean_1600_200,
  ancestral_b_len_proportion_mean_1600_200
))
figure_3B_dataframe_1600_200$sample_size = sample_size
figure_3B_dataframe_1600_200$msprime_shape = msprime_nu_shape_1600_200

table_s3 = data.frame(sample_size,
  msprime_nu_shape_200_200, ancestral_b_len_proportion_mean_200_200, 
  bottleneck_b_len_proportion_mean_200_200, growth_b_len_proportion_mean_200_200,
  msprime_nu_shape_400_200, ancestral_b_len_proportion_mean_400_200, 
  bottleneck_b_len_proportion_mean_400_200, growth_b_len_proportion_mean_400_200,
  msprime_nu_shape_600_200, ancestral_b_len_proportion_mean_600_200, 
  bottleneck_b_len_proportion_mean_600_200, growth_b_len_proportion_mean_600_200,
  msprime_nu_shape_800_200, ancestral_b_len_proportion_mean_800_200, 
  bottleneck_b_len_proportion_mean_800_200, growth_b_len_proportion_mean_800_200,
  msprime_nu_shape_1000_200, ancestral_b_len_proportion_mean_1000_200, 
  bottleneck_b_len_proportion_mean_1000_200, growth_b_len_proportion_mean_1000_200,
  msprime_nu_shape_1200_200, ancestral_b_len_proportion_mean_1200_200, 
  bottleneck_b_len_proportion_mean_1200_200, growth_b_len_proportion_mean_1200_200,
  msprime_nu_shape_1400_200, ancestral_b_len_proportion_mean_1400_200, 
  bottleneck_b_len_proportion_mean_1400_200, growth_b_len_proportion_mean_1400_200,
  msprime_nu_shape_1600_200, ancestral_b_len_proportion_mean_1600_200, 
  bottleneck_b_len_proportion_mean_1600_200, growth_b_len_proportion_mean_1600_200)

names(table_s3) = c('Sample size',
  "Two-epoch inference, [Anc, 200, 200]", "Ancestral branch proportion, [Anc, 200, 200]",
  "Bottleneck branch proportion, [Anc, 200, 200]", "Current branch proportion, [Anc, 200, 200]",
  "Two-epoch inference, [Anc, 400, 200]", "Ancestral branch proportion, [Anc, 400, 200]",
  "Bottleneck branch proportion, [Anc, 400, 200]", "Current branch proportion, [Anc, 400, 200]",
  "Two-epoch inference, [Anc, 600, 200]", "Ancestral branch proportion, [Anc, 600, 200]",
  "Bottleneck branch proportion, [Anc, 600, 200]", "Current branch proportion, [Anc, 600, 200]",
  "Two-epoch inference, [Anc, 800, 200]", "Ancestral branch proportion, [Anc, 800, 200]",
  "Bottleneck branch proportion, [Anc, 800, 200]", "Current branch proportion, [Anc, 800, 200]",
  "Two-epoch inference, [Anc, 1000, 200]", "Ancestral branch proportion, [Anc, 1000, 200]",
  "Bottleneck branch proportion, [Anc, 1000, 200]", "Current branch proportion, [Anc, 1000, 200]",
  "Two-epoch inference, [Anc, 1200, 200]", "Ancestral branch proportion, [Anc, 1200, 200]",
  "Bottleneck branch proportion, [Anc, 1200, 200]", "Current branch proportion, [Anc, 1200, 200]",
  "Two-epoch inference, [Anc, 1400, 200]", "Ancestral branch proportion, [Anc, 1400, 200]",
  "Bottleneck branch proportion, [Anc, 1400, 200]", "Current branch proportion, [Anc, 1400, 200]",
  "Two-epoch inference, [Anc, 1600, 200]", "Ancestral branch proportion, [Anc, 1600, 200]",
  "Bottleneck branch proportion, [Anc, 1600, 200]", "Current branch proportion, [Anc, 1600, 200]")

table_s3
write.csv(table_s3, "../Supplement/table_s3.csv", row.names=FALSE)
## Supplemental Table 4
sample_size = seq(from=10, to=800, by=10)

msprime_sfs_singletons = c()
msprime_snm_singletons = c()
msprime_singleton_ratio = c()
msprime_singleton_diff = c()

dadi_sfs_singletons = c()
dadi_snm_singletons = c()
dadi_singleton_ratio = c()
dadi_singleton_diff = c()


for (i in sample_size) {
  msprime_sfs = proportional_sfs(read_input_sfs(paste0(
    "../Simulations/simple_simulations/ThreeEpochBottleneck_", i, '_concat.sfs')))
  msprime_snm_sfs = proportional_sfs(sfs_from_demography(paste0(
    "../Analysis/msprime_3EpB_", i, '/one_epoch_demography.txt')))
  msprime_sfs_singletons = c(msprime_sfs_singletons, msprime_sfs[1])
  msprime_snm_singletons = c(msprime_snm_singletons, msprime_snm_sfs[1])
  msprime_singleton_ratio = c(msprime_singleton_ratio, msprime_sfs[1] / msprime_snm_sfs[1])
  msprime_singleton_diff = c(msprime_singleton_diff, (msprime_sfs[1] - msprime_snm_sfs[1]))
  
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
  msprime_singleton_ratio,
  dadi_singleton_ratio
))
singleton_ratio_dataframe$sample_size = sample_size

nu_label_text = expression(nu == frac(N[current], N[ancestral]))
ratio_label_text = expression(frac('Proportion of singletons in data', 'Proportion of singletons in SNM'))

singleton_proportion_dataframe = melt(data.frame(
  msprime_sfs_singletons,
  dadi_sfs_singletons,
  dadi_snm_singletons
))
singleton_proportion_dataframe$sample_size = sample_size

singleton_diff_dataframe = melt(data.frame(
  msprime_singleton_diff,
  dadi_singleton_diff
))
singleton_diff_dataframe$sample_size = sample_size

table_s4 = data.frame(sample_size, dadi_snm_singletons,
  msprime_sfs_singletons, msprime_singleton_ratio, msprime_singleton_diff,
  dadi_sfs_singletons, dadi_singleton_ratio, dadi_singleton_diff)

names(table_s4) = c("Sample size", "SNM singleton proportion", "MSPrime singleton proportion",
  "MSPrime singleton ratio", "MSPrime singleton difference", "Dadi singleton proportion",
  "Dadi singleton ratio", "Dadi singleton difference")

table_s4
write.csv(table_s4, "../Supplement/table_s4.csv", row.names=FALSE)

## Supplemental Table 5
sample_size = seq(from=10, to=300, by=10)

EUR_2020_nu = c()
EUR_2020_time = c()
EUR_2020_tau = c()
EUR_2020_tajima_D = c()
EUR_2020_lambda_32 = c()
EUR_2020_lambda_21 = c()
EUR_2020_one_LL = c()
EUR_2020_one_theta = c()
EUR_2020_two_LL = c()
EUR_2020_two_theta = c()
EUR_2020_three_LL = c()
EUR_2020_three_theta = c()

EUR_2020_nu_min = c()
EUR_2020_nu_max = c()
EUR_2020_tau_min = c()
EUR_2020_tau_max = c()

EUR_2020_nu_b = c()
EUR_2020_nu_f = c()
EUR_2020_tau_b = c()
EUR_2020_tau_f = c()

for (i in sample_size) {
  EUR_2020_sfs = paste0(
    "../Analysis/1kg_EUR_2020_", i, 'syn_downsampled_sfs.txt')
  EUR_2020_demography = paste0(
    "../Analysis/1kg_EUR_2020_", i, '/two_epoch_demography.txt')
  EUR_2020_demography_1 = paste0(
    "../Analysis/1kg_EUR_2020_", i, '/one_epoch_demography.txt')
  EUR_2020_demography_3 = paste0(
    "../Analysis/1kg_EUR_2020_", i, '/three_epoch_demography.txt')
  EUR_2020_likelihood = paste0(
   "../Analysis/1kg_EUR_2020_", i, '/likelihood_surface.csv')
  # EUR_2020_nu = c(EUR_2020_nu, nu_from_demography(EUR_2020_demography))
  EUR_2020_time = c(EUR_2020_time, time_from_demography(EUR_2020_demography))
  # EUR_2020_tau = c(EUR_2020_tau, tau_from_demography(EUR_2020_demography))
  EUR_2020_summary = paste0(
    "../Analysis/1kg_EUR_2020_", i, '/syn_downsampled_sfs_summary.txt')
  
  EUR_2020_tajima_D = c(EUR_2020_tajima_D, read_summary_statistics(EUR_2020_summary)[3])
  this_EUR_2020_one_LL = LL_from_demography(EUR_2020_demography_1)
  this_EUR_2020_two_LL = LL_from_demography(EUR_2020_demography)
  this_EUR_2020_three_LL = LL_from_demography(EUR_2020_demography_3)
  EUR_2020_one_LL = c(EUR_2020_one_LL, this_EUR_2020_one_LL)
  EUR_2020_one_theta = c(EUR_2020_one_theta, theta_from_demography(EUR_2020_demography_1))
  EUR_2020_two_LL = c(EUR_2020_two_LL, this_EUR_2020_two_LL)
  EUR_2020_two_theta = c(EUR_2020_two_theta, theta_from_demography(EUR_2020_demography))
  EUR_2020_three_LL = c(EUR_2020_three_LL, this_EUR_2020_three_LL)
  EUR_2020_three_theta = c(EUR_2020_three_theta, theta_from_demography(EUR_2020_demography_3))
  EUR_2020_LL_diff_32 = this_EUR_2020_three_LL - this_EUR_2020_two_LL
  EUR_2020_LL_diff_21 = this_EUR_2020_two_LL - this_EUR_2020_one_LL
  EUR_2020_lambda_32 = c(EUR_2020_lambda_32, 2 * EUR_2020_LL_diff_32)
  EUR_2020_lambda_21 = c(EUR_2020_lambda_21, 2 * EUR_2020_LL_diff_21)
  
  EUR_2020_nu = c(EUR_2020_nu, find_CI_bounds(EUR_2020_likelihood)$nu_MLE)
  EUR_2020_tau = c(EUR_2020_tau, find_CI_bounds(EUR_2020_likelihood)$tau_MLE)
  
  EUR_2020_nu_b = c(EUR_2020_nu_b, nuB_from_demography(EUR_2020_demography_3))
  EUR_2020_nu_f = c(EUR_2020_nu_f, nuF_from_demography(EUR_2020_demography_3))
  EUR_2020_tau_b = c(EUR_2020_tau_b, tauB_from_demography(EUR_2020_demography_3))
  EUR_2020_tau_f = c(EUR_2020_tau_f, tauF_from_demography(EUR_2020_demography_3))
}

table_s5 = data.frame(sample_size, EUR_2020_tajima_D, EUR_2020_one_LL, EUR_2020_one_theta,
  EUR_2020_lambda_21, EUR_2020_two_LL, EUR_2020_two_theta, EUR_2020_nu, EUR_2020_tau,
  EUR_2020_lambda_32, EUR_2020_three_LL, EUR_2020_three_theta, EUR_2020_nu_b, EUR_2020_nu_f,
  EUR_2020_tau_b, EUR_2020_tau_f)

names(table_s5) = c("Sample size", "Tajima's D", "One-epoch LL", "One-epoch Theta",
  "Lambda Two vs. One", "Two-epoch LL", "Two-epoch Theta", "Two-epoch Nu",
  "Two-epoch Tau", "Lambda Three vs. Two", "Three-epoch LL", "Three-epoch Theta", 
  "Three-epoch NuB",  "Three-epoch NuF", "Three-epoch TauB", "Three-epoch TauF")

table_s5
write.csv(table_s5, "../Supplement/table_s5.csv", row.names=FALSE)
