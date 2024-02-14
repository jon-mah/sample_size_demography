## Tennessen simulation

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

# Tennessen_OOA 10-800:80
OOA_empirical_file_list = list()
OOA_one_epoch_file_list = list()
OOA_two_epoch_file_list = list()
OOA_three_epoch_file_list = list()
OOA_one_epoch_AIC = c()
OOA_one_epoch_LL = c()
OOA_one_epoch_theta = c()
OOA_one_epoch_allele_sum = c()
OOA_two_epoch_AIC = c()
OOA_two_epoch_LL = c()
OOA_two_epoch_theta = c()
OOA_two_epoch_nu = c()
OOA_two_epoch_tau = c()
OOA_two_epoch_allele_sum = c()
OOA_three_epoch_AIC = c()
OOA_three_epoch_LL = c()
OOA_three_epoch_theta = c()
OOA_three_epoch_nuB = c()
OOA_three_epoch_nuF = c()
OOA_three_epoch_tauB = c()
OOA_three_epoch_tauF = c()
OOA_three_epoch_allele_sum = c()

# Loop through subdirectories and get relevant files
for (i in seq(10, 800, by = 80)) {
  subdirectory <- paste0("../Analysis/ooa_simulated_", i)
  OOA_empirical_file_path <- file.path(subdirectory, "syn_downsampled_sfs.txt")
  OOA_one_epoch_file_path <- file.path(subdirectory, "one_epoch_demography.txt")
  OOA_two_epoch_file_path <- file.path(subdirectory, "two_epoch_demography.txt")
  OOA_three_epoch_file_path <- file.path(subdirectory, "three_epoch_demography.txt")
  
  # Check if the file exists before attempting to read and print its contents
  if (file.exists(OOA_empirical_file_path)) {
    this_empirical_sfs = read_input_sfs(OOA_empirical_file_path)
    OOA_empirical_file_list[[subdirectory]] = this_empirical_sfs
  }
  if (file.exists(OOA_one_epoch_file_path)) {
    this_one_epoch_sfs = sfs_from_demography(OOA_one_epoch_file_path)
    OOA_one_epoch_file_list[[subdirectory]] = this_one_epoch_sfs
    OOA_one_epoch_AIC = c(OOA_one_epoch_AIC, AIC_from_demography(OOA_one_epoch_file_path))
    OOA_one_epoch_LL = c(OOA_one_epoch_LL, LL_from_demography(OOA_one_epoch_file_path))
    OOA_one_epoch_theta = c(OOA_one_epoch_theta, theta_from_demography(OOA_one_epoch_file_path))
    OOA_one_epoch_allele_sum = c(OOA_one_epoch_allele_sum, sum(this_one_epoch_sfs))
  }
  if (file.exists(OOA_two_epoch_file_path)) {
    this_two_epoch_sfs = sfs_from_demography(OOA_two_epoch_file_path)
    OOA_two_epoch_file_list[[subdirectory]] = this_two_epoch_sfs
    OOA_two_epoch_AIC = c(OOA_two_epoch_AIC, AIC_from_demography(OOA_two_epoch_file_path))
    OOA_two_epoch_LL = c(OOA_two_epoch_LL, LL_from_demography(OOA_two_epoch_file_path))
    OOA_two_epoch_theta = c(OOA_two_epoch_theta, theta_from_demography(OOA_two_epoch_file_path))
    OOA_two_epoch_nu = c(OOA_two_epoch_nu, nu_from_demography(OOA_two_epoch_file_path))
    OOA_two_epoch_tau = c(OOA_two_epoch_tau, tau_from_demography(OOA_two_epoch_file_path))
    OOA_two_epoch_allele_sum = c(OOA_two_epoch_allele_sum, sum(this_two_epoch_sfs))
  }
  if (file.exists(OOA_three_epoch_file_path)) {
    this_three_epoch_sfs = sfs_from_demography(OOA_three_epoch_file_path)
    OOA_three_epoch_file_list[[subdirectory]] = this_three_epoch_sfs
    OOA_three_epoch_AIC = c(OOA_three_epoch_AIC, AIC_from_demography(OOA_three_epoch_file_path))
    OOA_three_epoch_LL = c(OOA_three_epoch_LL, LL_from_demography(OOA_three_epoch_file_path))
    OOA_three_epoch_theta = c(OOA_three_epoch_theta, theta_from_demography(OOA_three_epoch_file_path))
    OOA_three_epoch_nuB = c(OOA_three_epoch_nuB, nuB_from_demography(OOA_three_epoch_file_path))
    OOA_three_epoch_nuF = c(OOA_three_epoch_nuF, nuF_from_demography(OOA_three_epoch_file_path))
    OOA_three_epoch_tauB = c(OOA_three_epoch_tauB, tauB_from_demography(OOA_three_epoch_file_path))
    OOA_three_epoch_tauF = c(OOA_three_epoch_tauF, tauF_from_demography(OOA_three_epoch_file_path))
    OOA_three_epoch_allele_sum = c(OOA_three_epoch_allele_sum, sum(this_three_epoch_sfs))
  }  
}

OOA_AIC_df = data.frame(OOA_one_epoch_AIC, OOA_two_epoch_AIC, OOA_three_epoch_AIC)
# Reshape the data from wide to long format
OOA_df_long <- tidyr::gather(OOA_AIC_df, key = "Epoch", value = "AIC", OOA_one_epoch_AIC:OOA_three_epoch_AIC)

# Increase the x-axis index by 4
OOA_df_long$Index <- rep(seq(10, 800, by = 80), times = 3)

# Create the line plot with ggplot2
ggplot(OOA_df_long, aes(x = Index, y = AIC, color = Epoch)) +
  geom_line() +
  geom_point() +
  labs(title = "Tennessen OOA AIC values by sample size",
       x = "Sample Size",
       y = "AIC") +
  scale_y_log10() +
  scale_x_continuous(breaks=OOA_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('One-epoch', 'Three-epoch', 'Two-epoch')) +
  theme_bw()

OOA_lambda_two_one = 2 * (OOA_two_epoch_LL - OOA_one_epoch_LL)
OOA_lambda_three_one = 2 * (OOA_three_epoch_LL - OOA_one_epoch_LL)
OOA_lambda_three_two = 2 * (OOA_three_epoch_LL - OOA_two_epoch_LL)

OOA_lambda_df = data.frame(OOA_lambda_two_one, OOA_lambda_three_one, OOA_lambda_three_two)
# Reshape the data from wide to long format
OOA_df_long_lambda <- tidyr::gather(OOA_lambda_df, key = "Full_vs_Null", value = "Lambda", OOA_lambda_two_one:OOA_lambda_three_two)
# Increase the x-axis index by 4
OOA_df_long_lambda$Index <- rep(seq(10, 800, by = 80), times = 3)

# Create the line plot with ggplot2
ggplot(OOA_df_long_lambda, aes(x = Index, y = Lambda, color = Full_vs_Null)) +
  geom_line() +
  geom_point() +
  labs(title = "Tennessen OOA Lambda values by sample size (N=10-730:80)",
       x = "Sample Size",
       y = "2 * Lambda") +
  # scale_y_log10() +
  scale_x_continuous(breaks=OOA_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('Three vs. One', 'Three vs. Two', 'Two vs. One')) +
  theme_bw()

OOA_one_epoch_residual = c()
OOA_two_epoch_residual = c()
OOA_three_epoch_residual = c()

for (i in 1:10) {
  OOA_one_epoch_residual = c(OOA_one_epoch_residual, compute_residual(unlist(OOA_empirical_file_list[i]), unlist(OOA_one_epoch_file_list[i])))
  OOA_two_epoch_residual = c(OOA_two_epoch_residual, compute_residual(unlist(OOA_empirical_file_list[i]), unlist(OOA_two_epoch_file_list[i])))
  OOA_three_epoch_residual = c(OOA_three_epoch_residual, compute_residual(unlist(OOA_empirical_file_list[i]), unlist(OOA_three_epoch_file_list[i])))
}

OOA_residual_df = data.frame(OOA_one_epoch_residual, OOA_two_epoch_residual, OOA_three_epoch_residual)
# Reshape the data from wide to long format
OOA_df_long_residual <- tidyr::gather(OOA_residual_df, key = "Epoch", value = "residual", OOA_one_epoch_residual:OOA_three_epoch_residual)

# Increase the x-axis index by 4
OOA_df_long_residual$Index <- rep(seq(10, 800, by = 80), times = 3)

# Create the line plot with ggplot2
ggplot(OOA_df_long_residual, aes(x = Index, y = residual, color = Epoch)) +
  geom_line() +
  geom_point() +
  labs(title = "OOA residual values by sample size",
       x = "Sample Size",
       y = "Residual") +
  scale_y_log10() +
  scale_x_continuous(breaks=OOA_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('One-epoch', 'Three-epoch', 'Two-epoch')) +
  theme_bw()

ggplot(OOA_df_long, aes(x = Index, y = AIC, color = Epoch)) +
  geom_line(linetype=3) +
  geom_point() +
  labs(title = "Tennessen OOA AIC and residual by sample size (N=10-730:80)",
       x = "Sample Size",
       y = "AIC") +
  scale_y_log10(sec.axis = sec_axis(~.*1, name="Residual")) +
  scale_x_continuous(breaks=OOA_df_long$Index) +
  geom_line(data=OOA_df_long_residual, aes(x = Index, y = residual*1, color = Epoch)) +
  scale_color_manual(values = c("blue", "orange", "green", "violet", "red", "seagreen"),
    label=c('One-epoch AIC', 'One-epoch residual',
      'Three-epoch AIC', 'Three-epoch residual',
      'Two-epoch AIC', 'Two-epoch residual')) +
  theme_bw()

# Tennessen_OOA population genetic constants

OOA_mu = 1.5E-8
# OOA_allele_sum = 8058343

# NAnc = theta / (4 * allele_sum * mu)
# generations = 2 * tau * theta / (4 * mu * allele_sum)
# years = generations / 365
# NCurr = nu * NAnc
# generations_b = 2 * tauB * theta / (4 * mu * allele_sum)
# generations_f = 2 * tauF * theta / (4 * mu * allele_sum)
# NBottle = nuB * NAnc
# NSince = nuF * NAnc


OOA_one_epoch_NAnc = OOA_one_epoch_theta / (4 * OOA_one_epoch_allele_sum * OOA_mu)
OOA_two_epoch_NAnc = OOA_two_epoch_theta / (4 * OOA_two_epoch_allele_sum * OOA_mu)
OOA_two_epoch_NCurr = OOA_two_epoch_nu * OOA_two_epoch_NAnc
OOA_two_epoch_Time = 2 * 25 * OOA_two_epoch_tau * OOA_two_epoch_theta / (4 * OOA_mu * OOA_two_epoch_allele_sum)
OOA_three_epoch_NAnc = OOA_three_epoch_theta / (4 * OOA_three_epoch_allele_sum * OOA_mu)
OOA_three_epoch_NBottle = OOA_three_epoch_nuB * OOA_three_epoch_NAnc
OOA_three_epoch_NCurr = OOA_three_epoch_nuF * OOA_three_epoch_NAnc
OOA_three_epoch_TimeBottleEnd = 2 * 25 * OOA_three_epoch_tauF * OOA_three_epoch_theta / (4 * OOA_mu * OOA_three_epoch_allele_sum)
OOA_three_epoch_TimeBottleStart = 2 * 25 * OOA_three_epoch_tauB * OOA_three_epoch_theta / (4 * OOA_mu * OOA_three_epoch_allele_sum) + OOA_three_epoch_TimeBottleEnd
OOA_three_epoch_TimeTotal = OOA_three_epoch_TimeBottleStart + OOA_three_epoch_TimeBottleEnd

OOA_two_epoch_max_time = rep(1.25E6, 10)
# OOA_two_epoch_max_time = rep(2E4, 10)
OOA_two_epoch_current_time = rep(0, 10)
OOA_two_epoch_demography = data.frame(OOA_two_epoch_NAnc, OOA_two_epoch_max_time, 
  OOA_two_epoch_NCurr, OOA_two_epoch_Time, 
  OOA_two_epoch_NCurr, OOA_two_epoch_current_time)

# OOA_three_epoch_max_time = rep(100000000, 10)
# OOA_three_epoch_max_time = rep(1.25E6, 10)
OOA_three_epoch_max_time = rep(1.25E6, 10)
OOA_three_epoch_current_time = rep(0, 10)
OOA_three_epoch_demography = data.frame(OOA_three_epoch_NAnc, OOA_three_epoch_max_time,
  OOA_three_epoch_NBottle, OOA_three_epoch_TimeBottleStart,
  OOA_three_epoch_NCurr, OOA_three_epoch_TimeBottleEnd,
  OOA_three_epoch_NCurr, OOA_three_epoch_current_time)

OOA_two_epoch_NEffective_10 = c(OOA_two_epoch_demography[1, 1], OOA_two_epoch_demography[1, 3], OOA_two_epoch_demography[1, 5])
OOA_two_epoch_Time_10 = c(-OOA_two_epoch_demography[1, 2], -OOA_two_epoch_demography[1, 4], OOA_two_epoch_demography[1, 6])
OOA_two_epoch_demography_10 = data.frame(OOA_two_epoch_Time_10, OOA_two_epoch_NEffective_10)
OOA_two_epoch_NEffective_90 = c(OOA_two_epoch_demography[2, 1], OOA_two_epoch_demography[2, 3], OOA_two_epoch_demography[2, 5])
OOA_two_epoch_Time_90 = c(-OOA_two_epoch_demography[2, 2], -OOA_two_epoch_demography[2, 4], OOA_two_epoch_demography[2, 6])
OOA_two_epoch_demography_90 = data.frame(OOA_two_epoch_Time_90, OOA_two_epoch_NEffective_90)
OOA_two_epoch_NEffective_170 = c(OOA_two_epoch_demography[3, 1], OOA_two_epoch_demography[3, 3], OOA_two_epoch_demography[3, 5])
OOA_two_epoch_Time_170 = c(-OOA_two_epoch_demography[3, 2], -OOA_two_epoch_demography[3, 4], OOA_two_epoch_demography[3, 6])
OOA_two_epoch_demography_170 = data.frame(OOA_two_epoch_Time_170, OOA_two_epoch_NEffective_170)
OOA_two_epoch_NEffective_250 = c(OOA_two_epoch_demography[4, 1], OOA_two_epoch_demography[4, 3], OOA_two_epoch_demography[4, 5])
OOA_two_epoch_Time_250 = c(-OOA_two_epoch_demography[4, 2], -OOA_two_epoch_demography[4, 4], OOA_two_epoch_demography[4, 6])
OOA_two_epoch_demography_250 = data.frame(OOA_two_epoch_Time_250, OOA_two_epoch_NEffective_250)
OOA_two_epoch_NEffective_330 = c(OOA_two_epoch_demography[5, 1], OOA_two_epoch_demography[5, 3], OOA_two_epoch_demography[5, 5])
OOA_two_epoch_Time_330 = c(-OOA_two_epoch_demography[5, 2], -OOA_two_epoch_demography[5, 4], OOA_two_epoch_demography[5, 6])
OOA_two_epoch_demography_330 = data.frame(OOA_two_epoch_Time_330, OOA_two_epoch_NEffective_330)
OOA_two_epoch_NEffective_410 = c(OOA_two_epoch_demography[6, 1], OOA_two_epoch_demography[6, 3], OOA_two_epoch_demography[6, 5])
OOA_two_epoch_Time_410 = c(-OOA_two_epoch_demography[6, 2], -OOA_two_epoch_demography[6, 4], OOA_two_epoch_demography[6, 6])
OOA_two_epoch_demography_410 = data.frame(OOA_two_epoch_Time_410, OOA_two_epoch_NEffective_410)
OOA_two_epoch_NEffective_490 = c(OOA_two_epoch_demography[7, 1], OOA_two_epoch_demography[7, 3], OOA_two_epoch_demography[7, 5])
OOA_two_epoch_Time_490 = c(-OOA_two_epoch_demography[7, 2], -OOA_two_epoch_demography[7, 4], OOA_two_epoch_demography[7, 6])
OOA_two_epoch_demography_490 = data.frame(OOA_two_epoch_Time_490, OOA_two_epoch_NEffective_490)
OOA_two_epoch_NEffective_570 = c(OOA_two_epoch_demography[8, 1], OOA_two_epoch_demography[8, 3], OOA_two_epoch_demography[8, 5])
OOA_two_epoch_Time_570 = c(-OOA_two_epoch_demography[8, 2], -OOA_two_epoch_demography[8, 4], OOA_two_epoch_demography[8, 6])
OOA_two_epoch_demography_570 = data.frame(OOA_two_epoch_Time_570, OOA_two_epoch_NEffective_570)
OOA_two_epoch_NEffective_650 = c(OOA_two_epoch_demography[9, 1], OOA_two_epoch_demography[9, 3], OOA_two_epoch_demography[9, 5])
OOA_two_epoch_Time_650 = c(-OOA_two_epoch_demography[9, 2], -OOA_two_epoch_demography[9, 4], OOA_two_epoch_demography[9, 6])
OOA_two_epoch_demography_650 = data.frame(OOA_two_epoch_Time_650, OOA_two_epoch_NEffective_650)
OOA_two_epoch_NEffective_730 = c(OOA_two_epoch_demography[10, 1], OOA_two_epoch_demography[10, 3], OOA_two_epoch_demography[10, 5])
OOA_two_epoch_Time_730 = c(-OOA_two_epoch_demography[10, 2], -OOA_two_epoch_demography[10, 4], OOA_two_epoch_demography[10, 6])
OOA_two_epoch_demography_730 = data.frame(OOA_two_epoch_Time_730, OOA_two_epoch_NEffective_730)

