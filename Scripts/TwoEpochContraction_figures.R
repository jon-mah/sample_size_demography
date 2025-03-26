## Tennessen simulation

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

global_allele_sum = 20 * 1000000

# 2EpC 10,20,30,50,100,150,200,300,500,700
TwoEpochC_empirical_file_list = list()
TwoEpochC_one_epoch_file_list = list()
TwoEpochC_two_epoch_file_list = list()
TwoEpochC_three_epoch_file_list = list()
TwoEpochC_true_demography_file_list = list()
TwoEpochC_one_epoch_AIC = c()
TwoEpochC_one_epoch_LL = c()
TwoEpochC_one_epoch_theta = c()
TwoEpochC_one_epoch_allele_sum = global_allele_sum
TwoEpochC_two_epoch_AIC = c()
TwoEpochC_two_epoch_LL = c()
TwoEpochC_two_epoch_theta = c()
TwoEpochC_two_epoch_nu = c()
TwoEpochC_two_epoch_tau = c()
TwoEpochC_two_epoch_allele_sum = global_allele_sum
TwoEpochC_three_epoch_AIC = c()
TwoEpochC_three_epoch_LL = c()
TwoEpochC_three_epoch_theta = c()
TwoEpochC_three_epoch_nuB = c()
TwoEpochC_three_epoch_nuF = c()
TwoEpochC_three_epoch_tauB = c()
TwoEpochC_three_epoch_tauF = c()
TwoEpochC_three_epoch_allele_sum = global_allele_sum
TwoEpochC_true_demography_AIC = c()
TwoEpochC_true_demography_LL = c()
TwoEpochC_true_demography_theta = c()
TwoEpochC_true_demography_allele_sum = global_allele_sum
TwoEpochC_true_demography_nu = c()
TwoEpochC_true_demography_tau = c()

# Loop through subdirectories and get relevant files
for (i in c(10, 20, 30, 50, 100, 150, 200, 300, 500, 700)) {
  subdirectory <- paste0("../Analysis/TwoEpochContraction_", i)
  TwoEpochC_empirical_file_path <- file.path(subdirectory, "syn_downsampled_sfs.txt")
  TwoEpochC_one_epoch_file_path <- file.path(subdirectory, "one_epoch_demography.txt")
  TwoEpochC_two_epoch_file_path <- file.path(subdirectory, "two_epoch_demography.txt")
  TwoEpochC_three_epoch_file_path <- file.path(subdirectory, "three_epoch_demography.txt")
  TwoEpochC_true_demography_file_path <- file.path(subdirectory, 'true_demography.txt')
  
  # Check if the file exists before attempting to read and print its contents
  if (file.exists(TwoEpochC_empirical_file_path)) {
    this_empirical_sfs = read_input_sfs(TwoEpochC_empirical_file_path)
    TwoEpochC_empirical_file_list[[subdirectory]] = this_empirical_sfs
  }
  if (file.exists(TwoEpochC_one_epoch_file_path)) {
    this_one_epoch_sfs = sfs_from_demography(TwoEpochC_one_epoch_file_path)
    TwoEpochC_one_epoch_file_list[[subdirectory]] = this_one_epoch_sfs
    TwoEpochC_one_epoch_AIC = c(TwoEpochC_one_epoch_AIC, AIC_from_demography(TwoEpochC_one_epoch_file_path))
    TwoEpochC_one_epoch_LL = c(TwoEpochC_one_epoch_LL, LL_from_demography(TwoEpochC_one_epoch_file_path))
    TwoEpochC_one_epoch_theta = c(TwoEpochC_one_epoch_theta, theta_from_demography(TwoEpochC_one_epoch_file_path))
    # TwoEpochC_one_epoch_allele_sum = c(TwoEpochC_one_epoch_allele_sum, sum(this_one_epoch_sfs))
  }
  if (file.exists(TwoEpochC_two_epoch_file_path)) {
    this_two_epoch_sfs = sfs_from_demography(TwoEpochC_two_epoch_file_path)
    TwoEpochC_two_epoch_file_list[[subdirectory]] = this_two_epoch_sfs
    TwoEpochC_two_epoch_AIC = c(TwoEpochC_two_epoch_AIC, AIC_from_demography(TwoEpochC_two_epoch_file_path))
    TwoEpochC_two_epoch_LL = c(TwoEpochC_two_epoch_LL, LL_from_demography(TwoEpochC_two_epoch_file_path))
    TwoEpochC_two_epoch_theta = c(TwoEpochC_two_epoch_theta, theta_from_demography(TwoEpochC_two_epoch_file_path))
    TwoEpochC_two_epoch_nu = c(TwoEpochC_two_epoch_nu, nu_from_demography(TwoEpochC_two_epoch_file_path))
    TwoEpochC_two_epoch_tau = c(TwoEpochC_two_epoch_tau, tau_from_demography(TwoEpochC_two_epoch_file_path))
    # TwoEpochC_two_epoch_allele_sum = c(TwoEpochC_two_epoch_allele_sum, sum(this_two_epoch_sfs))
  }
  if (file.exists(TwoEpochC_three_epoch_file_path)) {
    this_three_epoch_sfs = sfs_from_demography(TwoEpochC_three_epoch_file_path)
    TwoEpochC_three_epoch_file_list[[subdirectory]] = this_three_epoch_sfs
    TwoEpochC_three_epoch_AIC = c(TwoEpochC_three_epoch_AIC, AIC_from_demography(TwoEpochC_three_epoch_file_path))
    TwoEpochC_three_epoch_LL = c(TwoEpochC_three_epoch_LL, LL_from_demography(TwoEpochC_three_epoch_file_path))
    TwoEpochC_three_epoch_theta = c(TwoEpochC_three_epoch_theta, theta_from_demography(TwoEpochC_three_epoch_file_path))
    TwoEpochC_three_epoch_nuB = c(TwoEpochC_three_epoch_nuB, nuB_from_demography(TwoEpochC_three_epoch_file_path))
    TwoEpochC_three_epoch_nuF = c(TwoEpochC_three_epoch_nuF, nuF_from_demography(TwoEpochC_three_epoch_file_path))
    TwoEpochC_three_epoch_tauB = c(TwoEpochC_three_epoch_tauB, tauB_from_demography(TwoEpochC_three_epoch_file_path))
    TwoEpochC_three_epoch_tauF = c(TwoEpochC_three_epoch_tauF, tauF_from_demography(TwoEpochC_three_epoch_file_path))
    # TwoEpochC_three_epoch_allele_sum = c(TwoEpochC_three_epoch_allele_sum, sum(this_three_epoch_sfs))
  }  
  if (file.exists(TwoEpochC_true_demography_file_path)) {
    this_true_demography_sfs = sfs_from_demography(TwoEpochC_true_demography_file_path)
    TwoEpochC_true_demography_file_list[[subdirectory]] = this_true_demography_sfs
    TwoEpochC_true_demography_AIC = c(TwoEpochC_true_demography_AIC, AIC_from_demography(TwoEpochC_true_demography_file_path))
    TwoEpochC_true_demography_LL = c(TwoEpochC_true_demography_LL, LL_from_demography(TwoEpochC_true_demography_file_path))
    TwoEpochC_true_demography_theta = c(TwoEpochC_true_demography_theta, theta_from_demography(TwoEpochC_true_demography_file_path))
    TwoEpochC_true_demography_nu = c(TwoEpochC_true_demography_nu, nu_from_demography(TwoEpochC_true_demography_file_path))
    TwoEpochC_true_demography_tau = c(TwoEpochC_true_demography_tau, tau_from_demography(TwoEpochC_true_demography_file_path))
  }
}

