## Tennessen simulation

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

global_allele_sum = 20 * 1000000

# 3EpE 10,20,30,50,100,150,200,300,500,700
ThreeEpochE_empirical_file_list = list()
ThreeEpochE_one_epoch_file_list = list()
ThreeEpochE_two_epoch_file_list = list()
ThreeEpochE_three_epoch_file_list = list()
ThreeEpochE_true_demography_file_list = list()
ThreeEpochE_one_epoch_AIC = c()
ThreeEpochE_one_epoch_LL = c()
ThreeEpochE_one_epoch_theta = c()
ThreeEpochE_one_epoch_allele_sum = global_allele_sum
ThreeEpochE_two_epoch_AIC = c()
ThreeEpochE_two_epoch_LL = c()
ThreeEpochE_two_epoch_theta = c()
ThreeEpochE_two_epoch_nu = c()
ThreeEpochE_two_epoch_tau = c()
ThreeEpochE_two_epoch_allele_sum = global_allele_sum
ThreeEpochE_three_epoch_AIC = c()
ThreeEpochE_three_epoch_LL = c()
ThreeEpochE_three_epoch_theta = c()
ThreeEpochE_three_epoch_nuB = c()
ThreeEpochE_three_epoch_nuF = c()
ThreeEpochE_three_epoch_tauB = c()
ThreeEpochE_three_epoch_tauF = c()
ThreeEpochE_three_epoch_allele_sum = global_allele_sum
ThreeEpochE_true_demography_AIC = c()
ThreeEpochE_true_demography_LL = c()
ThreeEpochE_true_demography_theta = c()
ThreeEpochE_true_demography_allele_sum = global_allele_sum
ThreeEpochE_true_demography_nu = c()
ThreeEpochE_true_demography_tau = c()

# Loop through subdirectories and get relevant files
for (i in c(10, 20, 30, 50, 100, 150, 200, 300, 500, 700)) {
  subdirectory <- paste0("../Analysis/ThreeEpochExpansion_", i)
  ThreeEpochE_empirical_file_path <- file.path(subdirectory, "syn_downsampled_sfs.txt")
  ThreeEpochE_one_epoch_file_path <- file.path(subdirectory, "one_epoch_demography.txt")
  ThreeEpochE_two_epoch_file_path <- file.path(subdirectory, "two_epoch_demography.txt")
  ThreeEpochE_three_epoch_file_path <- file.path(subdirectory, "three_epoch_demography.txt")
  ThreeEpochE_true_demography_file_path <- file.path(subdirectory, 'true_demography.txt')
  
  # Check if the file exists before attempting to read and print its contents
  if (file.exists(ThreeEpochE_empirical_file_path)) {
    this_empirical_sfs = read_input_sfs(ThreeEpochE_empirical_file_path)
    ThreeEpochE_empirical_file_list[[subdirectory]] = this_empirical_sfs
  }
  if (file.exists(ThreeEpochE_one_epoch_file_path)) {
    this_one_epoch_sfs = sfs_from_demography(ThreeEpochE_one_epoch_file_path)
    ThreeEpochE_one_epoch_file_list[[subdirectory]] = this_one_epoch_sfs
    ThreeEpochE_one_epoch_AIC = c(ThreeEpochE_one_epoch_AIC, AIC_from_demography(ThreeEpochE_one_epoch_file_path))
    ThreeEpochE_one_epoch_LL = c(ThreeEpochE_one_epoch_LL, LL_from_demography(ThreeEpochE_one_epoch_file_path))
    ThreeEpochE_one_epoch_theta = c(ThreeEpochE_one_epoch_theta, theta_from_demography(ThreeEpochE_one_epoch_file_path))
    # ThreeEpochE_one_epoch_allele_sum = c(ThreeEpochE_one_epoch_allele_sum, sum(this_one_epoch_sfs))
  }
  if (file.exists(ThreeEpochE_two_epoch_file_path)) {
    this_two_epoch_sfs = sfs_from_demography(ThreeEpochE_two_epoch_file_path)
    ThreeEpochE_two_epoch_file_list[[subdirectory]] = this_two_epoch_sfs
    ThreeEpochE_two_epoch_AIC = c(ThreeEpochE_two_epoch_AIC, AIC_from_demography(ThreeEpochE_two_epoch_file_path))
    ThreeEpochE_two_epoch_LL = c(ThreeEpochE_two_epoch_LL, LL_from_demography(ThreeEpochE_two_epoch_file_path))
    ThreeEpochE_two_epoch_theta = c(ThreeEpochE_two_epoch_theta, theta_from_demography(ThreeEpochE_two_epoch_file_path))
    ThreeEpochE_two_epoch_nu = c(ThreeEpochE_two_epoch_nu, nu_from_demography(ThreeEpochE_two_epoch_file_path))
    ThreeEpochE_two_epoch_tau = c(ThreeEpochE_two_epoch_tau, tau_from_demography(ThreeEpochE_two_epoch_file_path))
    # ThreeEpochE_two_epoch_allele_sum = c(ThreeEpochE_two_epoch_allele_sum, sum(this_two_epoch_sfs))
  }
  if (file.exists(ThreeEpochE_three_epoch_file_path)) {
    this_three_epoch_sfs = sfs_from_demography(ThreeEpochE_three_epoch_file_path)
    ThreeEpochE_three_epoch_file_list[[subdirectory]] = this_three_epoch_sfs
    ThreeEpochE_three_epoch_AIC = c(ThreeEpochE_three_epoch_AIC, AIC_from_demography(ThreeEpochE_three_epoch_file_path))
    ThreeEpochE_three_epoch_LL = c(ThreeEpochE_three_epoch_LL, LL_from_demography(ThreeEpochE_three_epoch_file_path))
    ThreeEpochE_three_epoch_theta = c(ThreeEpochE_three_epoch_theta, theta_from_demography(ThreeEpochE_three_epoch_file_path))
    ThreeEpochE_three_epoch_nuB = c(ThreeEpochE_three_epoch_nuB, nuB_from_demography(ThreeEpochE_three_epoch_file_path))
    ThreeEpochE_three_epoch_nuF = c(ThreeEpochE_three_epoch_nuF, nuF_from_demography(ThreeEpochE_three_epoch_file_path))
    ThreeEpochE_three_epoch_tauB = c(ThreeEpochE_three_epoch_tauB, tauB_from_demography(ThreeEpochE_three_epoch_file_path))
    ThreeEpochE_three_epoch_tauF = c(ThreeEpochE_three_epoch_tauF, tauF_from_demography(ThreeEpochE_three_epoch_file_path))
    # ThreeEpochE_three_epoch_allele_sum = c(ThreeEpochE_three_epoch_allele_sum, sum(this_three_epoch_sfs))
  }  
  if (file.exists(ThreeEpochE_true_demography_file_path)) {
    this_true_demography_sfs = sfs_from_demography(ThreeEpochE_true_demography_file_path)
    ThreeEpochE_true_demography_file_list[[subdirectory]] = this_true_demography_sfs
    ThreeEpochE_true_demography_AIC = c(ThreeEpochE_true_demography_AIC, AIC_from_demography(ThreeEpochE_true_demography_file_path))
    ThreeEpochE_true_demography_LL = c(ThreeEpochE_true_demography_LL, LL_from_demography(ThreeEpochE_true_demography_file_path))
    ThreeEpochE_true_demography_theta = c(ThreeEpochE_true_demography_theta, theta_from_demography(ThreeEpochE_true_demography_file_path))
    ThreeEpochE_true_demography_nu = c(ThreeEpochE_true_demography_nu, nu_from_demography(ThreeEpochE_true_demography_file_path))
    ThreeEpochE_true_demography_tau = c(ThreeEpochE_true_demography_tau, tau_from_demography(ThreeEpochE_true_demography_file_path))
  }
}

ThreeEpochE_AIC_df = data.frame(ThreeEpochE_one_epoch_AIC, ThreeEpochE_two_epoch_AIC, ThreeEpochE_three_epoch_AIC, ThreeEpochE_three_epoch_AIC)
#ThreeEpochE_AIC_df = data.frame(ThreeEpochE_two_epoch_AIC, ThreeEpochE_three_epoch_AIC, ThreeEpochE_true_demography_AIC)
# Reshape the data from wide to long format
ThreeEpochE_df_long <- tidyr::gather(ThreeEpochE_AIC_df, key = "Epoch", value = "AIC", ThreeEpochE_one_epoch_AIC:ThreeEpochE_three_epoch_AIC)
#ThreeEpochE_df_long <- tidyr::gather(ThreeEpochE_AIC_df, key = "Model", value = "AIC", ThreeEpochE_two_epoch_AIC:ThreeEpochE_true_demography_AIC)