OOA_three_epoch_NEffective_10 = c(OOA_three_epoch_demography[1, 1], OOA_three_epoch_demography[1, 3], OOA_three_epoch_demography[1, 5], OOA_three_epoch_demography[1, 7])
OOA_three_epoch_Time_10 = c(-OOA_three_epoch_demography[1, 2], -OOA_three_epoch_demography[1, 4], -OOA_three_epoch_demography[1, 6], OOA_three_epoch_demography[1, 8])
OOA_three_epoch_demography_10 = data.frame(OOA_three_epoch_Time_10, OOA_three_epoch_NEffective_10)
OOA_three_epoch_NEffective_90 = c(OOA_three_epoch_demography[2, 1], OOA_three_epoch_demography[2, 3], OOA_three_epoch_demography[2, 5], OOA_three_epoch_demography[2, 7])
OOA_three_epoch_Time_90 = c(-OOA_three_epoch_demography[2, 2], -OOA_three_epoch_demography[2, 4], -OOA_three_epoch_demography[2, 6], OOA_three_epoch_demography[2, 8])
OOA_three_epoch_demography_90 = data.frame(OOA_three_epoch_Time_90, OOA_three_epoch_NEffective_90)
OOA_three_epoch_NEffective_170 = c(OOA_three_epoch_demography[3, 1], OOA_three_epoch_demography[3, 3], OOA_three_epoch_demography[3, 5], OOA_three_epoch_demography[3, 7])
OOA_three_epoch_Time_170 = c(-OOA_three_epoch_demography[3, 2], -OOA_three_epoch_demography[3, 4], -OOA_three_epoch_demography[3, 6], OOA_three_epoch_demography[3, 8])
OOA_three_epoch_demography_170 = data.frame(OOA_three_epoch_Time_170, OOA_three_epoch_NEffective_170)
OOA_three_epoch_NEffective_250 = c(OOA_three_epoch_demography[4, 1], OOA_three_epoch_demography[4, 3], OOA_three_epoch_demography[4, 5], OOA_three_epoch_demography[4, 7])
OOA_three_epoch_Time_250 = c(-OOA_three_epoch_demography[4, 2], -OOA_three_epoch_demography[4, 4], -OOA_three_epoch_demography[4, 6], OOA_three_epoch_demography[4, 8])
OOA_three_epoch_demography_250 = data.frame(OOA_three_epoch_Time_250, OOA_three_epoch_NEffective_250)
OOA_three_epoch_NEffective_330 = c(OOA_three_epoch_demography[5, 1], OOA_three_epoch_demography[5, 3], OOA_three_epoch_demography[5, 5], OOA_three_epoch_demography[5, 7])
OOA_three_epoch_Time_330 = c(-OOA_three_epoch_demography[5, 2], -OOA_three_epoch_demography[5, 4], -OOA_three_epoch_demography[5, 6], OOA_three_epoch_demography[5, 8])
OOA_three_epoch_demography_330 = data.frame(OOA_three_epoch_Time_330, OOA_three_epoch_NEffective_330)
OOA_three_epoch_NEffective_410 = c(OOA_three_epoch_demography[6, 1], OOA_three_epoch_demography[6, 3], OOA_three_epoch_demography[6, 5], OOA_three_epoch_demography[6, 7])
OOA_three_epoch_Time_410 = c(-OOA_three_epoch_demography[6, 2], -OOA_three_epoch_demography[6, 4], -OOA_three_epoch_demography[6, 6], OOA_three_epoch_demography[6, 8])
OOA_three_epoch_demography_410 = data.frame(OOA_three_epoch_Time_410, OOA_three_epoch_NEffective_410)
OOA_three_epoch_NEffective_490 = c(OOA_three_epoch_demography[7, 1], OOA_three_epoch_demography[7, 3], OOA_three_epoch_demography[7, 5], OOA_three_epoch_demography[7, 7])
OOA_three_epoch_Time_490 = c(-OOA_three_epoch_demography[7, 2], -OOA_three_epoch_demography[7, 4], -OOA_three_epoch_demography[7, 6], OOA_three_epoch_demography[7, 8])
OOA_three_epoch_demography_490 = data.frame(OOA_three_epoch_Time_490, OOA_three_epoch_NEffective_490)
OOA_three_epoch_NEffective_570 = c(OOA_three_epoch_demography[8, 1], OOA_three_epoch_demography[8, 3], OOA_three_epoch_demography[8, 5], OOA_three_epoch_demography[8, 7])
OOA_three_epoch_Time_570 = c(-OOA_three_epoch_demography[8, 2], -OOA_three_epoch_demography[8, 4], -OOA_three_epoch_demography[8, 6], OOA_three_epoch_demography[8, 8])
OOA_three_epoch_demography_570 = data.frame(OOA_three_epoch_Time_570, OOA_three_epoch_NEffective_570)
OOA_three_epoch_NEffective_650 = c(OOA_three_epoch_demography[9, 1], OOA_three_epoch_demography[9, 3], OOA_three_epoch_demography[9, 5], OOA_three_epoch_demography[9, 7])
OOA_three_epoch_Time_650 = c(-OOA_three_epoch_demography[9, 2], -OOA_three_epoch_demography[9, 4], -OOA_three_epoch_demography[9, 6], OOA_three_epoch_demography[9, 8])
OOA_three_epoch_demography_650 = data.frame(OOA_three_epoch_Time_650, OOA_three_epoch_NEffective_650)
OOA_three_epoch_NEffective_730 = c(OOA_three_epoch_demography[10, 1], OOA_three_epoch_demography[10, 3], OOA_three_epoch_demography[10, 5], OOA_three_epoch_demography[10, 7])
OOA_three_epoch_Time_730 = c(-OOA_three_epoch_demography[10, 2], -OOA_three_epoch_demography[10, 4], -OOA_three_epoch_demography[10, 6], OOA_three_epoch_demography[10, 8])
OOA_three_epoch_demography_730 = data.frame(OOA_three_epoch_Time_730, OOA_three_epoch_NEffective_730)