TwoEpochC_AIC_df = data.frame(TwoEpochC_one_epoch_AIC, TwoEpochC_two_epoch_AIC, TwoEpochC_three_epoch_AIC, TwoEpochC_three_epoch_AIC)
#TwoEpochC_AIC_df = data.frame(TwoEpochC_two_epoch_AIC, TwoEpochC_three_epoch_AIC, TwoEpochC_true_demography_AIC)
# Reshape the data from wide to long format
TwoEpochC_df_long <- tidyr::gather(TwoEpochC_AIC_df, key = "Epoch", value = "AIC", TwoEpochC_one_epoch_AIC:TwoEpochC_three_epoch_AIC)
#TwoEpochC_df_long <- tidyr::gather(TwoEpochC_AIC_df, key = "Model", value = "AIC", TwoEpochC_two_epoch_AIC:TwoEpochC_true_demography_AIC)

# Increase the x-axis index by 4
TwoEpochC_df_long$Index <- rep(c(10, 20, 30, 50, 100, 150, 200, 300, 500, 700), times = 3)

# Create the line plot with ggplot2
ggplot(TwoEpochC_df_long, aes(x = Index, y = AIC, color = Epoch)) +
  geom_line() +
  geom_point() +
  labs(title = "Simulated 2EpC AIC values by sample size",
       x = "Sample Size",
       y = "AIC") +
  scale_y_log10() +
  scale_x_continuous(breaks=TwoEpochC_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('One-epoch', 'Three-epoch', 'Two-epoch')) +
  theme_bw()

# ggplot(TwoEpochC_df_long, aes(x = Index, y = AIC, color = Model)) +
#   geom_line() +
#   geom_point() +
#   labs(title = "Simulated 2EpC AIC values by sample size",
#        x = "Sample Size",
#        y = "AIC") +
#   scale_y_log10() +
#   scale_x_continuous(breaks=TwoEpochC_df_long$Index) +
#   scale_color_manual(values = c("green", "red", 'black'),
#     label=c('Three-epoch', 'Two-epoch', 'True demography')) +
#   theme_bw()

# compare_two_three_true_proportional_sfs_cutoff(this_empirical_sfs,
#   this_two_epoch_sfs,
#   this_three_epoch_sfs,
#   this_true_demography_sfs) +
#   ggtitle('Comparison of inferred and modeled SFSs, n=700')

TwoEpochC_lambda_two_one = 2 * (TwoEpochC_two_epoch_LL - TwoEpochC_one_epoch_LL)
TwoEpochC_lambda_three_one = 2 * (TwoEpochC_three_epoch_LL - TwoEpochC_one_epoch_LL)
TwoEpochC_lambda_three_two = 2 * (TwoEpochC_three_epoch_LL - TwoEpochC_two_epoch_LL)

TwoEpochC_lambda_df = data.frame(TwoEpochC_lambda_two_one, TwoEpochC_lambda_three_one, TwoEpochC_lambda_three_two)
# Reshape the data from wide to long format
TwoEpochC_df_long_lambda <- tidyr::gather(TwoEpochC_lambda_df, key = "Full_vs_Null", value = "Lambda", TwoEpochC_lambda_two_one:TwoEpochC_lambda_three_two)
# Increase the x-axis index by 4
TwoEpochC_df_long_lambda$Index <- rep(c(10, 20, 30, 50, 100, 150, 200, 300, 500, 700), times = 3)

# Create the line plot with ggplot2
ggplot(TwoEpochC_df_long_lambda, aes(x = Index, y = Lambda, color = Full_vs_Null)) +
  geom_line() +
  geom_point() +
  labs(title = "Simulated 2EpC Lambda values by sample size",
       x = "Sample Size",
       y = "2 * Lambda") +
  # scale_y_log10() +
  scale_x_continuous(breaks=TwoEpochC_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('Three vs. One', 'Three vs. Two', 'Two vs. One')) +
  theme_bw()

# Create the line plot with ggplot2
ggplot(TwoEpochC_df_long_lambda, aes(x = Index, y = Lambda, color = Full_vs_Null)) +
  geom_line() +
  geom_point() +
  labs(title = "Simulated 2EpC Lambda values by sample size",
       x = "Sample Size",
       y = "2 * Lambda") +
  # scale_y_log10() +
  scale_x_continuous(breaks=TwoEpochC_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('Three vs. One', 'Three vs. Two', 'Two vs. One')) +
  theme_bw() +
  ylim(-5, 10)

TwoEpochC_one_epoch_residual = c()
TwoEpochC_two_epoch_residual = c()
TwoEpochC_three_epoch_residual = c()

for (i in 1:10) {
  TwoEpochC_one_epoch_residual = c(TwoEpochC_one_epoch_residual, compute_residual(unlist(TwoEpochC_empirical_file_list[i]), unlist(TwoEpochC_one_epoch_file_list[i])))
  TwoEpochC_two_epoch_residual = c(TwoEpochC_two_epoch_residual, compute_residual(unlist(TwoEpochC_empirical_file_list[i]), unlist(TwoEpochC_two_epoch_file_list[i])))
  TwoEpochC_three_epoch_residual = c(TwoEpochC_three_epoch_residual, compute_residual(unlist(TwoEpochC_empirical_file_list[i]), unlist(TwoEpochC_three_epoch_file_list[i])))
}

TwoEpochC_residual_df = data.frame(TwoEpochC_one_epoch_residual, TwoEpochC_two_epoch_residual, TwoEpochC_three_epoch_residual)
# Reshape the data from wide to long format
TwoEpochC_df_long_residual <- tidyr::gather(TwoEpochC_residual_df, key = "Epoch", value = "residual", TwoEpochC_one_epoch_residual:TwoEpochC_three_epoch_residual)

# Increase the x-axis index by 4
TwoEpochC_df_long_residual$Index <- rep(c(10, 20, 30, 50, 100, 150, 200, 300, 500, 700), times = 3)

# Create the line plot with ggplot2
ggplot(TwoEpochC_df_long_residual, aes(x = Index, y = residual, color = Epoch)) +
  geom_line() +
  geom_point() +
  labs(title = "2EpC residual values by sample size",
       x = "Sample Size",
       y = "Residual") +
  scale_y_log10() +
  scale_x_continuous(breaks=TwoEpochC_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('One-epoch', 'Three-epoch', 'Two-epoch')) +
  theme_bw()

ggplot(TwoEpochC_df_long, aes(x = Index, y = AIC, color = Epoch)) +
  geom_line(linetype=3) +
  geom_point() +
  labs(title = "Simulated 2EpC AIC and residual by sample size",
       x = "Sample Size",
       y = "AIC") +
  scale_y_log10(sec.axis = sec_axis(~.*1, name="Residual")) +
  scale_x_continuous(breaks=TwoEpochC_df_long$Index) +
  geom_line(data=TwoEpochC_df_long_residual, aes(x = Index, y = residual*1, color = Epoch)) +
  scale_color_manual(values = c("blue", "orange", "green", "violet", "red", "seagreen"),
    label=c('One-epoch AIC', 'One-epoch residual',
      'Three-epoch AIC', 'Three-epoch residual',
      'Two-epoch AIC', 'Two-epoch residual')) +
  theme_bw()

# Tennessen_2EpC population genetic constants

TwoEpochC_mu = 1.5E-8

# NAnc = theta / (4 * allele_sum * mu)
# generations = 2 * tau * theta / (4 * mu * allele_sum)
# NCurr = nu * NAnc
# generations_b = 2 * tauB * theta / (4 * mu * allele_sum)
# generations_f = 2 * tauF * theta / (4 * mu * allele_sum)
# NBottle = nuB * NAnc
# NSince = nuF * NAnc

TwoEpochC_true_NAnc = 10000
TwoEpochC_true_NCurr = 5000
TwoEpochC_true_Time = 2000