# Increase the x-axis index by 4
ThreeEpochE_df_long$Index <- rep(c(10, 20, 30, 50, 100, 150, 200, 300, 500, 700), times = 3)

# Create the line plot with ggplot2
ggplot(ThreeEpochE_df_long, aes(x = Index, y = AIC, color = Epoch)) +
  geom_line() +
  geom_point() +
  labs(title = "Simulated 3EpE AIC values by sample size",
       x = "Sample Size",
       y = "AIC") +
  scale_y_log10() +
  scale_x_continuous(breaks=ThreeEpochE_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('One-epoch', 'Three-epoch', 'Three-epoch')) +
  theme_bw()

# ggplot(ThreeEpochE_df_long, aes(x = Index, y = AIC, color = Model)) +
#   geom_line() +
#   geom_point() +
#   labs(title = "Simulated 3EpE AIC values by sample size",
#        x = "Sample Size",
#        y = "AIC") +
#   scale_y_log10() +
#   scale_x_continuous(breaks=ThreeEpochE_df_long$Index) +
#   scale_color_manual(values = c("green", "red", 'black'),
#     label=c('Three-epoch', 'Three-epoch', 'True demography')) +
#   theme_bw()

ThreeEpochE_lambda_Three_one = 2 * (ThreeEpochE_two_epoch_LL - ThreeEpochE_one_epoch_LL)
ThreeEpochE_lambda_three_one = 2 * (ThreeEpochE_three_epoch_LL - ThreeEpochE_one_epoch_LL)
ThreeEpochE_lambda_three_Three = 2 * (ThreeEpochE_three_epoch_LL - ThreeEpochE_two_epoch_LL)

ThreeEpochE_lambda_df = data.frame(ThreeEpochE_lambda_Three_one, ThreeEpochE_lambda_three_one, ThreeEpochE_lambda_three_Three)
# Reshape the data from wide to long format
ThreeEpochE_df_long_lambda <- tidyr::gather(ThreeEpochE_lambda_df, key = "Full_vs_Null", value = "Lambda", ThreeEpochE_lambda_Three_one:ThreeEpochE_lambda_three_Three)
# Increase the x-axis index by 4
ThreeEpochE_df_long_lambda$Index <- rep(c(10, 20, 30, 50, 100, 150, 200, 300, 500, 700), times = 3)

# Create the line plot with ggplot2
ggplot(ThreeEpochE_df_long_lambda, aes(x = Index, y = Lambda, color = Full_vs_Null)) +
  geom_line() +
  geom_point() +
  labs(title = "Simulated 3EpE Lambda values by sample size",
       x = "Sample Size",
       y = "2 * Lambda") +
  # scale_y_log10() +
  scale_x_continuous(breaks=ThreeEpochE_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('Three vs. One', 'Three vs. Three', 'Three vs. One')) +
  theme_bw()

# Create the line plot with ggplot2
ggplot(ThreeEpochE_df_long_lambda, aes(x = Index, y = Lambda, color = Full_vs_Null)) +
  geom_line() +
  geom_point() +
  labs(title = "Simulated 3EpE Lambda values by sample size",
       x = "Sample Size",
       y = "2 * Lambda") +
  # scale_y_log10() +
  scale_x_continuous(breaks=ThreeEpochE_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('Three vs. One', 'Three vs. Three', 'Three vs. One')) +
  theme_bw() +
  ylim(-5, 10)

ThreeEpochE_one_epoch_residual = c()
ThreeEpochE_two_epoch_residual = c()
ThreeEpochE_three_epoch_residual = c()

for (i in 1:10) {
  ThreeEpochE_one_epoch_residual = c(ThreeEpochE_one_epoch_residual, compute_residual(unlist(ThreeEpochE_empirical_file_list[i]), unlist(ThreeEpochE_one_epoch_file_list[i])))
  ThreeEpochE_two_epoch_residual = c(ThreeEpochE_two_epoch_residual, compute_residual(unlist(ThreeEpochE_empirical_file_list[i]), unlist(ThreeEpochE_two_epoch_file_list[i])))
  ThreeEpochE_three_epoch_residual = c(ThreeEpochE_three_epoch_residual, compute_residual(unlist(ThreeEpochE_empirical_file_list[i]), unlist(ThreeEpochE_three_epoch_file_list[i])))
}

ThreeEpochE_residual_df = data.frame(ThreeEpochE_one_epoch_residual, ThreeEpochE_two_epoch_residual, ThreeEpochE_three_epoch_residual)
# Reshape the data from wide to long format
ThreeEpochE_df_long_residual <- tidyr::gather(ThreeEpochE_residual_df, key = "Epoch", value = "residual", ThreeEpochE_one_epoch_residual:ThreeEpochE_three_epoch_residual)

# Increase the x-axis index by 4
ThreeEpochE_df_long_residual$Index <- rep(c(10, 20, 30, 50, 100, 150, 200, 300, 500, 700), times = 3)

# Create the line plot with ggplot2
ggplot(ThreeEpochE_df_long_residual, aes(x = Index, y = residual, color = Epoch)) +
  geom_line() +
  geom_point() +
  labs(title = "3EpE residual values by sample size",
       x = "Sample Size",
       y = "Residual") +
  scale_y_log10() +
  scale_x_continuous(breaks=ThreeEpochE_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('One-epoch', 'Three-epoch', 'Three-epoch')) +
  theme_bw()

ggplot(ThreeEpochE_df_long, aes(x = Index, y = AIC, color = Epoch)) +
  geom_line(linetype=3) +
  geom_point() +
  labs(title = "Simulated 3EpE AIC and residual by sample size",
       x = "Sample Size",
       y = "AIC") +
  scale_y_log10(sec.axis = sec_axis(~.*1, name="Residual")) +
  scale_x_continuous(breaks=ThreeEpochE_df_long$Index) +
  geom_line(data=ThreeEpochE_df_long_residual, aes(x = Index, y = residual*1, color = Epoch)) +
  scale_color_manual(values = c("blue", "orange", "green", "violet", "red", "seagreen"),
    label=c('One-epoch AIC', 'One-epoch residual',
      'Three-epoch AIC', 'Three-epoch residual',
      'Three-epoch AIC', 'Three-epoch residual')) +
  theme_bw()

# Tennessen_3EpE population genetic constants

ThreeEpochE_mu = 1.5E-8

# NAnc = theta / (4 * allele_sum * mu)
# generations = 2 * tau * theta / (4 * mu * allele_sum)
# NCurr = nu * NAnc
# generations_b = 2 * tauB * theta / (4 * mu * allele_sum)
# generations_f = 2 * tauF * theta / (4 * mu * allele_sum)
# NBottle = nuB * NAnc
# NSince = nuF * NAnc

ThreeEpochE_true_NAnc = 10000
ThreeEpochE_true_NBottle = 20000
ThreeEpochE_true_NCurr = 40000
ThreeEpochE_true_TimeBottleEnd = 200
ThreeEpochE_true_TimeBottleStart = 2000
ThreeEpochE_true_TimeTotal = 2000

ThreeEpochE_one_epoch_NAnc = ThreeEpochE_one_epoch_theta / (4 * ThreeEpochE_one_epoch_allele_sum * ThreeEpochE_mu)
ThreeEpochE_two_epoch_NAnc = ThreeEpochE_two_epoch_theta / (4 * ThreeEpochE_two_epoch_allele_sum * ThreeEpochE_mu)
ThreeEpochE_two_epoch_NCurr = ThreeEpochE_two_epoch_nu * ThreeEpochE_two_epoch_NAnc
ThreeEpochE_two_epoch_Time = 2 * ThreeEpochE_two_epoch_tau * ThreeEpochE_two_epoch_theta / (4 * ThreeEpochE_mu * ThreeEpochE_two_epoch_allele_sum)
ThreeEpochE_three_epoch_NAnc = ThreeEpochE_three_epoch_theta / (4 * ThreeEpochE_three_epoch_allele_sum * ThreeEpochE_mu)
ThreeEpochE_three_epoch_NBottle = ThreeEpochE_three_epoch_nuB * ThreeEpochE_three_epoch_NAnc
ThreeEpochE_three_epoch_NCurr = ThreeEpochE_three_epoch_nuF * ThreeEpochE_three_epoch_NAnc
ThreeEpochE_three_epoch_TimeBottleEnd = 2 * ThreeEpochE_three_epoch_tauF * ThreeEpochE_three_epoch_theta / (4 * ThreeEpochE_mu * ThreeEpochE_three_epoch_allele_sum)
ThreeEpochE_three_epoch_TimeBottleStart = 2 * ThreeEpochE_three_epoch_tauB * ThreeEpochE_three_epoch_theta / (4 * ThreeEpochE_mu * ThreeEpochE_three_epoch_allele_sum) + ThreeEpochE_three_epoch_TimeBottleEnd
ThreeEpochE_three_epoch_TimeTotal = ThreeEpochE_three_epoch_TimeBottleStart + ThreeEpochE_three_epoch_TimeBottleEnd

