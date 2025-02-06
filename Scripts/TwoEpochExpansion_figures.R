## Tennessen simulation

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

# 2EpE 10,20,30,50,100,150,200,300,500,700
TwoEpochE_empirical_file_list = list()
TwoEpochE_one_epoch_file_list = list()
TwoEpochE_two_epoch_file_list = list()
TwoEpochE_three_epoch_file_list = list()
TwoEpochE_one_epoch_AIC = c()
TwoEpochE_one_epoch_LL = c()
TwoEpochE_one_epoch_theta = c()
TwoEpochE_one_epoch_allele_sum = c()
TwoEpochE_two_epoch_AIC = c()
TwoEpochE_two_epoch_LL = c()
TwoEpochE_two_epoch_theta = c()
TwoEpochE_two_epoch_nu = c()
TwoEpochE_two_epoch_tau = c()
TwoEpochE_two_epoch_allele_sum = c()
TwoEpochE_three_epoch_AIC = c()
TwoEpochE_three_epoch_LL = c()
TwoEpochE_three_epoch_theta = c()
TwoEpochE_three_epoch_nuB = c()
TwoEpochE_three_epoch_nuF = c()
TwoEpochE_three_epoch_tauB = c()
TwoEpochE_three_epoch_tauF = c()
TwoEpochE_three_epoch_allele_sum = c()

# Loop through subdirectories and get relevant files
for (i in c(10, 20, 30, 50, 100, 150, 200, 300, 500, 700)) {
  subdirectory <- paste0("../Analysis/TwoEpochExpansion_", i)
  TwoEpochE_empirical_file_path <- file.path(subdirectory, "syn_downsampled_sfs.txt")
  TwoEpochE_one_epoch_file_path <- file.path(subdirectory, "one_epoch_demography.txt")
  TwoEpochE_two_epoch_file_path <- file.path(subdirectory, "two_epoch_demography.txt")
  TwoEpochE_three_epoch_file_path <- file.path(subdirectory, "three_epoch_demography.txt")
  
  # Check if the file exists before attempting to read and print its contents
  if (file.exists(TwoEpochE_empirical_file_path)) {
    this_empirical_sfs = read_input_sfs(TwoEpochE_empirical_file_path)
    TwoEpochE_empirical_file_list[[subdirectory]] = this_empirical_sfs
  }
  if (file.exists(TwoEpochE_one_epoch_file_path)) {
    this_one_epoch_sfs = sfs_from_demography(TwoEpochE_one_epoch_file_path)
    TwoEpochE_one_epoch_file_list[[subdirectory]] = this_one_epoch_sfs
    TwoEpochE_one_epoch_AIC = c(TwoEpochE_one_epoch_AIC, AIC_from_demography(TwoEpochE_one_epoch_file_path))
    TwoEpochE_one_epoch_LL = c(TwoEpochE_one_epoch_LL, LL_from_demography(TwoEpochE_one_epoch_file_path))
    TwoEpochE_one_epoch_theta = c(TwoEpochE_one_epoch_theta, theta_from_demography(TwoEpochE_one_epoch_file_path))
    TwoEpochE_one_epoch_allele_sum = c(TwoEpochE_one_epoch_allele_sum, sum(this_one_epoch_sfs))
  }
  if (file.exists(TwoEpochE_two_epoch_file_path)) {
    this_two_epoch_sfs = sfs_from_demography(TwoEpochE_two_epoch_file_path)
    TwoEpochE_two_epoch_file_list[[subdirectory]] = this_two_epoch_sfs
    TwoEpochE_two_epoch_AIC = c(TwoEpochE_two_epoch_AIC, AIC_from_demography(TwoEpochE_two_epoch_file_path))
    TwoEpochE_two_epoch_LL = c(TwoEpochE_two_epoch_LL, LL_from_demography(TwoEpochE_two_epoch_file_path))
    TwoEpochE_two_epoch_theta = c(TwoEpochE_two_epoch_theta, theta_from_demography(TwoEpochE_two_epoch_file_path))
    TwoEpochE_two_epoch_nu = c(TwoEpochE_two_epoch_nu, nu_from_demography(TwoEpochE_two_epoch_file_path))
    TwoEpochE_two_epoch_tau = c(TwoEpochE_two_epoch_tau, tau_from_demography(TwoEpochE_two_epoch_file_path))
    TwoEpochE_two_epoch_allele_sum = c(TwoEpochE_two_epoch_allele_sum, sum(this_two_epoch_sfs))
  }
  if (file.exists(TwoEpochE_three_epoch_file_path)) {
    this_three_epoch_sfs = sfs_from_demography(TwoEpochE_three_epoch_file_path)
    TwoEpochE_three_epoch_file_list[[subdirectory]] = this_three_epoch_sfs
    TwoEpochE_three_epoch_AIC = c(TwoEpochE_three_epoch_AIC, AIC_from_demography(TwoEpochE_three_epoch_file_path))
    TwoEpochE_three_epoch_LL = c(TwoEpochE_three_epoch_LL, LL_from_demography(TwoEpochE_three_epoch_file_path))
    TwoEpochE_three_epoch_theta = c(TwoEpochE_three_epoch_theta, theta_from_demography(TwoEpochE_three_epoch_file_path))
    TwoEpochE_three_epoch_nuB = c(TwoEpochE_three_epoch_nuB, nuB_from_demography(TwoEpochE_three_epoch_file_path))
    TwoEpochE_three_epoch_nuF = c(TwoEpochE_three_epoch_nuF, nuF_from_demography(TwoEpochE_three_epoch_file_path))
    TwoEpochE_three_epoch_tauB = c(TwoEpochE_three_epoch_tauB, tauB_from_demography(TwoEpochE_three_epoch_file_path))
    TwoEpochE_three_epoch_tauF = c(TwoEpochE_three_epoch_tauF, tauF_from_demography(TwoEpochE_three_epoch_file_path))
    TwoEpochE_three_epoch_allele_sum = c(TwoEpochE_three_epoch_allele_sum, sum(this_three_epoch_sfs))
  }  
}

TwoEpochE_AIC_df = data.frame(TwoEpochE_one_epoch_AIC, TwoEpochE_two_epoch_AIC, TwoEpochE_three_epoch_AIC)
# Reshape the data from wide to long format
TwoEpochE_df_long <- tidyr::gather(TwoEpochE_AIC_df, key = "Epoch", value = "AIC", TwoEpochE_one_epoch_AIC:TwoEpochE_three_epoch_AIC)

# Increase the x-axis index by 4
TwoEpochE_df_long$Index <- rep(c(10, 20, 30, 50, 100, 150, 200, 300, 500, 700), times = 3)

# Create the line plot with ggplot2
ggplot(TwoEpochE_df_long, aes(x = Index, y = AIC, color = Epoch)) +
  geom_line() +
  geom_point() +
  labs(title = "Simulated 2EpE AIC values by sample size",
       x = "Sample Size",
       y = "AIC") +
  scale_y_log10() +
  scale_x_continuous(breaks=TwoEpochE_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('One-epoch', 'Three-epoch', 'Two-epoch')) +
  theme_bw()