TwoEpochC_one_epoch_NAnc = TwoEpochC_one_epoch_theta / (4 * TwoEpochC_one_epoch_allele_sum * TwoEpochC_mu)
TwoEpochC_two_epoch_NAnc = TwoEpochC_two_epoch_theta / (4 * TwoEpochC_two_epoch_allele_sum * TwoEpochC_mu)
TwoEpochC_two_epoch_NCurr = TwoEpochC_two_epoch_nu * TwoEpochC_two_epoch_NAnc
TwoEpochC_two_epoch_Time = 2 * TwoEpochC_two_epoch_tau * TwoEpochC_two_epoch_theta / (4 * TwoEpochC_mu * TwoEpochC_two_epoch_allele_sum)
TwoEpochC_three_epoch_NAnc = TwoEpochC_three_epoch_theta / (4 * TwoEpochC_three_epoch_allele_sum * TwoEpochC_mu)
TwoEpochC_three_epoch_NBottle = TwoEpochC_three_epoch_nuB * TwoEpochC_three_epoch_NAnc
TwoEpochC_three_epoch_NCurr = TwoEpochC_three_epoch_nuF * TwoEpochC_three_epoch_NAnc
TwoEpochC_three_epoch_TimeBottleEnd = 2 * TwoEpochC_three_epoch_tauF * TwoEpochC_three_epoch_theta / (4 * TwoEpochC_mu * TwoEpochC_three_epoch_allele_sum)
TwoEpochC_three_epoch_TimeBottleStart = 2 * TwoEpochC_three_epoch_tauB * TwoEpochC_three_epoch_theta / (4 * TwoEpochC_mu * TwoEpochC_three_epoch_allele_sum) + TwoEpochC_three_epoch_TimeBottleEnd
TwoEpochC_three_epoch_TimeTotal = TwoEpochC_three_epoch_TimeBottleStart + TwoEpochC_three_epoch_TimeBottleEnd

max_time = max(TwoEpochC_two_epoch_Time, TwoEpochC_three_epoch_TimeTotal, TwoEpochC_true_Time) * 1.1
two_epoch_max_time = max(TwoEpochC_two_epoch_Time, TwoEpochC_true_Time) * 1.1
three_epoch_max_time = max(TwoEpochC_three_epoch_TimeTotal)

TwoEpochC_two_epoch_max_time = rep(two_epoch_max_time, 10)
TwoEpochC_two_epoch_current_time = rep(0, 10)

TwoEpochC_true_demography = data.frame(TwoEpochC_true_NAnc, TwoEpochC_two_epoch_max_time,
  TwoEpochC_true_NCurr, TwoEpochC_true_Time,
  TwoEpochC_true_NCurr, TwoEpochC_two_epoch_current_time)

# TwoEpochC_two_epoch_max_time = rep(2E4, 10)
TwoEpochC_two_epoch_current_time = rep(0, 10)
TwoEpochC_two_epoch_demography = data.frame(TwoEpochC_two_epoch_NAnc, TwoEpochC_two_epoch_max_time, 
  TwoEpochC_two_epoch_NCurr, TwoEpochC_two_epoch_Time, 
  TwoEpochC_two_epoch_NCurr, TwoEpochC_two_epoch_current_time)

# TwoEpochC_three_epoch_max_time = rep(100000000, 10)
# TwoEpochC_three_epoch_max_time = rep(5E6, 10)
TwoEpochC_three_epoch_max_time = rep(three_epoch_max_time, 10)
TwoEpochC_three_epoch_current_time = rep(0, 10)
TwoEpochC_three_epoch_demography = data.frame(TwoEpochC_three_epoch_NAnc, TwoEpochC_three_epoch_max_time,
  TwoEpochC_three_epoch_NBottle, TwoEpochC_three_epoch_TimeBottleStart,
  TwoEpochC_three_epoch_NCurr, TwoEpochC_three_epoch_TimeBottleEnd,
  TwoEpochC_three_epoch_NCurr, TwoEpochC_three_epoch_current_time)

TwoEpochC_true_NEffective_params = c(TwoEpochC_true_demography[1, 1], TwoEpochC_true_demography[1, 3], TwoEpochC_true_demography[1, 5])
TwoEpochC_true_Time_params = c(-TwoEpochC_true_demography[1, 2], -TwoEpochC_true_demography[1, 4], TwoEpochC_true_demography[1, 6])
TwoEpochC_true_demography_params = data.frame(TwoEpochC_true_Time_params, TwoEpochC_true_NEffective_params)

TwoEpochC_two_epoch_NEffective_10 = c(TwoEpochC_two_epoch_demography[1, 1], TwoEpochC_two_epoch_demography[1, 3], TwoEpochC_two_epoch_demography[1, 5])
TwoEpochC_two_epoch_Time_10 = c(-TwoEpochC_two_epoch_demography[1, 2], -TwoEpochC_two_epoch_demography[1, 4], TwoEpochC_two_epoch_demography[1, 6])
TwoEpochC_two_epoch_demography_10 = data.frame(TwoEpochC_two_epoch_Time_10, TwoEpochC_two_epoch_NEffective_10)
TwoEpochC_two_epoch_NEffective_20 = c(TwoEpochC_two_epoch_demography[2, 1], TwoEpochC_two_epoch_demography[2, 3], TwoEpochC_two_epoch_demography[2, 5])
TwoEpochC_two_epoch_Time_20 = c(-TwoEpochC_two_epoch_demography[2, 2], -TwoEpochC_two_epoch_demography[2, 4], TwoEpochC_two_epoch_demography[2, 6])
TwoEpochC_two_epoch_demography_20 = data.frame(TwoEpochC_two_epoch_Time_20, TwoEpochC_two_epoch_NEffective_20)
TwoEpochC_two_epoch_NEffective_30 = c(TwoEpochC_two_epoch_demography[3, 1], TwoEpochC_two_epoch_demography[3, 3], TwoEpochC_two_epoch_demography[3, 5])
TwoEpochC_two_epoch_Time_30 = c(-TwoEpochC_two_epoch_demography[3, 2], -TwoEpochC_two_epoch_demography[3, 4], TwoEpochC_two_epoch_demography[3, 6])
TwoEpochC_two_epoch_demography_30 = data.frame(TwoEpochC_two_epoch_Time_30, TwoEpochC_two_epoch_NEffective_30)
TwoEpochC_two_epoch_NEffective_50 = c(TwoEpochC_two_epoch_demography[4, 1], TwoEpochC_two_epoch_demography[4, 3], TwoEpochC_two_epoch_demography[4, 5])
TwoEpochC_two_epoch_Time_50 = c(-TwoEpochC_two_epoch_demography[4, 2], -TwoEpochC_two_epoch_demography[4, 4], TwoEpochC_two_epoch_demography[4, 6])
TwoEpochC_two_epoch_demography_50 = data.frame(TwoEpochC_two_epoch_Time_50, TwoEpochC_two_epoch_NEffective_50)
TwoEpochC_two_epoch_NEffective_100 = c(TwoEpochC_two_epoch_demography[5, 1], TwoEpochC_two_epoch_demography[5, 3], TwoEpochC_two_epoch_demography[5, 5])
TwoEpochC_two_epoch_Time_100 = c(-TwoEpochC_two_epoch_demography[5, 2], -TwoEpochC_two_epoch_demography[5, 4], TwoEpochC_two_epoch_demography[5, 6])
TwoEpochC_two_epoch_demography_100 = data.frame(TwoEpochC_two_epoch_Time_100, TwoEpochC_two_epoch_NEffective_100)
TwoEpochC_two_epoch_NEffective_150 = c(TwoEpochC_two_epoch_demography[6, 1], TwoEpochC_two_epoch_demography[6, 3], TwoEpochC_two_epoch_demography[6, 5])
TwoEpochC_two_epoch_Time_150 = c(-TwoEpochC_two_epoch_demography[6, 2], -TwoEpochC_two_epoch_demography[6, 4], TwoEpochC_two_epoch_demography[6, 6])
TwoEpochC_two_epoch_demography_150 = data.frame(TwoEpochC_two_epoch_Time_150, TwoEpochC_two_epoch_NEffective_150)
TwoEpochC_two_epoch_NEffective_200 = c(TwoEpochC_two_epoch_demography[7, 1], TwoEpochC_two_epoch_demography[7, 3], TwoEpochC_two_epoch_demography[7, 5])
TwoEpochC_two_epoch_Time_200 = c(-TwoEpochC_two_epoch_demography[7, 2], -TwoEpochC_two_epoch_demography[7, 4], TwoEpochC_two_epoch_demography[7, 6])
TwoEpochC_two_epoch_demography_200 = data.frame(TwoEpochC_two_epoch_Time_200, TwoEpochC_two_epoch_NEffective_200)
TwoEpochC_two_epoch_NEffective_300 = c(TwoEpochC_two_epoch_demography[8, 1], TwoEpochC_two_epoch_demography[8, 3], TwoEpochC_two_epoch_demography[8, 5])
TwoEpochC_two_epoch_Time_300 = c(-TwoEpochC_two_epoch_demography[8, 2], -TwoEpochC_two_epoch_demography[8, 4], TwoEpochC_two_epoch_demography[8, 6])
TwoEpochC_two_epoch_demography_300 = data.frame(TwoEpochC_two_epoch_Time_300, TwoEpochC_two_epoch_NEffective_300)
TwoEpochC_two_epoch_NEffective_500 = c(TwoEpochC_two_epoch_demography[9, 1], TwoEpochC_two_epoch_demography[9, 3], TwoEpochC_two_epoch_demography[9, 5])
TwoEpochC_two_epoch_Time_500 = c(-TwoEpochC_two_epoch_demography[9, 2], -TwoEpochC_two_epoch_demography[9, 4], TwoEpochC_two_epoch_demography[9, 6])
TwoEpochC_two_epoch_demography_500 = data.frame(TwoEpochC_two_epoch_Time_500, TwoEpochC_two_epoch_NEffective_500)
TwoEpochC_two_epoch_NEffective_700 = c(TwoEpochC_two_epoch_demography[10, 1], TwoEpochC_two_epoch_demography[10, 3], TwoEpochC_two_epoch_demography[10, 5])
TwoEpochC_two_epoch_Time_700 = c(-TwoEpochC_two_epoch_demography[10, 2], -TwoEpochC_two_epoch_demography[10, 4], TwoEpochC_two_epoch_demography[10, 6])
TwoEpochC_two_epoch_demography_700 = data.frame(TwoEpochC_two_epoch_Time_700, TwoEpochC_two_epoch_NEffective_700)