max_time = 2500
two_epoch_max_time = max_time
three_epoch_max_time = max_time

ThreeEpochE_two_epoch_max_time = rep(max_time, 10)
ThreeEpochE_two_epoch_current_time = rep(0, 10)

ThreeEpochE_true_demography = data.frame(ThreeEpochE_true_NAnc, max_time,
  ThreeEpochE_true_NBottle, ThreeEpochE_true_TimeBottleStart,
  ThreeEpochE_true_NCurr, ThreeEpochE_true_TimeBottleEnd,
  ThreeEpochE_true_NCurr, ThreeEpochE_two_epoch_current_time)

ThreeEpochE_one_epoch_demography = data.frame(ThreeEpochE_one_epoch_NAnc, max_time,
  ThreeEpochE_one_epoch_NAnc, rep(0, 10))

# ThreeEpochE_two_epoch_max_time = rep(2E4, 10)
ThreeEpochE_two_epoch_current_time = rep(0, 10)
ThreeEpochE_two_epoch_demography = data.frame(ThreeEpochE_two_epoch_NAnc, ThreeEpochE_two_epoch_max_time, 
  ThreeEpochE_two_epoch_NCurr, ThreeEpochE_two_epoch_Time, 
  ThreeEpochE_two_epoch_NCurr, ThreeEpochE_two_epoch_current_time)

# ThreeEpochE_three_epoch_max_time = rep(100000000, 10)
# ThreeEpochE_three_epoch_max_time = rep(5E6, 10)
ThreeEpochE_three_epoch_max_time = rep(three_epoch_max_time, 10)
ThreeEpochE_three_epoch_current_time = rep(0, 10)
ThreeEpochE_three_epoch_demography = data.frame(ThreeEpochE_three_epoch_NAnc, ThreeEpochE_three_epoch_max_time,
  ThreeEpochE_three_epoch_NBottle, ThreeEpochE_three_epoch_TimeBottleStart,
  ThreeEpochE_three_epoch_NCurr, ThreeEpochE_three_epoch_TimeBottleEnd,
  ThreeEpochE_three_epoch_NCurr, ThreeEpochE_three_epoch_current_time)

ThreeEpochE_true_NEffective_params = c(ThreeEpochE_true_demography[1, 1], ThreeEpochE_true_demography[1, 3], ThreeEpochE_true_demography[1, 5], ThreeEpochE_true_demography[1, 7])
ThreeEpochE_true_Time_params = c(-ThreeEpochE_true_demography[1, 2], -ThreeEpochE_true_demography[1, 4], -ThreeEpochE_true_demography[1, 6], -ThreeEpochE_true_demography[1, 8])
ThreeEpochE_true_demography_params = data.frame(ThreeEpochE_true_Time_params, ThreeEpochE_true_NEffective_params)

ThreeEpochE_one_epoch_NEffective_10 = c(ThreeEpochE_one_epoch_demography[1, 1], ThreeEpochE_one_epoch_demography[1, 3])
ThreeEpochE_one_epoch_Time_10 = c(-ThreeEpochE_one_epoch_demography[1, 2], -ThreeEpochE_one_epoch_demography[1, 4])
ThreeEpochE_one_epoch_demography_10 = data.frame(ThreeEpochE_one_epoch_Time_10, ThreeEpochE_one_epoch_NEffective_10)
ThreeEpochE_one_epoch_NEffective_20 = c(ThreeEpochE_one_epoch_demography[2, 1], ThreeEpochE_one_epoch_demography[2, 3])
ThreeEpochE_one_epoch_Time_20 = c(-ThreeEpochE_one_epoch_demography[2, 2], -ThreeEpochE_one_epoch_demography[2, 4])
ThreeEpochE_one_epoch_demography_20 = data.frame(ThreeEpochE_one_epoch_Time_20, ThreeEpochE_one_epoch_NEffective_20)
ThreeEpochE_one_epoch_NEffective_30 = c(ThreeEpochE_one_epoch_demography[3, 1], ThreeEpochE_one_epoch_demography[3, 3])
ThreeEpochE_one_epoch_Time_30 = c(-ThreeEpochE_one_epoch_demography[3, 2], -ThreeEpochE_one_epoch_demography[3, 4])
ThreeEpochE_one_epoch_demography_30 = data.frame(ThreeEpochE_one_epoch_Time_30, ThreeEpochE_one_epoch_NEffective_30)
ThreeEpochE_one_epoch_NEffective_50 = c(ThreeEpochE_one_epoch_demography[4, 1], ThreeEpochE_one_epoch_demography[4, 3])
ThreeEpochE_one_epoch_Time_50 = c(-ThreeEpochE_one_epoch_demography[4, 2], -ThreeEpochE_one_epoch_demography[4, 4])
ThreeEpochE_one_epoch_demography_50 = data.frame(ThreeEpochE_one_epoch_Time_50, ThreeEpochE_one_epoch_NEffective_50)
ThreeEpochE_one_epoch_NEffective_100 = c(ThreeEpochE_one_epoch_demography[5, 1], ThreeEpochE_one_epoch_demography[5, 3])
ThreeEpochE_one_epoch_Time_100 = c(-ThreeEpochE_one_epoch_demography[5, 2], -ThreeEpochE_one_epoch_demography[5, 4])
ThreeEpochE_one_epoch_demography_100 = data.frame(ThreeEpochE_one_epoch_Time_100, ThreeEpochE_one_epoch_NEffective_100)
ThreeEpochE_one_epoch_NEffective_150 = c(ThreeEpochE_one_epoch_demography[6, 1], ThreeEpochE_one_epoch_demography[6, 3])
ThreeEpochE_one_epoch_Time_150 = c(-ThreeEpochE_one_epoch_demography[6, 2], -ThreeEpochE_one_epoch_demography[6, 4])
ThreeEpochE_one_epoch_demography_150 = data.frame(ThreeEpochE_one_epoch_Time_150, ThreeEpochE_one_epoch_NEffective_150)
ThreeEpochE_one_epoch_NEffective_200 = c(ThreeEpochE_one_epoch_demography[7, 1], ThreeEpochE_one_epoch_demography[7, 3])
ThreeEpochE_one_epoch_Time_200 = c(-ThreeEpochE_one_epoch_demography[7, 2], -ThreeEpochE_one_epoch_demography[7, 4])
ThreeEpochE_one_epoch_demography_200 = data.frame(ThreeEpochE_one_epoch_Time_200, ThreeEpochE_one_epoch_NEffective_200)
ThreeEpochE_one_epoch_NEffective_300 = c(ThreeEpochE_one_epoch_demography[8, 1], ThreeEpochE_one_epoch_demography[8, 3])
ThreeEpochE_one_epoch_Time_300 = c(-ThreeEpochE_one_epoch_demography[8, 2], -ThreeEpochE_one_epoch_demography[8, 4])
ThreeEpochE_one_epoch_demography_300 = data.frame(ThreeEpochE_one_epoch_Time_300, ThreeEpochE_one_epoch_NEffective_300)
ThreeEpochE_one_epoch_NEffective_500 = c(ThreeEpochE_one_epoch_demography[9, 1], ThreeEpochE_one_epoch_demography[9, 3])
ThreeEpochE_one_epoch_Time_500 = c(-ThreeEpochE_one_epoch_demography[9, 2], -ThreeEpochE_one_epoch_demography[9, 4])
ThreeEpochE_one_epoch_demography_500 = data.frame(ThreeEpochE_one_epoch_Time_500, ThreeEpochE_one_epoch_NEffective_500)
ThreeEpochE_one_epoch_NEffective_700 = c(ThreeEpochE_one_epoch_demography[10, 1], ThreeEpochE_one_epoch_demography[10, 3])
ThreeEpochE_one_epoch_Time_700 = c(-ThreeEpochE_one_epoch_demography[10, 2], -ThreeEpochE_one_epoch_demography[10, 4])
ThreeEpochE_one_epoch_demography_700 = data.frame(ThreeEpochE_one_epoch_Time_700, ThreeEpochE_one_epoch_NEffective_700)