TwoEpochE_lambda_two_one = 2 * (TwoEpochE_two_epoch_LL - TwoEpochE_one_epoch_LL)
TwoEpochE_lambda_three_one = 2 * (TwoEpochE_three_epoch_LL - TwoEpochE_one_epoch_LL)
TwoEpochE_lambda_three_two = 2 * (TwoEpochE_three_epoch_LL - TwoEpochE_two_epoch_LL)

TwoEpochE_lambda_df = data.frame(TwoEpochE_lambda_two_one, TwoEpochE_lambda_three_one, TwoEpochE_lambda_three_two)
# Reshape the data from wide to long format
TwoEpochE_df_long_lambda <- tidyr::gather(TwoEpochE_lambda_df, key = "Full_vs_Null", value = "Lambda", TwoEpochE_lambda_two_one:TwoEpochE_lambda_three_two)
# Increase the x-axis index by 4
TwoEpochE_df_long_lambda$Index <- rep(c(10, 20, 30, 50, 100, 150, 200, 300, 500, 700), times = 3)

# Create the line plot with ggplot2
ggplot(TwoEpochE_df_long_lambda, aes(x = Index, y = Lambda, color = Full_vs_Null)) +
  geom_line() +
  geom_point() +
  labs(title = "Simulated 2EpE Lambda values by sample size",
       x = "Sample Size",
       y = "2 * Lambda") +
  # scale_y_log10() +
  scale_x_continuous(breaks=TwoEpochE_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('Three vs. One', 'Three vs. Two', 'Two vs. One')) +
  theme_bw()

# Create the line plot with ggplot2
ggplot(TwoEpochE_df_long_lambda, aes(x = Index, y = Lambda, color = Full_vs_Null)) +
  geom_line() +
  geom_point() +
  labs(title = "Simulated 2EpE Lambda values by sample size",
       x = "Sample Size",
       y = "2 * Lambda") +
  # scale_y_log10() +
  scale_x_continuous(breaks=TwoEpochE_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('Three vs. One', 'Three vs. Two', 'Two vs. One')) +
  theme_bw() +
  ylim(-5, 10)

TwoEpochE_one_epoch_residual = c()
TwoEpochE_two_epoch_residual = c()
TwoEpochE_three_epoch_residual = c()

for (i in 1:10) {
  TwoEpochE_one_epoch_residual = c(TwoEpochE_one_epoch_residual, compute_residual(unlist(TwoEpochE_empirical_file_list[i]), unlist(TwoEpochE_one_epoch_file_list[i])))
  TwoEpochE_two_epoch_residual = c(TwoEpochE_two_epoch_residual, compute_residual(unlist(TwoEpochE_empirical_file_list[i]), unlist(TwoEpochE_two_epoch_file_list[i])))
  TwoEpochE_three_epoch_residual = c(TwoEpochE_three_epoch_residual, compute_residual(unlist(TwoEpochE_empirical_file_list[i]), unlist(TwoEpochE_three_epoch_file_list[i])))
}

TwoEpochE_residual_df = data.frame(TwoEpochE_one_epoch_residual, TwoEpochE_two_epoch_residual, TwoEpochE_three_epoch_residual)
# Reshape the data from wide to long format
TwoEpochE_df_long_residual <- tidyr::gather(TwoEpochE_residual_df, key = "Epoch", value = "residual", TwoEpochE_one_epoch_residual:TwoEpochE_three_epoch_residual)

# Increase the x-axis index by 4
TwoEpochE_df_long_residual$Index <- rep(c(10, 20, 30, 50, 100, 150, 200, 300, 500, 700), times = 3)

# Create the line plot with ggplot2
ggplot(TwoEpochE_df_long_residual, aes(x = Index, y = residual, color = Epoch)) +
  geom_line() +
  geom_point() +
  labs(title = "2EpE residual values by sample size",
       x = "Sample Size",
       y = "Residual") +
  scale_y_log10() +
  scale_x_continuous(breaks=TwoEpochE_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('One-epoch', 'Three-epoch', 'Two-epoch')) +
  theme_bw()

ggplot(TwoEpochE_df_long, aes(x = Index, y = AIC, color = Epoch)) +
  geom_line(linetype=3) +
  geom_point() +
  labs(title = "Simulated 2EpE AIC and residual by sample size",
       x = "Sample Size",
       y = "AIC") +
  scale_y_log10(sec.axis = sec_axis(~.*1, name="Residual")) +
  scale_x_continuous(breaks=TwoEpochE_df_long$Index) +
  geom_line(data=TwoEpochE_df_long_residual, aes(x = Index, y = residual*1, color = Epoch)) +
  scale_color_manual(values = c("blue", "orange", "green", "violet", "red", "seagreen"),
    label=c('One-epoch AIC', 'One-epoch residual',
      'Three-epoch AIC', 'Three-epoch residual',
      'Two-epoch AIC', 'Two-epoch residual')) +
  theme_bw()

# Tennessen_2EpE population genetic constants

TwoEpochE_mu = 1.5E-8

# NAnc = theta / (4 * allele_sum * mu)
# generations = 2 * tau * theta / (4 * mu * allele_sum)
# years = generations / 365
# NCurr = nu * NAnc
# generations_b = 2 * tauB * theta / (4 * mu * allele_sum)
# generations_f = 2 * tauF * theta / (4 * mu * allele_sum)
# NBottle = nuB * NAnc
# NSince = nuF * NAnc

TwoEpochE_one_epoch_NAnc = TwoEpochE_one_epoch_theta / (4 * TwoEpochE_one_epoch_allele_sum * TwoEpochE_mu)
TwoEpochE_two_epoch_NAnc = TwoEpochE_two_epoch_theta / (4 * TwoEpochE_two_epoch_allele_sum * TwoEpochE_mu)
TwoEpochE_two_epoch_NCurr = TwoEpochE_two_epoch_nu * TwoEpochE_two_epoch_NAnc
TwoEpochE_two_epoch_Time = 2 * 25 * TwoEpochE_two_epoch_tau * TwoEpochE_two_epoch_theta / (4 * TwoEpochE_mu * TwoEpochE_two_epoch_allele_sum)
TwoEpochE_three_epoch_NAnc = TwoEpochE_three_epoch_theta / (4 * TwoEpochE_three_epoch_allele_sum * TwoEpochE_mu)
TwoEpochE_three_epoch_NBottle = TwoEpochE_three_epoch_nuB * TwoEpochE_three_epoch_NAnc
TwoEpochE_three_epoch_NCurr = TwoEpochE_three_epoch_nuF * TwoEpochE_three_epoch_NAnc
TwoEpochE_three_epoch_TimeBottleEnd = 2 * 25 * TwoEpochE_three_epoch_tauF * TwoEpochE_three_epoch_theta / (4 * TwoEpochE_mu * TwoEpochE_three_epoch_allele_sum)
TwoEpochE_three_epoch_TimeBottleStart = 2 * 25 * TwoEpochE_three_epoch_tauB * TwoEpochE_three_epoch_theta / (4 * TwoEpochE_mu * TwoEpochE_three_epoch_allele_sum) + TwoEpochE_three_epoch_TimeBottleEnd
TwoEpochE_three_epoch_TimeTotal = TwoEpochE_three_epoch_TimeBottleStart + TwoEpochE_three_epoch_TimeBottleEnd

max_time = max(TwoEpochE_two_epoch_Time, TwoEpochE_three_epoch_TimeTotal) + 1
two_epoch_max_time = max(TwoEpochE_two_epoch_Time)
three_epoch_max_time = max(TwoEpochE_three_epoch_TimeTotal)