TwoEpochC_three_epoch_NEffective_10 = c(TwoEpochC_three_epoch_demography[1, 1], TwoEpochC_three_epoch_demography[1, 3], TwoEpochC_three_epoch_demography[1, 5], TwoEpochC_three_epoch_demography[1, 7])
TwoEpochC_three_epoch_Time_10 = c(-TwoEpochC_three_epoch_demography[1, 2], -TwoEpochC_three_epoch_demography[1, 4], -TwoEpochC_three_epoch_demography[1, 6], TwoEpochC_three_epoch_demography[1, 8])
TwoEpochC_three_epoch_demography_10 = data.frame(TwoEpochC_three_epoch_Time_10, TwoEpochC_three_epoch_NEffective_10)
TwoEpochC_three_epoch_NEffective_20 = c(TwoEpochC_three_epoch_demography[2, 1], TwoEpochC_three_epoch_demography[2, 3], TwoEpochC_three_epoch_demography[2, 5], TwoEpochC_three_epoch_demography[2, 7])
TwoEpochC_three_epoch_Time_20 = c(-TwoEpochC_three_epoch_demography[2, 2], -TwoEpochC_three_epoch_demography[2, 4], -TwoEpochC_three_epoch_demography[2, 6], TwoEpochC_three_epoch_demography[2, 8])
TwoEpochC_three_epoch_demography_20 = data.frame(TwoEpochC_three_epoch_Time_20, TwoEpochC_three_epoch_NEffective_20)
TwoEpochC_three_epoch_NEffective_30 = c(TwoEpochC_three_epoch_demography[3, 1], TwoEpochC_three_epoch_demography[3, 3], TwoEpochC_three_epoch_demography[3, 5], TwoEpochC_three_epoch_demography[3, 7])
TwoEpochC_three_epoch_Time_30 = c(-TwoEpochC_three_epoch_demography[3, 2], -TwoEpochC_three_epoch_demography[3, 4], -TwoEpochC_three_epoch_demography[3, 6], TwoEpochC_three_epoch_demography[3, 8])
TwoEpochC_three_epoch_demography_30 = data.frame(TwoEpochC_three_epoch_Time_30, TwoEpochC_three_epoch_NEffective_30)
TwoEpochC_three_epoch_NEffective_50 = c(TwoEpochC_three_epoch_demography[4, 1], TwoEpochC_three_epoch_demography[4, 3], TwoEpochC_three_epoch_demography[4, 5], TwoEpochC_three_epoch_demography[4, 7])
TwoEpochC_three_epoch_Time_50 = c(-TwoEpochC_three_epoch_demography[4, 2], -TwoEpochC_three_epoch_demography[4, 4], -TwoEpochC_three_epoch_demography[4, 6], TwoEpochC_three_epoch_demography[4, 8])
TwoEpochC_three_epoch_demography_50 = data.frame(TwoEpochC_three_epoch_Time_50, TwoEpochC_three_epoch_NEffective_50)
TwoEpochC_three_epoch_NEffective_100 = c(TwoEpochC_three_epoch_demography[5, 1], TwoEpochC_three_epoch_demography[5, 3], TwoEpochC_three_epoch_demography[5, 5], TwoEpochC_three_epoch_demography[5, 7])
TwoEpochC_three_epoch_Time_100 = c(-TwoEpochC_three_epoch_demography[5, 2], -TwoEpochC_three_epoch_demography[5, 4], -TwoEpochC_three_epoch_demography[5, 6], TwoEpochC_three_epoch_demography[5, 8])
TwoEpochC_three_epoch_demography_100 = data.frame(TwoEpochC_three_epoch_Time_100, TwoEpochC_three_epoch_NEffective_100)
TwoEpochC_three_epoch_NEffective_150 = c(TwoEpochC_three_epoch_demography[6, 1], TwoEpochC_three_epoch_demography[6, 3], TwoEpochC_three_epoch_demography[6, 5], TwoEpochC_three_epoch_demography[6, 7])
TwoEpochC_three_epoch_Time_150 = c(-TwoEpochC_three_epoch_demography[6, 2], -TwoEpochC_three_epoch_demography[6, 4], -TwoEpochC_three_epoch_demography[6, 6], TwoEpochC_three_epoch_demography[6, 8])
TwoEpochC_three_epoch_demography_150 = data.frame(TwoEpochC_three_epoch_Time_150, TwoEpochC_three_epoch_NEffective_150)
TwoEpochC_three_epoch_NEffective_200 = c(TwoEpochC_three_epoch_demography[7, 1], TwoEpochC_three_epoch_demography[7, 3], TwoEpochC_three_epoch_demography[7, 5], TwoEpochC_three_epoch_demography[7, 7])
TwoEpochC_three_epoch_Time_200 = c(-TwoEpochC_three_epoch_demography[7, 2], -TwoEpochC_three_epoch_demography[7, 4], -TwoEpochC_three_epoch_demography[7, 6], TwoEpochC_three_epoch_demography[7, 8])
TwoEpochC_three_epoch_demography_200 = data.frame(TwoEpochC_three_epoch_Time_200, TwoEpochC_three_epoch_NEffective_200)
TwoEpochC_three_epoch_NEffective_300 = c(TwoEpochC_three_epoch_demography[8, 1], TwoEpochC_three_epoch_demography[8, 3], TwoEpochC_three_epoch_demography[8, 5], TwoEpochC_three_epoch_demography[8, 7])
TwoEpochC_three_epoch_Time_300 = c(-TwoEpochC_three_epoch_demography[8, 2], -TwoEpochC_three_epoch_demography[8, 4], -TwoEpochC_three_epoch_demography[8, 6], TwoEpochC_three_epoch_demography[8, 8])
TwoEpochC_three_epoch_demography_300 = data.frame(TwoEpochC_three_epoch_Time_300, TwoEpochC_three_epoch_NEffective_300)
TwoEpochC_three_epoch_NEffective_500 = c(TwoEpochC_three_epoch_demography[9, 1], TwoEpochC_three_epoch_demography[9, 3], TwoEpochC_three_epoch_demography[9, 5], TwoEpochC_three_epoch_demography[9, 7])
TwoEpochC_three_epoch_Time_500 = c(-TwoEpochC_three_epoch_demography[9, 2], -TwoEpochC_three_epoch_demography[9, 4], -TwoEpochC_three_epoch_demography[9, 6], TwoEpochC_three_epoch_demography[9, 8])
TwoEpochC_three_epoch_demography_500 = data.frame(TwoEpochC_three_epoch_Time_500, TwoEpochC_three_epoch_NEffective_500)
TwoEpochC_three_epoch_NEffective_700 = c(TwoEpochC_three_epoch_demography[10, 1], TwoEpochC_three_epoch_demography[10, 3], TwoEpochC_three_epoch_demography[10, 5], TwoEpochC_three_epoch_demography[10, 7])
TwoEpochC_three_epoch_Time_700 = c(-TwoEpochC_three_epoch_demography[10, 2], -TwoEpochC_three_epoch_demography[10, 4], -TwoEpochC_three_epoch_demography[10, 6], TwoEpochC_three_epoch_demography[10, 8])
TwoEpochC_three_epoch_demography_700 = data.frame(TwoEpochC_three_epoch_Time_700, TwoEpochC_three_epoch_NEffective_700)