ThreeEpochE_two_epoch_NEffective_10 = c(ThreeEpochE_two_epoch_demography[1, 1], ThreeEpochE_two_epoch_demography[1, 3], ThreeEpochE_two_epoch_demography[1, 5])
ThreeEpochE_two_epoch_Time_10 = c(-ThreeEpochE_two_epoch_demography[1, 2], -ThreeEpochE_two_epoch_demography[1, 4], ThreeEpochE_two_epoch_demography[1, 6])
ThreeEpochE_two_epoch_demography_10 = data.frame(ThreeEpochE_two_epoch_Time_10, ThreeEpochE_two_epoch_NEffective_10)
ThreeEpochE_two_epoch_NEffective_20 = c(ThreeEpochE_two_epoch_demography[2, 1], ThreeEpochE_two_epoch_demography[2, 3], ThreeEpochE_two_epoch_demography[2, 5])
ThreeEpochE_two_epoch_Time_20 = c(-ThreeEpochE_two_epoch_demography[2, 2], -ThreeEpochE_two_epoch_demography[2, 4], ThreeEpochE_two_epoch_demography[2, 6])
ThreeEpochE_two_epoch_demography_20 = data.frame(ThreeEpochE_two_epoch_Time_20, ThreeEpochE_two_epoch_NEffective_20)
ThreeEpochE_two_epoch_NEffective_30 = c(ThreeEpochE_two_epoch_demography[3, 1], ThreeEpochE_two_epoch_demography[3, 3], ThreeEpochE_two_epoch_demography[3, 5])
ThreeEpochE_two_epoch_Time_30 = c(-ThreeEpochE_two_epoch_demography[3, 2], -ThreeEpochE_two_epoch_demography[3, 4], ThreeEpochE_two_epoch_demography[3, 6])
ThreeEpochE_two_epoch_demography_30 = data.frame(ThreeEpochE_two_epoch_Time_30, ThreeEpochE_two_epoch_NEffective_30)
ThreeEpochE_two_epoch_NEffective_50 = c(ThreeEpochE_two_epoch_demography[4, 1], ThreeEpochE_two_epoch_demography[4, 3], ThreeEpochE_two_epoch_demography[4, 5])
ThreeEpochE_two_epoch_Time_50 = c(-ThreeEpochE_two_epoch_demography[4, 2], -ThreeEpochE_two_epoch_demography[4, 4], ThreeEpochE_two_epoch_demography[4, 6])
ThreeEpochE_two_epoch_demography_50 = data.frame(ThreeEpochE_two_epoch_Time_50, ThreeEpochE_two_epoch_NEffective_50)
ThreeEpochE_two_epoch_NEffective_100 = c(ThreeEpochE_two_epoch_demography[5, 1], ThreeEpochE_two_epoch_demography[5, 3], ThreeEpochE_two_epoch_demography[5, 5])
ThreeEpochE_two_epoch_Time_100 = c(-ThreeEpochE_two_epoch_demography[5, 2], -ThreeEpochE_two_epoch_demography[5, 4], ThreeEpochE_two_epoch_demography[5, 6])
ThreeEpochE_two_epoch_demography_100 = data.frame(ThreeEpochE_two_epoch_Time_100, ThreeEpochE_two_epoch_NEffective_100)
ThreeEpochE_two_epoch_NEffective_150 = c(ThreeEpochE_two_epoch_demography[6, 1], ThreeEpochE_two_epoch_demography[6, 3], ThreeEpochE_two_epoch_demography[6, 5])
ThreeEpochE_two_epoch_Time_150 = c(-ThreeEpochE_two_epoch_demography[6, 2], -ThreeEpochE_two_epoch_demography[6, 4], ThreeEpochE_two_epoch_demography[6, 6])
ThreeEpochE_two_epoch_demography_150 = data.frame(ThreeEpochE_two_epoch_Time_150, ThreeEpochE_two_epoch_NEffective_150)
ThreeEpochE_two_epoch_NEffective_200 = c(ThreeEpochE_two_epoch_demography[7, 1], ThreeEpochE_two_epoch_demography[7, 3], ThreeEpochE_two_epoch_demography[7, 5])
ThreeEpochE_two_epoch_Time_200 = c(-ThreeEpochE_two_epoch_demography[7, 2], -ThreeEpochE_two_epoch_demography[7, 4], ThreeEpochE_two_epoch_demography[7, 6])
ThreeEpochE_two_epoch_demography_200 = data.frame(ThreeEpochE_two_epoch_Time_200, ThreeEpochE_two_epoch_NEffective_200)
ThreeEpochE_two_epoch_NEffective_300 = c(ThreeEpochE_two_epoch_demography[8, 1], ThreeEpochE_two_epoch_demography[8, 3], ThreeEpochE_two_epoch_demography[8, 5])
ThreeEpochE_two_epoch_Time_300 = c(-ThreeEpochE_two_epoch_demography[8, 2], -ThreeEpochE_two_epoch_demography[8, 4], ThreeEpochE_two_epoch_demography[8, 6])
ThreeEpochE_two_epoch_demography_300 = data.frame(ThreeEpochE_two_epoch_Time_300, ThreeEpochE_two_epoch_NEffective_300)
ThreeEpochE_two_epoch_NEffective_500 = c(ThreeEpochE_two_epoch_demography[9, 1], ThreeEpochE_two_epoch_demography[9, 3], ThreeEpochE_two_epoch_demography[9, 5])
ThreeEpochE_two_epoch_Time_500 = c(-ThreeEpochE_two_epoch_demography[9, 2], -ThreeEpochE_two_epoch_demography[9, 4], ThreeEpochE_two_epoch_demography[9, 6])
ThreeEpochE_two_epoch_demography_500 = data.frame(ThreeEpochE_two_epoch_Time_500, ThreeEpochE_two_epoch_NEffective_500)
ThreeEpochE_two_epoch_NEffective_700 = c(ThreeEpochE_two_epoch_demography[10, 1], ThreeEpochE_two_epoch_demography[10, 3], ThreeEpochE_two_epoch_demography[10, 5])
ThreeEpochE_two_epoch_Time_700 = c(-ThreeEpochE_two_epoch_demography[10, 2], -ThreeEpochE_two_epoch_demography[10, 4], ThreeEpochE_two_epoch_demography[10, 6])
ThreeEpochE_two_epoch_demography_700 = data.frame(ThreeEpochE_two_epoch_Time_700, ThreeEpochE_two_epoch_NEffective_700)