TwoEpochE_two_epoch_max_time = rep(two_epoch_max_time, 10)
# TwoEpochE_two_epoch_max_time = rep(2E4, 10)
TwoEpochE_two_epoch_current_time = rep(0, 10)
TwoEpochE_two_epoch_demography = data.frame(TwoEpochE_two_epoch_NAnc, TwoEpochE_two_epoch_max_time, 
  TwoEpochE_two_epoch_NCurr, TwoEpochE_two_epoch_Time, 
  TwoEpochE_two_epoch_NCurr, TwoEpochE_two_epoch_current_time)

# TwoEpochE_three_epoch_max_time = rep(100000000, 10)
# TwoEpochE_three_epoch_max_time = rep(5E6, 10)
TwoEpochE_three_epoch_max_time = rep(three_epoch_max_time, 10)
TwoEpochE_three_epoch_current_time = rep(0, 10)
TwoEpochE_three_epoch_demography = data.frame(TwoEpochE_three_epoch_NAnc, TwoEpochE_three_epoch_max_time,
  TwoEpochE_three_epoch_NBottle, TwoEpochE_three_epoch_TimeBottleStart,
  TwoEpochE_three_epoch_NCurr, TwoEpochE_three_epoch_TimeBottleEnd,
  TwoEpochE_three_epoch_NCurr, TwoEpochE_three_epoch_current_time)

TwoEpochE_two_epoch_NEffective_10 = c(TwoEpochE_two_epoch_demography[1, 1], TwoEpochE_two_epoch_demography[1, 3], TwoEpochE_two_epoch_demography[1, 5])
TwoEpochE_two_epoch_Time_10 = c(-TwoEpochE_two_epoch_demography[1, 2], -TwoEpochE_two_epoch_demography[1, 4], TwoEpochE_two_epoch_demography[1, 6])
TwoEpochE_two_epoch_demography_10 = data.frame(TwoEpochE_two_epoch_Time_10, TwoEpochE_two_epoch_NEffective_10)
TwoEpochE_two_epoch_NEffective_20 = c(TwoEpochE_two_epoch_demography[2, 1], TwoEpochE_two_epoch_demography[2, 3], TwoEpochE_two_epoch_demography[2, 5])
TwoEpochE_two_epoch_Time_20 = c(-TwoEpochE_two_epoch_demography[2, 2], -TwoEpochE_two_epoch_demography[2, 4], TwoEpochE_two_epoch_demography[2, 6])
TwoEpochE_two_epoch_demography_20 = data.frame(TwoEpochE_two_epoch_Time_20, TwoEpochE_two_epoch_NEffective_20)
TwoEpochE_two_epoch_NEffective_30 = c(TwoEpochE_two_epoch_demography[3, 1], TwoEpochE_two_epoch_demography[3, 3], TwoEpochE_two_epoch_demography[3, 5])
TwoEpochE_two_epoch_Time_30 = c(-TwoEpochE_two_epoch_demography[3, 2], -TwoEpochE_two_epoch_demography[3, 4], TwoEpochE_two_epoch_demography[3, 6])
TwoEpochE_two_epoch_demography_30 = data.frame(TwoEpochE_two_epoch_Time_30, TwoEpochE_two_epoch_NEffective_30)
TwoEpochE_two_epoch_NEffective_50 = c(TwoEpochE_two_epoch_demography[4, 1], TwoEpochE_two_epoch_demography[4, 3], TwoEpochE_two_epoch_demography[4, 5])
TwoEpochE_two_epoch_Time_50 = c(-TwoEpochE_two_epoch_demography[4, 2], -TwoEpochE_two_epoch_demography[4, 4], TwoEpochE_two_epoch_demography[4, 6])
TwoEpochE_two_epoch_demography_50 = data.frame(TwoEpochE_two_epoch_Time_50, TwoEpochE_two_epoch_NEffective_50)
TwoEpochE_two_epoch_NEffective_100 = c(TwoEpochE_two_epoch_demography[5, 1], TwoEpochE_two_epoch_demography[5, 3], TwoEpochE_two_epoch_demography[5, 5])
TwoEpochE_two_epoch_Time_100 = c(-TwoEpochE_two_epoch_demography[5, 2], -TwoEpochE_two_epoch_demography[5, 4], TwoEpochE_two_epoch_demography[5, 6])
TwoEpochE_two_epoch_demography_100 = data.frame(TwoEpochE_two_epoch_Time_100, TwoEpochE_two_epoch_NEffective_100)
TwoEpochE_two_epoch_NEffective_150 = c(TwoEpochE_two_epoch_demography[6, 1], TwoEpochE_two_epoch_demography[6, 3], TwoEpochE_two_epoch_demography[6, 5])
TwoEpochE_two_epoch_Time_150 = c(-TwoEpochE_two_epoch_demography[6, 2], -TwoEpochE_two_epoch_demography[6, 4], TwoEpochE_two_epoch_demography[6, 6])
TwoEpochE_two_epoch_demography_150 = data.frame(TwoEpochE_two_epoch_Time_150, TwoEpochE_two_epoch_NEffective_150)
TwoEpochE_two_epoch_NEffective_200 = c(TwoEpochE_two_epoch_demography[7, 1], TwoEpochE_two_epoch_demography[7, 3], TwoEpochE_two_epoch_demography[7, 5])
TwoEpochE_two_epoch_Time_200 = c(-TwoEpochE_two_epoch_demography[7, 2], -TwoEpochE_two_epoch_demography[7, 4], TwoEpochE_two_epoch_demography[7, 6])
TwoEpochE_two_epoch_demography_200 = data.frame(TwoEpochE_two_epoch_Time_200, TwoEpochE_two_epoch_NEffective_200)
TwoEpochE_two_epoch_NEffective_300 = c(TwoEpochE_two_epoch_demography[8, 1], TwoEpochE_two_epoch_demography[8, 3], TwoEpochE_two_epoch_demography[8, 5])
TwoEpochE_two_epoch_Time_300 = c(-TwoEpochE_two_epoch_demography[8, 2], -TwoEpochE_two_epoch_demography[8, 4], TwoEpochE_two_epoch_demography[8, 6])
TwoEpochE_two_epoch_demography_300 = data.frame(TwoEpochE_two_epoch_Time_300, TwoEpochE_two_epoch_NEffective_300)
TwoEpochE_two_epoch_NEffective_500 = c(TwoEpochE_two_epoch_demography[9, 1], TwoEpochE_two_epoch_demography[9, 3], TwoEpochE_two_epoch_demography[9, 5])
TwoEpochE_two_epoch_Time_500 = c(-TwoEpochE_two_epoch_demography[9, 2], -TwoEpochE_two_epoch_demography[9, 4], TwoEpochE_two_epoch_demography[9, 6])
TwoEpochE_two_epoch_demography_500 = data.frame(TwoEpochE_two_epoch_Time_500, TwoEpochE_two_epoch_NEffective_500)
TwoEpochE_two_epoch_NEffective_700 = c(TwoEpochE_two_epoch_demography[10, 1], TwoEpochE_two_epoch_demography[10, 3], TwoEpochE_two_epoch_demography[10, 5])
TwoEpochE_two_epoch_Time_700 = c(-TwoEpochE_two_epoch_demography[10, 2], -TwoEpochE_two_epoch_demography[10, 4], TwoEpochE_two_epoch_demography[10, 6])
TwoEpochE_two_epoch_demography_700 = data.frame(TwoEpochE_two_epoch_Time_700, TwoEpochE_two_epoch_NEffective_700)