ggplot(TwoEpochC_two_epoch_demography_10, aes(TwoEpochC_two_epoch_Time_10, TwoEpochC_two_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='dashed') + 
  geom_step(data=TwoEpochC_two_epoch_demography_20, aes(TwoEpochC_two_epoch_Time_20, TwoEpochC_two_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='dashed') +
  geom_step(data=TwoEpochC_two_epoch_demography_30, aes(TwoEpochC_two_epoch_Time_30, TwoEpochC_two_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='dashed') +
  geom_step(data=TwoEpochC_two_epoch_demography_50, aes(TwoEpochC_two_epoch_Time_50, TwoEpochC_two_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='dashed') +
  geom_step(data=TwoEpochC_two_epoch_demography_100, aes(TwoEpochC_two_epoch_Time_100, TwoEpochC_two_epoch_NEffective_100, color='N=100'), linewidth=1, linetype='dashed') +
  geom_step(data=TwoEpochC_two_epoch_demography_150, aes(TwoEpochC_two_epoch_Time_150, TwoEpochC_two_epoch_NEffective_150, color='N=150'), linewidth=1, linetype='dashed') +
  geom_step(data=TwoEpochC_two_epoch_demography_200, aes(TwoEpochC_two_epoch_Time_200, TwoEpochC_two_epoch_NEffective_200, color='N=200'), linewidth=1, linetype='dashed') +
  geom_step(data=TwoEpochC_two_epoch_demography_300, aes(TwoEpochC_two_epoch_Time_300, TwoEpochC_two_epoch_NEffective_300, color='N=300'), linewidth=1, linetype='dashed') +
  geom_step(data=TwoEpochC_two_epoch_demography_500, aes(TwoEpochC_two_epoch_Time_500, TwoEpochC_two_epoch_NEffective_500, color='N=500'), linewidth=1, linetype='dashed') +
  geom_step(data=TwoEpochC_two_epoch_demography_700, aes(TwoEpochC_two_epoch_Time_700, TwoEpochC_two_epoch_NEffective_700, color='N=700'), linewidth=1, linetype='dashed') +
  geom_step(data=TwoEpochC_true_demography_params, aes(TwoEpochC_true_Time_params, TwoEpochC_true_NEffective_params, color='True'), linewidth=1, linetype='longdash') +
  scale_color_manual(name='Sample Size',
                     breaks=c('N=10', 'N=20', 'N=30', 'N=50', 'N=100', 'N=150', 'N=200', 'N=300', 'N=500', 'N=700'),
                     values=c('N=10'='#7f3b08',
                       'N=20'='#b35806',
                       'N=30'='#e08250',
                       'N=50'='#fdb863',
                       'N=100'='#fee0b6',
                       'N=150'='#d8daeb',
                       'N=200'='#b2abd2',
                       'N=300'='#8073ac',
                       'N=500'='#542788',
                       'N=700'='#2d004b',
                       'True'='darkgreen')) +
  theme_bw() +
  scale_y_log10() +
  ylab('Effective Population Size') +
  xlab('Time in Generations') +
  ggtitle('Simulated two-epoch contraction')

best_fit_2EpC = ggplot(TwoEpochC_two_epoch_demography_10, aes(TwoEpochC_two_epoch_Time_10, TwoEpochC_two_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='dashed') + 
  geom_step(data=TwoEpochC_two_epoch_demography_20, aes(TwoEpochC_two_epoch_Time_20, TwoEpochC_two_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='dashed') +
  geom_step(data=TwoEpochC_two_epoch_demography_30, aes(TwoEpochC_two_epoch_Time_30, TwoEpochC_two_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='dashed') +
  geom_step(data=TwoEpochC_two_epoch_demography_50, aes(TwoEpochC_two_epoch_Time_50, TwoEpochC_two_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='dashed') +
  geom_step(data=TwoEpochC_two_epoch_demography_100, aes(TwoEpochC_two_epoch_Time_100, TwoEpochC_two_epoch_NEffective_100, color='N=100'), linewidth=1, linetype='dashed') +
  geom_step(data=TwoEpochC_two_epoch_demography_150, aes(TwoEpochC_two_epoch_Time_150, TwoEpochC_two_epoch_NEffective_150, color='N=150'), linewidth=1, linetype='dashed') +
  geom_step(data=TwoEpochC_two_epoch_demography_200, aes(TwoEpochC_two_epoch_Time_200, TwoEpochC_two_epoch_NEffective_200, color='N=200'), linewidth=1, linetype='dashed') +
  geom_step(data=TwoEpochC_two_epoch_demography_300, aes(TwoEpochC_two_epoch_Time_300, TwoEpochC_two_epoch_NEffective_300, color='N=300'), linewidth=1, linetype='dashed') +
  geom_step(data=TwoEpochC_two_epoch_demography_500, aes(TwoEpochC_two_epoch_Time_500, TwoEpochC_two_epoch_NEffective_500, color='N=500'), linewidth=1, linetype='dashed') +
  geom_step(data=TwoEpochC_two_epoch_demography_700, aes(TwoEpochC_two_epoch_Time_700, TwoEpochC_two_epoch_NEffective_700, color='N=700'), linewidth=1, linetype='dashed') +
  # geom_step(data=TwoEpochC_three_epoch_demography_10, aes(TwoEpochC_three_epoch_Time_10, TwoEpochC_three_epoch_NEffective_10, color='N=10'), linewidth=1, linetype='solid') +
  # geom_step(data=TwoEpochC_three_epoch_demography_20, aes(TwoEpochC_three_epoch_Time_20, TwoEpochC_three_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='solid') +
  # geom_step(data=TwoEpochC_three_epoch_demography_30, aes(TwoEpochC_three_epoch_Time_30, TwoEpochC_three_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='solid') +
  # geom_step(data=TwoEpochC_three_epoch_demography_50, aes(TwoEpochC_three_epoch_Time_50, TwoEpochC_three_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='solid') +
  # geom_step(data=TwoEpochC_three_epoch_demography_100, aes(TwoEpochC_three_epoch_Time_100, TwoEpochC_three_epoch_NEffective_100, color='N=100'), linewidth=1, linetype='solid') +
  # geom_step(data=TwoEpochC_three_epoch_demography_150, aes(TwoEpochC_three_epoch_Time_150, TwoEpochC_three_epoch_NEffective_150, color='N=150'), linewidth=1, linetype='solid') +
  # geom_step(data=TwoEpochC_three_epoch_demography_200, aes(TwoEpochC_three_epoch_Time_200, TwoEpochC_three_epoch_NEffective_200, color='N=200'), linewidth=1, linetype='solid') +
  # geom_step(data=TwoEpochC_three_epoch_demography_300, aes(TwoEpochC_three_epoch_Time_300, TwoEpochC_three_epoch_NEffective_300, color='N=300'), linewidth=1, linetype='solid') +
  # geom_step(data=TwoEpochC_three_epoch_demography_500, aes(TwoEpochC_three_epoch_Time_500, TwoEpochC_three_epoch_NEffective_500, color='N=500'), linewidth=1, linetype='solid') +
  # geom_step(data=TwoEpochC_three_epoch_demography_700, aes(TwoEpochC_three_epoch_Time_700, TwoEpochC_three_epoch_NEffective_700, color='N=700'), linewidth=1, linetype='solid') +
  geom_step(data=TwoEpochC_true_demography_params, aes(TwoEpochC_true_Time_params, TwoEpochC_true_NEffective_params, color='True'), linewidth=1.5, linetype='longdash') +
  scale_color_manual(name='Sample Size',
                     breaks=c('N=10', 'N=20', 'N=30', 'N=50', 'N=100', 'N=150', 'N=200', 'N=300', 'N=500', 'N=700', 'True'),
                     values=c('N=10'='#7f3b08',
                       'N=20'='#b35806',
                       'N=30'='#e08250',
                       'N=50'='#fdb863',
                       'N=100'='#fee0b6',
                       'N=150'='#d8daeb',
                       'N=200'='#b2abd2',
                       'N=300'='#8073ac',
                       'N=500'='#542788',
                       'N=700'='#2d004b',
                       'True'='darkgreen')) +
  theme_bw() +
  scale_y_log10() +
  ylab('Effective Population Size') +
  xlab('Time in Generations') +
  ggtitle('Simulated 2EpC Best-fitting Demography')

best_fit_2EpC

ggplot(TwoEpochC_three_epoch_demography_10, aes(TwoEpochC_three_epoch_Time_10, TwoEpochC_three_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='solid') + 
  geom_step(data=TwoEpochC_three_epoch_demography_20, aes(TwoEpochC_three_epoch_Time_20, TwoEpochC_three_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='solid') +
  geom_step(data=TwoEpochC_three_epoch_demography_30, aes(TwoEpochC_three_epoch_Time_30, TwoEpochC_three_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='solid') +
  geom_step(data=TwoEpochC_three_epoch_demography_50, aes(TwoEpochC_three_epoch_Time_50, TwoEpochC_three_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='solid') +
  geom_step(data=TwoEpochC_three_epoch_demography_100, aes(TwoEpochC_three_epoch_Time_100, TwoEpochC_three_epoch_NEffective_100, color='N=100'), linewidth=1, linetype='solid') +
  geom_step(data=TwoEpochC_three_epoch_demography_150, aes(TwoEpochC_three_epoch_Time_150, TwoEpochC_three_epoch_NEffective_150, color='N=150'), linewidth=1, linetype='solid') +
  geom_step(data=TwoEpochC_three_epoch_demography_200, aes(TwoEpochC_three_epoch_Time_200, TwoEpochC_three_epoch_NEffective_200, color='N=200'), linewidth=1, linetype='solid') +
  geom_step(data=TwoEpochC_three_epoch_demography_300, aes(TwoEpochC_three_epoch_Time_300, TwoEpochC_three_epoch_NEffective_300, color='N=300'), linewidth=1, linetype='solid') +
  geom_step(data=TwoEpochC_three_epoch_demography_500, aes(TwoEpochC_three_epoch_Time_500, TwoEpochC_three_epoch_NEffective_500, color='N=500'), linewidth=1, linetype='solid') +
  geom_step(data=TwoEpochC_three_epoch_demography_700, aes(TwoEpochC_three_epoch_Time_700, TwoEpochC_three_epoch_NEffective_700, color='N=700'), linewidth=1, linetype='solid') +
  scale_color_manual(name='Sample Size',
                     breaks=c('N=10', 'N=20', 'N=30', 'N=50', 'N=100', 'N=150', 'N=200', 'N=300', 'N=500', 'N=700'),
                     values=c('N=10'='#7f3b08',
                       'N=20'='#b35806',
                       'N=30'='#e08250',
                       'N=50'='#fdb863',
                       'N=100'='#fee0b6',
                       'N=150'='#d8daeb',
                       'N=200'='#b2abd2',
                       'N=300'='#8073ac',
                       'N=500'='#542788',
                       'N=700'='#2d004b')) +
  theme_bw() +
  ylab('Effective Population Size') +
  xlab('Time in Generations') +
  ggtitle('Simulated 2EpC Three Epoch Demography')


# NAnc Estimate by Sample Size
sample_size = c(10, 20, 30, 50, 100, 150, 200, 300, 500, 700)

NAnc_df = data.frame(sample_size, TwoEpochC_one_epoch_NAnc, TwoEpochC_two_epoch_NAnc, TwoEpochC_three_epoch_NAnc)
NAnc_df = melt(NAnc_df, id='sample_size')

ggplot(data=NAnc_df, aes(x=sample_size, y=value, color=variable)) + geom_line() +
  xlab('Sample size') +
  ylab('Estimated ancestral effective population size') +
  ggtitle('Simulated 2EpC NAnc by sample size') +
  theme_bw() +
  guides(color=guide_legend(title="Epoch")) +
  scale_color_manual(
    labels=c('One-epoch', 'Two-epoch', 'Three-epoch'),
    values=c('red', 'blue', 'green')) +
  geom_hline(yintercept=10000, color='black', linetype='dashed') +
  scale_x_continuous(breaks=sample_size)

EUR_empirical_10 = read_input_sfs('../Analysis/1kg_EUR_10/syn_downsampled_sfs.txt')
TwoEpochC_empirical_10 = read_input_sfs('../Analysis/TwoEpochContraction_10/syn_downsampled_sfs.txt')
TwoEpochC_one_epoch_10 = sfs_from_demography('../Analysis/TwoEpochContraction_10/one_epoch_demography.txt')
TwoEpochC_two_epoch_10 = sfs_from_demography('../Analysis/TwoEpochContraction_10/two_epoch_demography.txt')
TwoEpochC_three_epoch_10 = sfs_from_demography('../Analysis/TwoEpochContraction_10/three_epoch_demography.txt')

EUR_empirical_20 = read_input_sfs('../Analysis/1kg_EUR_20/syn_downsampled_sfs.txt')
TwoEpochC_empirical_20 = read_input_sfs('../Analysis/TwoEpochContraction_20/syn_downsampled_sfs.txt')
TwoEpochC_one_epoch_20 = sfs_from_demography('../Analysis/TwoEpochContraction_20/one_epoch_demography.txt')
TwoEpochC_two_epoch_20 = sfs_from_demography('../Analysis/TwoEpochContraction_20/two_epoch_demography.txt')
TwoEpochC_three_epoch_20 = sfs_from_demography('../Analysis/TwoEpochContraction_20/three_epoch_demography.txt')

EUR_empirical_30 = read_input_sfs('../Analysis/1kg_EUR_30/syn_downsampled_sfs.txt')
TwoEpochC_empirical_30 = read_input_sfs('../Analysis/TwoEpochContraction_30/syn_downsampled_sfs.txt')
TwoEpochC_one_epoch_30 = sfs_from_demography('../Analysis/TwoEpochContraction_30/one_epoch_demography.txt')
TwoEpochC_two_epoch_30 = sfs_from_demography('../Analysis/TwoEpochContraction_30/two_epoch_demography.txt')
TwoEpochC_three_epoch_30 = sfs_from_demography('../Analysis/TwoEpochContraction_30/three_epoch_demography.txt')

EUR_empirical_50 = read_input_sfs('../Analysis/1kg_EUR_50/syn_downsampled_sfs.txt')
TwoEpochC_empirical_50 = read_input_sfs('../Analysis/TwoEpochContraction_50/syn_downsampled_sfs.txt')
TwoEpochC_one_epoch_50 = sfs_from_demography('../Analysis/TwoEpochContraction_50/one_epoch_demography.txt')
TwoEpochC_two_epoch_50 = sfs_from_demography('../Analysis/TwoEpochContraction_50/two_epoch_demography.txt')
TwoEpochC_three_epoch_50 = sfs_from_demography('../Analysis/TwoEpochContraction_50/three_epoch_demography.txt')

EUR_empirical_100 = read_input_sfs('../Analysis/1kg_EUR_100/syn_downsampled_sfs.txt')
TwoEpochC_empirical_100 = read_input_sfs('../Analysis/TwoEpochContraction_100/syn_downsampled_sfs.txt')
TwoEpochC_one_epoch_100 = sfs_from_demography('../Analysis/TwoEpochContraction_100/one_epoch_demography.txt')
TwoEpochC_two_epoch_100 = sfs_from_demography('../Analysis/TwoEpochContraction_100/two_epoch_demography.txt')
TwoEpochC_three_epoch_100 = sfs_from_demography('../Analysis/TwoEpochContraction_100/three_epoch_demography.txt')

EUR_empirical_150 = read_input_sfs('../Analysis/1kg_EUR_150/syn_downsampled_sfs.txt')
TwoEpochC_empirical_150 = read_input_sfs('../Analysis/TwoEpochContraction_150/syn_downsampled_sfs.txt')
TwoEpochC_one_epoch_150 = sfs_from_demography('../Analysis/TwoEpochContraction_150/one_epoch_demography.txt')
TwoEpochC_two_epoch_150 = sfs_from_demography('../Analysis/TwoEpochContraction_150/two_epoch_demography.txt')
TwoEpochC_three_epoch_150 = sfs_from_demography('../Analysis/TwoEpochContraction_150/three_epoch_demography.txt')

EUR_empirical_200 = read_input_sfs('../Analysis/1kg_EUR_200/syn_downsampled_sfs.txt')
TwoEpochC_empirical_200 = read_input_sfs('../Analysis/TwoEpochContraction_200/syn_downsampled_sfs.txt')
TwoEpochC_one_epoch_200 = sfs_from_demography('../Analysis/TwoEpochContraction_200/one_epoch_demography.txt')
TwoEpochC_two_epoch_200 = sfs_from_demography('../Analysis/TwoEpochContraction_200/two_epoch_demography.txt')
TwoEpochC_three_epoch_200 = sfs_from_demography('../Analysis/TwoEpochContraction_200/three_epoch_demography.txt')

EUR_empirical_300 = read_input_sfs('../Analysis/1kg_EUR_300/syn_downsampled_sfs.txt')
TwoEpochC_empirical_300 = read_input_sfs('../Analysis/TwoEpochContraction_300/syn_downsampled_sfs.txt')
TwoEpochC_one_epoch_300 = sfs_from_demography('../Analysis/TwoEpochContraction_300/one_epoch_demography.txt')
TwoEpochC_two_epoch_300 = sfs_from_demography('../Analysis/TwoEpochContraction_300/two_epoch_demography.txt')
TwoEpochC_three_epoch_300 = sfs_from_demography('../Analysis/TwoEpochContraction_300/three_epoch_demography.txt')

EUR_empirical_500 = read_input_sfs('../Analysis/1kg_EUR_500/syn_downsampled_sfs.txt')
TwoEpochC_empirical_500 = read_input_sfs('../Analysis/TwoEpochContraction_500/syn_downsampled_sfs.txt')
TwoEpochC_one_epoch_500 = sfs_from_demography('../Analysis/TwoEpochContraction_500/one_epoch_demography.txt')
TwoEpochC_two_epoch_500 = sfs_from_demography('../Analysis/TwoEpochContraction_500/two_epoch_demography.txt')
TwoEpochC_three_epoch_500 = sfs_from_demography('../Analysis/TwoEpochContraction_500/three_epoch_demography.txt')

EUR_empirical_700 = read_input_sfs('../Analysis/1kg_EUR_700/syn_downsampled_sfs.txt')
TwoEpochC_empirical_700 = read_input_sfs('../Analysis/TwoEpochContraction_700/syn_downsampled_sfs.txt')
TwoEpochC_one_epoch_700 = sfs_from_demography('../Analysis/TwoEpochContraction_700/one_epoch_demography.txt')
TwoEpochC_two_epoch_700 = sfs_from_demography('../Analysis/TwoEpochContraction_700/two_epoch_demography.txt')
TwoEpochC_three_epoch_700 = sfs_from_demography('../Analysis/TwoEpochContraction_700/three_epoch_demography.txt')

# compare_one_two_three_sfs(TwoEpochC_empirical_10, TwoEpochC_one_epoch_10, TwoEpochC_two_epoch_10, TwoEpochC_three_epoch_10) + ggtitle('TwoEpochC, sample size = 10') + 
#   compare_one_two_three_proportional_sfs(TwoEpochC_empirical_10, TwoEpochC_one_epoch_10, TwoEpochC_two_epoch_10, TwoEpochC_three_epoch_10) + 
#   plot_layout(nrow=2)
# 
# compare_one_two_three_sfs(TwoEpochC_empirical_20, TwoEpochC_one_epoch_20, TwoEpochC_two_epoch_20, TwoEpochC_three_epoch_20) + ggtitle('TwoEpochC, sample size = 20') + 
#   compare_one_two_three_proportional_sfs(TwoEpochC_empirical_20, TwoEpochC_one_epoch_20, TwoEpochC_two_epoch_20, TwoEpochC_three_epoch_20) + 
#   plot_layout(nrow=2)
# 
# compare_one_two_three_sfs(TwoEpochC_empirical_30, TwoEpochC_one_epoch_30, TwoEpochC_two_epoch_30, TwoEpochC_three_epoch_30) + ggtitle('TwoEpochC, sample size = 30') + 
#   compare_one_two_three_proportional_sfs(TwoEpochC_empirical_30, TwoEpochC_one_epoch_30, TwoEpochC_two_epoch_30, TwoEpochC_three_epoch_30) + 
#   plot_layout(nrow=2)
# 
# compare_one_two_three_sfs(TwoEpochC_empirical_50, TwoEpochC_one_epoch_50, TwoEpochC_two_epoch_50, TwoEpochC_three_epoch_50) + ggtitle('TwoEpochC, sample size = 50') + 
#   compare_one_two_three_proportional_sfs(TwoEpochC_empirical_50, TwoEpochC_one_epoch_50, TwoEpochC_two_epoch_50, TwoEpochC_three_epoch_50) + 
#   plot_layout(nrow=2)
# 
# compare_one_two_three_sfs(TwoEpochC_empirical_100, TwoEpochC_one_epoch_100, TwoEpochC_two_epoch_100, TwoEpochC_three_epoch_100) + ggtitle('TwoEpochC, sample size = 100') + 
#   compare_one_two_three_proportional_sfs(TwoEpochC_empirical_100, TwoEpochC_one_epoch_100, TwoEpochC_two_epoch_100, TwoEpochC_three_epoch_100) + 
#   plot_layout(nrow=2)
# 
# compare_one_two_three_sfs(TwoEpochC_empirical_150, TwoEpochC_one_epoch_150, TwoEpochC_two_epoch_150, TwoEpochC_three_epoch_150) + ggtitle('TwoEpochC, sample size = 150') + 
#   compare_one_two_three_proportional_sfs(TwoEpochC_empirical_150, TwoEpochC_one_epoch_150, TwoEpochC_two_epoch_150, TwoEpochC_three_epoch_150) + 
#   plot_layout(nrow=2)
# 
# compare_one_two_three_sfs(TwoEpochC_empirical_200, TwoEpochC_one_epoch_200, TwoEpochC_two_epoch_200, TwoEpochC_three_epoch_200) + ggtitle('TwoEpochC, sample size = 200') + 
#   compare_one_two_three_proportional_sfs(TwoEpochC_empirical_200, TwoEpochC_one_epoch_200, TwoEpochC_two_epoch_200, TwoEpochC_three_epoch_200) + 
#   plot_layout(nrow=2)
# 
# compare_one_two_three_sfs(TwoEpochC_empirical_300, TwoEpochC_one_epoch_300, TwoEpochC_two_epoch_300, TwoEpochC_three_epoch_300) + ggtitle('TwoEpochC, sample size = 300') + 
#   compare_one_two_three_proportional_sfs(TwoEpochC_empirical_300, TwoEpochC_one_epoch_300, TwoEpochC_two_epoch_300, TwoEpochC_three_epoch_300) + 
#   plot_layout(nrow=2)
# 
# compare_one_two_three_sfs(TwoEpochC_empirical_500, TwoEpochC_one_epoch_500, TwoEpochC_two_epoch_500, TwoEpochC_three_epoch_500) + ggtitle('TwoEpochC, sample size = 500') + 
#   compare_one_two_three_proportional_sfs(TwoEpochC_empirical_500, TwoEpochC_one_epoch_500, TwoEpochC_two_epoch_500, TwoEpochC_three_epoch_500) + 
#   plot_layout(nrow=2)
# 
# compare_one_two_three_sfs(TwoEpochC_empirical_700, TwoEpochC_one_epoch_700, TwoEpochC_two_epoch_700, TwoEpochC_three_epoch_700) + ggtitle('TwoEpochC, sample size = 700') + 
#   compare_one_two_three_proportional_sfs(TwoEpochC_empirical_700, TwoEpochC_one_epoch_700, TwoEpochC_two_epoch_700, TwoEpochC_three_epoch_700) + 
#   plot_layout(nrow=2)

compare_one_two_three_proportional_sfs_cutoff(TwoEpochC_empirical_10, TwoEpochC_one_epoch_10, TwoEpochC_two_epoch_10, TwoEpochC_three_epoch_10) + ggtitle('TwoEpochC, sample size = 10')
compare_one_two_three_proportional_sfs_cutoff(TwoEpochC_empirical_20, TwoEpochC_one_epoch_20, TwoEpochC_two_epoch_20, TwoEpochC_three_epoch_20) + ggtitle('TwoEpochC, sample size = 20')
compare_one_two_three_proportional_sfs_cutoff(TwoEpochC_empirical_30, TwoEpochC_one_epoch_30, TwoEpochC_two_epoch_30, TwoEpochC_three_epoch_30) + ggtitle('TwoEpochC, sample size = 30')
compare_one_two_three_proportional_sfs_cutoff(TwoEpochC_empirical_50, TwoEpochC_one_epoch_50, TwoEpochC_two_epoch_50, TwoEpochC_three_epoch_50) + ggtitle('TwoEpochC, sample size = 50')
compare_one_two_three_proportional_sfs_cutoff(TwoEpochC_empirical_100, TwoEpochC_one_epoch_100, TwoEpochC_two_epoch_100, TwoEpochC_three_epoch_100) + ggtitle('TwoEpochC, sample size = 100')
compare_one_two_three_proportional_sfs_cutoff(TwoEpochC_empirical_150, TwoEpochC_one_epoch_150, TwoEpochC_two_epoch_150, TwoEpochC_three_epoch_150) + ggtitle('TwoEpochC, sample size = 150')
compare_one_two_three_proportional_sfs_cutoff(TwoEpochC_empirical_200, TwoEpochC_one_epoch_200, TwoEpochC_two_epoch_200, TwoEpochC_three_epoch_200) + ggtitle('TwoEpochC, sample size = 200')
compare_one_two_three_proportional_sfs_cutoff(TwoEpochC_empirical_300, TwoEpochC_one_epoch_300, TwoEpochC_two_epoch_300, TwoEpochC_three_epoch_300) + ggtitle('TwoEpochC, sample size = 300')
compare_one_two_three_proportional_sfs_cutoff(TwoEpochC_empirical_500, TwoEpochC_one_epoch_500, TwoEpochC_two_epoch_500, TwoEpochC_three_epoch_500) + ggtitle('TwoEpochC, sample size = 500')
compare_one_two_three_proportional_sfs_cutoff(TwoEpochC_empirical_700, TwoEpochC_one_epoch_700, TwoEpochC_two_epoch_700, TwoEpochC_three_epoch_700) + ggtitle('TwoEpochC, sample size = 700')

# Simple simulations
empirical_singletons = c()
empirical_doubletons = c()
empirical_rare = c()
one_epoch_singletons = c()
one_epoch_doubletons = c()
one_epoch_rare = c()

# Loop through subdirectories and get relevant files
for (i in seq(10, 700, 10)) {
  subdirectory <- paste0("../Analysis/TwoEpochContraction_", i)
  TwoEpochC_empirical_file_path <- file.path(subdirectory, "syn_downsampled_sfs.txt")
  empirical_singletons = c(empirical_singletons, proportional_sfs(read_input_sfs(TwoEpochC_empirical_file_path))[1])
  empirical_doubletons = c(empirical_doubletons, proportional_sfs(read_input_sfs(TwoEpochC_empirical_file_path))[2])
  TwoEpochC_one_epoch_file_path <- file.path(subdirectory, "one_epoch_demography.txt")
  one_epoch_singletons = c(one_epoch_singletons, proportional_sfs(sfs_from_demography(TwoEpochC_one_epoch_file_path))[1])
  one_epoch_doubletons = c(one_epoch_doubletons, proportional_sfs(sfs_from_demography(TwoEpochC_one_epoch_file_path))[2])
}

sample_size = seq(10, 700, 10)

singletons_df = data.frame(
  "Sample size" = sample_size,
  "Empirical" = empirical_singletons,
  "One epoch" = one_epoch_singletons
)

doubletons_df = data.frame(
  "Sample size" = sample_size,
  "Empirical" = empirical_doubletons,
  "One epoch" = one_epoch_doubletons
)

single_plus_doubletons_df = data.frame(
  "Sample size" = sample_size,
  "Empirical" = empirical_singletons + empirical_doubletons,
  "One epoch" = one_epoch_singletons + one_epoch_doubletons
)

singletons_df = melt(singletons_df, id="Sample.size")
doubletons_df = melt(doubletons_df, id="Sample.size")
single_plus_doubletons_df = melt(single_plus_doubletons_df, id="Sample.size")

ggplot(singletons_df, aes(x=Sample.size, y=value, color=variable)) + geom_line() +
  theme_bw() + 
  scale_color_manual(values=c('red', 'blue'),
    labels=c('Empirical', 'One Epoch'),
    name='Demography') +
  xlab('Sample size') +
  ylab('Singleton proportion') +
  ggtitle('Proportion of TwoEpochC SFS comprised of singletons')

ggplot(doubletons_df, aes(x=Sample.size, y=value, color=variable)) + geom_line() +
  theme_bw() +
  scale_color_manual(values=c('red', 'blue'),
    labels=c('Empirical', 'One Epoch'),
    name='Demography') +
  xlab('Sample size') +
  ylab('Doubleton proportion') +
  ggtitle('Proportion of TwoEpochC SFS comprised of doubletons')

ggplot(single_plus_doubletons_df, aes(x=Sample.size, y=value, color=variable)) + geom_line() +
  theme_bw() +
  scale_color_manual(values=c('red', 'blue'),
    labels=c('Empirical', 'One Epoch'),
    name='Demography') +
  xlab('Sample size') +
  ylab('Singleton + doubleton proportion') +
  ggtitle('Proportion of TwoEpochC SFS comprised of singletons or doubletons')