ThreeEpochE_three_epoch_NEffective_10 = c(ThreeEpochE_three_epoch_demography[1, 1], ThreeEpochE_three_epoch_demography[1, 3], ThreeEpochE_three_epoch_demography[1, 5], ThreeEpochE_three_epoch_demography[1, 7])
ThreeEpochE_three_epoch_Time_10 = c(-ThreeEpochE_three_epoch_demography[1, 2], -ThreeEpochE_three_epoch_demography[1, 4], -ThreeEpochE_three_epoch_demography[1, 6], ThreeEpochE_three_epoch_demography[1, 8])
ThreeEpochE_three_epoch_demography_10 = data.frame(ThreeEpochE_three_epoch_Time_10, ThreeEpochE_three_epoch_NEffective_10)
ThreeEpochE_three_epoch_NEffective_20 = c(ThreeEpochE_three_epoch_demography[2, 1], ThreeEpochE_three_epoch_demography[2, 3], ThreeEpochE_three_epoch_demography[2, 5], ThreeEpochE_three_epoch_demography[2, 7])
ThreeEpochE_three_epoch_Time_20 = c(-ThreeEpochE_three_epoch_demography[2, 2], -ThreeEpochE_three_epoch_demography[2, 4], -ThreeEpochE_three_epoch_demography[2, 6], ThreeEpochE_three_epoch_demography[2, 8])
ThreeEpochE_three_epoch_demography_20 = data.frame(ThreeEpochE_three_epoch_Time_20, ThreeEpochE_three_epoch_NEffective_20)
ThreeEpochE_three_epoch_NEffective_30 = c(ThreeEpochE_three_epoch_demography[3, 1], ThreeEpochE_three_epoch_demography[3, 3], ThreeEpochE_three_epoch_demography[3, 5], ThreeEpochE_three_epoch_demography[3, 7])
ThreeEpochE_three_epoch_Time_30 = c(-ThreeEpochE_three_epoch_demography[3, 2], -ThreeEpochE_three_epoch_demography[3, 4], -ThreeEpochE_three_epoch_demography[3, 6], ThreeEpochE_three_epoch_demography[3, 8])
ThreeEpochE_three_epoch_demography_30 = data.frame(ThreeEpochE_three_epoch_Time_30, ThreeEpochE_three_epoch_NEffective_30)
ThreeEpochE_three_epoch_NEffective_50 = c(ThreeEpochE_three_epoch_demography[4, 1], ThreeEpochE_three_epoch_demography[4, 3], ThreeEpochE_three_epoch_demography[4, 5], ThreeEpochE_three_epoch_demography[4, 7])
ThreeEpochE_three_epoch_Time_50 = c(-ThreeEpochE_three_epoch_demography[4, 2], -ThreeEpochE_three_epoch_demography[4, 4], -ThreeEpochE_three_epoch_demography[4, 6], ThreeEpochE_three_epoch_demography[4, 8])
ThreeEpochE_three_epoch_demography_50 = data.frame(ThreeEpochE_three_epoch_Time_50, ThreeEpochE_three_epoch_NEffective_50)
ThreeEpochE_three_epoch_NEffective_100 = c(ThreeEpochE_three_epoch_demography[5, 1], ThreeEpochE_three_epoch_demography[5, 3], ThreeEpochE_three_epoch_demography[5, 5], ThreeEpochE_three_epoch_demography[5, 7])
ThreeEpochE_three_epoch_Time_100 = c(-ThreeEpochE_three_epoch_demography[5, 2], -ThreeEpochE_three_epoch_demography[5, 4], -ThreeEpochE_three_epoch_demography[5, 6], ThreeEpochE_three_epoch_demography[5, 8])
ThreeEpochE_three_epoch_demography_100 = data.frame(ThreeEpochE_three_epoch_Time_100, ThreeEpochE_three_epoch_NEffective_100)
ThreeEpochE_three_epoch_NEffective_150 = c(ThreeEpochE_three_epoch_demography[6, 1], ThreeEpochE_three_epoch_demography[6, 3], ThreeEpochE_three_epoch_demography[6, 5], ThreeEpochE_three_epoch_demography[6, 7])
ThreeEpochE_three_epoch_Time_150 = c(-ThreeEpochE_three_epoch_demography[6, 2], -ThreeEpochE_three_epoch_demography[6, 4], -ThreeEpochE_three_epoch_demography[6, 6], ThreeEpochE_three_epoch_demography[6, 8])
ThreeEpochE_three_epoch_demography_150 = data.frame(ThreeEpochE_three_epoch_Time_150, ThreeEpochE_three_epoch_NEffective_150)
ThreeEpochE_three_epoch_NEffective_200 = c(ThreeEpochE_three_epoch_demography[7, 1], ThreeEpochE_three_epoch_demography[7, 3], ThreeEpochE_three_epoch_demography[7, 5], ThreeEpochE_three_epoch_demography[7, 7])
ThreeEpochE_three_epoch_Time_200 = c(-ThreeEpochE_three_epoch_demography[7, 2], -ThreeEpochE_three_epoch_demography[7, 4], -ThreeEpochE_three_epoch_demography[7, 6], ThreeEpochE_three_epoch_demography[7, 8])
ThreeEpochE_three_epoch_demography_200 = data.frame(ThreeEpochE_three_epoch_Time_200, ThreeEpochE_three_epoch_NEffective_200)
ThreeEpochE_three_epoch_NEffective_300 = c(ThreeEpochE_three_epoch_demography[8, 1], ThreeEpochE_three_epoch_demography[8, 3], ThreeEpochE_three_epoch_demography[8, 5], ThreeEpochE_three_epoch_demography[8, 7])
ThreeEpochE_three_epoch_Time_300 = c(-ThreeEpochE_three_epoch_demography[8, 2], -ThreeEpochE_three_epoch_demography[8, 4], -ThreeEpochE_three_epoch_demography[8, 6], ThreeEpochE_three_epoch_demography[8, 8])
ThreeEpochE_three_epoch_demography_300 = data.frame(ThreeEpochE_three_epoch_Time_300, ThreeEpochE_three_epoch_NEffective_300)
ThreeEpochE_three_epoch_NEffective_500 = c(ThreeEpochE_three_epoch_demography[9, 1], ThreeEpochE_three_epoch_demography[9, 3], ThreeEpochE_three_epoch_demography[9, 5], ThreeEpochE_three_epoch_demography[9, 7])
ThreeEpochE_three_epoch_Time_500 = c(-ThreeEpochE_three_epoch_demography[9, 2], -ThreeEpochE_three_epoch_demography[9, 4], -ThreeEpochE_three_epoch_demography[9, 6], ThreeEpochE_three_epoch_demography[9, 8])
ThreeEpochE_three_epoch_demography_500 = data.frame(ThreeEpochE_three_epoch_Time_500, ThreeEpochE_three_epoch_NEffective_500)
ThreeEpochE_three_epoch_NEffective_700 = c(ThreeEpochE_three_epoch_demography[10, 1], ThreeEpochE_three_epoch_demography[10, 3], ThreeEpochE_three_epoch_demography[10, 5], ThreeEpochE_three_epoch_demography[10, 7])
ThreeEpochE_three_epoch_Time_700 = c(-ThreeEpochE_three_epoch_demography[10, 2], -ThreeEpochE_three_epoch_demography[10, 4], -ThreeEpochE_three_epoch_demography[10, 6], ThreeEpochE_three_epoch_demography[10, 8])
ThreeEpochE_three_epoch_demography_700 = data.frame(ThreeEpochE_three_epoch_Time_700, ThreeEpochE_three_epoch_NEffective_700)