TwoEpochE_three_epoch_NEffective_10 = c(TwoEpochE_three_epoch_demography[1, 1], TwoEpochE_three_epoch_demography[1, 3], TwoEpochE_three_epoch_demography[1, 5], TwoEpochE_three_epoch_demography[1, 7])
TwoEpochE_three_epoch_Time_10 = c(-TwoEpochE_three_epoch_demography[1, 2], -TwoEpochE_three_epoch_demography[1, 4], -TwoEpochE_three_epoch_demography[1, 6], TwoEpochE_three_epoch_demography[1, 8])
TwoEpochE_three_epoch_demography_10 = data.frame(TwoEpochE_three_epoch_Time_10, TwoEpochE_three_epoch_NEffective_10)
TwoEpochE_three_epoch_NEffective_20 = c(TwoEpochE_three_epoch_demography[2, 1], TwoEpochE_three_epoch_demography[2, 3], TwoEpochE_three_epoch_demography[2, 5], TwoEpochE_three_epoch_demography[2, 7])
TwoEpochE_three_epoch_Time_20 = c(-TwoEpochE_three_epoch_demography[2, 2], -TwoEpochE_three_epoch_demography[2, 4], -TwoEpochE_three_epoch_demography[2, 6], TwoEpochE_three_epoch_demography[2, 8])
TwoEpochE_three_epoch_demography_20 = data.frame(TwoEpochE_three_epoch_Time_20, TwoEpochE_three_epoch_NEffective_20)
TwoEpochE_three_epoch_NEffective_30 = c(TwoEpochE_three_epoch_demography[3, 1], TwoEpochE_three_epoch_demography[3, 3], TwoEpochE_three_epoch_demography[3, 5], TwoEpochE_three_epoch_demography[3, 7])
TwoEpochE_three_epoch_Time_30 = c(-TwoEpochE_three_epoch_demography[3, 2], -TwoEpochE_three_epoch_demography[3, 4], -TwoEpochE_three_epoch_demography[3, 6], TwoEpochE_three_epoch_demography[3, 8])
TwoEpochE_three_epoch_demography_30 = data.frame(TwoEpochE_three_epoch_Time_30, TwoEpochE_three_epoch_NEffective_30)
TwoEpochE_three_epoch_NEffective_50 = c(TwoEpochE_three_epoch_demography[4, 1], TwoEpochE_three_epoch_demography[4, 3], TwoEpochE_three_epoch_demography[4, 5], TwoEpochE_three_epoch_demography[4, 7])
TwoEpochE_three_epoch_Time_50 = c(-TwoEpochE_three_epoch_demography[4, 2], -TwoEpochE_three_epoch_demography[4, 4], -TwoEpochE_three_epoch_demography[4, 6], TwoEpochE_three_epoch_demography[4, 8])
TwoEpochE_three_epoch_demography_50 = data.frame(TwoEpochE_three_epoch_Time_50, TwoEpochE_three_epoch_NEffective_50)
TwoEpochE_three_epoch_NEffective_100 = c(TwoEpochE_three_epoch_demography[5, 1], TwoEpochE_three_epoch_demography[5, 3], TwoEpochE_three_epoch_demography[5, 5], TwoEpochE_three_epoch_demography[5, 7])
TwoEpochE_three_epoch_Time_100 = c(-TwoEpochE_three_epoch_demography[5, 2], -TwoEpochE_three_epoch_demography[5, 4], -TwoEpochE_three_epoch_demography[5, 6], TwoEpochE_three_epoch_demography[5, 8])
TwoEpochE_three_epoch_demography_100 = data.frame(TwoEpochE_three_epoch_Time_100, TwoEpochE_three_epoch_NEffective_100)
TwoEpochE_three_epoch_NEffective_150 = c(TwoEpochE_three_epoch_demography[6, 1], TwoEpochE_three_epoch_demography[6, 3], TwoEpochE_three_epoch_demography[6, 5], TwoEpochE_three_epoch_demography[6, 7])
TwoEpochE_three_epoch_Time_150 = c(-TwoEpochE_three_epoch_demography[6, 2], -TwoEpochE_three_epoch_demography[6, 4], -TwoEpochE_three_epoch_demography[6, 6], TwoEpochE_three_epoch_demography[6, 8])
TwoEpochE_three_epoch_demography_150 = data.frame(TwoEpochE_three_epoch_Time_150, TwoEpochE_three_epoch_NEffective_150)
TwoEpochE_three_epoch_NEffective_200 = c(TwoEpochE_three_epoch_demography[7, 1], TwoEpochE_three_epoch_demography[7, 3], TwoEpochE_three_epoch_demography[7, 5], TwoEpochE_three_epoch_demography[7, 7])
TwoEpochE_three_epoch_Time_200 = c(-TwoEpochE_three_epoch_demography[7, 2], -TwoEpochE_three_epoch_demography[7, 4], -TwoEpochE_three_epoch_demography[7, 6], TwoEpochE_three_epoch_demography[7, 8])
TwoEpochE_three_epoch_demography_200 = data.frame(TwoEpochE_three_epoch_Time_200, TwoEpochE_three_epoch_NEffective_200)
TwoEpochE_three_epoch_NEffective_300 = c(TwoEpochE_three_epoch_demography[8, 1], TwoEpochE_three_epoch_demography[8, 3], TwoEpochE_three_epoch_demography[8, 5], TwoEpochE_three_epoch_demography[8, 7])
TwoEpochE_three_epoch_Time_300 = c(-TwoEpochE_three_epoch_demography[8, 2], -TwoEpochE_three_epoch_demography[8, 4], -TwoEpochE_three_epoch_demography[8, 6], TwoEpochE_three_epoch_demography[8, 8])
TwoEpochE_three_epoch_demography_300 = data.frame(TwoEpochE_three_epoch_Time_300, TwoEpochE_three_epoch_NEffective_300)
TwoEpochE_three_epoch_NEffective_500 = c(TwoEpochE_three_epoch_demography[9, 1], TwoEpochE_three_epoch_demography[9, 3], TwoEpochE_three_epoch_demography[9, 5], TwoEpochE_three_epoch_demography[9, 7])
TwoEpochE_three_epoch_Time_500 = c(-TwoEpochE_three_epoch_demography[9, 2], -TwoEpochE_three_epoch_demography[9, 4], -TwoEpochE_three_epoch_demography[9, 6], TwoEpochE_three_epoch_demography[9, 8])
TwoEpochE_three_epoch_demography_500 = data.frame(TwoEpochE_three_epoch_Time_500, TwoEpochE_three_epoch_NEffective_500)
TwoEpochE_three_epoch_NEffective_700 = c(TwoEpochE_three_epoch_demography[10, 1], TwoEpochE_three_epoch_demography[10, 3], TwoEpochE_three_epoch_demography[10, 5], TwoEpochE_three_epoch_demography[10, 7])
TwoEpochE_three_epoch_Time_700 = c(-TwoEpochE_three_epoch_demography[10, 2], -TwoEpochE_three_epoch_demography[10, 4], -TwoEpochE_three_epoch_demography[10, 6], TwoEpochE_three_epoch_demography[10, 8])
TwoEpochE_three_epoch_demography_700 = data.frame(TwoEpochE_three_epoch_Time_700, TwoEpochE_three_epoch_NEffective_700)