ggplot(OOA_two_epoch_demography_10, aes(OOA_two_epoch_Time_10, OOA_two_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='dotted') + 
  geom_step(data=OOA_two_epoch_demography_90, aes(OOA_two_epoch_Time_90, OOA_two_epoch_NEffective_90, color='N=90'), linewidth=1, linetype='dotted') +
  geom_step(data=OOA_two_epoch_demography_170, aes(OOA_two_epoch_Time_170, OOA_two_epoch_NEffective_170, color='N=170'), linewidth=1, linetype='dotted') +
  geom_step(data=OOA_two_epoch_demography_250, aes(OOA_two_epoch_Time_250, OOA_two_epoch_NEffective_250, color='N=250'), linewidth=1, linetype='dotted') +
  geom_step(data=OOA_two_epoch_demography_330, aes(OOA_two_epoch_Time_330, OOA_two_epoch_NEffective_330, color='N=330'), linewidth=1, linetype='dotted') +
  geom_step(data=OOA_two_epoch_demography_410, aes(OOA_two_epoch_Time_410, OOA_two_epoch_NEffective_410, color='N=410'), linewidth=1, linetype='dotted') +
  geom_step(data=OOA_two_epoch_demography_490, aes(OOA_two_epoch_Time_490, OOA_two_epoch_NEffective_490, color='N=490'), linewidth=1, linetype='dotted') +
  geom_step(data=OOA_two_epoch_demography_570, aes(OOA_two_epoch_Time_570, OOA_two_epoch_NEffective_570, color='N=570'), linewidth=1, linetype='dotted') +
  geom_step(data=OOA_two_epoch_demography_650, aes(OOA_two_epoch_Time_650, OOA_two_epoch_NEffective_650, color='N=650'), linewidth=1, linetype='dotted') +
  geom_step(data=OOA_two_epoch_demography_730, aes(OOA_two_epoch_Time_730, OOA_two_epoch_NEffective_730, color='N=730'), linewidth=1, linetype='dotted') +
  scale_color_manual(name='Sample Size',
                     breaks=c('N=10', 'N=90', 'N=170', 'N=250', 'N=330', 'N=410', 'N=490', 'N=570', 'N=650', 'N=730'),
                     values=c('N=10'='#7f3b08',
                       'N=90'='#b35806',
                       'N=170'='#e08214',
                       'N=250'='#fdb863',
                       'N=330'='#fee0b6',
                       'N=410'='#d8daeb',
                       'N=490'='#b2abd2',
                       'N=570'='#8073ac',
                       'N=650'='#542788',
                       'N=730'='#2d004b')) +
  theme_bw() +
  ylab('Effective Population Size') +
  xlab('Time in Years') +
  ggtitle('Tennessen OOA two Epoch Demography (N=10-730:80)')

# ggplot(OOA_two_epoch_demography_330, aes(OOA_two_epoch_Time_330, OOA_two_epoch_NEffective_330)) + geom_step(color='#d8daeb', linewidth=1, linetype='dotted') + 
#   # geom_step(data=OOA_two_epoch_demography_90, aes(OOA_two_epoch_Time_90, OOA_two_epoch_NEffective_90), color='#b35806', linewidth=1, linetype='dotted') +
#   # geom_step(data=OOA_two_epoch_demography_170, aes(OOA_two_epoch_Time_170, OOA_two_epoch_NEffective_170), color='#e08214', linewidth=1, linetype='dotted') +
#   # geom_step(data=OOA_two_epoch_demography_250, aes(OOA_two_epoch_Time_250, OOA_two_epoch_NEffective_250), color='#fdb863', linewidth=1, linetype='dotted') +
#   # geom_step(data=OOA_two_epoch_demography_330, aes(OOA_two_epoch_Time_330, OOA_two_epoch_NEffective_330), color='#fee0b6', linewidth=1, linetype='dotted') +
#   geom_step(data=OOA_two_epoch_demography_410, aes(OOA_two_epoch_Time_410, OOA_two_epoch_NEffective_410), color='#d8daeb', linewidth=1, linetype='dotted') +
#   geom_step(data=OOA_two_epoch_demography_490, aes(OOA_two_epoch_Time_490, OOA_two_epoch_NEffective_490), color='#b2abd2', linewidth=1, linetype='dotted') +
#   geom_step(data=OOA_two_epoch_demography_570, aes(OOA_two_epoch_Time_570, OOA_two_epoch_NEffective_570), color='#8073ac', linewidth=1, linetype='dotted') +
#   geom_step(data=OOA_two_epoch_demography_650, aes(OOA_two_epoch_Time_650, OOA_two_epoch_NEffective_650), color='#542788', linewidth=1, linetype='dotted') +
#   geom_step(data=OOA_two_epoch_demography_730, aes(OOA_two_epoch_Time_730, OOA_two_epoch_NEffective_730), color='#2d004b', linewidth=1, linetype='dotted') +
#   theme_bw() +
#   ylab('Effective Population Size') +
#   xlab('Time in Years') +
#   ggtitle('Tennessen OOA two Epoch Demography, 330-730:80')

ggplot(OOA_two_epoch_demography_10, aes(OOA_two_epoch_Time_10, OOA_two_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='dashed') + 
  # geom_step(data=OOA_two_epoch_demography_90, aes(OOA_two_epoch_Time_90, OOA_two_epoch_NEffective_90, color='N=90'), linewidth=1, linetype='dashed') +
  # geom_step(data=OOA_two_epoch_demography_170, aes(OOA_two_epoch_Time_170, OOA_two_epoch_NEffective_170, color='N=170'), linewidth=1, linetype='dashed') +
  # geom_step(data=OOA_two_epoch_demography_250, aes(OOA_two_epoch_Time_250, OOA_two_epoch_NEffective_250, color='N=250'), linewidth=1, linetype='dashed') +
  # geom_step(data=OOA_two_epoch_demography_330, aes(OOA_two_epoch_Time_330, OOA_two_epoch_NEffective_330, color='N=330'), linewidth=1, linetype='dashed') +
  # geom_step(data=OOA_two_epoch_demography_410, aes(OOA_two_epoch_Time_410, OOA_two_epoch_NEffective_410, color='N=410'), linewidth=1, linetype='dashed') +
  # geom_step(data=OOA_two_epoch_demography_490, aes(OOA_two_epoch_Time_490, OOA_two_epoch_NEffective_490, color='N=490'), linewidth=1, linetype='dashed') +
  # geom_step(data=OOA_two_epoch_demography_570, aes(OOA_two_epoch_Time_570, OOA_two_epoch_NEffective_570, color='N=570'), linewidth=1, linetype='dashed') +
  # geom_step(data=OOA_two_epoch_demography_650, aes(OOA_two_epoch_Time_650, OOA_two_epoch_NEffective_650, color='N=650'), linewidth=1, linetype='dashed') +
  # geom_step(data=OOA_two_epoch_demography_730, aes(OOA_two_epoch_Time_730, OOA_two_epoch_NEffective_730, color='N=730'), linewidth=1, linetype='dashed') +
  # geom_step(data=OOA_three_epoch_demography_10, aes(OOA_three_epoch_Time_10, OOA_three_epoch_NEffective_10, color='N=10'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_90, aes(OOA_three_epoch_Time_90, OOA_three_epoch_NEffective_90, color='N=90'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_170, aes(OOA_three_epoch_Time_170, OOA_three_epoch_NEffective_170, color='N=170'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_250, aes(OOA_three_epoch_Time_250, OOA_three_epoch_NEffective_250, color='N=250'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_330, aes(OOA_three_epoch_Time_330, OOA_three_epoch_NEffective_330, color='N=330'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_410, aes(OOA_three_epoch_Time_410, OOA_three_epoch_NEffective_410, color='N=410'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_490, aes(OOA_three_epoch_Time_490, OOA_three_epoch_NEffective_490, color='N=490'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_570, aes(OOA_three_epoch_Time_570, OOA_three_epoch_NEffective_570, color='N=570'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_650, aes(OOA_three_epoch_Time_650, OOA_three_epoch_NEffective_650, color='N=650'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_730, aes(OOA_three_epoch_Time_730, OOA_three_epoch_NEffective_730, color='N=730'), linewidth=1, linetype='solid') +
  theme_bw() +
  scale_color_manual(name='Sample Size',
                     breaks=c('N=10', 'N=90', 'N=170', 'N=250', 'N=330', 'N=410', 'N=490', 'N=570', 'N=650', 'N=730'),
                     values=c('N=10'='#7f3b08',
                       'N=90'='#b35806',
                       'N=170'='#e08214',
                       'N=250'='#fdb863',
                       'N=330'='#fee0b6',
                       'N=410'='#d8daeb',
                       'N=490'='#b2abd2',
                       'N=570'='#8073ac',
                       'N=650'='#542788',
                       'N=730'='#2d004b'))+
  ylab('Effective Population Size') +
  xlab('Time in Years') +
  ggtitle('Tennessen OOA Best-fitting Demography (N=10-730:80)')

ggplot(OOA_three_epoch_demography_10, aes(OOA_three_epoch_Time_10, OOA_three_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='solid') + 
  geom_step(data=OOA_three_epoch_demography_90, aes(OOA_three_epoch_Time_90, OOA_three_epoch_NEffective_90, color='N=90'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_170, aes(OOA_three_epoch_Time_170, OOA_three_epoch_NEffective_170, color='N=170'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_250, aes(OOA_three_epoch_Time_250, OOA_three_epoch_NEffective_250, color='N=250'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_330, aes(OOA_three_epoch_Time_330, OOA_three_epoch_NEffective_330, color='N=330'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_410, aes(OOA_three_epoch_Time_410, OOA_three_epoch_NEffective_410, color='N=410'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_490, aes(OOA_three_epoch_Time_490, OOA_three_epoch_NEffective_490, color='N=490'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_570, aes(OOA_three_epoch_Time_570, OOA_three_epoch_NEffective_570, color='N=570'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_650, aes(OOA_three_epoch_Time_650, OOA_three_epoch_NEffective_650, color='N=650'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_730, aes(OOA_three_epoch_Time_730, OOA_three_epoch_NEffective_730, color='N=730'), linewidth=1, linetype='solid') +
  scale_color_manual(name='Sample Size',
                     breaks=c('N=10', 'N=90', 'N=170', 'N=250', 'N=330', 'N=410', 'N=490', 'N=570', 'N=650', 'N=730'),
                     values=c('N=10'='#7f3b08',
                       'N=90'='#b35806',
                       'N=170'='#e08214',
                       'N=250'='#fdb863',
                       'N=330'='#fee0b6',
                       'N=410'='#d8daeb',
                       'N=490'='#b2abd2',
                       'N=570'='#8073ac',
                       'N=650'='#542788',
                       'N=730'='#2d004b')) +
  theme_bw() +
  ylab('Effective Population Size') +
  xlab('Time in Years') +
  ggtitle('Tennessen OOA Three Epoch Demography (N=10-730:80)')

# ggplot(OOA_three_epoch_demography_90, aes(OOA_three_epoch_Time_90, OOA_three_epoch_NEffective_90)) + geom_step(color='#b35806', linewidth=1, linetype='solid') + 
#   # geom_step(data=OOA_three_epoch_demography_90, aes(OOA_three_epoch_Time_90, OOA_three_epoch_NEffective_90), color='#b35806', linewidth=1, linetype='solid') +
#   geom_step(data=OOA_three_epoch_demography_170, aes(OOA_three_epoch_Time_170, OOA_three_epoch_NEffective_170), color='#e08214', linewidth=1, linetype='solid') +
#   geom_step(data=OOA_three_epoch_demography_250, aes(OOA_three_epoch_Time_250, OOA_three_epoch_NEffective_250), color='#fdb863', linewidth=1, linetype='solid') +
#   geom_step(data=OOA_three_epoch_demography_330, aes(OOA_three_epoch_Time_330, OOA_three_epoch_NEffective_330), color='#fee0b6', linewidth=1, linetype='solid') +
#   geom_step(data=OOA_three_epoch_demography_410, aes(OOA_three_epoch_Time_410, OOA_three_epoch_NEffective_410), color='#d8daeb', linewidth=1, linetype='solid') +
#   geom_step(data=OOA_three_epoch_demography_490, aes(OOA_three_epoch_Time_490, OOA_three_epoch_NEffective_490), color='#b2abd2', linewidth=1, linetype='solid') +
#   geom_step(data=OOA_three_epoch_demography_570, aes(OOA_three_epoch_Time_570, OOA_three_epoch_NEffective_570), color='#8073ac', linewidth=1, linetype='solid') +
#   geom_step(data=OOA_three_epoch_demography_650, aes(OOA_three_epoch_Time_650, OOA_three_epoch_NEffective_650), color='#542788', linewidth=1, linetype='solid') +
#   geom_step(data=OOA_three_epoch_demography_730, aes(OOA_three_epoch_Time_730, OOA_three_epoch_NEffective_730), color='#2d004b', linewidth=1, linetype='solid') +
#   theme_bw() +
#   ylab('Effective Population Size') +
#   xlab('Time in Years') +
#   ggtitle('Tennessen OOA Three Epoch Demography, 90-730:80')

# NAnc Estimate by Sample Size
sample_size = c(10, 90, 170, 250, 330, 410, 490, 570, 650, 730)

NAnc_df = data.frame(sample_size, OOA_one_epoch_NAnc, OOA_two_epoch_NAnc, OOA_three_epoch_NAnc)
NAnc_df = melt(NAnc_df, id='sample_size')

ggplot(data=NAnc_df, aes(x=sample_size, y=value, color=variable)) + geom_line() +
  xlab('Sample size') +
  ylab('Estimated ancestral effective population size') +
  ggtitle('Tennessen OOA NAnc by sample size (N=10-730:80)') +
  theme_bw() +
  guides(color=guide_legend(title="Epoch")) +
  scale_color_manual(
    labels=c('One-epoch', 'Two-epoch', 'Three-epoch'),
    values=c('red', 'blue', 'green')) +
  geom_hline(yintercept=12378, color='black', linetype='dashed') +
  scale_x_continuous(breaks=sample_size)

# # Tennessen_OOA 10-100:10
OOA_empirical_file_list = list()
OOA_one_epoch_file_list = list()
OOA_two_epoch_file_list = list()
OOA_three_epoch_file_list = list()
OOA_one_epoch_AIC = c()
OOA_one_epoch_LL = c()
OOA_one_epoch_theta = c()
OOA_one_epoch_allele_sum = c()
OOA_two_epoch_AIC = c()
OOA_two_epoch_LL = c()
OOA_two_epoch_theta = c()
OOA_two_epoch_nu = c()
OOA_two_epoch_tau = c()
OOA_two_epoch_allele_sum = c()
OOA_three_epoch_AIC = c()
OOA_three_epoch_LL = c()
OOA_three_epoch_theta = c()
OOA_three_epoch_nuB = c()
OOA_three_epoch_nuF = c()
OOA_three_epoch_tauB = c()
OOA_three_epoch_tauF = c()
OOA_three_epoch_allele_sum = c()

# Loop through subdirectories and get relevant files
for (i in seq(10, 100, by = 10)) {
  subdirectory <- paste0("../Analysis/ooa_simulated_", i)
  OOA_empirical_file_path <- file.path(subdirectory, "syn_downsampled_sfs.txt")
  OOA_one_epoch_file_path <- file.path(subdirectory, "one_epoch_demography.txt")
  OOA_two_epoch_file_path <- file.path(subdirectory, "two_epoch_demography.txt")
  OOA_three_epoch_file_path <- file.path(subdirectory, "three_epoch_demography.txt")
  
  # Check if the file exists before attempting to read and print its contents
  if (file.exists(OOA_empirical_file_path)) {
    this_empirical_sfs = read_input_sfs(OOA_empirical_file_path)
    OOA_empirical_file_list[[subdirectory]] = this_empirical_sfs
  }
  if (file.exists(OOA_one_epoch_file_path)) {
    this_one_epoch_sfs = sfs_from_demography(OOA_one_epoch_file_path)
    OOA_one_epoch_file_list[[subdirectory]] = this_one_epoch_sfs
    OOA_one_epoch_AIC = c(OOA_one_epoch_AIC, AIC_from_demography(OOA_one_epoch_file_path))
    OOA_one_epoch_LL = c(OOA_one_epoch_LL, LL_from_demography(OOA_one_epoch_file_path))
    OOA_one_epoch_theta = c(OOA_one_epoch_theta, theta_from_demography(OOA_one_epoch_file_path))
    OOA_one_epoch_allele_sum = c(OOA_one_epoch_allele_sum, sum(this_one_epoch_sfs))
  }
  if (file.exists(OOA_two_epoch_file_path)) {
    this_two_epoch_sfs = sfs_from_demography(OOA_two_epoch_file_path)
    OOA_two_epoch_file_list[[subdirectory]] = this_two_epoch_sfs
    OOA_two_epoch_AIC = c(OOA_two_epoch_AIC, AIC_from_demography(OOA_two_epoch_file_path))
    OOA_two_epoch_LL = c(OOA_two_epoch_LL, LL_from_demography(OOA_two_epoch_file_path))
    OOA_two_epoch_theta = c(OOA_two_epoch_theta, theta_from_demography(OOA_two_epoch_file_path))
    OOA_two_epoch_nu = c(OOA_two_epoch_nu, nu_from_demography(OOA_two_epoch_file_path))
    OOA_two_epoch_tau = c(OOA_two_epoch_tau, tau_from_demography(OOA_two_epoch_file_path))
    OOA_two_epoch_allele_sum = c(OOA_two_epoch_allele_sum, sum(this_two_epoch_sfs))
  }
  if (file.exists(OOA_three_epoch_file_path)) {
    this_three_epoch_sfs = sfs_from_demography(OOA_three_epoch_file_path)
    OOA_three_epoch_file_list[[subdirectory]] = this_three_epoch_sfs
    OOA_three_epoch_AIC = c(OOA_three_epoch_AIC, AIC_from_demography(OOA_three_epoch_file_path))
    OOA_three_epoch_LL = c(OOA_three_epoch_LL, LL_from_demography(OOA_three_epoch_file_path))
    OOA_three_epoch_theta = c(OOA_three_epoch_theta, theta_from_demography(OOA_three_epoch_file_path))
    OOA_three_epoch_nuB = c(OOA_three_epoch_nuB, nuB_from_demography(OOA_three_epoch_file_path))
    OOA_three_epoch_nuF = c(OOA_three_epoch_nuF, nuF_from_demography(OOA_three_epoch_file_path))
    OOA_three_epoch_tauB = c(OOA_three_epoch_tauB, tauB_from_demography(OOA_three_epoch_file_path))
    OOA_three_epoch_tauF = c(OOA_three_epoch_tauF, tauF_from_demography(OOA_three_epoch_file_path))
    OOA_three_epoch_allele_sum = c(OOA_three_epoch_allele_sum, sum(this_three_epoch_sfs))
  }  
}

OOA_AIC_df = data.frame(OOA_one_epoch_AIC, OOA_two_epoch_AIC, OOA_three_epoch_AIC)
# Reshape the data from wide to long format
OOA_df_long <- tidyr::gather(OOA_AIC_df, key = "Epoch", value = "AIC", OOA_one_epoch_AIC:OOA_three_epoch_AIC)

# Increase the x-axis index by 4
OOA_df_long$Index <- rep(seq(10, 100, by = 10), times = 3)

# Create the line plot with ggplot2
ggplot(OOA_df_long, aes(x = Index, y = AIC, color = Epoch)) +
  geom_line() +
  geom_point() +
  labs(title = "Tennessen OOA AIC values by sample size",
       x = "Sample Size",
       y = "AIC") +
  scale_y_log10() +
  scale_x_continuous(breaks=OOA_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('One-epoch', 'Three-epoch', 'Two-epoch')) +
  theme_bw()

OOA_lambda_two_one = 2 * (OOA_two_epoch_LL - OOA_one_epoch_LL)
OOA_lambda_three_one = 2 * (OOA_three_epoch_LL - OOA_one_epoch_LL)
OOA_lambda_three_two = 2 * (OOA_three_epoch_LL - OOA_two_epoch_LL)

OOA_lambda_df = data.frame(OOA_lambda_two_one, OOA_lambda_three_one, OOA_lambda_three_two)
# Reshape the data from wide to long format
OOA_df_long_lambda <- tidyr::gather(OOA_lambda_df, key = "Full_vs_Null", value = "Lambda", OOA_lambda_two_one:OOA_lambda_three_two)
# Increase the x-axis index by 4
OOA_df_long_lambda$Index <- rep(seq(10, 100, by = 10), times = 3)

# Create the line plot with ggplot2
ggplot(OOA_df_long_lambda, aes(x = Index, y = Lambda, color = Full_vs_Null)) +
  geom_line() +
  geom_point() +
  labs(title = "Tennessen OOA Lambda values by sample size (N=10-100:10)",
       x = "Sample Size",
       y = "2 * Lambda") +
  # scale_y_log10() +
  scale_x_continuous(breaks=OOA_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('Three vs. One', 'Three vs. Two', 'Two vs. One')) +
  theme_bw()

OOA_one_epoch_residual = c()
OOA_two_epoch_residual = c()
OOA_three_epoch_residual = c()

for (i in 1:10) {
  OOA_one_epoch_residual = c(OOA_one_epoch_residual, compute_residual(unlist(OOA_empirical_file_list[i]), unlist(OOA_one_epoch_file_list[i])))
  OOA_two_epoch_residual = c(OOA_two_epoch_residual, compute_residual(unlist(OOA_empirical_file_list[i]), unlist(OOA_two_epoch_file_list[i])))
  OOA_three_epoch_residual = c(OOA_three_epoch_residual, compute_residual(unlist(OOA_empirical_file_list[i]), unlist(OOA_three_epoch_file_list[i])))
}

OOA_residual_df = data.frame(OOA_one_epoch_residual, OOA_two_epoch_residual, OOA_three_epoch_residual)
# Reshape the data from wide to long format
OOA_df_long_residual <- tidyr::gather(OOA_residual_df, key = "Epoch", value = "residual", OOA_one_epoch_residual:OOA_three_epoch_residual)

# Increase the x-axis index by 4
OOA_df_long_residual$Index <- rep(seq(10, 100, by = 10), times = 3)

# Create the line plot with ggplot2
ggplot(OOA_df_long_residual, aes(x = Index, y = residual, color = Epoch)) +
  geom_line() +
  geom_point() +
  labs(title = "OOA residual values by sample size",
       x = "Sample Size",
       y = "Residual") +
  scale_y_log10() +
  scale_x_continuous(breaks=OOA_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('One-epoch', 'Three-epoch', 'Two-epoch')) +
  theme_bw()

ggplot(OOA_df_long, aes(x = Index, y = AIC, color = Epoch)) +
  geom_line(linetype=3) +
  geom_point() +
  labs(title = "Tennessen OOA AIC and residual by sample size (N=10-100:10)",
       x = "Sample Size",
       y = "AIC") +
  scale_y_log10(sec.axis = sec_axis(~.*1, name="Residual")) +
  scale_x_continuous(breaks=OOA_df_long$Index) +
  geom_line(data=OOA_df_long_residual, aes(x = Index, y = residual*1, color = Epoch)) +
  scale_color_manual(values = c("blue", "orange", "green", "violet", "red", "seagreen"),
    label=c('One-epoch AIC', 'One-epoch residual',
      'Three-epoch AIC', 'Three-epoch residual',
      'Two-epoch AIC', 'Two-epoch residual')) +
  theme_bw()

# Tennessen_OOA population genetic constants

OOA_mu = 1.5E-8

# NAnc = theta / (4 * allele_sum * mu)
# generations = 2 * tau * theta / (4 * mu * allele_sum)
# years = generations / 365
# NCurr = nu * NAnc
# generations_b = 2 * tauB * theta / (4 * mu * allele_sum)
# generations_f = 2 * tauF * theta / (4 * mu * allele_sum)
# NBottle = nuB * NAnc
# NSince = nuF * NAnc

OOA_one_epoch_NAnc = OOA_one_epoch_theta / (4 * OOA_one_epoch_allele_sum * OOA_mu)
OOA_two_epoch_NAnc = OOA_two_epoch_theta / (4 * OOA_two_epoch_allele_sum * OOA_mu)
OOA_two_epoch_NCurr = OOA_two_epoch_nu * OOA_two_epoch_NAnc
OOA_two_epoch_Time = 2 * 25 * OOA_two_epoch_tau * OOA_two_epoch_theta / (4 * OOA_mu * OOA_two_epoch_allele_sum)
OOA_three_epoch_NAnc = OOA_three_epoch_theta / (4 * OOA_three_epoch_allele_sum * OOA_mu)
OOA_three_epoch_NBottle = OOA_three_epoch_nuB * OOA_three_epoch_NAnc
OOA_three_epoch_NCurr = OOA_three_epoch_nuF * OOA_three_epoch_NAnc
OOA_three_epoch_TimeBottleEnd = 2 * 25 * OOA_three_epoch_tauF * OOA_three_epoch_theta / (4 * OOA_mu * OOA_three_epoch_allele_sum)
OOA_three_epoch_TimeBottleStart = 2 * 25 * OOA_three_epoch_tauB * OOA_three_epoch_theta / (4 * OOA_mu * OOA_three_epoch_allele_sum) + OOA_three_epoch_TimeBottleEnd
OOA_three_epoch_TimeTotal = OOA_three_epoch_TimeBottleStart + OOA_three_epoch_TimeBottleEnd

OOA_two_epoch_max_time = rep(2E6, 10)
# OOA_two_epoch_max_time = rep(2E4, 10)
OOA_two_epoch_current_time = rep(0, 10)
OOA_two_epoch_demography = data.frame(OOA_two_epoch_NAnc, OOA_two_epoch_max_time, 
  OOA_two_epoch_NCurr, OOA_two_epoch_Time, 
  OOA_two_epoch_NCurr, OOA_two_epoch_current_time)

# OOA_three_epoch_max_time = rep(100000000, 10)
# OOA_three_epoch_max_time = rep(5E6, 10)
OOA_three_epoch_max_time = rep(2E6, 10)
OOA_three_epoch_current_time = rep(0, 10)
OOA_three_epoch_demography = data.frame(OOA_three_epoch_NAnc, OOA_three_epoch_max_time,
  OOA_three_epoch_NBottle, OOA_three_epoch_TimeBottleStart,
  OOA_three_epoch_NCurr, OOA_three_epoch_TimeBottleEnd,
  OOA_three_epoch_NCurr, OOA_three_epoch_current_time)

OOA_two_epoch_NEffective_10 = c(OOA_two_epoch_demography[1, 1], OOA_two_epoch_demography[1, 3], OOA_two_epoch_demography[1, 5])
OOA_two_epoch_Time_10 = c(-OOA_two_epoch_demography[1, 2], -OOA_two_epoch_demography[1, 4], OOA_two_epoch_demography[1, 6])
OOA_two_epoch_demography_10 = data.frame(OOA_two_epoch_Time_10, OOA_two_epoch_NEffective_10)
OOA_two_epoch_NEffective_20 = c(OOA_two_epoch_demography[2, 1], OOA_two_epoch_demography[2, 3], OOA_two_epoch_demography[2, 5])
OOA_two_epoch_Time_20 = c(-OOA_two_epoch_demography[2, 2], -OOA_two_epoch_demography[2, 4], OOA_two_epoch_demography[2, 6])
OOA_two_epoch_demography_20 = data.frame(OOA_two_epoch_Time_20, OOA_two_epoch_NEffective_20)
OOA_two_epoch_NEffective_30 = c(OOA_two_epoch_demography[3, 1], OOA_two_epoch_demography[3, 3], OOA_two_epoch_demography[3, 5])
OOA_two_epoch_Time_30 = c(-OOA_two_epoch_demography[3, 2], -OOA_two_epoch_demography[3, 4], OOA_two_epoch_demography[3, 6])
OOA_two_epoch_demography_30 = data.frame(OOA_two_epoch_Time_30, OOA_two_epoch_NEffective_30)
OOA_two_epoch_NEffective_40 = c(OOA_two_epoch_demography[4, 1], OOA_two_epoch_demography[4, 3], OOA_two_epoch_demography[4, 5])
OOA_two_epoch_Time_40 = c(-OOA_two_epoch_demography[4, 2], -OOA_two_epoch_demography[4, 4], OOA_two_epoch_demography[4, 6])
OOA_two_epoch_demography_40 = data.frame(OOA_two_epoch_Time_40, OOA_two_epoch_NEffective_40)
OOA_two_epoch_NEffective_50 = c(OOA_two_epoch_demography[5, 1], OOA_two_epoch_demography[5, 3], OOA_two_epoch_demography[5, 5])
OOA_two_epoch_Time_50 = c(-OOA_two_epoch_demography[5, 2], -OOA_two_epoch_demography[5, 4], OOA_two_epoch_demography[5, 6])
OOA_two_epoch_demography_50 = data.frame(OOA_two_epoch_Time_50, OOA_two_epoch_NEffective_50)
OOA_two_epoch_NEffective_60 = c(OOA_two_epoch_demography[6, 1], OOA_two_epoch_demography[6, 3], OOA_two_epoch_demography[6, 5])
OOA_two_epoch_Time_60 = c(-OOA_two_epoch_demography[6, 2], -OOA_two_epoch_demography[6, 4], OOA_two_epoch_demography[6, 6])
OOA_two_epoch_demography_60 = data.frame(OOA_two_epoch_Time_60, OOA_two_epoch_NEffective_60)
OOA_two_epoch_NEffective_70 = c(OOA_two_epoch_demography[7, 1], OOA_two_epoch_demography[7, 3], OOA_two_epoch_demography[7, 5])
OOA_two_epoch_Time_70 = c(-OOA_two_epoch_demography[7, 2], -OOA_two_epoch_demography[7, 4], OOA_two_epoch_demography[7, 6])
OOA_two_epoch_demography_70 = data.frame(OOA_two_epoch_Time_70, OOA_two_epoch_NEffective_70)
OOA_two_epoch_NEffective_80 = c(OOA_two_epoch_demography[8, 1], OOA_two_epoch_demography[8, 3], OOA_two_epoch_demography[8, 5])
OOA_two_epoch_Time_80 = c(-OOA_two_epoch_demography[8, 2], -OOA_two_epoch_demography[8, 4], OOA_two_epoch_demography[8, 6])
OOA_two_epoch_demography_80 = data.frame(OOA_two_epoch_Time_80, OOA_two_epoch_NEffective_80)
OOA_two_epoch_NEffective_90 = c(OOA_two_epoch_demography[9, 1], OOA_two_epoch_demography[9, 3], OOA_two_epoch_demography[9, 5])
OOA_two_epoch_Time_90 = c(-OOA_two_epoch_demography[9, 2], -OOA_two_epoch_demography[9, 4], OOA_two_epoch_demography[9, 6])
OOA_two_epoch_demography_90 = data.frame(OOA_two_epoch_Time_90, OOA_two_epoch_NEffective_90)
OOA_two_epoch_NEffective_100 = c(OOA_two_epoch_demography[10, 1], OOA_two_epoch_demography[10, 3], OOA_two_epoch_demography[10, 5])
OOA_two_epoch_Time_100 = c(-OOA_two_epoch_demography[10, 2], -OOA_two_epoch_demography[10, 4], OOA_two_epoch_demography[10, 6])
OOA_two_epoch_demography_100 = data.frame(OOA_two_epoch_Time_100, OOA_two_epoch_NEffective_100)

OOA_three_epoch_NEffective_10 = c(OOA_three_epoch_demography[1, 1], OOA_three_epoch_demography[1, 3], OOA_three_epoch_demography[1, 5], OOA_three_epoch_demography[1, 7])
OOA_three_epoch_Time_10 = c(-OOA_three_epoch_demography[1, 2], -OOA_three_epoch_demography[1, 4], -OOA_three_epoch_demography[1, 6], OOA_three_epoch_demography[1, 8])
OOA_three_epoch_demography_10 = data.frame(OOA_three_epoch_Time_10, OOA_three_epoch_NEffective_10)
OOA_three_epoch_NEffective_20 = c(OOA_three_epoch_demography[2, 1], OOA_three_epoch_demography[2, 3], OOA_three_epoch_demography[2, 5], OOA_three_epoch_demography[2, 7])
OOA_three_epoch_Time_20 = c(-OOA_three_epoch_demography[2, 2], -OOA_three_epoch_demography[2, 4], -OOA_three_epoch_demography[2, 6], OOA_three_epoch_demography[2, 8])
OOA_three_epoch_demography_20 = data.frame(OOA_three_epoch_Time_20, OOA_three_epoch_NEffective_20)
OOA_three_epoch_NEffective_30 = c(OOA_three_epoch_demography[3, 1], OOA_three_epoch_demography[3, 3], OOA_three_epoch_demography[3, 5], OOA_three_epoch_demography[3, 7])
OOA_three_epoch_Time_30 = c(-OOA_three_epoch_demography[3, 2], -OOA_three_epoch_demography[3, 4], -OOA_three_epoch_demography[3, 6], OOA_three_epoch_demography[3, 8])
OOA_three_epoch_demography_30 = data.frame(OOA_three_epoch_Time_30, OOA_three_epoch_NEffective_30)
OOA_three_epoch_NEffective_40 = c(OOA_three_epoch_demography[4, 1], OOA_three_epoch_demography[4, 3], OOA_three_epoch_demography[4, 5], OOA_three_epoch_demography[4, 7])
OOA_three_epoch_Time_40 = c(-OOA_three_epoch_demography[4, 2], -OOA_three_epoch_demography[4, 4], -OOA_three_epoch_demography[4, 6], OOA_three_epoch_demography[4, 8])
OOA_three_epoch_demography_40 = data.frame(OOA_three_epoch_Time_40, OOA_three_epoch_NEffective_40)
OOA_three_epoch_NEffective_50 = c(OOA_three_epoch_demography[5, 1], OOA_three_epoch_demography[5, 3], OOA_three_epoch_demography[5, 5], OOA_three_epoch_demography[5, 7])
OOA_three_epoch_Time_50 = c(-OOA_three_epoch_demography[5, 2], -OOA_three_epoch_demography[5, 4], -OOA_three_epoch_demography[5, 6], OOA_three_epoch_demography[5, 8])
OOA_three_epoch_demography_50 = data.frame(OOA_three_epoch_Time_50, OOA_three_epoch_NEffective_50)
OOA_three_epoch_NEffective_60 = c(OOA_three_epoch_demography[6, 1], OOA_three_epoch_demography[6, 3], OOA_three_epoch_demography[6, 5], OOA_three_epoch_demography[6, 7])
OOA_three_epoch_Time_60 = c(-OOA_three_epoch_demography[6, 2], -OOA_three_epoch_demography[6, 4], -OOA_three_epoch_demography[6, 6], OOA_three_epoch_demography[6, 8])
OOA_three_epoch_demography_60 = data.frame(OOA_three_epoch_Time_60, OOA_three_epoch_NEffective_60)
OOA_three_epoch_NEffective_70 = c(OOA_three_epoch_demography[7, 1], OOA_three_epoch_demography[7, 3], OOA_three_epoch_demography[7, 5], OOA_three_epoch_demography[7, 7])
OOA_three_epoch_Time_70 = c(-OOA_three_epoch_demography[7, 2], -OOA_three_epoch_demography[7, 4], -OOA_three_epoch_demography[7, 6], OOA_three_epoch_demography[7, 8])
OOA_three_epoch_demography_70 = data.frame(OOA_three_epoch_Time_70, OOA_three_epoch_NEffective_70)
OOA_three_epoch_NEffective_80 = c(OOA_three_epoch_demography[8, 1], OOA_three_epoch_demography[8, 3], OOA_three_epoch_demography[8, 5], OOA_three_epoch_demography[8, 7])
OOA_three_epoch_Time_80 = c(-OOA_three_epoch_demography[8, 2], -OOA_three_epoch_demography[8, 4], -OOA_three_epoch_demography[8, 6], OOA_three_epoch_demography[8, 8])
OOA_three_epoch_demography_80 = data.frame(OOA_three_epoch_Time_80, OOA_three_epoch_NEffective_80)
OOA_three_epoch_NEffective_90 = c(OOA_three_epoch_demography[9, 1], OOA_three_epoch_demography[9, 3], OOA_three_epoch_demography[9, 5], OOA_three_epoch_demography[9, 7])
OOA_three_epoch_Time_90 = c(-OOA_three_epoch_demography[9, 2], -OOA_three_epoch_demography[9, 4], -OOA_three_epoch_demography[9, 6], OOA_three_epoch_demography[9, 8])
OOA_three_epoch_demography_90 = data.frame(OOA_three_epoch_Time_90, OOA_three_epoch_NEffective_90)
OOA_three_epoch_NEffective_100 = c(OOA_three_epoch_demography[10, 1], OOA_three_epoch_demography[10, 3], OOA_three_epoch_demography[10, 5], OOA_three_epoch_demography[10, 7])
OOA_three_epoch_Time_100 = c(-OOA_three_epoch_demography[10, 2], -OOA_three_epoch_demography[10, 4], -OOA_three_epoch_demography[10, 6], OOA_three_epoch_demography[10, 8])
OOA_three_epoch_demography_100 = data.frame(OOA_three_epoch_Time_100, OOA_three_epoch_NEffective_100)

ggplot(OOA_two_epoch_demography_10, aes(OOA_two_epoch_Time_10, OOA_two_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='dotted') + 
  geom_step(data=OOA_two_epoch_demography_20, aes(OOA_two_epoch_Time_20, OOA_two_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='dotted') +
  geom_step(data=OOA_two_epoch_demography_30, aes(OOA_two_epoch_Time_30, OOA_two_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='dotted') +
  geom_step(data=OOA_two_epoch_demography_40, aes(OOA_two_epoch_Time_40, OOA_two_epoch_NEffective_40, color='N=40'), linewidth=1, linetype='dotted') +
  geom_step(data=OOA_two_epoch_demography_50, aes(OOA_two_epoch_Time_50, OOA_two_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='dotted') +
  geom_step(data=OOA_two_epoch_demography_60, aes(OOA_two_epoch_Time_60, OOA_two_epoch_NEffective_60, color='N=60'), linewidth=1, linetype='dotted') +
  geom_step(data=OOA_two_epoch_demography_70, aes(OOA_two_epoch_Time_70, OOA_two_epoch_NEffective_70, color='N=70'), linewidth=1, linetype='dotted') +
  geom_step(data=OOA_two_epoch_demography_80, aes(OOA_two_epoch_Time_80, OOA_two_epoch_NEffective_80, color='N=80'), linewidth=1, linetype='dotted') +
  geom_step(data=OOA_two_epoch_demography_90, aes(OOA_two_epoch_Time_90, OOA_two_epoch_NEffective_90, color='N=90'), linewidth=1, linetype='dotted') +
  geom_step(data=OOA_two_epoch_demography_100, aes(OOA_two_epoch_Time_100, OOA_two_epoch_NEffective_100, color='N=100'), linewidth=1, linetype='dotted') +
  scale_color_manual(name='Sample Size',
                     breaks=c('N=10', 'N=20', 'N=30', 'N=40', 'N=50', 'N=60', 'N=70', 'N=80', 'N=90', 'N=100'),
                     values=c('N=10'='#7f3b08',
                       'N=20'='#b35806',
                       'N=30'='#e08214',
                       'N=40'='#fdb863',
                       'N=50'='#fee0b6',
                       'N=60'='#d8daeb',
                       'N=70'='#b2abd2',
                       'N=80'='#8073ac',
                       'N=90'='#542788',
                       'N=100'='#2d004b')) +
  theme_bw() +
  ylab('Effective Population Size') +
  xlab('Time in Years') +
  ggtitle('Tennessen OOA two Epoch Demography (N=10-100:10)')

ggplot(OOA_two_epoch_demography_10, aes(OOA_two_epoch_Time_10, OOA_two_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='dashed') + 
  # geom_step(data=OOA_two_epoch_demography_20, aes(OOA_two_epoch_Time_20, OOA_two_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='dashed') +
  # geom_step(data=OOA_two_epoch_demography_30, aes(OOA_two_epoch_Time_30, OOA_two_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='dashed') +
  # geom_step(data=OOA_two_epoch_demography_40, aes(OOA_two_epoch_Time_40, OOA_two_epoch_NEffective_40, color='N=40'), linewidth=1, linetype='dashed') +
  # geom_step(data=OOA_two_epoch_demography_50, aes(OOA_two_epoch_Time_50, OOA_two_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='dashed') +
  # geom_step(data=OOA_two_epoch_demography_60, aes(OOA_two_epoch_Time_60, OOA_two_epoch_NEffective_60, color='N=60'), linewidth=1, linetype='dashed') +
  # geom_step(data=OOA_two_epoch_demography_70, aes(OOA_two_epoch_Time_70, OOA_two_epoch_NEffective_70, color='N=70'), linewidth=1, linetype='dashed') +
  # geom_step(data=OOA_two_epoch_demography_80, aes(OOA_two_epoch_Time_80, OOA_two_epoch_NEffective_80, color='N=80'), linewidth=1, linetype='dashed') +
  # geom_step(data=OOA_two_epoch_demography_90, aes(OOA_two_epoch_Time_90, OOA_two_epoch_NEffective_90, color='N=90'), linewidth=1, linetype='dashed') +
  # geom_step(data=OOA_two_epoch_demography_100, aes(OOA_two_epoch_Time_100, OOA_two_epoch_NEffective_100, color='#N=100'), linewidth=1, linetype='dashed') +
  # geom_step(data=OOA_three_epoch_demography_10, aes(OOA_three_epoch_Time_10, OOA_three_epoch_NEffective_10, color='N=10'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_20, aes(OOA_three_epoch_Time_20, OOA_three_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_30, aes(OOA_three_epoch_Time_30, OOA_three_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_40, aes(OOA_three_epoch_Time_40, OOA_three_epoch_NEffective_40, color='N=40'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_50, aes(OOA_three_epoch_Time_50, OOA_three_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_60, aes(OOA_three_epoch_Time_60, OOA_three_epoch_NEffective_60, color='N=60'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_70, aes(OOA_three_epoch_Time_70, OOA_three_epoch_NEffective_70, color='N=70'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_80, aes(OOA_three_epoch_Time_80, OOA_three_epoch_NEffective_80, color='N=80'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_90, aes(OOA_three_epoch_Time_90, OOA_three_epoch_NEffective_90, color='N=90'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_100, aes(OOA_three_epoch_Time_100, OOA_three_epoch_NEffective_100, color='N=100'), linewidth=1, linetype='solid') +
  scale_color_manual(name='Sample Size',
                     breaks=c('N=10', 'N=20', 'N=30', 'N=40', 'N=50', 'N=60', 'N=70', 'N=80', 'N=90', 'N=100'),
                     values=c('N=10'='#7f3b08',
                       'N=20'='#b35806',
                       'N=30'='#e08214',
                       'N=40'='#fdb863',
                       'N=50'='#fee0b6',
                       'N=60'='#d8daeb',
                       'N=70'='#b2abd2',
                       'N=80'='#8073ac',
                       'N=90'='#542788',
                       'N=100'='#2d004b')) +
  theme_bw() +
  ylab('Effective Population Size') +
  xlab('Time in Years') +
  ggtitle('Tennessen OOA Best-fitting Demography (N=10-100:10)')

ggplot(OOA_three_epoch_demography_10, aes(OOA_three_epoch_Time_10, OOA_three_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='solid') + 
  geom_step(data=OOA_three_epoch_demography_20, aes(OOA_three_epoch_Time_20, OOA_three_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_30, aes(OOA_three_epoch_Time_30, OOA_three_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_40, aes(OOA_three_epoch_Time_40, OOA_three_epoch_NEffective_40, color='N=40'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_50, aes(OOA_three_epoch_Time_50, OOA_three_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_60, aes(OOA_three_epoch_Time_60, OOA_three_epoch_NEffective_60, color='N=60'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_70, aes(OOA_three_epoch_Time_70, OOA_three_epoch_NEffective_70, color='N=70'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_80, aes(OOA_three_epoch_Time_80, OOA_three_epoch_NEffective_80, color='N=80'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_90, aes(OOA_three_epoch_Time_90, OOA_three_epoch_NEffective_90, color='N=90'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_100, aes(OOA_three_epoch_Time_100, OOA_three_epoch_NEffective_100, color='N=100'), linewidth=1, linetype='solid') +
  scale_color_manual(name='Sample Size',
                     breaks=c('N=10', 'N=20', 'N=30', 'N=40', 'N=50', 'N=60', 'N=70', 'N=80', 'N=90', 'N=100'),
                     values=c('N=10'='#7f3b08',
                       'N=20'='#b35806',
                       'N=30'='#e08214',
                       'N=40'='#fdb863',
                       'N=50'='#fee0b6',
                       'N=60'='#d8daeb',
                       'N=70'='#b2abd2',
                       'N=80'='#8073ac',
                       'N=90'='#542788',
                       'N=100'='#2d004b')) +
  theme_bw() +
  ylab('Effective Population Size') +
  xlab('Time in Years') +
  ggtitle('Tennessen OOA Three Epoch Demography (N=10-100:10)')

# ggplot(OOA_three_epoch_demography_20, aes(OOA_three_epoch_Time_20, OOA_three_epoch_NEffective_20color='#b35806')) + geom_step(linewidth=1, linetype='solid') + 
#   # geom_step(data=OOA_three_epoch_demography_20, aes(OOA_three_epoch_Time_20, OOA_three_epoch_NEffective_20, color='#b35806'), linewidth=1, linetype='solid') +
#   geom_step(data=OOA_three_epoch_demography_30, aes(OOA_three_epoch_Time_30, OOA_three_epoch_NEffective_30, color='#e08214'), linewidth=1, linetype='solid') +
#   geom_step(data=OOA_three_epoch_demography_40, aes(OOA_three_epoch_Time_40, OOA_three_epoch_NEffective_40, color='#fdb863'), linewidth=1, linetype='solid') +
#   geom_step(data=OOA_three_epoch_demography_50, aes(OOA_three_epoch_Time_50, OOA_three_epoch_NEffective_50, color='#fee0b6'), linewidth=1, linetype='solid') +
#   geom_step(data=OOA_three_epoch_demography_60, aes(OOA_three_epoch_Time_60, OOA_three_epoch_NEffective_60, color='#d8daeb'), linewidth=1, linetype='solid') +
#   geom_step(data=OOA_three_epoch_demography_70, aes(OOA_three_epoch_Time_70, OOA_three_epoch_NEffective_70, color='#b2abd2'), linewidth=1, linetype='solid') +
#   geom_step(data=OOA_three_epoch_demography_80, aes(OOA_three_epoch_Time_80, OOA_three_epoch_NEffective_80, color='#8073ac'), linewidth=1, linetype='solid') +
#   geom_step(data=OOA_three_epoch_demography_90, aes(OOA_three_epoch_Time_90, OOA_three_epoch_NEffective_90, color='#542788'), linewidth=1, linetype='solid') +
#   geom_step(data=OOA_three_epoch_demography_100, aes(OOA_three_epoch_Time_100, OOA_three_epoch_NEffective_100, color='#2d004b'), linewidth=1, linetype='solid') +
#   scale_color_manual(name='Sample Size',
#                      breaks=c('N=10', 'N=20', 'N=30', 'N=40', 'N=50', 'N=60', 'N=70', 'N=80', 'N=90', 'N=100'),
#                      values=c('N=10'='#7f3b08',
#                        'N=20'='#b35806',
#                        'N=30'='#e08214',
#                        'N=40'='#fdb863',
#                        'N=50'='#fee0b6',
#                        'N=60'='#d8daeb',
#                        'N=70'='#b2abd2',
#                        'N=80'='#8073ac',
#                        'N=90'='#542788',
#                        'N=100'='#2d004b')) +
#   theme_bw() +
#   ylab('Effective Population Size') +
#   xlab('Time in Years') +
#   ggtitle('Tennessen OOA Three Epoch Demography, 10-100:10')

# NAnc Estimate by Sample Size
sample_size = c(10, 20, 30, 40, 50, 60, 70, 80, 90, 100)

NAnc_df = data.frame(sample_size, OOA_one_epoch_NAnc, OOA_two_epoch_NAnc, OOA_three_epoch_NAnc)
NAnc_df = melt(NAnc_df, id='sample_size')

ggplot(data=NAnc_df, aes(x=sample_size, y=value, color=variable)) + geom_line() +
  xlab('Sample size') +
  ylab('Estimated ancestral effective population size') +
  ggtitle('Tennessen OOA NAnc by sample size (N=10-100:10)') +
  theme_bw() +
  guides(color=guide_legend(title="Epoch")) +
  scale_color_manual(
    labels=c('One-epoch', 'Two-epoch', 'Three-epoch'),
    values=c('red', 'blue', 'green')) +
  geom_hline(yintercept=12378, color='black', linetype='dashed') +
  scale_x_continuous(breaks=sample_size)


# # Tennessen_OOA 10-19:1
OOA_empirical_file_list = list()
OOA_one_epoch_file_list = list()
OOA_two_epoch_file_list = list()
OOA_three_epoch_file_list = list()
OOA_one_epoch_AIC = c()
OOA_one_epoch_LL = c()
OOA_one_epoch_theta = c()
OOA_one_epoch_allele_sum = c()
OOA_two_epoch_AIC = c()
OOA_two_epoch_LL = c()
OOA_two_epoch_theta = c()
OOA_two_epoch_nu = c()
OOA_two_epoch_tau = c()
OOA_two_epoch_allele_sum = c()
OOA_three_epoch_AIC = c()
OOA_three_epoch_LL = c()
OOA_three_epoch_theta = c()
OOA_three_epoch_nuB = c()
OOA_three_epoch_nuF = c()
OOA_three_epoch_tauB = c()
OOA_three_epoch_tauF = c()
OOA_three_epoch_allele_sum = c()

# Loop through subdirectories and get relevant files
for (i in seq(10, 19, by = 1)) {
  subdirectory <- paste0("../Analysis/ooa_simulated_", i)
  OOA_empirical_file_path <- file.path(subdirectory, "syn_downsampled_sfs.txt")
  OOA_one_epoch_file_path <- file.path(subdirectory, "one_epoch_demography.txt")
  OOA_two_epoch_file_path <- file.path(subdirectory, "two_epoch_demography.txt")
  OOA_three_epoch_file_path <- file.path(subdirectory, "three_epoch_demography.txt")
  
  # Check if the file exists before attempting to read and print its contents
  if (file.exists(OOA_empirical_file_path)) {
    this_empirical_sfs = read_input_sfs(OOA_empirical_file_path)
    OOA_empirical_file_list[[subdirectory]] = this_empirical_sfs
  }
  if (file.exists(OOA_one_epoch_file_path)) {
    this_one_epoch_sfs = sfs_from_demography(OOA_one_epoch_file_path)
    OOA_one_epoch_file_list[[subdirectory]] = this_one_epoch_sfs
    OOA_one_epoch_AIC = c(OOA_one_epoch_AIC, AIC_from_demography(OOA_one_epoch_file_path))
    OOA_one_epoch_LL = c(OOA_one_epoch_LL, LL_from_demography(OOA_one_epoch_file_path))
    OOA_one_epoch_theta = c(OOA_one_epoch_theta, theta_from_demography(OOA_one_epoch_file_path))
    OOA_one_epoch_allele_sum = c(OOA_one_epoch_allele_sum, sum(this_one_epoch_sfs))
  }
  if (file.exists(OOA_two_epoch_file_path)) {
    this_two_epoch_sfs = sfs_from_demography(OOA_two_epoch_file_path)
    OOA_two_epoch_file_list[[subdirectory]] = this_two_epoch_sfs
    OOA_two_epoch_AIC = c(OOA_two_epoch_AIC, AIC_from_demography(OOA_two_epoch_file_path))
    OOA_two_epoch_LL = c(OOA_two_epoch_LL, LL_from_demography(OOA_two_epoch_file_path))
    OOA_two_epoch_theta = c(OOA_two_epoch_theta, theta_from_demography(OOA_two_epoch_file_path))
    OOA_two_epoch_nu = c(OOA_two_epoch_nu, nu_from_demography(OOA_two_epoch_file_path))
    OOA_two_epoch_tau = c(OOA_two_epoch_tau, tau_from_demography(OOA_two_epoch_file_path))
    OOA_two_epoch_allele_sum = c(OOA_two_epoch_allele_sum, sum(this_two_epoch_sfs))
  }
  if (file.exists(OOA_three_epoch_file_path)) {
    this_three_epoch_sfs = sfs_from_demography(OOA_three_epoch_file_path)
    OOA_three_epoch_file_list[[subdirectory]] = this_three_epoch_sfs
    OOA_three_epoch_AIC = c(OOA_three_epoch_AIC, AIC_from_demography(OOA_three_epoch_file_path))
    OOA_three_epoch_LL = c(OOA_three_epoch_LL, LL_from_demography(OOA_three_epoch_file_path))
    OOA_three_epoch_theta = c(OOA_three_epoch_theta, theta_from_demography(OOA_three_epoch_file_path))
    OOA_three_epoch_nuB = c(OOA_three_epoch_nuB, nuB_from_demography(OOA_three_epoch_file_path))
    OOA_three_epoch_nuF = c(OOA_three_epoch_nuF, nuF_from_demography(OOA_three_epoch_file_path))
    OOA_three_epoch_tauB = c(OOA_three_epoch_tauB, tauB_from_demography(OOA_three_epoch_file_path))
    OOA_three_epoch_tauF = c(OOA_three_epoch_tauF, tauF_from_demography(OOA_three_epoch_file_path))
    OOA_three_epoch_allele_sum = c(OOA_three_epoch_allele_sum, sum(this_three_epoch_sfs))
  }  
}

OOA_AIC_df = data.frame(OOA_one_epoch_AIC, OOA_two_epoch_AIC, OOA_three_epoch_AIC)
# Reshape the data from wide to long format
OOA_df_long <- tidyr::gather(OOA_AIC_df, key = "Epoch", value = "AIC", OOA_one_epoch_AIC:OOA_three_epoch_AIC)

# Increase the x-axis index by 4
OOA_df_long$Index <- rep(seq(10, 19, by = 1), times = 3)

# Create the line plot with ggplot2
ggplot(OOA_df_long, aes(x = Index, y = AIC, color = Epoch)) +
  geom_line() +
  geom_point() +
  labs(title = "Tennessen OOA AIC values by sample size (N=10-19:1)",
       x = "Sample Size",
       y = "AIC") +
  scale_y_log10() +
  scale_x_continuous(breaks=OOA_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('One-epoch', 'Three-epoch', 'Two-epoch')) +
  theme_bw()

OOA_lambda_two_one = 2 * (OOA_two_epoch_LL - OOA_one_epoch_LL)
OOA_lambda_three_one = 2 * (OOA_three_epoch_LL - OOA_one_epoch_LL)
OOA_lambda_three_two = 2 * (OOA_three_epoch_LL - OOA_two_epoch_LL)

OOA_lambda_df = data.frame(OOA_lambda_two_one, OOA_lambda_three_one, OOA_lambda_three_two)
# Reshape the data from wide to long format
OOA_df_long_lambda <- tidyr::gather(OOA_lambda_df, key = "Full_vs_Null", value = "Lambda", OOA_lambda_two_one:OOA_lambda_three_two)
# Increase the x-axis index by 4
OOA_df_long_lambda$Index <- rep(seq(10, 19, by = 1), times = 3)

# Create the line plot with ggplot2
ggplot(OOA_df_long_lambda, aes(x = Index, y = Lambda, color = Full_vs_Null)) +
  geom_line() +
  geom_point() +
  labs(title = "Tennessen OOA Lambda values by sample size (N=10-19:1)",
       x = "Sample Size",
       y = "2 * Lambda") +
  # scale_y_log10() +
  scale_x_continuous(breaks=OOA_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('Three vs. One', 'Three vs. Two', 'Two vs. One')) +
  theme_bw()

# Create the line plot with ggplot2
ggplot(OOA_df_long_lambda, aes(x = Index, y = Lambda, color = Full_vs_Null)) +
  geom_line() +
  geom_point() +
  labs(title = "Tennessen OOA Lambda values by sample size (N=10-19:1)",
       x = "Sample Size",
       y = "2 * Lambda") +
  # scale_y_log10() +
  scale_x_continuous(breaks=OOA_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('Three vs. One', 'Three vs. Two', 'Two vs. One')) +
  theme_bw() +
  ylim(-5, 10)

OOA_one_epoch_residual = c()
OOA_two_epoch_residual = c()
OOA_three_epoch_residual = c()

for (i in 1:10) {
  OOA_one_epoch_residual = c(OOA_one_epoch_residual, compute_residual(unlist(OOA_empirical_file_list[i]), unlist(OOA_one_epoch_file_list[i])))
  OOA_two_epoch_residual = c(OOA_two_epoch_residual, compute_residual(unlist(OOA_empirical_file_list[i]), unlist(OOA_two_epoch_file_list[i])))
  OOA_three_epoch_residual = c(OOA_three_epoch_residual, compute_residual(unlist(OOA_empirical_file_list[i]), unlist(OOA_three_epoch_file_list[i])))
}

OOA_residual_df = data.frame(OOA_one_epoch_residual, OOA_two_epoch_residual, OOA_three_epoch_residual)
# Reshape the data from wide to long format
OOA_df_long_residual <- tidyr::gather(OOA_residual_df, key = "Epoch", value = "residual", OOA_one_epoch_residual:OOA_three_epoch_residual)

# Increase the x-axis index by 4
OOA_df_long_residual$Index <- rep(seq(10, 19, by = 1), times = 3)

# Create the line plot with ggplot2
ggplot(OOA_df_long_residual, aes(x = Index, y = residual, color = Epoch)) +
  geom_line() +
  geom_point() +
  labs(title = "OOA residual values by sample size (N=10-19:1)",
       x = "Sample Size",
       y = "Residual") +
  scale_y_log10() +
  scale_x_continuous(breaks=OOA_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('One-epoch', 'Three-epoch', 'Two-epoch')) +
  theme_bw()

ggplot(OOA_df_long, aes(x = Index, y = AIC, color = Epoch)) +
  geom_line(linetype=3) +
  geom_point() +
  labs(title = "Tennessen OOA AIC and residual by sample size (N=10-19:1)",
       x = "Sample Size",
       y = "AIC") +
  scale_y_log10(sec.axis = sec_axis(~.*1, name="Residual")) +
  scale_x_continuous(breaks=OOA_df_long$Index) +
  geom_line(data=OOA_df_long_residual, aes(x = Index, y = residual*1, color = Epoch)) +
  scale_color_manual(values = c("blue", "orange", "green", "violet", "red", "seagreen"),
    label=c('One-epoch AIC', 'One-epoch residual',
      'Three-epoch AIC', 'Three-epoch residual',
      'Two-epoch AIC', 'Two-epoch residual')) +
  theme_bw()

# Tennessen_OOA population genetic constants

OOA_mu = 1.5E-8

# NAnc = theta / (4 * allele_sum * mu)
# generations = 2 * tau * theta / (4 * mu * allele_sum)
# years = generations / 365
# NCurr = nu * NAnc
# generations_b = 2 * tauB * theta / (4 * mu * allele_sum)
# generations_f = 2 * tauF * theta / (4 * mu * allele_sum)
# NBottle = nuB * NAnc
# NSince = nuF * NAnc

OOA_one_epoch_NAnc = OOA_one_epoch_theta / (4 * OOA_one_epoch_allele_sum * OOA_mu)
OOA_two_epoch_NAnc = OOA_two_epoch_theta / (4 * OOA_two_epoch_allele_sum * OOA_mu)
OOA_two_epoch_NCurr = OOA_two_epoch_nu * OOA_two_epoch_NAnc
OOA_two_epoch_Time = 2 * 25 * OOA_two_epoch_tau * OOA_two_epoch_theta / (4 * OOA_mu * OOA_two_epoch_allele_sum)
OOA_three_epoch_NAnc = OOA_three_epoch_theta / (4 * OOA_three_epoch_allele_sum * OOA_mu)
OOA_three_epoch_NBottle = OOA_three_epoch_nuB * OOA_three_epoch_NAnc
OOA_three_epoch_NCurr = OOA_three_epoch_nuF * OOA_three_epoch_NAnc
OOA_three_epoch_TimeBottleEnd = 2 * 25 * OOA_three_epoch_tauF * OOA_three_epoch_theta / (4 * OOA_mu * OOA_three_epoch_allele_sum)
OOA_three_epoch_TimeBottleStart = 2 * 25 * OOA_three_epoch_tauB * OOA_three_epoch_theta / (4 * OOA_mu * OOA_three_epoch_allele_sum) + OOA_three_epoch_TimeBottleEnd
OOA_three_epoch_TimeTotal = OOA_three_epoch_TimeBottleStart + OOA_three_epoch_TimeBottleEnd

OOA_two_epoch_max_time = rep(1.25E6, 10)
# OOA_two_epoch_max_time = rep(2E4, 10)
OOA_two_epoch_current_time = rep(0, 10)
OOA_two_epoch_demography = data.frame(OOA_two_epoch_NAnc, OOA_two_epoch_max_time, 
  OOA_two_epoch_NCurr, OOA_two_epoch_Time, 
  OOA_two_epoch_NCurr, OOA_two_epoch_current_time)

# OOA_three_epoch_max_time = rep(100000000, 10)
# OOA_three_epoch_max_time = rep(5E6, 10)
OOA_three_epoch_max_time = rep(1.25E6, 10)
OOA_three_epoch_current_time = rep(0, 10)
OOA_three_epoch_demography = data.frame(OOA_three_epoch_NAnc, OOA_three_epoch_max_time,
  OOA_three_epoch_NBottle, OOA_three_epoch_TimeBottleStart,
  OOA_three_epoch_NCurr, OOA_three_epoch_TimeBottleEnd,
  OOA_three_epoch_NCurr, OOA_three_epoch_current_time)

OOA_two_epoch_NEffective_10 = c(OOA_two_epoch_demography[1, 1], OOA_two_epoch_demography[1, 3], OOA_two_epoch_demography[1, 5])
OOA_two_epoch_Time_10 = c(-OOA_two_epoch_demography[1, 2], -OOA_two_epoch_demography[1, 4], OOA_two_epoch_demography[1, 6])
OOA_two_epoch_demography_10 = data.frame(OOA_two_epoch_Time_10, OOA_two_epoch_NEffective_10)
OOA_two_epoch_NEffective_11 = c(OOA_two_epoch_demography[2, 1], OOA_two_epoch_demography[2, 3], OOA_two_epoch_demography[2, 5])
OOA_two_epoch_Time_11 = c(-OOA_two_epoch_demography[2, 2], -OOA_two_epoch_demography[2, 4], OOA_two_epoch_demography[2, 6])
OOA_two_epoch_demography_11 = data.frame(OOA_two_epoch_Time_11, OOA_two_epoch_NEffective_11)
OOA_two_epoch_NEffective_12 = c(OOA_two_epoch_demography[3, 1], OOA_two_epoch_demography[3, 3], OOA_two_epoch_demography[3, 5])
OOA_two_epoch_Time_12 = c(-OOA_two_epoch_demography[3, 2], -OOA_two_epoch_demography[3, 4], OOA_two_epoch_demography[3, 6])
OOA_two_epoch_demography_12 = data.frame(OOA_two_epoch_Time_12, OOA_two_epoch_NEffective_12)
OOA_two_epoch_NEffective_13 = c(OOA_two_epoch_demography[4, 1], OOA_two_epoch_demography[4, 3], OOA_two_epoch_demography[4, 5])
OOA_two_epoch_Time_13 = c(-OOA_two_epoch_demography[4, 2], -OOA_two_epoch_demography[4, 4], OOA_two_epoch_demography[4, 6])
OOA_two_epoch_demography_13 = data.frame(OOA_two_epoch_Time_13, OOA_two_epoch_NEffective_13)
OOA_two_epoch_NEffective_14 = c(OOA_two_epoch_demography[5, 1], OOA_two_epoch_demography[5, 3], OOA_two_epoch_demography[5, 5])
OOA_two_epoch_Time_14 = c(-OOA_two_epoch_demography[5, 2], -OOA_two_epoch_demography[5, 4], OOA_two_epoch_demography[5, 6])
OOA_two_epoch_demography_14 = data.frame(OOA_two_epoch_Time_14, OOA_two_epoch_NEffective_14)
OOA_two_epoch_NEffective_15 = c(OOA_two_epoch_demography[6, 1], OOA_two_epoch_demography[6, 3], OOA_two_epoch_demography[6, 5])
OOA_two_epoch_Time_15 = c(-OOA_two_epoch_demography[6, 2], -OOA_two_epoch_demography[6, 4], OOA_two_epoch_demography[6, 6])
OOA_two_epoch_demography_15 = data.frame(OOA_two_epoch_Time_15, OOA_two_epoch_NEffective_15)
OOA_two_epoch_NEffective_16 = c(OOA_two_epoch_demography[7, 1], OOA_two_epoch_demography[7, 3], OOA_two_epoch_demography[7, 5])
OOA_two_epoch_Time_16 = c(-OOA_two_epoch_demography[7, 2], -OOA_two_epoch_demography[7, 4], OOA_two_epoch_demography[7, 6])
OOA_two_epoch_demography_16 = data.frame(OOA_two_epoch_Time_16, OOA_two_epoch_NEffective_16)
OOA_two_epoch_NEffective_17 = c(OOA_two_epoch_demography[8, 1], OOA_two_epoch_demography[8, 3], OOA_two_epoch_demography[8, 5])
OOA_two_epoch_Time_17 = c(-OOA_two_epoch_demography[8, 2], -OOA_two_epoch_demography[8, 4], OOA_two_epoch_demography[8, 6])
OOA_two_epoch_demography_17 = data.frame(OOA_two_epoch_Time_17, OOA_two_epoch_NEffective_17)
OOA_two_epoch_NEffective_18 = c(OOA_two_epoch_demography[9, 1], OOA_two_epoch_demography[9, 3], OOA_two_epoch_demography[9, 5])
OOA_two_epoch_Time_18 = c(-OOA_two_epoch_demography[9, 2], -OOA_two_epoch_demography[9, 4], OOA_two_epoch_demography[9, 6])
OOA_two_epoch_demography_18 = data.frame(OOA_two_epoch_Time_18, OOA_two_epoch_NEffective_18)
OOA_two_epoch_NEffective_19 = c(OOA_two_epoch_demography[10, 1], OOA_two_epoch_demography[10, 3], OOA_two_epoch_demography[10, 5])
OOA_two_epoch_Time_19 = c(-OOA_two_epoch_demography[10, 2], -OOA_two_epoch_demography[10, 4], OOA_two_epoch_demography[10, 6])
OOA_two_epoch_demography_19 = data.frame(OOA_two_epoch_Time_19, OOA_two_epoch_NEffective_19)

OOA_three_epoch_NEffective_10 = c(OOA_three_epoch_demography[1, 1], OOA_three_epoch_demography[1, 3], OOA_three_epoch_demography[1, 5], OOA_three_epoch_demography[1, 7])
OOA_three_epoch_Time_10 = c(-OOA_three_epoch_demography[1, 2], -OOA_three_epoch_demography[1, 4], -OOA_three_epoch_demography[1, 6], OOA_three_epoch_demography[1, 8])
OOA_three_epoch_demography_10 = data.frame(OOA_three_epoch_Time_10, OOA_three_epoch_NEffective_10)
OOA_three_epoch_NEffective_11 = c(OOA_three_epoch_demography[2, 1], OOA_three_epoch_demography[2, 3], OOA_three_epoch_demography[2, 5], OOA_three_epoch_demography[2, 7])
OOA_three_epoch_Time_11 = c(-OOA_three_epoch_demography[2, 2], -OOA_three_epoch_demography[2, 4], -OOA_three_epoch_demography[2, 6], OOA_three_epoch_demography[2, 8])
OOA_three_epoch_demography_11 = data.frame(OOA_three_epoch_Time_11, OOA_three_epoch_NEffective_11)
OOA_three_epoch_NEffective_12 = c(OOA_three_epoch_demography[3, 1], OOA_three_epoch_demography[3, 3], OOA_three_epoch_demography[3, 5], OOA_three_epoch_demography[3, 7])
OOA_three_epoch_Time_12 = c(-OOA_three_epoch_demography[3, 2], -OOA_three_epoch_demography[3, 4], -OOA_three_epoch_demography[3, 6], OOA_three_epoch_demography[3, 8])
OOA_three_epoch_demography_12 = data.frame(OOA_three_epoch_Time_12, OOA_three_epoch_NEffective_12)
OOA_three_epoch_NEffective_13 = c(OOA_three_epoch_demography[4, 1], OOA_three_epoch_demography[4, 3], OOA_three_epoch_demography[4, 5], OOA_three_epoch_demography[4, 7])
OOA_three_epoch_Time_13 = c(-OOA_three_epoch_demography[4, 2], -OOA_three_epoch_demography[4, 4], -OOA_three_epoch_demography[4, 6], OOA_three_epoch_demography[4, 8])
OOA_three_epoch_demography_13 = data.frame(OOA_three_epoch_Time_13, OOA_three_epoch_NEffective_13)
OOA_three_epoch_NEffective_14 = c(OOA_three_epoch_demography[5, 1], OOA_three_epoch_demography[5, 3], OOA_three_epoch_demography[5, 5], OOA_three_epoch_demography[5, 7])
OOA_three_epoch_Time_14 = c(-OOA_three_epoch_demography[5, 2], -OOA_three_epoch_demography[5, 4], -OOA_three_epoch_demography[5, 6], OOA_three_epoch_demography[5, 8])
OOA_three_epoch_demography_14 = data.frame(OOA_three_epoch_Time_14, OOA_three_epoch_NEffective_14)
OOA_three_epoch_NEffective_15 = c(OOA_three_epoch_demography[6, 1], OOA_three_epoch_demography[6, 3], OOA_three_epoch_demography[6, 5], OOA_three_epoch_demography[6, 7])
OOA_three_epoch_Time_15 = c(-OOA_three_epoch_demography[6, 2], -OOA_three_epoch_demography[6, 4], -OOA_three_epoch_demography[6, 6], OOA_three_epoch_demography[6, 8])
OOA_three_epoch_demography_15 = data.frame(OOA_three_epoch_Time_15, OOA_three_epoch_NEffective_15)
OOA_three_epoch_NEffective_16 = c(OOA_three_epoch_demography[7, 1], OOA_three_epoch_demography[7, 3], OOA_three_epoch_demography[7, 5], OOA_three_epoch_demography[7, 7])
OOA_three_epoch_Time_16 = c(-OOA_three_epoch_demography[7, 2], -OOA_three_epoch_demography[7, 4], -OOA_three_epoch_demography[7, 6], OOA_three_epoch_demography[7, 8])
OOA_three_epoch_demography_16 = data.frame(OOA_three_epoch_Time_16, OOA_three_epoch_NEffective_16)
OOA_three_epoch_NEffective_17 = c(OOA_three_epoch_demography[8, 1], OOA_three_epoch_demography[8, 3], OOA_three_epoch_demography[8, 5], OOA_three_epoch_demography[8, 7])
OOA_three_epoch_Time_17 = c(-OOA_three_epoch_demography[8, 2], -OOA_three_epoch_demography[8, 4], -OOA_three_epoch_demography[8, 6], OOA_three_epoch_demography[8, 8])
OOA_three_epoch_demography_17 = data.frame(OOA_three_epoch_Time_17, OOA_three_epoch_NEffective_17)
OOA_three_epoch_NEffective_18 = c(OOA_three_epoch_demography[9, 1], OOA_three_epoch_demography[9, 3], OOA_three_epoch_demography[9, 5], OOA_three_epoch_demography[9, 7])
OOA_three_epoch_Time_18 = c(-OOA_three_epoch_demography[9, 2], -OOA_three_epoch_demography[9, 4], -OOA_three_epoch_demography[9, 6], OOA_three_epoch_demography[9, 8])
OOA_three_epoch_demography_18 = data.frame(OOA_three_epoch_Time_18, OOA_three_epoch_NEffective_18)
OOA_three_epoch_NEffective_19 = c(OOA_three_epoch_demography[10, 1], OOA_three_epoch_demography[10, 3], OOA_three_epoch_demography[10, 5], OOA_three_epoch_demography[10, 7])
OOA_three_epoch_Time_19 = c(-OOA_three_epoch_demography[10, 2], -OOA_three_epoch_demography[10, 4], -OOA_three_epoch_demography[10, 6], OOA_three_epoch_demography[10, 8])
OOA_three_epoch_demography_19 = data.frame(OOA_three_epoch_Time_19, OOA_three_epoch_NEffective_19)

ggplot(OOA_two_epoch_demography_10, aes(OOA_two_epoch_Time_10, OOA_two_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='dotted') + 
  geom_step(data=OOA_two_epoch_demography_11, aes(OOA_two_epoch_Time_11, OOA_two_epoch_NEffective_11, color='N=11'), linewidth=1, linetype='dotted') +
  geom_step(data=OOA_two_epoch_demography_12, aes(OOA_two_epoch_Time_12, OOA_two_epoch_NEffective_12, color='N=12'), linewidth=1, linetype='dotted') +
  geom_step(data=OOA_two_epoch_demography_13, aes(OOA_two_epoch_Time_13, OOA_two_epoch_NEffective_13, color='N=13'), linewidth=1, linetype='dotted') +
  geom_step(data=OOA_two_epoch_demography_14, aes(OOA_two_epoch_Time_14, OOA_two_epoch_NEffective_14, color='N=14'), linewidth=1, linetype='dotted') +
  geom_step(data=OOA_two_epoch_demography_15, aes(OOA_two_epoch_Time_15, OOA_two_epoch_NEffective_15, color='N=15'), linewidth=1, linetype='dotted') +
  geom_step(data=OOA_two_epoch_demography_16, aes(OOA_two_epoch_Time_16, OOA_two_epoch_NEffective_16, color='N=16'), linewidth=1, linetype='dotted') +
  geom_step(data=OOA_two_epoch_demography_17, aes(OOA_two_epoch_Time_17, OOA_two_epoch_NEffective_17, color='N=17'), linewidth=1, linetype='dotted') +
  geom_step(data=OOA_two_epoch_demography_18, aes(OOA_two_epoch_Time_18, OOA_two_epoch_NEffective_18, color='N=18'), linewidth=1, linetype='dotted') +
  geom_step(data=OOA_two_epoch_demography_19, aes(OOA_two_epoch_Time_19, OOA_two_epoch_NEffective_19, color='N=19'), linewidth=1, linetype='dotted') +
  scale_color_manual(name='Sample Size',
                     breaks=c('N=10', 'N=11', 'N=12', 'N=13', 'N=14', 'N=15', 'N=16', 'N=17', 'N=18', 'N=19'),
                     values=c('N=10'='#7f3b08',
                       'N=11'='#b35806',
                       'N=12'='#e08214',
                       'N=13'='#fdb863',
                       'N=14'='#fee0b6',
                       'N=15'='#d8daeb',
                       'N=16'='#b2abd2',
                       'N=17'='#8073ac',
                       'N=18'='#542788',
                       'N=19'='#2d004b')) +
  theme_bw() +
  ylab('Effective Population Size') +
  xlab('Time in Years') +
  ggtitle('Tennessen OOA two Epoch Demography (N=10-19:1)')

ggplot(OOA_two_epoch_demography_10, aes(OOA_two_epoch_Time_10, OOA_two_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='dashed') + 
  geom_step(data=OOA_two_epoch_demography_11, aes(OOA_two_epoch_Time_11, OOA_two_epoch_NEffective_11, color='N=11'), linewidth=1, linetype='dashed') +
  geom_step(data=OOA_two_epoch_demography_12, aes(OOA_two_epoch_Time_12, OOA_two_epoch_NEffective_12, color='N=12'), linewidth=1, linetype='dashed') +
  geom_step(data=OOA_two_epoch_demography_13, aes(OOA_two_epoch_Time_13, OOA_two_epoch_NEffective_13, color='N=13'), linewidth=1, linetype='dashed') +
  geom_step(data=OOA_two_epoch_demography_14, aes(OOA_two_epoch_Time_14, OOA_two_epoch_NEffective_14, color='N=14'), linewidth=1, linetype='dashed') +
  geom_step(data=OOA_two_epoch_demography_15, aes(OOA_two_epoch_Time_15, OOA_two_epoch_NEffective_15, color='N=15'), linewidth=1, linetype='dashed') +
  # geom_step(data=OOA_two_epoch_demography_16, aes(OOA_two_epoch_Time_16, OOA_two_epoch_NEffective_16, color='N=16'), linewidth=1, linetype='dashed') +
  # geom_step(data=OOA_two_epoch_demography_17, aes(OOA_two_epoch_Time_17, OOA_two_epoch_NEffective_17, color='N=17'), linewidth=1, linetype='dashed') +
  # geom_step(data=OOA_two_epoch_demography_18, aes(OOA_two_epoch_Time_18, OOA_two_epoch_NEffective_18, color='N=18'), linewidth=1, linetype='dashed') +
  # geom_step(data=OOA_two_epoch_demography_19, aes(OOA_two_epoch_Time_19, OOA_two_epoch_NEffective_19, color='N=19'), linewidth=1, linetype='dashed') +
  # geom_step(data=OOA_three_epoch_demography_10, aes(OOA_three_epoch_Time_10, OOA_three_epoch_NEffective_10, color='N=10'), linewidth=1, linetype='solid') +
  # geom_step(data=OOA_three_epoch_demography_11, aes(OOA_three_epoch_Time_11, OOA_three_epoch_NEffective_11, color='N=11'), linewidth=1, linetype='solid') +
  # geom_step(data=OOA_three_epoch_demography_12, aes(OOA_three_epoch_Time_12, OOA_three_epoch_NEffective_12, color='N=12'), linewidth=1, linetype='solid') +
  # geom_step(data=OOA_three_epoch_demography_13, aes(OOA_three_epoch_Time_13, OOA_three_epoch_NEffective_13, color='N=13'), linewidth=1, linetype='solid') +
  # geom_step(data=OOA_three_epoch_demography_14, aes(OOA_three_epoch_Time_14, OOA_three_epoch_NEffective_14, color='N=14'), linewidth=1, linetype='solid') +
  # geom_step(data=OOA_three_epoch_demography_15, aes(OOA_three_epoch_Time_15, OOA_three_epoch_NEffective_15, color='N=15'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_16, aes(OOA_three_epoch_Time_16, OOA_three_epoch_NEffective_16, color='N=16'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_17, aes(OOA_three_epoch_Time_17, OOA_three_epoch_NEffective_17, color='N=17'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_18, aes(OOA_three_epoch_Time_18, OOA_three_epoch_NEffective_18, color='N=18'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_19, aes(OOA_three_epoch_Time_19, OOA_three_epoch_NEffective_19, color='N=19'), linewidth=1, linetype='solid') +
  scale_color_manual(name='Sample Size',
                     breaks=c('N=10', 'N=11', 'N=12', 'N=13', 'N=14', 'N=15', 'N=16', 'N=17', 'N=18', 'N=19'),
                     values=c('N=10'='#7f3b08',
                       'N=11'='#b35806',
                       'N=12'='#e08214',
                       'N=13'='#fdb863',
                       'N=14'='#fee0b6',
                       'N=15'='#d8daeb',
                       'N=16'='#b2abd2',
                       'N=17'='#8073ac',
                       'N=18'='#542788',
                       'N=19'='#2d004b')) +
  theme_bw() +
  ylab('Effective Population Size') +
  xlab('Time in Years') +
  ggtitle('Tennessen OOA Best-fitting Demography (N=10-19:1)')

ggplot(OOA_three_epoch_demography_10, aes(OOA_three_epoch_Time_10, OOA_three_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='solid') + 
  geom_step(data=OOA_three_epoch_demography_11, aes(OOA_three_epoch_Time_11, OOA_three_epoch_NEffective_11, color='N=11'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_12, aes(OOA_three_epoch_Time_12, OOA_three_epoch_NEffective_12, color='N=12'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_13, aes(OOA_three_epoch_Time_13, OOA_three_epoch_NEffective_13, color='N=13'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_14, aes(OOA_three_epoch_Time_14, OOA_three_epoch_NEffective_14, color='N=14'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_15, aes(OOA_three_epoch_Time_15, OOA_three_epoch_NEffective_15, color='N=15'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_16, aes(OOA_three_epoch_Time_16, OOA_three_epoch_NEffective_16, color='N=16'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_17, aes(OOA_three_epoch_Time_17, OOA_three_epoch_NEffective_17, color='N=17'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_18, aes(OOA_three_epoch_Time_18, OOA_three_epoch_NEffective_18, color='N=18'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_19, aes(OOA_three_epoch_Time_19, OOA_three_epoch_NEffective_19, color='N=19'), linewidth=1, linetype='solid') +
  scale_color_manual(name='Sample Size',
                     breaks=c('N=10', 'N=11', 'N=12', 'N=13', 'N=14', 'N=15', 'N=16', 'N=17', 'N=18', 'N=19'),
                     values=c('N=10'='#7f3b08',
                       'N=11'='#b35806',
                       'N=12'='#e08214',
                       'N=13'='#fdb863',
                       'N=14'='#fee0b6',
                       'N=15'='#d8daeb',
                       'N=16'='#b2abd2',
                       'N=17'='#8073ac',
                       'N=18'='#542788',
                       'N=19'='#2d004b')) +
  theme_bw() +
  ylab('Effective Population Size') +
  xlab('Time in Years') +
  ggtitle('Tennessen OOA Three Epoch Demography (N=10-19:1)')

# ggplot(OOA_three_epoch_demography_11, aes(OOA_three_epoch_Time_11, OOA_three_epoch_NEffective_11)) + geom_step(color='#b35806', linewidth=1, linetype='solid') + 
#   # geom_step(data=OOA_three_epoch_demography_11, aes(OOA_three_epoch_Time_11, OOA_three_epoch_NEffective_11), color='#b35806', linewidth=1, linetype='solid') +
#   geom_step(data=OOA_three_epoch_demography_12, aes(OOA_three_epoch_Time_12, OOA_three_epoch_NEffective_12), color='#e08214', linewidth=1, linetype='solid') +
#   geom_step(data=OOA_three_epoch_demography_13, aes(OOA_three_epoch_Time_13, OOA_three_epoch_NEffective_13), color='#fdb863', linewidth=1, linetype='solid') +
#   geom_step(data=OOA_three_epoch_demography_14, aes(OOA_three_epoch_Time_14, OOA_three_epoch_NEffective_14), color='#fee0b6', linewidth=1, linetype='solid') +
#   geom_step(data=OOA_three_epoch_demography_15, aes(OOA_three_epoch_Time_15, OOA_three_epoch_NEffective_15), color='#d8daeb', linewidth=1, linetype='solid') +
#   geom_step(data=OOA_three_epoch_demography_16, aes(OOA_three_epoch_Time_16, OOA_three_epoch_NEffective_16), color='#b2abd2', linewidth=1, linetype='solid') +
#   geom_step(data=OOA_three_epoch_demography_17, aes(OOA_three_epoch_Time_17, OOA_three_epoch_NEffective_17), color='#8073ac', linewidth=1, linetype='solid') +
#   geom_step(data=OOA_three_epoch_demography_18, aes(OOA_three_epoch_Time_18, OOA_three_epoch_NEffective_18), color='#542788', linewidth=1, linetype='solid') +
#   geom_step(data=OOA_three_epoch_demography_19, aes(OOA_three_epoch_Time_19, OOA_three_epoch_NEffective_19), color='#2d004b', linewidth=1, linetype='solid') +
#   theme_bw() +
#   ylab('Effective Population Size') +
#   xlab('Time in Years') +
#   ggtitle('Tennessen OOA Three Epoch Demography (N=10-19:1)')

# NAnc Estimate by Sample Size
sample_size = c(10, 11, 12, 13, 14, 15, 16, 17, 18, 19)

NAnc_df = data.frame(sample_size, OOA_one_epoch_NAnc, OOA_two_epoch_NAnc, OOA_three_epoch_NAnc)
NAnc_df = melt(NAnc_df, id='sample_size')

ggplot(data=NAnc_df, aes(x=sample_size, y=value, color=variable)) + geom_line() +
  xlab('Sample size') +
  ylab('Estimated ancestral effective population size') +
  ggtitle('Tennessen OOA NAnc by sample size (N=10-19:1)') +
  theme_bw() +
  guides(color=guide_legend(title="Epoch")) +
  scale_color_manual(
    labels=c('One-epoch', 'Two-epoch', 'Three-epoch'),
    values=c('red', 'blue', 'green')) +
  geom_hline(yintercept=12378, color='black', linetype='dashed') +
  scale_x_continuous(breaks=sample_size)

# # Tennessen_OOA 10-100:10
OOA_empirical_file_list = list()
OOA_one_epoch_file_list = list()
OOA_two_epoch_file_list = list()
OOA_three_epoch_file_list = list()
OOA_one_epoch_AIC = c()
OOA_one_epoch_LL = c()
OOA_one_epoch_theta = c()
OOA_one_epoch_allele_sum = c()
OOA_two_epoch_AIC = c()
OOA_two_epoch_LL = c()
OOA_two_epoch_theta = c()
OOA_two_epoch_nu = c()
OOA_two_epoch_tau = c()
OOA_two_epoch_allele_sum = c()
OOA_three_epoch_AIC = c()
OOA_three_epoch_LL = c()
OOA_three_epoch_theta = c()
OOA_three_epoch_nuB = c()
OOA_three_epoch_nuF = c()
OOA_three_epoch_tauB = c()
OOA_three_epoch_tauF = c()
OOA_three_epoch_allele_sum = c()

# Loop through subdirectories and get relevant files
for (i in seq(10, 100, by = 10)) {
  subdirectory <- paste0("../Analysis/ooa_simulated_", i)
  OOA_empirical_file_path <- file.path(subdirectory, "syn_downsampled_sfs.txt")
  OOA_one_epoch_file_path <- file.path(subdirectory, "one_epoch_demography.txt")
  OOA_two_epoch_file_path <- file.path(subdirectory, "two_epoch_demography.txt")
  OOA_three_epoch_file_path <- file.path(subdirectory, "three_epoch_demography.txt")
  
  # Check if the file exists before attempting to read and print its contents
  if (file.exists(OOA_empirical_file_path)) {
    this_empirical_sfs = read_input_sfs(OOA_empirical_file_path)
    OOA_empirical_file_list[[subdirectory]] = this_empirical_sfs
  }
  if (file.exists(OOA_one_epoch_file_path)) {
    this_one_epoch_sfs = sfs_from_demography(OOA_one_epoch_file_path)
    OOA_one_epoch_file_list[[subdirectory]] = this_one_epoch_sfs
    OOA_one_epoch_AIC = c(OOA_one_epoch_AIC, AIC_from_demography(OOA_one_epoch_file_path))
    OOA_one_epoch_LL = c(OOA_one_epoch_LL, LL_from_demography(OOA_one_epoch_file_path))
    OOA_one_epoch_theta = c(OOA_one_epoch_theta, theta_from_demography(OOA_one_epoch_file_path))
    OOA_one_epoch_allele_sum = c(OOA_one_epoch_allele_sum, sum(this_one_epoch_sfs))
  }
  if (file.exists(OOA_two_epoch_file_path)) {
    this_two_epoch_sfs = sfs_from_demography(OOA_two_epoch_file_path)
    OOA_two_epoch_file_list[[subdirectory]] = this_two_epoch_sfs
    OOA_two_epoch_AIC = c(OOA_two_epoch_AIC, AIC_from_demography(OOA_two_epoch_file_path))
    OOA_two_epoch_LL = c(OOA_two_epoch_LL, LL_from_demography(OOA_two_epoch_file_path))
    OOA_two_epoch_theta = c(OOA_two_epoch_theta, theta_from_demography(OOA_two_epoch_file_path))
    OOA_two_epoch_nu = c(OOA_two_epoch_nu, nu_from_demography(OOA_two_epoch_file_path))
    OOA_two_epoch_tau = c(OOA_two_epoch_tau, tau_from_demography(OOA_two_epoch_file_path))
    OOA_two_epoch_allele_sum = c(OOA_two_epoch_allele_sum, sum(this_two_epoch_sfs))
  }
  if (file.exists(OOA_three_epoch_file_path)) {
    this_three_epoch_sfs = sfs_from_demography(OOA_three_epoch_file_path)
    OOA_three_epoch_file_list[[subdirectory]] = this_three_epoch_sfs
    OOA_three_epoch_AIC = c(OOA_three_epoch_AIC, AIC_from_demography(OOA_three_epoch_file_path))
    OOA_three_epoch_LL = c(OOA_three_epoch_LL, LL_from_demography(OOA_three_epoch_file_path))
    OOA_three_epoch_theta = c(OOA_three_epoch_theta, theta_from_demography(OOA_three_epoch_file_path))
    OOA_three_epoch_nuB = c(OOA_three_epoch_nuB, nuB_from_demography(OOA_three_epoch_file_path))
    OOA_three_epoch_nuF = c(OOA_three_epoch_nuF, nuF_from_demography(OOA_three_epoch_file_path))
    OOA_three_epoch_tauB = c(OOA_three_epoch_tauB, tauB_from_demography(OOA_three_epoch_file_path))
    OOA_three_epoch_tauF = c(OOA_three_epoch_tauF, tauF_from_demography(OOA_three_epoch_file_path))
    OOA_three_epoch_allele_sum = c(OOA_three_epoch_allele_sum, sum(this_three_epoch_sfs))
  }  
}

OOA_AIC_df = data.frame(OOA_one_epoch_AIC, OOA_two_epoch_AIC, OOA_three_epoch_AIC)
# Reshape the data from wide to long format
OOA_df_long <- tidyr::gather(OOA_AIC_df, key = "Epoch", value = "AIC", OOA_one_epoch_AIC:OOA_three_epoch_AIC)

# Increase the x-axis index by 4
OOA_df_long$Index <- rep(seq(10, 100, by = 10), times = 3)

# Create the line plot with ggplot2
ggplot(OOA_df_long, aes(x = Index, y = AIC, color = Epoch)) +
  geom_line() +
  geom_point() +
  labs(title = "Tennessen OOA AIC values by sample size",
       x = "Sample Size",
       y = "AIC") +
  scale_y_log10() +
  scale_x_continuous(breaks=OOA_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('One-epoch', 'Three-epoch', 'Two-epoch')) +
  theme_bw()

OOA_lambda_two_one = 2 * (OOA_two_epoch_LL - OOA_one_epoch_LL)
OOA_lambda_three_one = 2 * (OOA_three_epoch_LL - OOA_one_epoch_LL)
OOA_lambda_three_two = 2 * (OOA_three_epoch_LL - OOA_two_epoch_LL)

OOA_lambda_df = data.frame(OOA_lambda_two_one, OOA_lambda_three_one, OOA_lambda_three_two)
# Reshape the data from wide to long format
OOA_df_long_lambda <- tidyr::gather(OOA_lambda_df, key = "Full_vs_Null", value = "Lambda", OOA_lambda_two_one:OOA_lambda_three_two)
# Increase the x-axis index by 4
OOA_df_long_lambda$Index <- rep(seq(10, 100, by = 10), times = 3)

# Create the line plot with ggplot2
ggplot(OOA_df_long_lambda, aes(x = Index, y = Lambda, color = Full_vs_Null)) +
  geom_line() +
  geom_point() +
  labs(title = "Tennessen OOA Lambda values by sample size (N=10-100:10)",
       x = "Sample Size",
       y = "2 * Lambda") +
  # scale_y_log10() +
  scale_x_continuous(breaks=OOA_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('Three vs. One', 'Three vs. Two', 'Two vs. One')) +
  theme_bw()

OOA_one_epoch_residual = c()
OOA_two_epoch_residual = c()
OOA_three_epoch_residual = c()

for (i in 1:10) {
  OOA_one_epoch_residual = c(OOA_one_epoch_residual, compute_residual(unlist(OOA_empirical_file_list[i]), unlist(OOA_one_epoch_file_list[i])))
  OOA_two_epoch_residual = c(OOA_two_epoch_residual, compute_residual(unlist(OOA_empirical_file_list[i]), unlist(OOA_two_epoch_file_list[i])))
  OOA_three_epoch_residual = c(OOA_three_epoch_residual, compute_residual(unlist(OOA_empirical_file_list[i]), unlist(OOA_three_epoch_file_list[i])))
}

OOA_residual_df = data.frame(OOA_one_epoch_residual, OOA_two_epoch_residual, OOA_three_epoch_residual)
# Reshape the data from wide to long format
OOA_df_long_residual <- tidyr::gather(OOA_residual_df, key = "Epoch", value = "residual", OOA_one_epoch_residual:OOA_three_epoch_residual)

# Increase the x-axis index by 4
OOA_df_long_residual$Index <- rep(seq(10, 100, by = 10), times = 3)

# Create the line plot with ggplot2
ggplot(OOA_df_long_residual, aes(x = Index, y = residual, color = Epoch)) +
  geom_line() +
  geom_point() +
  labs(title = "OOA residual values by sample size",
       x = "Sample Size",
       y = "Residual") +
  scale_y_log10() +
  scale_x_continuous(breaks=OOA_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('One-epoch', 'Three-epoch', 'Two-epoch')) +
  theme_bw()

ggplot(OOA_df_long, aes(x = Index, y = AIC, color = Epoch)) +
  geom_line(linetype=3) +
  geom_point() +
  labs(title = "Tennessen OOA AIC and residual by sample size (N=10-100:10)",
       x = "Sample Size",
       y = "AIC") +
  scale_y_log10(sec.axis = sec_axis(~.*1, name="Residual")) +
  scale_x_continuous(breaks=OOA_df_long$Index) +
  geom_line(data=OOA_df_long_residual, aes(x = Index, y = residual*1, color = Epoch)) +
  scale_color_manual(values = c("blue", "orange", "green", "violet", "red", "seagreen"),
    label=c('One-epoch AIC', 'One-epoch residual',
      'Three-epoch AIC', 'Three-epoch residual',
      'Two-epoch AIC', 'Two-epoch residual')) +
  theme_bw()

# Tennessen_OOA population genetic constants

OOA_mu = 1.5E-8

# NAnc = theta / (4 * allele_sum * mu)
# generations = 2 * tau * theta / (4 * mu * allele_sum)
# years = generations / 365
# NCurr = nu * NAnc
# generations_b = 2 * tauB * theta / (4 * mu * allele_sum)
# generations_f = 2 * tauF * theta / (4 * mu * allele_sum)
# NBottle = nuB * NAnc
# NSince = nuF * NAnc

OOA_one_epoch_NAnc = OOA_one_epoch_theta / (4 * OOA_one_epoch_allele_sum * OOA_mu)
OOA_two_epoch_NAnc = OOA_two_epoch_theta / (4 * OOA_two_epoch_allele_sum * OOA_mu)
OOA_two_epoch_NCurr = OOA_two_epoch_nu * OOA_two_epoch_NAnc
OOA_two_epoch_Time = 2 * 25 * OOA_two_epoch_tau * OOA_two_epoch_theta / (4 * OOA_mu * OOA_two_epoch_allele_sum)
OOA_three_epoch_NAnc = OOA_three_epoch_theta / (4 * OOA_three_epoch_allele_sum * OOA_mu)
OOA_three_epoch_NBottle = OOA_three_epoch_nuB * OOA_three_epoch_NAnc
OOA_three_epoch_NCurr = OOA_three_epoch_nuF * OOA_three_epoch_NAnc
OOA_three_epoch_TimeBottleEnd = 2 * 25 * OOA_three_epoch_tauF * OOA_three_epoch_theta / (4 * OOA_mu * OOA_three_epoch_allele_sum)
OOA_three_epoch_TimeBottleStart = 2 * 25 * OOA_three_epoch_tauB * OOA_three_epoch_theta / (4 * OOA_mu * OOA_three_epoch_allele_sum) + OOA_three_epoch_TimeBottleEnd
OOA_three_epoch_TimeTotal = OOA_three_epoch_TimeBottleStart + OOA_three_epoch_TimeBottleEnd

OOA_two_epoch_max_time = rep(2E6, 10)
# OOA_two_epoch_max_time = rep(2E4, 10)
OOA_two_epoch_current_time = rep(0, 10)
OOA_two_epoch_demography = data.frame(OOA_two_epoch_NAnc, OOA_two_epoch_max_time, 
  OOA_two_epoch_NCurr, OOA_two_epoch_Time, 
  OOA_two_epoch_NCurr, OOA_two_epoch_current_time)

# OOA_three_epoch_max_time = rep(100000000, 10)
# OOA_three_epoch_max_time = rep(5E6, 10)
OOA_three_epoch_max_time = rep(2E6, 10)
OOA_three_epoch_current_time = rep(0, 10)
OOA_three_epoch_demography = data.frame(OOA_three_epoch_NAnc, OOA_three_epoch_max_time,
  OOA_three_epoch_NBottle, OOA_three_epoch_TimeBottleStart,
  OOA_three_epoch_NCurr, OOA_three_epoch_TimeBottleEnd,
  OOA_three_epoch_NCurr, OOA_three_epoch_current_time)

OOA_two_epoch_NEffective_10 = c(OOA_two_epoch_demography[1, 1], OOA_two_epoch_demography[1, 3], OOA_two_epoch_demography[1, 5])
OOA_two_epoch_Time_10 = c(-OOA_two_epoch_demography[1, 2], -OOA_two_epoch_demography[1, 4], OOA_two_epoch_demography[1, 6])
OOA_two_epoch_demography_10 = data.frame(OOA_two_epoch_Time_10, OOA_two_epoch_NEffective_10)
OOA_two_epoch_NEffective_20 = c(OOA_two_epoch_demography[2, 1], OOA_two_epoch_demography[2, 3], OOA_two_epoch_demography[2, 5])
OOA_two_epoch_Time_20 = c(-OOA_two_epoch_demography[2, 2], -OOA_two_epoch_demography[2, 4], OOA_two_epoch_demography[2, 6])
OOA_two_epoch_demography_20 = data.frame(OOA_two_epoch_Time_20, OOA_two_epoch_NEffective_20)
OOA_two_epoch_NEffective_30 = c(OOA_two_epoch_demography[3, 1], OOA_two_epoch_demography[3, 3], OOA_two_epoch_demography[3, 5])
OOA_two_epoch_Time_30 = c(-OOA_two_epoch_demography[3, 2], -OOA_two_epoch_demography[3, 4], OOA_two_epoch_demography[3, 6])
OOA_two_epoch_demography_30 = data.frame(OOA_two_epoch_Time_30, OOA_two_epoch_NEffective_30)
OOA_two_epoch_NEffective_40 = c(OOA_two_epoch_demography[4, 1], OOA_two_epoch_demography[4, 3], OOA_two_epoch_demography[4, 5])
OOA_two_epoch_Time_40 = c(-OOA_two_epoch_demography[4, 2], -OOA_two_epoch_demography[4, 4], OOA_two_epoch_demography[4, 6])
OOA_two_epoch_demography_40 = data.frame(OOA_two_epoch_Time_40, OOA_two_epoch_NEffective_40)
OOA_two_epoch_NEffective_50 = c(OOA_two_epoch_demography[5, 1], OOA_two_epoch_demography[5, 3], OOA_two_epoch_demography[5, 5])
OOA_two_epoch_Time_50 = c(-OOA_two_epoch_demography[5, 2], -OOA_two_epoch_demography[5, 4], OOA_two_epoch_demography[5, 6])
OOA_two_epoch_demography_50 = data.frame(OOA_two_epoch_Time_50, OOA_two_epoch_NEffective_50)
OOA_two_epoch_NEffective_60 = c(OOA_two_epoch_demography[6, 1], OOA_two_epoch_demography[6, 3], OOA_two_epoch_demography[6, 5])
OOA_two_epoch_Time_60 = c(-OOA_two_epoch_demography[6, 2], -OOA_two_epoch_demography[6, 4], OOA_two_epoch_demography[6, 6])
OOA_two_epoch_demography_60 = data.frame(OOA_two_epoch_Time_60, OOA_two_epoch_NEffective_60)
OOA_two_epoch_NEffective_70 = c(OOA_two_epoch_demography[7, 1], OOA_two_epoch_demography[7, 3], OOA_two_epoch_demography[7, 5])
OOA_two_epoch_Time_70 = c(-OOA_two_epoch_demography[7, 2], -OOA_two_epoch_demography[7, 4], OOA_two_epoch_demography[7, 6])
OOA_two_epoch_demography_70 = data.frame(OOA_two_epoch_Time_70, OOA_two_epoch_NEffective_70)
OOA_two_epoch_NEffective_80 = c(OOA_two_epoch_demography[8, 1], OOA_two_epoch_demography[8, 3], OOA_two_epoch_demography[8, 5])
OOA_two_epoch_Time_80 = c(-OOA_two_epoch_demography[8, 2], -OOA_two_epoch_demography[8, 4], OOA_two_epoch_demography[8, 6])
OOA_two_epoch_demography_80 = data.frame(OOA_two_epoch_Time_80, OOA_two_epoch_NEffective_80)
OOA_two_epoch_NEffective_90 = c(OOA_two_epoch_demography[9, 1], OOA_two_epoch_demography[9, 3], OOA_two_epoch_demography[9, 5])
OOA_two_epoch_Time_90 = c(-OOA_two_epoch_demography[9, 2], -OOA_two_epoch_demography[9, 4], OOA_two_epoch_demography[9, 6])
OOA_two_epoch_demography_90 = data.frame(OOA_two_epoch_Time_90, OOA_two_epoch_NEffective_90)
OOA_two_epoch_NEffective_100 = c(OOA_two_epoch_demography[10, 1], OOA_two_epoch_demography[10, 3], OOA_two_epoch_demography[10, 5])
OOA_two_epoch_Time_100 = c(-OOA_two_epoch_demography[10, 2], -OOA_two_epoch_demography[10, 4], OOA_two_epoch_demography[10, 6])
OOA_two_epoch_demography_100 = data.frame(OOA_two_epoch_Time_100, OOA_two_epoch_NEffective_100)

OOA_three_epoch_NEffective_10 = c(OOA_three_epoch_demography[1, 1], OOA_three_epoch_demography[1, 3], OOA_three_epoch_demography[1, 5], OOA_three_epoch_demography[1, 7])
OOA_three_epoch_Time_10 = c(-OOA_three_epoch_demography[1, 2], -OOA_three_epoch_demography[1, 4], -OOA_three_epoch_demography[1, 6], OOA_three_epoch_demography[1, 8])
OOA_three_epoch_demography_10 = data.frame(OOA_three_epoch_Time_10, OOA_three_epoch_NEffective_10)
OOA_three_epoch_NEffective_20 = c(OOA_three_epoch_demography[2, 1], OOA_three_epoch_demography[2, 3], OOA_three_epoch_demography[2, 5], OOA_three_epoch_demography[2, 7])
OOA_three_epoch_Time_20 = c(-OOA_three_epoch_demography[2, 2], -OOA_three_epoch_demography[2, 4], -OOA_three_epoch_demography[2, 6], OOA_three_epoch_demography[2, 8])
OOA_three_epoch_demography_20 = data.frame(OOA_three_epoch_Time_20, OOA_three_epoch_NEffective_20)
OOA_three_epoch_NEffective_30 = c(OOA_three_epoch_demography[3, 1], OOA_three_epoch_demography[3, 3], OOA_three_epoch_demography[3, 5], OOA_three_epoch_demography[3, 7])
OOA_three_epoch_Time_30 = c(-OOA_three_epoch_demography[3, 2], -OOA_three_epoch_demography[3, 4], -OOA_three_epoch_demography[3, 6], OOA_three_epoch_demography[3, 8])
OOA_three_epoch_demography_30 = data.frame(OOA_three_epoch_Time_30, OOA_three_epoch_NEffective_30)
OOA_three_epoch_NEffective_40 = c(OOA_three_epoch_demography[4, 1], OOA_three_epoch_demography[4, 3], OOA_three_epoch_demography[4, 5], OOA_three_epoch_demography[4, 7])
OOA_three_epoch_Time_40 = c(-OOA_three_epoch_demography[4, 2], -OOA_three_epoch_demography[4, 4], -OOA_three_epoch_demography[4, 6], OOA_three_epoch_demography[4, 8])
OOA_three_epoch_demography_40 = data.frame(OOA_three_epoch_Time_40, OOA_three_epoch_NEffective_40)
OOA_three_epoch_NEffective_50 = c(OOA_three_epoch_demography[5, 1], OOA_three_epoch_demography[5, 3], OOA_three_epoch_demography[5, 5], OOA_three_epoch_demography[5, 7])
OOA_three_epoch_Time_50 = c(-OOA_three_epoch_demography[5, 2], -OOA_three_epoch_demography[5, 4], -OOA_three_epoch_demography[5, 6], OOA_three_epoch_demography[5, 8])
OOA_three_epoch_demography_50 = data.frame(OOA_three_epoch_Time_50, OOA_three_epoch_NEffective_50)
OOA_three_epoch_NEffective_60 = c(OOA_three_epoch_demography[6, 1], OOA_three_epoch_demography[6, 3], OOA_three_epoch_demography[6, 5], OOA_three_epoch_demography[6, 7])
OOA_three_epoch_Time_60 = c(-OOA_three_epoch_demography[6, 2], -OOA_three_epoch_demography[6, 4], -OOA_three_epoch_demography[6, 6], OOA_three_epoch_demography[6, 8])
OOA_three_epoch_demography_60 = data.frame(OOA_three_epoch_Time_60, OOA_three_epoch_NEffective_60)
OOA_three_epoch_NEffective_70 = c(OOA_three_epoch_demography[7, 1], OOA_three_epoch_demography[7, 3], OOA_three_epoch_demography[7, 5], OOA_three_epoch_demography[7, 7])
OOA_three_epoch_Time_70 = c(-OOA_three_epoch_demography[7, 2], -OOA_three_epoch_demography[7, 4], -OOA_three_epoch_demography[7, 6], OOA_three_epoch_demography[7, 8])
OOA_three_epoch_demography_70 = data.frame(OOA_three_epoch_Time_70, OOA_three_epoch_NEffective_70)
OOA_three_epoch_NEffective_80 = c(OOA_three_epoch_demography[8, 1], OOA_three_epoch_demography[8, 3], OOA_three_epoch_demography[8, 5], OOA_three_epoch_demography[8, 7])
OOA_three_epoch_Time_80 = c(-OOA_three_epoch_demography[8, 2], -OOA_three_epoch_demography[8, 4], -OOA_three_epoch_demography[8, 6], OOA_three_epoch_demography[8, 8])
OOA_three_epoch_demography_80 = data.frame(OOA_three_epoch_Time_80, OOA_three_epoch_NEffective_80)
OOA_three_epoch_NEffective_90 = c(OOA_three_epoch_demography[9, 1], OOA_three_epoch_demography[9, 3], OOA_three_epoch_demography[9, 5], OOA_three_epoch_demography[9, 7])
OOA_three_epoch_Time_90 = c(-OOA_three_epoch_demography[9, 2], -OOA_three_epoch_demography[9, 4], -OOA_three_epoch_demography[9, 6], OOA_three_epoch_demography[9, 8])
OOA_three_epoch_demography_90 = data.frame(OOA_three_epoch_Time_90, OOA_three_epoch_NEffective_90)
OOA_three_epoch_NEffective_100 = c(OOA_three_epoch_demography[10, 1], OOA_three_epoch_demography[10, 3], OOA_three_epoch_demography[10, 5], OOA_three_epoch_demography[10, 7])
OOA_three_epoch_Time_100 = c(-OOA_three_epoch_demography[10, 2], -OOA_three_epoch_demography[10, 4], -OOA_three_epoch_demography[10, 6], OOA_three_epoch_demography[10, 8])
OOA_three_epoch_demography_100 = data.frame(OOA_three_epoch_Time_100, OOA_three_epoch_NEffective_100)

ggplot(OOA_two_epoch_demography_10, aes(OOA_two_epoch_Time_10, OOA_two_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='dotted') + 
  geom_step(data=OOA_two_epoch_demography_20, aes(OOA_two_epoch_Time_20, OOA_two_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='dotted') +
  geom_step(data=OOA_two_epoch_demography_30, aes(OOA_two_epoch_Time_30, OOA_two_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='dotted') +
  geom_step(data=OOA_two_epoch_demography_40, aes(OOA_two_epoch_Time_40, OOA_two_epoch_NEffective_40, color='N=40'), linewidth=1, linetype='dotted') +
  geom_step(data=OOA_two_epoch_demography_50, aes(OOA_two_epoch_Time_50, OOA_two_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='dotted') +
  geom_step(data=OOA_two_epoch_demography_60, aes(OOA_two_epoch_Time_60, OOA_two_epoch_NEffective_60, color='N=60'), linewidth=1, linetype='dotted') +
  geom_step(data=OOA_two_epoch_demography_70, aes(OOA_two_epoch_Time_70, OOA_two_epoch_NEffective_70, color='N=70'), linewidth=1, linetype='dotted') +
  geom_step(data=OOA_two_epoch_demography_80, aes(OOA_two_epoch_Time_80, OOA_two_epoch_NEffective_80, color='N=80'), linewidth=1, linetype='dotted') +
  geom_step(data=OOA_two_epoch_demography_90, aes(OOA_two_epoch_Time_90, OOA_two_epoch_NEffective_90, color='N=90'), linewidth=1, linetype='dotted') +
  geom_step(data=OOA_two_epoch_demography_100, aes(OOA_two_epoch_Time_100, OOA_two_epoch_NEffective_100, color='N=100'), linewidth=1, linetype='dotted') +
  scale_color_manual(name='Sample Size',
                     breaks=c('N=10', 'N=20', 'N=30', 'N=40', 'N=50', 'N=60', 'N=70', 'N=80', 'N=90', 'N=100'),
                     values=c('N=10'='#7f3b08',
                       'N=20'='#b35806',
                       'N=30'='#e08214',
                       'N=40'='#fdb863',
                       'N=50'='#fee0b6',
                       'N=60'='#d8daeb',
                       'N=70'='#b2abd2',
                       'N=80'='#8073ac',
                       'N=90'='#542788',
                       'N=100'='#2d004b')) +
  theme_bw() +
  ylab('Effective Population Size') +
  xlab('Time in Years') +
  ggtitle('Tennessen OOA two Epoch Demography (N=10-100:10)')

ggplot(OOA_two_epoch_demography_10, aes(OOA_two_epoch_Time_10, OOA_two_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='dashed') + 
  # geom_step(data=OOA_two_epoch_demography_20, aes(OOA_two_epoch_Time_20, OOA_two_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='dashed') +
  # geom_step(data=OOA_two_epoch_demography_30, aes(OOA_two_epoch_Time_30, OOA_two_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='dashed') +
  # geom_step(data=OOA_two_epoch_demography_40, aes(OOA_two_epoch_Time_40, OOA_two_epoch_NEffective_40, color='N=40'), linewidth=1, linetype='dashed') +
  # geom_step(data=OOA_two_epoch_demography_50, aes(OOA_two_epoch_Time_50, OOA_two_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='dashed') +
  # geom_step(data=OOA_two_epoch_demography_60, aes(OOA_two_epoch_Time_60, OOA_two_epoch_NEffective_60, color='N=60'), linewidth=1, linetype='dashed') +
  # geom_step(data=OOA_two_epoch_demography_70, aes(OOA_two_epoch_Time_70, OOA_two_epoch_NEffective_70, color='N=70'), linewidth=1, linetype='dashed') +
  # geom_step(data=OOA_two_epoch_demography_80, aes(OOA_two_epoch_Time_80, OOA_two_epoch_NEffective_80, color='N=80'), linewidth=1, linetype='dashed') +
  # geom_step(data=OOA_two_epoch_demography_90, aes(OOA_two_epoch_Time_90, OOA_two_epoch_NEffective_90, color='N=90'), linewidth=1, linetype='dashed') +
  # geom_step(data=OOA_two_epoch_demography_100, aes(OOA_two_epoch_Time_100, OOA_two_epoch_NEffective_100, color='#N=100'), linewidth=1, linetype='dashed') +
  # geom_step(data=OOA_three_epoch_demography_10, aes(OOA_three_epoch_Time_10, OOA_three_epoch_NEffective_10, color='N=10'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_20, aes(OOA_three_epoch_Time_20, OOA_three_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_30, aes(OOA_three_epoch_Time_30, OOA_three_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_40, aes(OOA_three_epoch_Time_40, OOA_three_epoch_NEffective_40, color='N=40'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_50, aes(OOA_three_epoch_Time_50, OOA_three_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_60, aes(OOA_three_epoch_Time_60, OOA_three_epoch_NEffective_60, color='N=60'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_70, aes(OOA_three_epoch_Time_70, OOA_three_epoch_NEffective_70, color='N=70'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_80, aes(OOA_three_epoch_Time_80, OOA_three_epoch_NEffective_80, color='N=80'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_90, aes(OOA_three_epoch_Time_90, OOA_three_epoch_NEffective_90, color='N=90'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_100, aes(OOA_three_epoch_Time_100, OOA_three_epoch_NEffective_100, color='N=100'), linewidth=1, linetype='solid') +
  scale_color_manual(name='Sample Size',
                     breaks=c('N=10', 'N=20', 'N=30', 'N=40', 'N=50', 'N=60', 'N=70', 'N=80', 'N=90', 'N=100'),
                     values=c('N=10'='#7f3b08',
                       'N=20'='#b35806',
                       'N=30'='#e08214',
                       'N=40'='#fdb863',
                       'N=50'='#fee0b6',
                       'N=60'='#d8daeb',
                       'N=70'='#b2abd2',
                       'N=80'='#8073ac',
                       'N=90'='#542788',
                       'N=100'='#2d004b')) +
  theme_bw() +
  ylab('Effective Population Size') +
  xlab('Time in Years') +
  ggtitle('Tennessen OOA Best-fitting Demography (N=10-100:10)')

ggplot(OOA_three_epoch_demography_10, aes(OOA_three_epoch_Time_10, OOA_three_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='solid') + 
  geom_step(data=OOA_three_epoch_demography_20, aes(OOA_three_epoch_Time_20, OOA_three_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_30, aes(OOA_three_epoch_Time_30, OOA_three_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_40, aes(OOA_three_epoch_Time_40, OOA_three_epoch_NEffective_40, color='N=40'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_50, aes(OOA_three_epoch_Time_50, OOA_three_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_60, aes(OOA_three_epoch_Time_60, OOA_three_epoch_NEffective_60, color='N=60'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_70, aes(OOA_three_epoch_Time_70, OOA_three_epoch_NEffective_70, color='N=70'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_80, aes(OOA_three_epoch_Time_80, OOA_three_epoch_NEffective_80, color='N=80'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_90, aes(OOA_three_epoch_Time_90, OOA_three_epoch_NEffective_90, color='N=90'), linewidth=1, linetype='solid') +
  geom_step(data=OOA_three_epoch_demography_100, aes(OOA_three_epoch_Time_100, OOA_three_epoch_NEffective_100, color='N=100'), linewidth=1, linetype='solid') +
  scale_color_manual(name='Sample Size',
                     breaks=c('N=10', 'N=20', 'N=30', 'N=40', 'N=50', 'N=60', 'N=70', 'N=80', 'N=90', 'N=100'),
                     values=c('N=10'='#7f3b08',
                       'N=20'='#b35806',
                       'N=30'='#e08214',
                       'N=40'='#fdb863',
                       'N=50'='#fee0b6',
                       'N=60'='#d8daeb',
                       'N=70'='#b2abd2',
                       'N=80'='#8073ac',
                       'N=90'='#542788',
                       'N=100'='#2d004b')) +
  theme_bw() +
  ylab('Effective Population Size') +
  xlab('Time in Years') +
  ggtitle('Tennessen OOA Three Epoch Demography (N=10-100:10)')

# ggplot(OOA_three_epoch_demography_20, aes(OOA_three_epoch_Time_20, OOA_three_epoch_NEffective_20color='#b35806')) + geom_step(linewidth=1, linetype='solid') + 
#   # geom_step(data=OOA_three_epoch_demography_20, aes(OOA_three_epoch_Time_20, OOA_three_epoch_NEffective_20, color='#b35806'), linewidth=1, linetype='solid') +
#   geom_step(data=OOA_three_epoch_demography_30, aes(OOA_three_epoch_Time_30, OOA_three_epoch_NEffective_30, color='#e08214'), linewidth=1, linetype='solid') +
#   geom_step(data=OOA_three_epoch_demography_40, aes(OOA_three_epoch_Time_40, OOA_three_epoch_NEffective_40, color='#fdb863'), linewidth=1, linetype='solid') +
#   geom_step(data=OOA_three_epoch_demography_50, aes(OOA_three_epoch_Time_50, OOA_three_epoch_NEffective_50, color='#fee0b6'), linewidth=1, linetype='solid') +
#   geom_step(data=OOA_three_epoch_demography_60, aes(OOA_three_epoch_Time_60, OOA_three_epoch_NEffective_60, color='#d8daeb'), linewidth=1, linetype='solid') +
#   geom_step(data=OOA_three_epoch_demography_70, aes(OOA_three_epoch_Time_70, OOA_three_epoch_NEffective_70, color='#b2abd2'), linewidth=1, linetype='solid') +
#   geom_step(data=OOA_three_epoch_demography_80, aes(OOA_three_epoch_Time_80, OOA_three_epoch_NEffective_80, color='#8073ac'), linewidth=1, linetype='solid') +
#   geom_step(data=OOA_three_epoch_demography_90, aes(OOA_three_epoch_Time_90, OOA_three_epoch_NEffective_90, color='#542788'), linewidth=1, linetype='solid') +
#   geom_step(data=OOA_three_epoch_demography_100, aes(OOA_three_epoch_Time_100, OOA_three_epoch_NEffective_100, color='#2d004b'), linewidth=1, linetype='solid') +
#   scale_color_manual(name='Sample Size',
#                      breaks=c('N=10', 'N=20', 'N=30', 'N=40', 'N=50', 'N=60', 'N=70', 'N=80', 'N=90', 'N=100'),
#                      values=c('N=10'='#7f3b08',
#                        'N=20'='#b35806',
#                        'N=30'='#e08214',
#                        'N=40'='#fdb863',
#                        'N=50'='#fee0b6',
#                        'N=60'='#d8daeb',
#                        'N=70'='#b2abd2',
#                        'N=80'='#8073ac',
#                        'N=90'='#542788',
#                        'N=100'='#2d004b')) +
#   theme_bw() +
#   ylab('Effective Population Size') +
#   xlab('Time in Years') +
#   ggtitle('Tennessen OOA Three Epoch Demography, 10-100:10')

# NAnc Estimate by Sample Size
sample_size = c(10, 20, 30, 40, 50, 60, 70, 80, 90, 100)

NAnc_df = data.frame(sample_size, OOA_one_epoch_NAnc, OOA_two_epoch_NAnc, OOA_three_epoch_NAnc)
NAnc_df = melt(NAnc_df, id='sample_size')

ggplot(data=NAnc_df, aes(x=sample_size, y=value, color=variable)) + geom_line() +
  xlab('Sample size') +
  ylab('Estimated ancestral effective population size') +
  ggtitle('Tennessen OOA NAnc by sample size (N=10-100:10)') +
  theme_bw() +
  guides(color=guide_legend(title="Epoch")) +
  scale_color_manual(
    labels=c('One-epoch', 'Two-epoch', 'Three-epoch'),
    values=c('red', 'blue', 'green')) +
  geom_hline(yintercept=12378, color='black', linetype='dashed') +
  scale_x_continuous(breaks=sample_size)