ggplot(ThreeEpochE_two_epoch_demography_10, aes(ThreeEpochE_two_epoch_Time_10, ThreeEpochE_two_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='dashed') + 
  geom_step(data=ThreeEpochE_two_epoch_demography_20, aes(ThreeEpochE_two_epoch_Time_20, ThreeEpochE_two_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='dashed') +
  geom_step(data=ThreeEpochE_two_epoch_demography_30, aes(ThreeEpochE_two_epoch_Time_30, ThreeEpochE_two_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='dashed') +
  geom_step(data=ThreeEpochE_two_epoch_demography_50, aes(ThreeEpochE_two_epoch_Time_50, ThreeEpochE_two_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='dashed') +
  geom_step(data=ThreeEpochE_two_epoch_demography_100, aes(ThreeEpochE_two_epoch_Time_100, ThreeEpochE_two_epoch_NEffective_100, color='N=100'), linewidth=1, linetype='dashed') +
  geom_step(data=ThreeEpochE_two_epoch_demography_150, aes(ThreeEpochE_two_epoch_Time_150, ThreeEpochE_two_epoch_NEffective_150, color='N=150'), linewidth=1, linetype='dashed') +
  geom_step(data=ThreeEpochE_two_epoch_demography_200, aes(ThreeEpochE_two_epoch_Time_200, ThreeEpochE_two_epoch_NEffective_200, color='N=200'), linewidth=1, linetype='dashed') +
  geom_step(data=ThreeEpochE_two_epoch_demography_300, aes(ThreeEpochE_two_epoch_Time_300, ThreeEpochE_two_epoch_NEffective_300, color='N=300'), linewidth=1, linetype='dashed') +
  geom_step(data=ThreeEpochE_two_epoch_demography_500, aes(ThreeEpochE_two_epoch_Time_500, ThreeEpochE_two_epoch_NEffective_500, color='N=500'), linewidth=1, linetype='dashed') +
  geom_step(data=ThreeEpochE_two_epoch_demography_700, aes(ThreeEpochE_two_epoch_Time_700, ThreeEpochE_two_epoch_NEffective_700, color='N=700'), linewidth=1, linetype='dashed') +
  geom_step(data=ThreeEpochE_true_demography_params, aes(ThreeEpochE_true_Time_params, ThreeEpochE_true_NEffective_params, color='True'), linewidth=1, linetype='longdash') +
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
  ggtitle('Simulated Three-epoch contraction')

best_fit_3EpE = ggplot(ThreeEpochE_two_epoch_demography_10, aes(ThreeEpochE_two_epoch_Time_10, ThreeEpochE_two_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='dashed') + 
  geom_step(data=ThreeEpochE_two_epoch_demography_20, aes(ThreeEpochE_two_epoch_Time_20, ThreeEpochE_two_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='dashed') +
  geom_step(data=ThreeEpochE_two_epoch_demography_30, aes(ThreeEpochE_two_epoch_Time_30, ThreeEpochE_two_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='dashed') +
  geom_step(data=ThreeEpochE_two_epoch_demography_50, aes(ThreeEpochE_two_epoch_Time_50, ThreeEpochE_two_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='dashed') +
  geom_step(data=ThreeEpochE_two_epoch_demography_100, aes(ThreeEpochE_two_epoch_Time_100, ThreeEpochE_two_epoch_NEffective_100, color='N=100'), linewidth=1, linetype='dashed') +
  geom_step(data=ThreeEpochE_two_epoch_demography_150, aes(ThreeEpochE_two_epoch_Time_150, ThreeEpochE_two_epoch_NEffective_150, color='N=150'), linewidth=1, linetype='dashed') +
  # geom_step(data=ThreeEpochE_two_epoch_demography_200, aes(ThreeEpochE_two_epoch_Time_200, ThreeEpochE_two_epoch_NEffective_200, color='N=200'), linewidth=1, linetype='dashed') +
  # geom_step(data=ThreeEpochE_two_epoch_demography_300, aes(ThreeEpochE_two_epoch_Time_300, ThreeEpochE_two_epoch_NEffective_300, color='N=300'), linewidth=1, linetype='dashed') +
  # geom_step(data=ThreeEpochE_two_epoch_demography_500, aes(ThreeEpochE_two_epoch_Time_500, ThreeEpochE_two_epoch_NEffective_500, color='N=500'), linewidth=1, linetype='dashed') +
  # geom_step(data=ThreeEpochE_two_epoch_demography_700, aes(ThreeEpochE_two_epoch_Time_700, ThreeEpochE_two_epoch_NEffective_700, color='N=700'), linewidth=1, linetype='dashed') +
  # geom_step(data=ThreeEpochE_three_epoch_demography_10, aes(ThreeEpochE_three_epoch_Time_10, ThreeEpochE_three_epoch_NEffective_10, color='N=10'), linewidth=1, linetype='solid') +
  # geom_step(data=ThreeEpochE_three_epoch_demography_20, aes(ThreeEpochE_three_epoch_Time_20, ThreeEpochE_three_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='solid') +
  # geom_step(data=ThreeEpochE_three_epoch_demography_30, aes(ThreeEpochE_three_epoch_Time_30, ThreeEpochE_three_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='solid') +
  # geom_step(data=ThreeEpochE_three_epoch_demography_50, aes(ThreeEpochE_three_epoch_Time_50, ThreeEpochE_three_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='solid') +
  # geom_step(data=ThreeEpochE_three_epoch_demography_100, aes(ThreeEpochE_three_epoch_Time_100, ThreeEpochE_three_epoch_NEffective_100, color='N=100'), linewidth=1, linetype='solid') +
  # geom_step(data=ThreeEpochE_three_epoch_demography_150, aes(ThreeEpochE_three_epoch_Time_150, ThreeEpochE_three_epoch_NEffective_150, color='N=150'), linewidth=1, linetype='solid') +
  geom_step(data=ThreeEpochE_three_epoch_demography_200, aes(ThreeEpochE_three_epoch_Time_200, ThreeEpochE_three_epoch_NEffective_200, color='N=200'), linewidth=1, linetype='solid') +
  geom_step(data=ThreeEpochE_three_epoch_demography_300, aes(ThreeEpochE_three_epoch_Time_300, ThreeEpochE_three_epoch_NEffective_300, color='N=300'), linewidth=1, linetype='solid') +
  geom_step(data=ThreeEpochE_three_epoch_demography_500, aes(ThreeEpochE_three_epoch_Time_500, ThreeEpochE_three_epoch_NEffective_500, color='N=500'), linewidth=1, linetype='solid') +
  geom_step(data=ThreeEpochE_three_epoch_demography_700, aes(ThreeEpochE_three_epoch_Time_700, ThreeEpochE_three_epoch_NEffective_700, color='N=700'), linewidth=1, linetype='solid') +
  geom_step(data=ThreeEpochE_true_demography_params, aes(ThreeEpochE_true_Time_params, ThreeEpochE_true_NEffective_params, color='True'), linewidth=1.5, linetype='longdash') +
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
  ggtitle('Simulated 3EpE Best-fitting Demography')

best_fit_3EpE

ggplot(ThreeEpochE_three_epoch_demography_10, aes(ThreeEpochE_three_epoch_Time_10, ThreeEpochE_three_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='solid') + 
  geom_step(data=ThreeEpochE_three_epoch_demography_20, aes(ThreeEpochE_three_epoch_Time_20, ThreeEpochE_three_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='solid') +
  geom_step(data=ThreeEpochE_three_epoch_demography_30, aes(ThreeEpochE_three_epoch_Time_30, ThreeEpochE_three_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='solid') +
  geom_step(data=ThreeEpochE_three_epoch_demography_50, aes(ThreeEpochE_three_epoch_Time_50, ThreeEpochE_three_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='solid') +
  geom_step(data=ThreeEpochE_three_epoch_demography_100, aes(ThreeEpochE_three_epoch_Time_100, ThreeEpochE_three_epoch_NEffective_100, color='N=100'), linewidth=1, linetype='solid') +
  geom_step(data=ThreeEpochE_three_epoch_demography_150, aes(ThreeEpochE_three_epoch_Time_150, ThreeEpochE_three_epoch_NEffective_150, color='N=150'), linewidth=1, linetype='solid') +
  geom_step(data=ThreeEpochE_three_epoch_demography_200, aes(ThreeEpochE_three_epoch_Time_200, ThreeEpochE_three_epoch_NEffective_200, color='N=200'), linewidth=1, linetype='solid') +
  geom_step(data=ThreeEpochE_three_epoch_demography_300, aes(ThreeEpochE_three_epoch_Time_300, ThreeEpochE_three_epoch_NEffective_300, color='N=300'), linewidth=1, linetype='solid') +
  geom_step(data=ThreeEpochE_three_epoch_demography_500, aes(ThreeEpochE_three_epoch_Time_500, ThreeEpochE_three_epoch_NEffective_500, color='N=500'), linewidth=1, linetype='solid') +
  geom_step(data=ThreeEpochE_three_epoch_demography_700, aes(ThreeEpochE_three_epoch_Time_700, ThreeEpochE_three_epoch_NEffective_700, color='N=700'), linewidth=1, linetype='solid') +
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
  ggtitle('Simulated 3EpE Three Epoch Demography')


# NAnc Estimate by Sample Size
sample_size = c(10, 20, 30, 50, 100, 150, 200, 300, 500, 700)

NAnc_df = data.frame(sample_size, ThreeEpochE_one_epoch_NAnc, ThreeEpochE_two_epoch_NAnc, ThreeEpochE_three_epoch_NAnc)
NAnc_df = melt(NAnc_df, id='sample_size')

ggplot(data=NAnc_df, aes(x=sample_size, y=value, color=variable)) + geom_line() +
  xlab('Sample size') +
  ylab('Estimated ancestral effective population size') +
  ggtitle('Simulated 3EpE NAnc by sample size') +
  theme_bw() +
  guides(color=guide_legend(title="Epoch")) +
  scale_color_manual(
    labels=c('One-epoch', 'Three-epoch', 'Three-epoch'),
    values=c('red', 'blue', 'green')) +
  geom_hline(yintercept=30378, color='black', linetype='dashed') +
  scale_x_continuous(breaks=sample_size)

EUR_empirical_10 = read_input_sfs('../Analysis/1kg_EUR_10/syn_downsampled_sfs.txt')
ThreeEpochE_empirical_10 = read_input_sfs('../Analysis/ThreeEpochExpansion_10/syn_downsampled_sfs.txt')
ThreeEpochE_one_epoch_10 = sfs_from_demography('../Analysis/ThreeEpochExpansion_10/one_epoch_demography.txt')
ThreeEpochE_two_epoch_10 = sfs_from_demography('../Analysis/ThreeEpochExpansion_10/two_epoch_demography.txt')
ThreeEpochE_three_epoch_10 = sfs_from_demography('../Analysis/ThreeEpochExpansion_10/three_epoch_demography.txt')

EUR_empirical_20 = read_input_sfs('../Analysis/1kg_EUR_20/syn_downsampled_sfs.txt')
ThreeEpochE_empirical_20 = read_input_sfs('../Analysis/ThreeEpochExpansion_20/syn_downsampled_sfs.txt')
ThreeEpochE_one_epoch_20 = sfs_from_demography('../Analysis/ThreeEpochExpansion_20/one_epoch_demography.txt')
ThreeEpochE_two_epoch_20 = sfs_from_demography('../Analysis/ThreeEpochExpansion_20/two_epoch_demography.txt')
ThreeEpochE_three_epoch_20 = sfs_from_demography('../Analysis/ThreeEpochExpansion_20/three_epoch_demography.txt')

EUR_empirical_30 = read_input_sfs('../Analysis/1kg_EUR_30/syn_downsampled_sfs.txt')
ThreeEpochE_empirical_30 = read_input_sfs('../Analysis/ThreeEpochExpansion_30/syn_downsampled_sfs.txt')
ThreeEpochE_one_epoch_30 = sfs_from_demography('../Analysis/ThreeEpochExpansion_30/one_epoch_demography.txt')
ThreeEpochE_two_epoch_30 = sfs_from_demography('../Analysis/ThreeEpochExpansion_30/two_epoch_demography.txt')
ThreeEpochE_three_epoch_30 = sfs_from_demography('../Analysis/ThreeEpochExpansion_30/three_epoch_demography.txt')

EUR_empirical_50 = read_input_sfs('../Analysis/1kg_EUR_50/syn_downsampled_sfs.txt')
ThreeEpochE_empirical_50 = read_input_sfs('../Analysis/ThreeEpochExpansion_50/syn_downsampled_sfs.txt')
ThreeEpochE_one_epoch_50 = sfs_from_demography('../Analysis/ThreeEpochExpansion_50/one_epoch_demography.txt')
ThreeEpochE_two_epoch_50 = sfs_from_demography('../Analysis/ThreeEpochExpansion_50/two_epoch_demography.txt')
ThreeEpochE_three_epoch_50 = sfs_from_demography('../Analysis/ThreeEpochExpansion_50/three_epoch_demography.txt')

EUR_empirical_100 = read_input_sfs('../Analysis/1kg_EUR_100/syn_downsampled_sfs.txt')
ThreeEpochE_empirical_100 = read_input_sfs('../Analysis/ThreeEpochExpansion_100/syn_downsampled_sfs.txt')
ThreeEpochE_one_epoch_100 = sfs_from_demography('../Analysis/ThreeEpochExpansion_100/one_epoch_demography.txt')
ThreeEpochE_two_epoch_100 = sfs_from_demography('../Analysis/ThreeEpochExpansion_100/two_epoch_demography.txt')
ThreeEpochE_three_epoch_100 = sfs_from_demography('../Analysis/ThreeEpochExpansion_100/three_epoch_demography.txt')

EUR_empirical_150 = read_input_sfs('../Analysis/1kg_EUR_150/syn_downsampled_sfs.txt')
ThreeEpochE_empirical_150 = read_input_sfs('../Analysis/ThreeEpochExpansion_150/syn_downsampled_sfs.txt')
ThreeEpochE_one_epoch_150 = sfs_from_demography('../Analysis/ThreeEpochExpansion_150/one_epoch_demography.txt')
ThreeEpochE_two_epoch_150 = sfs_from_demography('../Analysis/ThreeEpochExpansion_150/two_epoch_demography.txt')
ThreeEpochE_three_epoch_150 = sfs_from_demography('../Analysis/ThreeEpochExpansion_150/three_epoch_demography.txt')

EUR_empirical_200 = read_input_sfs('../Analysis/1kg_EUR_200/syn_downsampled_sfs.txt')
ThreeEpochE_empirical_200 = read_input_sfs('../Analysis/ThreeEpochExpansion_200/syn_downsampled_sfs.txt')
ThreeEpochE_one_epoch_200 = sfs_from_demography('../Analysis/ThreeEpochExpansion_200/one_epoch_demography.txt')
ThreeEpochE_two_epoch_200 = sfs_from_demography('../Analysis/ThreeEpochExpansion_200/two_epoch_demography.txt')
ThreeEpochE_three_epoch_200 = sfs_from_demography('../Analysis/ThreeEpochExpansion_200/three_epoch_demography.txt')

EUR_empirical_300 = read_input_sfs('../Analysis/1kg_EUR_300/syn_downsampled_sfs.txt')
ThreeEpochE_empirical_300 = read_input_sfs('../Analysis/ThreeEpochExpansion_300/syn_downsampled_sfs.txt')
ThreeEpochE_one_epoch_300 = sfs_from_demography('../Analysis/ThreeEpochExpansion_300/one_epoch_demography.txt')
ThreeEpochE_two_epoch_300 = sfs_from_demography('../Analysis/ThreeEpochExpansion_300/two_epoch_demography.txt')
ThreeEpochE_three_epoch_300 = sfs_from_demography('../Analysis/ThreeEpochExpansion_300/three_epoch_demography.txt')

EUR_empirical_500 = read_input_sfs('../Analysis/1kg_EUR_500/syn_downsampled_sfs.txt')
ThreeEpochE_empirical_500 = read_input_sfs('../Analysis/ThreeEpochExpansion_500/syn_downsampled_sfs.txt')
ThreeEpochE_one_epoch_500 = sfs_from_demography('../Analysis/ThreeEpochExpansion_500/one_epoch_demography.txt')
ThreeEpochE_two_epoch_500 = sfs_from_demography('../Analysis/ThreeEpochExpansion_500/two_epoch_demography.txt')
ThreeEpochE_three_epoch_500 = sfs_from_demography('../Analysis/ThreeEpochExpansion_500/three_epoch_demography.txt')

EUR_empirical_700 = read_input_sfs('../Analysis/1kg_EUR_700/syn_downsampled_sfs.txt')
ThreeEpochE_empirical_700 = read_input_sfs('../Analysis/ThreeEpochExpansion_700/syn_downsampled_sfs.txt')
ThreeEpochE_one_epoch_700 = sfs_from_demography('../Analysis/ThreeEpochExpansion_700/one_epoch_demography.txt')
ThreeEpochE_two_epoch_700 = sfs_from_demography('../Analysis/ThreeEpochExpansion_700/two_epoch_demography.txt')
ThreeEpochE_three_epoch_700 = sfs_from_demography('../Analysis/ThreeEpochExpansion_700/three_epoch_demography.txt')

# compare_one_Three_three_sfs(ThreeEpochE_empirical_10, ThreeEpochE_one_epoch_10, ThreeEpochE_two_epoch_10, ThreeEpochE_three_epoch_10) + ggtitle('ThreeEpochE, sample size = 10') + 
#   compare_one_Three_three_proportional_sfs(ThreeEpochE_empirical_10, ThreeEpochE_one_epoch_10, ThreeEpochE_two_epoch_10, ThreeEpochE_three_epoch_10) + 
#   plot_layout(nrow=2)
# 
# compare_one_Three_three_sfs(ThreeEpochE_empirical_20, ThreeEpochE_one_epoch_20, ThreeEpochE_two_epoch_20, ThreeEpochE_three_epoch_20) + ggtitle('ThreeEpochE, sample size = 20') + 
#   compare_one_Three_three_proportional_sfs(ThreeEpochE_empirical_20, ThreeEpochE_one_epoch_20, ThreeEpochE_two_epoch_20, ThreeEpochE_three_epoch_20) + 
#   plot_layout(nrow=2)
# 
# compare_one_Three_three_sfs(ThreeEpochE_empirical_30, ThreeEpochE_one_epoch_30, ThreeEpochE_two_epoch_30, ThreeEpochE_three_epoch_30) + ggtitle('ThreeEpochE, sample size = 30') + 
#   compare_one_Three_three_proportional_sfs(ThreeEpochE_empirical_30, ThreeEpochE_one_epoch_30, ThreeEpochE_two_epoch_30, ThreeEpochE_three_epoch_30) + 
#   plot_layout(nrow=2)
# 
# compare_one_Three_three_sfs(ThreeEpochE_empirical_50, ThreeEpochE_one_epoch_50, ThreeEpochE_two_epoch_50, ThreeEpochE_three_epoch_50) + ggtitle('ThreeEpochE, sample size = 50') + 
#   compare_one_Three_three_proportional_sfs(ThreeEpochE_empirical_50, ThreeEpochE_one_epoch_50, ThreeEpochE_two_epoch_50, ThreeEpochE_three_epoch_50) + 
#   plot_layout(nrow=2)
# 
# compare_one_Three_three_sfs(ThreeEpochE_empirical_100, ThreeEpochE_one_epoch_100, ThreeEpochE_two_epoch_100, ThreeEpochE_three_epoch_100) + ggtitle('ThreeEpochE, sample size = 100') + 
#   compare_one_Three_three_proportional_sfs(ThreeEpochE_empirical_100, ThreeEpochE_one_epoch_100, ThreeEpochE_two_epoch_100, ThreeEpochE_three_epoch_100) + 
#   plot_layout(nrow=2)
# 
# compare_one_Three_three_sfs(ThreeEpochE_empirical_150, ThreeEpochE_one_epoch_150, ThreeEpochE_two_epoch_150, ThreeEpochE_three_epoch_150) + ggtitle('ThreeEpochE, sample size = 150') + 
#   compare_one_Three_three_proportional_sfs(ThreeEpochE_empirical_150, ThreeEpochE_one_epoch_150, ThreeEpochE_two_epoch_150, ThreeEpochE_three_epoch_150) + 
#   plot_layout(nrow=2)
# 
# compare_one_Three_three_sfs(ThreeEpochE_empirical_200, ThreeEpochE_one_epoch_200, ThreeEpochE_two_epoch_200, ThreeEpochE_three_epoch_200) + ggtitle('ThreeEpochE, sample size = 200') + 
#   compare_one_Three_three_proportional_sfs(ThreeEpochE_empirical_200, ThreeEpochE_one_epoch_200, ThreeEpochE_two_epoch_200, ThreeEpochE_three_epoch_200) + 
#   plot_layout(nrow=2)
# 
# compare_one_Three_three_sfs(ThreeEpochE_empirical_300, ThreeEpochE_one_epoch_300, ThreeEpochE_two_epoch_300, ThreeEpochE_three_epoch_300) + ggtitle('ThreeEpochE, sample size = 300') + 
#   compare_one_Three_three_proportional_sfs(ThreeEpochE_empirical_300, ThreeEpochE_one_epoch_300, ThreeEpochE_two_epoch_300, ThreeEpochE_three_epoch_300) + 
#   plot_layout(nrow=2)
# 
# compare_one_Three_three_sfs(ThreeEpochE_empirical_500, ThreeEpochE_one_epoch_500, ThreeEpochE_two_epoch_500, ThreeEpochE_three_epoch_500) + ggtitle('ThreeEpochE, sample size = 500') + 
#   compare_one_Three_three_proportional_sfs(ThreeEpochE_empirical_500, ThreeEpochE_one_epoch_500, ThreeEpochE_two_epoch_500, ThreeEpochE_three_epoch_500) + 
#   plot_layout(nrow=2)
# 
# compare_one_Three_three_sfs(ThreeEpochE_empirical_700, ThreeEpochE_one_epoch_700, ThreeEpochE_two_epoch_700, ThreeEpochE_three_epoch_700) + ggtitle('ThreeEpochE, sample size = 700') + 
#   compare_one_Three_three_proportional_sfs(ThreeEpochE_empirical_700, ThreeEpochE_one_epoch_700, ThreeEpochE_two_epoch_700, ThreeEpochE_three_epoch_700) + 
#   plot_layout(nrow=2)

compare_one_two_three_proportional_sfs_cutoff(ThreeEpochE_empirical_10, ThreeEpochE_one_epoch_10, ThreeEpochE_two_epoch_10, ThreeEpochE_three_epoch_10) + ggtitle('ThreeEpochE, sample size = 10')
compare_one_two_three_proportional_sfs_cutoff(ThreeEpochE_empirical_20, ThreeEpochE_one_epoch_20, ThreeEpochE_two_epoch_20, ThreeEpochE_three_epoch_20) + ggtitle('ThreeEpochE, sample size = 20')
compare_one_two_three_proportional_sfs_cutoff(ThreeEpochE_empirical_30, ThreeEpochE_one_epoch_30, ThreeEpochE_two_epoch_30, ThreeEpochE_three_epoch_30) + ggtitle('ThreeEpochE, sample size = 30')
compare_one_two_three_proportional_sfs_cutoff(ThreeEpochE_empirical_50, ThreeEpochE_one_epoch_50, ThreeEpochE_two_epoch_50, ThreeEpochE_three_epoch_50) + ggtitle('ThreeEpochE, sample size = 50')
compare_one_two_three_proportional_sfs_cutoff(ThreeEpochE_empirical_100, ThreeEpochE_one_epoch_100, ThreeEpochE_two_epoch_100, ThreeEpochE_three_epoch_100) + ggtitle('ThreeEpochE, sample size = 100')
compare_one_two_three_proportional_sfs_cutoff(ThreeEpochE_empirical_150, ThreeEpochE_one_epoch_150, ThreeEpochE_two_epoch_150, ThreeEpochE_three_epoch_150) + ggtitle('ThreeEpochE, sample size = 150')
compare_one_two_three_proportional_sfs_cutoff(ThreeEpochE_empirical_200, ThreeEpochE_one_epoch_200, ThreeEpochE_two_epoch_200, ThreeEpochE_three_epoch_200) + ggtitle('ThreeEpochE, sample size = 200')
compare_one_two_three_proportional_sfs_cutoff(ThreeEpochE_empirical_300, ThreeEpochE_one_epoch_300, ThreeEpochE_two_epoch_300, ThreeEpochE_three_epoch_300) + ggtitle('ThreeEpochE, sample size = 300')
compare_one_two_three_proportional_sfs_cutoff(ThreeEpochE_empirical_500, ThreeEpochE_one_epoch_500, ThreeEpochE_two_epoch_500, ThreeEpochE_three_epoch_500) + ggtitle('ThreeEpochE, sample size = 500')
compare_one_two_three_proportional_sfs_cutoff(ThreeEpochE_empirical_700, ThreeEpochE_one_epoch_700, ThreeEpochE_two_epoch_700, ThreeEpochE_three_epoch_700) + ggtitle('ThreeEpochE, sample size = 700')

# Simple simulations
empirical_singletons = c()
empirical_doubletons = c()
empirical_rare = c()
one_epoch_singletons = c()
one_epoch_doubletons = c()
one_epoch_rare = c()

# Loop through subdirectories and get relevant files
for (i in seq(10, 700, 10)) {
  subdirectory <- paste0("../Analysis/ThreeEpochExpansion_", i)
  ThreeEpochE_empirical_file_path <- file.path(subdirectory, "syn_downsampled_sfs.txt")
  empirical_singletons = c(empirical_singletons, proportional_sfs(read_input_sfs(ThreeEpochE_empirical_file_path))[1])
  empirical_doubletons = c(empirical_doubletons, proportional_sfs(read_input_sfs(ThreeEpochE_empirical_file_path))[2])
  ThreeEpochE_one_epoch_file_path <- file.path(subdirectory, "one_epoch_demography.txt")
  one_epoch_singletons = c(one_epoch_singletons, proportional_sfs(sfs_from_demography(ThreeEpochE_one_epoch_file_path))[1])
  one_epoch_doubletons = c(one_epoch_doubletons, proportional_sfs(sfs_from_demography(ThreeEpochE_one_epoch_file_path))[2])
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
  ggtitle('Proportion of ThreeEpochE SFS comprised of singletons')

ggplot(doubletons_df, aes(x=Sample.size, y=value, color=variable)) + geom_line() +
  theme_bw() +
  scale_color_manual(values=c('red', 'blue'),
    labels=c('Empirical', 'One Epoch'),
    name='Demography') +
  xlab('Sample size') +
  ylab('Doubleton proportion') +
  ggtitle('Proportion of ThreeEpochE SFS comprised of doubletons')

ggplot(single_plus_doubletons_df, aes(x=Sample.size, y=value, color=variable)) + geom_line() +
  theme_bw() +
  scale_color_manual(values=c('red', 'blue'),
    labels=c('Empirical', 'One Epoch'),
    name='Demography') +
  xlab('Sample size') +
  ylab('Singleton + doubleton proportion') +
  ggtitle('Proportion of ThreeEpochE SFS comprised of singletons or doubletons')