ggplot(TwoEpochE_two_epoch_demography_10, aes(TwoEpochE_two_epoch_Time_10, TwoEpochE_two_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='dotted') + 
  geom_step(data=TwoEpochE_two_epoch_demography_20, aes(TwoEpochE_two_epoch_Time_20, TwoEpochE_two_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='dotted') +
  geom_step(data=TwoEpochE_two_epoch_demography_30, aes(TwoEpochE_two_epoch_Time_30, TwoEpochE_two_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='dotted') +
  geom_step(data=TwoEpochE_two_epoch_demography_50, aes(TwoEpochE_two_epoch_Time_50, TwoEpochE_two_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='dotted') +
  geom_step(data=TwoEpochE_two_epoch_demography_100, aes(TwoEpochE_two_epoch_Time_100, TwoEpochE_two_epoch_NEffective_100, color='N=100'), linewidth=1, linetype='dotted') +
  geom_step(data=TwoEpochE_two_epoch_demography_150, aes(TwoEpochE_two_epoch_Time_150, TwoEpochE_two_epoch_NEffective_150, color='N=150'), linewidth=1, linetype='dotted') +
  geom_step(data=TwoEpochE_two_epoch_demography_200, aes(TwoEpochE_two_epoch_Time_200, TwoEpochE_two_epoch_NEffective_200, color='N=200'), linewidth=1, linetype='dotted') +
  geom_step(data=TwoEpochE_two_epoch_demography_300, aes(TwoEpochE_two_epoch_Time_300, TwoEpochE_two_epoch_NEffective_300, color='N=300'), linewidth=1, linetype='dotted') +
  geom_step(data=TwoEpochE_two_epoch_demography_500, aes(TwoEpochE_two_epoch_Time_500, TwoEpochE_two_epoch_NEffective_500, color='N=500'), linewidth=1, linetype='dotted') +
  geom_step(data=TwoEpochE_two_epoch_demography_700, aes(TwoEpochE_two_epoch_Time_700, TwoEpochE_two_epoch_NEffective_700, color='N=700'), linewidth=1, linetype='dotted') +
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
  xlab('Time in Years') +
  ggtitle('Simulated 2EpE two Epoch Demography')

ggplot(TwoEpochE_two_epoch_demography_20, aes(TwoEpochE_two_epoch_Time_20, TwoEpochE_two_epoch_NEffective_20, color='N=20')) + geom_step(linewidth=1, linetype='dotted') + 
  geom_step(data=TwoEpochE_two_epoch_demography_30, aes(TwoEpochE_two_epoch_Time_30, TwoEpochE_two_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='dotted') +
  geom_step(data=TwoEpochE_two_epoch_demography_50, aes(TwoEpochE_two_epoch_Time_50, TwoEpochE_two_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='dotted') +
  geom_step(data=TwoEpochE_two_epoch_demography_100, aes(TwoEpochE_two_epoch_Time_100, TwoEpochE_two_epoch_NEffective_100, color='N=100'), linewidth=1, linetype='dotted') +
  geom_step(data=TwoEpochE_two_epoch_demography_150, aes(TwoEpochE_two_epoch_Time_150, TwoEpochE_two_epoch_NEffective_150, color='N=150'), linewidth=1, linetype='dotted') +
  geom_step(data=TwoEpochE_two_epoch_demography_200, aes(TwoEpochE_two_epoch_Time_200, TwoEpochE_two_epoch_NEffective_200, color='N=200'), linewidth=1, linetype='dotted') +
  geom_step(data=TwoEpochE_two_epoch_demography_300, aes(TwoEpochE_two_epoch_Time_300, TwoEpochE_two_epoch_NEffective_300, color='N=300'), linewidth=1, linetype='dotted') +
  geom_step(data=TwoEpochE_two_epoch_demography_500, aes(TwoEpochE_two_epoch_Time_500, TwoEpochE_two_epoch_NEffective_500, color='N=500'), linewidth=1, linetype='dotted') +
  geom_step(data=TwoEpochE_two_epoch_demography_700, aes(TwoEpochE_two_epoch_Time_700, TwoEpochE_two_epoch_NEffective_700, color='N=700'), linewidth=1, linetype='dotted') +
  scale_color_manual(name='Sample Size',
                     breaks=c('N=20', 'N=30', 'N=50', 'N=100', 'N=150', 'N=200', 'N=300', 'N=500', 'N=700'),
                     values=c('N=20'='#b35806',
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
  xlab('Time in Years') +
  ggtitle('Simulated 2EpE two Epoch Demography')

best_fit_2EpE = ggplot(TwoEpochE_two_epoch_demography_10, aes(TwoEpochE_two_epoch_Time_10, TwoEpochE_two_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='dashed') + 
  geom_step(data=TwoEpochE_two_epoch_demography_20, aes(TwoEpochE_two_epoch_Time_20, TwoEpochE_two_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='dashed') +
  geom_step(data=TwoEpochE_two_epoch_demography_30, aes(TwoEpochE_two_epoch_Time_30, TwoEpochE_two_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='dashed') +
  geom_step(data=TwoEpochE_two_epoch_demography_50, aes(TwoEpochE_two_epoch_Time_50, TwoEpochE_two_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='dashed') +
  geom_step(data=TwoEpochE_two_epoch_demography_100, aes(TwoEpochE_two_epoch_Time_100, TwoEpochE_two_epoch_NEffective_100, color='N=100'), linewidth=1, linetype='dashed') +
  geom_step(data=TwoEpochE_two_epoch_demography_150, aes(TwoEpochE_two_epoch_Time_150, TwoEpochE_two_epoch_NEffective_150, color='N=150'), linewidth=1, linetype='dashed') +
  # geom_step(data=TwoEpochE_two_epoch_demography_200, aes(TwoEpochE_two_epoch_Time_200, TwoEpochE_two_epoch_NEffective_200, color='N=200'), linewidth=1, linetype='dashed') +
  # geom_step(data=TwoEpochE_two_epoch_demography_300, aes(TwoEpochE_two_epoch_Time_300, TwoEpochE_two_epoch_NEffective_300, color='N=300'), linewidth=1, linetype='dashed') +
  # geom_step(data=TwoEpochE_two_epoch_demography_500, aes(TwoEpochE_two_epoch_Time_500, TwoEpochE_two_epoch_NEffective_500, color='N=500'), linewidth=1, linetype='dashed') +
  # geom_step(data=TwoEpochE_two_epoch_demography_700, aes(TwoEpochE_two_epoch_Time_700, TwoEpochE_two_epoch_NEffective_700, color='N=700'), linewidth=1, linetype='dashed') +
  # geom_step(data=TwoEpochE_three_epoch_demography_10, aes(TwoEpochE_three_epoch_Time_10, TwoEpochE_three_epoch_NEffective_10, color='N=10'), linewidth=1, linetype='solid') +
  # geom_step(data=TwoEpochE_three_epoch_demography_20, aes(TwoEpochE_three_epoch_Time_20, TwoEpochE_three_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='solid') +
  # geom_step(data=TwoEpochE_three_epoch_demography_30, aes(TwoEpochE_three_epoch_Time_30, TwoEpochE_three_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='solid') +
  # geom_step(data=TwoEpochE_three_epoch_demography_50, aes(TwoEpochE_three_epoch_Time_50, TwoEpochE_three_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='solid') +
  # geom_step(data=TwoEpochE_three_epoch_demography_100, aes(TwoEpochE_three_epoch_Time_100, TwoEpochE_three_epoch_NEffective_100, color='N=100'), linewidth=1, linetype='solid') +
  # geom_step(data=TwoEpochE_three_epoch_demography_150, aes(TwoEpochE_three_epoch_Time_150, TwoEpochE_three_epoch_NEffective_150, color='N=150'), linewidth=1, linetype='solid') +
  geom_step(data=TwoEpochE_three_epoch_demography_200, aes(TwoEpochE_three_epoch_Time_200, TwoEpochE_three_epoch_NEffective_200, color='N=200'), linewidth=1, linetype='solid') +
  geom_step(data=TwoEpochE_three_epoch_demography_300, aes(TwoEpochE_three_epoch_Time_300, TwoEpochE_three_epoch_NEffective_300, color='N=300'), linewidth=1, linetype='solid') +
  geom_step(data=TwoEpochE_three_epoch_demography_500, aes(TwoEpochE_three_epoch_Time_500, TwoEpochE_three_epoch_NEffective_500, color='N=500'), linewidth=1, linetype='solid') +
  geom_step(data=TwoEpochE_three_epoch_demography_700, aes(TwoEpochE_three_epoch_Time_700, TwoEpochE_three_epoch_NEffective_700, color='N=700'), linewidth=1, linetype='solid') +
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
  xlab('Time in Years') +
  ggtitle('Simulated 2EpE Best-fitting Demography')

ggplot(TwoEpochE_three_epoch_demography_10, aes(TwoEpochE_three_epoch_Time_10, TwoEpochE_three_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='solid') + 
  geom_step(data=TwoEpochE_three_epoch_demography_20, aes(TwoEpochE_three_epoch_Time_20, TwoEpochE_three_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='solid') +
  geom_step(data=TwoEpochE_three_epoch_demography_30, aes(TwoEpochE_three_epoch_Time_30, TwoEpochE_three_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='solid') +
  geom_step(data=TwoEpochE_three_epoch_demography_50, aes(TwoEpochE_three_epoch_Time_50, TwoEpochE_three_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='solid') +
  geom_step(data=TwoEpochE_three_epoch_demography_100, aes(TwoEpochE_three_epoch_Time_100, TwoEpochE_three_epoch_NEffective_100, color='N=100'), linewidth=1, linetype='solid') +
  geom_step(data=TwoEpochE_three_epoch_demography_150, aes(TwoEpochE_three_epoch_Time_150, TwoEpochE_three_epoch_NEffective_150, color='N=150'), linewidth=1, linetype='solid') +
  geom_step(data=TwoEpochE_three_epoch_demography_200, aes(TwoEpochE_three_epoch_Time_200, TwoEpochE_three_epoch_NEffective_200, color='N=200'), linewidth=1, linetype='solid') +
  geom_step(data=TwoEpochE_three_epoch_demography_300, aes(TwoEpochE_three_epoch_Time_300, TwoEpochE_three_epoch_NEffective_300, color='N=300'), linewidth=1, linetype='solid') +
  geom_step(data=TwoEpochE_three_epoch_demography_500, aes(TwoEpochE_three_epoch_Time_500, TwoEpochE_three_epoch_NEffective_500, color='N=500'), linewidth=1, linetype='solid') +
  geom_step(data=TwoEpochE_three_epoch_demography_700, aes(TwoEpochE_three_epoch_Time_700, TwoEpochE_three_epoch_NEffective_700, color='N=700'), linewidth=1, linetype='solid') +
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
  xlab('Time in Years') +
  ggtitle('Simulated 2EpE Three Epoch Demography')


# NAnc Estimate by Sample Size
sample_size = c(10, 20, 30, 50, 100, 150, 200, 300, 500, 700)

NAnc_df = data.frame(sample_size, TwoEpochE_one_epoch_NAnc, TwoEpochE_two_epoch_NAnc, TwoEpochE_three_epoch_NAnc)
NAnc_df = melt(NAnc_df, id='sample_size')

ggplot(data=NAnc_df, aes(x=sample_size, y=value, color=variable)) + geom_line() +
  xlab('Sample size') +
  ylab('Estimated ancestral effective population size') +
  ggtitle('Simulated 2EpE NAnc by sample size') +
  theme_bw() +
  guides(color=guide_legend(title="Epoch")) +
  scale_color_manual(
    labels=c('One-epoch', 'Two-epoch', 'Three-epoch'),
    values=c('red', 'blue', 'green')) +
  geom_hline(yintercept=30378, color='black', linetype='dashed') +
  scale_x_continuous(breaks=sample_size)

EUR_empirical_10 = read_input_sfs('../Analysis/1kg_EUR_10/syn_downsampled_sfs.txt')
TwoEpochE_empirical_10 = read_input_sfs('../Analysis/TwoEpochExpansion_10/syn_downsampled_sfs.txt')
TwoEpochE_one_epoch_10 = sfs_from_demography('../Analysis/TwoEpochExpansion_10/one_epoch_demography.txt')
TwoEpochE_two_epoch_10 = sfs_from_demography('../Analysis/TwoEpochExpansion_10/two_epoch_demography.txt')
TwoEpochE_three_epoch_10 = sfs_from_demography('../Analysis/TwoEpochExpansion_10/three_epoch_demography.txt')

EUR_empirical_20 = read_input_sfs('../Analysis/1kg_EUR_20/syn_downsampled_sfs.txt')
TwoEpochE_empirical_20 = read_input_sfs('../Analysis/TwoEpochExpansion_20/syn_downsampled_sfs.txt')
TwoEpochE_one_epoch_20 = sfs_from_demography('../Analysis/TwoEpochExpansion_20/one_epoch_demography.txt')
TwoEpochE_two_epoch_20 = sfs_from_demography('../Analysis/TwoEpochExpansion_20/two_epoch_demography.txt')
TwoEpochE_three_epoch_20 = sfs_from_demography('../Analysis/TwoEpochExpansion_20/three_epoch_demography.txt')

EUR_empirical_30 = read_input_sfs('../Analysis/1kg_EUR_30/syn_downsampled_sfs.txt')
TwoEpochE_empirical_30 = read_input_sfs('../Analysis/TwoEpochExpansion_30/syn_downsampled_sfs.txt')
TwoEpochE_one_epoch_30 = sfs_from_demography('../Analysis/TwoEpochExpansion_30/one_epoch_demography.txt')
TwoEpochE_two_epoch_30 = sfs_from_demography('../Analysis/TwoEpochExpansion_30/two_epoch_demography.txt')
TwoEpochE_three_epoch_30 = sfs_from_demography('../Analysis/TwoEpochExpansion_30/three_epoch_demography.txt')

EUR_empirical_50 = read_input_sfs('../Analysis/1kg_EUR_50/syn_downsampled_sfs.txt')
TwoEpochE_empirical_50 = read_input_sfs('../Analysis/TwoEpochExpansion_50/syn_downsampled_sfs.txt')
TwoEpochE_one_epoch_50 = sfs_from_demography('../Analysis/TwoEpochExpansion_50/one_epoch_demography.txt')
TwoEpochE_two_epoch_50 = sfs_from_demography('../Analysis/TwoEpochExpansion_50/two_epoch_demography.txt')
TwoEpochE_three_epoch_50 = sfs_from_demography('../Analysis/TwoEpochExpansion_50/three_epoch_demography.txt')

EUR_empirical_100 = read_input_sfs('../Analysis/1kg_EUR_100/syn_downsampled_sfs.txt')
TwoEpochE_empirical_100 = read_input_sfs('../Analysis/TwoEpochExpansion_100/syn_downsampled_sfs.txt')
TwoEpochE_one_epoch_100 = sfs_from_demography('../Analysis/TwoEpochExpansion_100/one_epoch_demography.txt')
TwoEpochE_two_epoch_100 = sfs_from_demography('../Analysis/TwoEpochExpansion_100/two_epoch_demography.txt')
TwoEpochE_three_epoch_100 = sfs_from_demography('../Analysis/TwoEpochExpansion_100/three_epoch_demography.txt')

EUR_empirical_150 = read_input_sfs('../Analysis/1kg_EUR_150/syn_downsampled_sfs.txt')
TwoEpochE_empirical_150 = read_input_sfs('../Analysis/TwoEpochExpansion_150/syn_downsampled_sfs.txt')
TwoEpochE_one_epoch_150 = sfs_from_demography('../Analysis/TwoEpochExpansion_150/one_epoch_demography.txt')
TwoEpochE_two_epoch_150 = sfs_from_demography('../Analysis/TwoEpochExpansion_150/two_epoch_demography.txt')
TwoEpochE_three_epoch_150 = sfs_from_demography('../Analysis/TwoEpochExpansion_150/three_epoch_demography.txt')

EUR_empirical_200 = read_input_sfs('../Analysis/1kg_EUR_200/syn_downsampled_sfs.txt')
TwoEpochE_empirical_200 = read_input_sfs('../Analysis/TwoEpochExpansion_200/syn_downsampled_sfs.txt')
TwoEpochE_one_epoch_200 = sfs_from_demography('../Analysis/TwoEpochExpansion_200/one_epoch_demography.txt')
TwoEpochE_two_epoch_200 = sfs_from_demography('../Analysis/TwoEpochExpansion_200/two_epoch_demography.txt')
TwoEpochE_three_epoch_200 = sfs_from_demography('../Analysis/TwoEpochExpansion_200/three_epoch_demography.txt')

EUR_empirical_300 = read_input_sfs('../Analysis/1kg_EUR_300/syn_downsampled_sfs.txt')
TwoEpochE_empirical_300 = read_input_sfs('../Analysis/TwoEpochExpansion_300/syn_downsampled_sfs.txt')
TwoEpochE_one_epoch_300 = sfs_from_demography('../Analysis/TwoEpochExpansion_300/one_epoch_demography.txt')
TwoEpochE_two_epoch_300 = sfs_from_demography('../Analysis/TwoEpochExpansion_300/two_epoch_demography.txt')
TwoEpochE_three_epoch_300 = sfs_from_demography('../Analysis/TwoEpochExpansion_300/three_epoch_demography.txt')

EUR_empirical_500 = read_input_sfs('../Analysis/1kg_EUR_500/syn_downsampled_sfs.txt')
TwoEpochE_empirical_500 = read_input_sfs('../Analysis/TwoEpochExpansion_500/syn_downsampled_sfs.txt')
TwoEpochE_one_epoch_500 = sfs_from_demography('../Analysis/TwoEpochExpansion_500/one_epoch_demography.txt')
TwoEpochE_two_epoch_500 = sfs_from_demography('../Analysis/TwoEpochExpansion_500/two_epoch_demography.txt')
TwoEpochE_three_epoch_500 = sfs_from_demography('../Analysis/TwoEpochExpansion_500/three_epoch_demography.txt')

EUR_empirical_700 = read_input_sfs('../Analysis/1kg_EUR_700/syn_downsampled_sfs.txt')
TwoEpochE_empirical_700 = read_input_sfs('../Analysis/TwoEpochExpansion_700/syn_downsampled_sfs.txt')
TwoEpochE_one_epoch_700 = sfs_from_demography('../Analysis/TwoEpochExpansion_700/one_epoch_demography.txt')
TwoEpochE_two_epoch_700 = sfs_from_demography('../Analysis/TwoEpochExpansion_700/two_epoch_demography.txt')
TwoEpochE_three_epoch_700 = sfs_from_demography('../Analysis/TwoEpochExpansion_700/three_epoch_demography.txt')

compare_one_two_three_sfs(TwoEpochE_empirical_10, TwoEpochE_one_epoch_10, TwoEpochE_two_epoch_10, TwoEpochE_three_epoch_10) + ggtitle('TwoEpochE, sample size = 10') + 
  compare_one_two_three_proportional_sfs(TwoEpochE_empirical_10, TwoEpochE_one_epoch_10, TwoEpochE_two_epoch_10, TwoEpochE_three_epoch_10) + 
  plot_layout(nrow=2)

compare_one_two_three_sfs(TwoEpochE_empirical_20, TwoEpochE_one_epoch_20, TwoEpochE_two_epoch_20, TwoEpochE_three_epoch_20) + ggtitle('TwoEpochE, sample size = 20') + 
  compare_one_two_three_proportional_sfs(TwoEpochE_empirical_20, TwoEpochE_one_epoch_20, TwoEpochE_two_epoch_20, TwoEpochE_three_epoch_20) + 
  plot_layout(nrow=2)

compare_one_two_three_sfs(TwoEpochE_empirical_30, TwoEpochE_one_epoch_30, TwoEpochE_two_epoch_30, TwoEpochE_three_epoch_30) + ggtitle('TwoEpochE, sample size = 30') + 
  compare_one_two_three_proportional_sfs(TwoEpochE_empirical_30, TwoEpochE_one_epoch_30, TwoEpochE_two_epoch_30, TwoEpochE_three_epoch_30) + 
  plot_layout(nrow=2)
# 
# compare_one_two_three_sfs(TwoEpochE_empirical_50, TwoEpochE_one_epoch_50, TwoEpochE_two_epoch_50, TwoEpochE_three_epoch_50) + ggtitle('TwoEpochE, sample size = 50') + 
#   compare_one_two_three_proportional_sfs(TwoEpochE_empirical_50, TwoEpochE_one_epoch_50, TwoEpochE_two_epoch_50, TwoEpochE_three_epoch_50) + 
#   plot_layout(nrow=2)
# 
# compare_one_two_three_sfs(TwoEpochE_empirical_100, TwoEpochE_one_epoch_100, TwoEpochE_two_epoch_100, TwoEpochE_three_epoch_100) + ggtitle('TwoEpochE, sample size = 100') + 
#   compare_one_two_three_proportional_sfs(TwoEpochE_empirical_100, TwoEpochE_one_epoch_100, TwoEpochE_two_epoch_100, TwoEpochE_three_epoch_100) + 
#   plot_layout(nrow=2)
# 
# compare_one_two_three_sfs(TwoEpochE_empirical_150, TwoEpochE_one_epoch_150, TwoEpochE_two_epoch_150, TwoEpochE_three_epoch_150) + ggtitle('TwoEpochE, sample size = 150') + 
#   compare_one_two_three_proportional_sfs(TwoEpochE_empirical_150, TwoEpochE_one_epoch_150, TwoEpochE_two_epoch_150, TwoEpochE_three_epoch_150) + 
#   plot_layout(nrow=2)
# 
# compare_one_two_three_sfs(TwoEpochE_empirical_200, TwoEpochE_one_epoch_200, TwoEpochE_two_epoch_200, TwoEpochE_three_epoch_200) + ggtitle('TwoEpochE, sample size = 200') + 
#   compare_one_two_three_proportional_sfs(TwoEpochE_empirical_200, TwoEpochE_one_epoch_200, TwoEpochE_two_epoch_200, TwoEpochE_three_epoch_200) + 
#   plot_layout(nrow=2)
# 
# compare_one_two_three_sfs(TwoEpochE_empirical_300, TwoEpochE_one_epoch_300, TwoEpochE_two_epoch_300, TwoEpochE_three_epoch_300) + ggtitle('TwoEpochE, sample size = 300') + 
#   compare_one_two_three_proportional_sfs(TwoEpochE_empirical_300, TwoEpochE_one_epoch_300, TwoEpochE_two_epoch_300, TwoEpochE_three_epoch_300) + 
#   plot_layout(nrow=2)
# 
# compare_one_two_three_sfs(TwoEpochE_empirical_500, TwoEpochE_one_epoch_500, TwoEpochE_two_epoch_500, TwoEpochE_three_epoch_500) + ggtitle('TwoEpochE, sample size = 500') + 
#   compare_one_two_three_proportional_sfs(TwoEpochE_empirical_500, TwoEpochE_one_epoch_500, TwoEpochE_two_epoch_500, TwoEpochE_three_epoch_500) + 
#   plot_layout(nrow=2)
# 
# compare_one_two_three_sfs(TwoEpochE_empirical_700, TwoEpochE_one_epoch_700, TwoEpochE_two_epoch_700, TwoEpochE_three_epoch_700) + ggtitle('TwoEpochE, sample size = 700') + 
#   compare_one_two_three_proportional_sfs(TwoEpochE_empirical_700, TwoEpochE_one_epoch_700, TwoEpochE_two_epoch_700, TwoEpochE_three_epoch_700) + 
#   plot_layout(nrow=2)

compare_one_two_three_proportional_sfs_cutoff(TwoEpochE_empirical_10, TwoEpochE_one_epoch_10, TwoEpochE_two_epoch_10, TwoEpochE_three_epoch_10) + ggtitle('TwoEpochE, sample size = 10')
compare_one_two_three_proportional_sfs_cutoff(TwoEpochE_empirical_20, TwoEpochE_one_epoch_20, TwoEpochE_two_epoch_20, TwoEpochE_three_epoch_20) + ggtitle('TwoEpochE, sample size = 20')
compare_one_two_three_proportional_sfs_cutoff(TwoEpochE_empirical_30, TwoEpochE_one_epoch_30, TwoEpochE_two_epoch_30, TwoEpochE_three_epoch_30) + ggtitle('TwoEpochE, sample size = 30')
compare_one_two_three_proportional_sfs_cutoff(TwoEpochE_empirical_50, TwoEpochE_one_epoch_50, TwoEpochE_two_epoch_50, TwoEpochE_three_epoch_50) + ggtitle('TwoEpochE, sample size = 50')
compare_one_two_three_proportional_sfs_cutoff(TwoEpochE_empirical_100, TwoEpochE_one_epoch_100, TwoEpochE_two_epoch_100, TwoEpochE_three_epoch_100) + ggtitle('TwoEpochE, sample size = 100')
compare_one_two_three_proportional_sfs_cutoff(TwoEpochE_empirical_150, TwoEpochE_one_epoch_150, TwoEpochE_two_epoch_150, TwoEpochE_three_epoch_150) + ggtitle('TwoEpochE, sample size = 150')
compare_one_two_three_proportional_sfs_cutoff(TwoEpochE_empirical_200, TwoEpochE_one_epoch_200, TwoEpochE_two_epoch_200, TwoEpochE_three_epoch_200) + ggtitle('TwoEpochE, sample size = 200')
compare_one_two_three_proportional_sfs_cutoff(TwoEpochE_empirical_300, TwoEpochE_one_epoch_300, TwoEpochE_two_epoch_300, TwoEpochE_three_epoch_300) + ggtitle('TwoEpochE, sample size = 300')
compare_one_two_three_proportional_sfs_cutoff(TwoEpochE_empirical_500, TwoEpochE_one_epoch_500, TwoEpochE_two_epoch_500, TwoEpochE_three_epoch_500) + ggtitle('TwoEpochE, sample size = 500')
compare_one_two_three_proportional_sfs_cutoff(TwoEpochE_empirical_700, TwoEpochE_one_epoch_700, TwoEpochE_two_epoch_700, TwoEpochE_three_epoch_700) + ggtitle('TwoEpochE, sample size = 700')

# Simple simulations
empirical_singletons = c()
empirical_doubletons = c()
empirical_rare = c()
one_epoch_singletons = c()
one_epoch_doubletons = c()
one_epoch_rare = c()

# Loop through subdirectories and get relevant files
for (i in seq(10, 700, 10)) {
  subdirectory <- paste0("../Analysis/TwoEpochExpansion_", i)
  TwoEpochE_empirical_file_path <- file.path(subdirectory, "syn_downsampled_sfs.txt")
  empirical_singletons = c(empirical_singletons, proportional_sfs(read_input_sfs(TwoEpochE_empirical_file_path))[1])
  empirical_doubletons = c(empirical_doubletons, proportional_sfs(read_input_sfs(TwoEpochE_empirical_file_path))[2])
  TwoEpochE_one_epoch_file_path <- file.path(subdirectory, "one_epoch_demography.txt")
  one_epoch_singletons = c(one_epoch_singletons, proportional_sfs(sfs_from_demography(TwoEpochE_one_epoch_file_path))[1])
  one_epoch_doubletons = c(one_epoch_doubletons, proportional_sfs(sfs_from_demography(TwoEpochE_one_epoch_file_path))[2])
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
  ggtitle('Proportion of TwoEpochE SFS comprised of singletons')

ggplot(doubletons_df, aes(x=Sample.size, y=value, color=variable)) + geom_line() +
  theme_bw() +
  scale_color_manual(values=c('red', 'blue'),
    labels=c('Empirical', 'One Epoch'),
    name='Demography') +
  xlab('Sample size') +
  ylab('Doubleton proportion') +
  ggtitle('Proportion of TwoEpochE SFS comprised of doubletons')

ggplot(single_plus_doubletons_df, aes(x=Sample.size, y=value, color=variable)) + geom_line() +
  theme_bw() +
  scale_color_manual(values=c('red', 'blue'),
    labels=c('Empirical', 'One Epoch'),
    name='Demography') +
  xlab('Sample size') +
  ylab('Singleton + doubleton proportion') +
  ggtitle('Proportion of TwoEpochE SFS comprised of singletons or doubletons')
