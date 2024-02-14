setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

# P. copri

p_copri_empirical_file_list = list()
p_copri_one_epoch_file_list = list()
p_copri_two_epoch_file_list = list()
p_copri_three_epoch_file_list = list()
p_copri_one_epoch_AIC = c()
p_copri_one_epoch_LL = c()
p_copri_one_epoch_theta = c()
p_copri_one_epoch_allele_sum = c()
p_copri_two_epoch_AIC = c()
p_copri_two_epoch_LL = c()
p_copri_two_epoch_theta = c()
p_copri_two_epoch_nu = c()
p_copri_two_epoch_tau = c()
p_copri_two_epoch_allele_sum = c()
p_copri_three_epoch_AIC = c()
p_copri_three_epoch_LL = c()
p_copri_three_epoch_theta = c()
p_copri_three_epoch_nuB = c()
p_copri_three_epoch_nuF = c()
p_copri_three_epoch_tauB = c()
p_copri_three_epoch_tauF = c()
p_copri_three_epoch_allele_sum = c()

# Loop through subdirectories and get relevant files
for (i in 5:14) {
  subdirectory <- paste0("../Analysis/p_copri_core_", i)
  p_copri_empirical_file_path <- file.path(subdirectory, "syn_downsampled_sfs.txt")
  p_copri_one_epoch_file_path <- file.path(subdirectory, "one_epoch_demography.txt")
  p_copri_two_epoch_file_path <- file.path(subdirectory, "two_epoch_demography.txt")
  p_copri_three_epoch_file_path <- file.path(subdirectory, "three_epoch_demography.txt")
  
  # Check if the file exists before attempting to read and print its contents
  if (file.exists(p_copri_empirical_file_path)) {
    this_empirical_sfs = read_input_sfs(p_copri_empirical_file_path)
    p_copri_empirical_file_list[[subdirectory]] = this_empirical_sfs
  }
  if (file.exists(p_copri_one_epoch_file_path)) {
    this_one_epoch_sfs = sfs_from_demography(p_copri_one_epoch_file_path)
    p_copri_one_epoch_file_list[[subdirectory]] = this_one_epoch_sfs
    p_copri_one_epoch_AIC = c(p_copri_one_epoch_AIC, AIC_from_demography(p_copri_one_epoch_file_path))
    p_copri_one_epoch_LL = c(p_copri_one_epoch_LL, LL_from_demography(p_copri_one_epoch_file_path))
    p_copri_one_epoch_theta = c(p_copri_one_epoch_theta, theta_from_demography(p_copri_one_epoch_file_path))
    p_copri_one_epoch_allele_sum = c(p_copri_one_epoch_allele_sum, sum(this_one_epoch_sfs))
  }
  if (file.exists(p_copri_two_epoch_file_path)) {
    this_two_epoch_sfs = sfs_from_demography(p_copri_two_epoch_file_path)
    p_copri_two_epoch_file_list[[subdirectory]] = this_two_epoch_sfs
    p_copri_two_epoch_AIC = c(p_copri_two_epoch_AIC, AIC_from_demography(p_copri_two_epoch_file_path))
    p_copri_two_epoch_LL = c(p_copri_two_epoch_LL, LL_from_demography(p_copri_two_epoch_file_path))
    p_copri_two_epoch_theta = c(p_copri_two_epoch_theta, theta_from_demography(p_copri_two_epoch_file_path))
    p_copri_two_epoch_nu = c(p_copri_two_epoch_nu, nu_from_demography(p_copri_two_epoch_file_path))
    p_copri_two_epoch_tau = c(p_copri_two_epoch_tau, tau_from_demography(p_copri_two_epoch_file_path))
    p_copri_two_epoch_allele_sum = c(p_copri_two_epoch_allele_sum, sum(this_two_epoch_sfs))
  }
  if (file.exists(p_copri_three_epoch_file_path)) {
    this_three_epoch_sfs = sfs_from_demography(p_copri_three_epoch_file_path)
    p_copri_three_epoch_file_list[[subdirectory]] = this_three_epoch_sfs
    p_copri_three_epoch_AIC = c(p_copri_three_epoch_AIC, AIC_from_demography(p_copri_three_epoch_file_path))
    p_copri_three_epoch_LL = c(p_copri_three_epoch_LL, LL_from_demography(p_copri_three_epoch_file_path))
    p_copri_three_epoch_theta = c(p_copri_three_epoch_theta, theta_from_demography(p_copri_three_epoch_file_path))
    p_copri_three_epoch_nuB = c(p_copri_three_epoch_nuB, nuB_from_demography(p_copri_three_epoch_file_path))
    p_copri_three_epoch_nuF = c(p_copri_three_epoch_nuF, nuF_from_demography(p_copri_three_epoch_file_path))
    p_copri_three_epoch_tauB = c(p_copri_three_epoch_tauB, tauB_from_demography(p_copri_three_epoch_file_path))
    p_copri_three_epoch_tauF = c(p_copri_three_epoch_tauF, tauF_from_demography(p_copri_three_epoch_file_path))
    p_copri_three_epoch_allele_sum = c(p_copri_three_epoch_allele_sum, sum(this_three_epoch_sfs))
  }  
}

p_copri_AIC_df = data.frame(p_copri_one_epoch_AIC, p_copri_two_epoch_AIC, p_copri_three_epoch_AIC)
# Reshape the data from wide to long format
p_copri_df_long <- tidyr::gather(p_copri_AIC_df, key = "Epoch", value = "AIC", p_copri_one_epoch_AIC:p_copri_three_epoch_AIC)

# Increase the x-axis index by 4
p_copri_df_long$Index <- rep(5:14, times = 3)

# Create the line plot with ggplot2
ggplot(p_copri_df_long, aes(x = Index, y = AIC, color = Epoch)) +
  geom_line() +
  geom_point() +
  labs(title = "P. copri AIC values by sample size",
       x = "Sample Size",
       y = "AIC") +
  scale_y_log10() +
  scale_x_continuous(breaks=p_copri_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('One-epoch', 'Three-epoch', 'Two-epoch')) +
  theme_bw()

# compare_one_two_three_proportional_sfs(unlist(p_copri_empirical_file_list[1]),
#   unlist(p_copri_one_epoch_file_list[1]),
#   unlist(p_copri_two_epoch_file_list[1]),
#   unlist(p_copri_three_epoch_file_list[1])) + ggtitle('P. copri, Sample size = 5')
# 
# compare_one_two_three_proportional_sfs(unlist(p_copri_empirical_file_list[2]),
#   unlist(p_copri_one_epoch_file_list[2]),
#   unlist(p_copri_two_epoch_file_list[2]),
#   unlist(p_copri_three_epoch_file_list[2])) + ggtitle('P. copri, Sample size = 6')
# 
# compare_one_two_three_proportional_sfs(unlist(p_copri_empirical_file_list[3]),
#   unlist(p_copri_one_epoch_file_list[3]),
#   unlist(p_copri_two_epoch_file_list[3]),
#   unlist(p_copri_three_epoch_file_list[3])) + ggtitle('P. copri, Sample size = 7')
# 
# compare_one_two_three_proportional_sfs(unlist(p_copri_empirical_file_list[4]),
#   unlist(p_copri_one_epoch_file_list[4]),
#   unlist(p_copri_two_epoch_file_list[4]),
#   unlist(p_copri_three_epoch_file_list[4])) + ggtitle('P. copri, Sample size = 8')
# 
# compare_one_two_three_proportional_sfs(unlist(p_copri_empirical_file_list[5]),
#   unlist(p_copri_one_epoch_file_list[5]),
#   unlist(p_copri_two_epoch_file_list[5]),
#   unlist(p_copri_three_epoch_file_list[5])) + ggtitle('P. copri, Sample size = 9')
# 
# compare_one_two_three_proportional_sfs(unlist(p_copri_empirical_file_list[6]),
#   unlist(p_copri_one_epoch_file_list[6]),
#   unlist(p_copri_two_epoch_file_list[6]),
#   unlist(p_copri_three_epoch_file_list[6])) + ggtitle('P. copri, Sample size = 10')
# 
# compare_one_two_three_proportional_sfs(unlist(p_copri_empirical_file_list[7]),
#   unlist(p_copri_one_epoch_file_list[7]),
#   unlist(p_copri_two_epoch_file_list[7]),
#   unlist(p_copri_three_epoch_file_list[7])) + ggtitle('P. copri, Sample size = 11')
# 
# compare_one_two_three_proportional_sfs(unlist(p_copri_empirical_file_list[8]),
#   unlist(p_copri_one_epoch_file_list[8]),
#   unlist(p_copri_two_epoch_file_list[8]),
#   unlist(p_copri_three_epoch_file_list[8])) + ggtitle('P. copri, Sample size = 12')
# 
# compare_one_two_three_proportional_sfs(unlist(p_copri_empirical_file_list[9]),
#   unlist(p_copri_one_epoch_file_list[9]),
#   unlist(p_copri_two_epoch_file_list[9]),
#   unlist(p_copri_three_epoch_file_list[9])) + ggtitle('P. copri, Sample size = 13')
# 
# compare_one_two_three_proportional_sfs(unlist(p_copri_empirical_file_list[10]),
#   unlist(p_copri_one_epoch_file_list[10]),
#   unlist(p_copri_two_epoch_file_list[10]),
#   unlist(p_copri_three_epoch_file_list[10])) + ggtitle('P. copri, Sample size = 14')

p_copri_one_epoch_residual = c()
p_copri_two_epoch_residual = c()
p_copri_three_epoch_residual = c()

for (i in 1:10) {
  p_copri_one_epoch_residual = c(p_copri_one_epoch_residual, compute_residual(unlist(p_copri_empirical_file_list[i]), unlist(p_copri_one_epoch_file_list[i])))
  p_copri_two_epoch_residual = c(p_copri_two_epoch_residual, compute_residual(unlist(p_copri_empirical_file_list[i]), unlist(p_copri_two_epoch_file_list[i])))
  p_copri_three_epoch_residual = c(p_copri_three_epoch_residual, compute_residual(unlist(p_copri_empirical_file_list[i]), unlist(p_copri_three_epoch_file_list[i])))
}

p_copri_residual_df = data.frame(p_copri_one_epoch_residual, p_copri_two_epoch_residual, p_copri_three_epoch_residual)
# Reshape the data from wide to long format
p_copri_df_long_residual <- tidyr::gather(p_copri_residual_df, key = "Epoch", value = "residual", p_copri_one_epoch_residual:p_copri_three_epoch_residual)

# Increase the x-axis index by 4
p_copri_df_long_residual$Index <- rep(5:14, times = 3)

# Create the line plot with ggplot2
ggplot(p_copri_df_long_residual, aes(x = Index, y = residual, color = Epoch)) +
  geom_line() +
  geom_point() +
  labs(title = "P. copri residual values by sample size",
       x = "Sample Size",
       y = "Residual") +
  scale_y_log10() +
  scale_x_continuous(breaks=p_copri_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('One-epoch', 'Three-epoch', 'Two-epoch')) +
  theme_bw()

# AIC and residual
# Create the line plot with ggplot2
ggplot(p_copri_df_long, aes(x = Index, y = AIC, color = Epoch)) +
  geom_line(linetype=3) +
  geom_point() +
  labs(title = "P. copri AIC and residual by sample size",
       x = "Sample Size",
       y = "AIC") +
  scale_y_log10(sec.axis = sec_axis(~.*0.001, name="Residual")) +
  scale_x_continuous(breaks=p_copri_df_long$Index) +
  geom_line(data=p_copri_df_long_residual, aes(x = Index, y = residual*1000, color = Epoch)) +
  scale_color_manual(values = c("blue", "orange", "green", "violet", "red", "seagreen"),
    label=c('One-epoch AIC', 'One-epoch residual',
      'Three-epoch AIC', 'Three-epoch residual',
      'Two-epoch AIC', 'Two-epoch residual')) +
  theme_bw()

p_copri_lambda_two_one = 2 * (p_copri_two_epoch_LL - p_copri_one_epoch_LL)
p_copri_lambda_three_one = 2 * (p_copri_three_epoch_LL - p_copri_one_epoch_LL)
p_copri_lambda_three_two = 2 * (p_copri_three_epoch_LL - p_copri_two_epoch_LL)

p_copri_lambda_df = data.frame(p_copri_lambda_two_one, p_copri_lambda_three_one, p_copri_lambda_three_two)
# Reshape the data from wide to long format
p_copri_df_long_lambda <- tidyr::gather(p_copri_lambda_df, key = "Full_vs_Null", value = "Lambda", p_copri_lambda_two_one:p_copri_lambda_three_two)

# Increase the x-axis index by 4
p_copri_df_long_lambda$Index <- rep(5:14, times = 3)

# Create the line plot with ggplot2
ggplot(p_copri_df_long_lambda, aes(x = Index, y = Lambda, color = Full_vs_Null)) +
  geom_line() +
  geom_point() +
  labs(title = "P. copri Lambda values by sample size",
       x = "Sample Size",
       y = "2 * Lambda") +
  # scale_y_log10() +
  scale_x_continuous(breaks=p_copri_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('Three vs. One', 'Three vs. Two', 'Two vs. One')) +
  theme_bw()

p_copri_df_long_lambda_temp_1 = p_copri_df_long_lambda[-c(21:30), ]

ggplot(p_copri_df_long_lambda_temp_1, aes(x = Index, y = Lambda, color = Full_vs_Null)) +
  geom_line() +
  geom_point() +
  labs(title = "P. copri Lambda values by sample size",
       x = "Sample Size",
       y = "2 * Lambda") +
  scale_y_log10() +
  scale_x_continuous(breaks=p_copri_df_long$Index) +
  scale_color_manual(values = c("blue", "red"),
    label=c('Three vs. One', 'Two vs. One')) +
  theme_bw()

p_copri_df_long_lambda_temp_2 = p_copri_df_long_lambda[-c(1:20), ]

ggplot(p_copri_df_long_lambda_temp_2, aes(x = Index, y = Lambda, color = Full_vs_Null)) +
  geom_line() +
  geom_point() +
  labs(title = "P. copri Lambda values by sample size",
       x = "Sample Size",
       y = "2 * Lambda") +
  scale_x_continuous(breaks=p_copri_df_long$Index) +
  scale_color_manual(values = c("green"),
    label=c('Three vs. Two')) +
  theme_bw()

# P. copri population genetic constants

p_copri_mu = 4.08E-10

# NAnc = theta / (4 * allele_sum * mu)
# generations = 2 * tau * theta / (4 * mu * allele_sum)
# years = generations / 365
# NCurr = nu * NAnc
# generations_b = 2 * tauB * theta / (4 * mu * allele_sum)
# generations_f = 2 * tauF * theta / (4 * mu * allele_sum)
# NBottle = nuB * NAnc
# NSince = nuF * NAnc


p_copri_one_epoch_NAnc = p_copri_one_epoch_theta / (4 * p_copri_one_epoch_allele_sum * p_copri_mu)
p_copri_two_epoch_NAnc = p_copri_two_epoch_theta / (4 * p_copri_two_epoch_allele_sum * p_copri_mu)
p_copri_two_epoch_NCurr = p_copri_two_epoch_nu * p_copri_two_epoch_NAnc
p_copri_two_epoch_Time = 2 * p_copri_two_epoch_tau * p_copri_two_epoch_theta / (4 * p_copri_mu * p_copri_two_epoch_allele_sum * 365)
p_copri_three_epoch_NAnc = p_copri_three_epoch_theta / (4 * p_copri_three_epoch_allele_sum * p_copri_mu)
p_copri_three_epoch_NBottle = p_copri_three_epoch_nuB * p_copri_three_epoch_NAnc
p_copri_three_epoch_NCurr = p_copri_three_epoch_nuF * p_copri_three_epoch_NAnc
p_copri_three_epoch_TimeBottleStart = 2 * p_copri_three_epoch_tauB * p_copri_three_epoch_theta / (4 * p_copri_mu * p_copri_three_epoch_allele_sum * 365)
p_copri_three_epoch_TimeBottleEnd = 2 * p_copri_three_epoch_tauF * p_copri_three_epoch_theta / (4 * p_copri_mu * p_copri_three_epoch_allele_sum * 365)
p_copri_three_epoch_TimeTotal = p_copri_three_epoch_TimeBottleStart + p_copri_three_epoch_TimeBottleEnd

p_copri_two_epoch_max_time = rep(1000000, 10)
p_copri_two_epoch_current_time = rep(0, 10)
p_copri_two_epoch_demography = data.frame(p_copri_two_epoch_NAnc, p_copri_two_epoch_max_time, 
  p_copri_two_epoch_NCurr, p_copri_two_epoch_Time, 
  p_copri_two_epoch_NCurr, p_copri_two_epoch_current_time)

p_copri_three_epoch_max_time = rep(1000000, 10)
p_copri_three_epoch_current_time = rep(0, 10)
p_copri_three_epoch_demography = data.frame(p_copri_three_epoch_NAnc, p_copri_three_epoch_max_time,
  p_copri_three_epoch_NBottle, p_copri_three_epoch_TimeBottleStart,
  p_copri_three_epoch_NCurr, p_copri_three_epoch_TimeBottleEnd,
  p_copri_three_epoch_NCurr, p_copri_three_epoch_current_time)

p_copri_two_epoch_NEffective_5 = c(p_copri_two_epoch_demography[1, 1], p_copri_two_epoch_demography[1, 3], p_copri_two_epoch_demography[1, 5])
p_copri_two_epoch_Time_5 = c(-p_copri_two_epoch_demography[1, 2], -p_copri_two_epoch_demography[1, 4], p_copri_two_epoch_demography[1, 6])
p_copri_two_epoch_demography_5 = data.frame(p_copri_two_epoch_Time_5, p_copri_two_epoch_NEffective_5)
p_copri_two_epoch_NEffective_6 = c(p_copri_two_epoch_demography[2, 1], p_copri_two_epoch_demography[2, 3], p_copri_two_epoch_demography[2, 5])
p_copri_two_epoch_Time_6 = c(-p_copri_two_epoch_demography[2, 2], -p_copri_two_epoch_demography[2, 4], p_copri_two_epoch_demography[2, 6])
p_copri_two_epoch_demography_6 = data.frame(p_copri_two_epoch_Time_6, p_copri_two_epoch_NEffective_6)
p_copri_two_epoch_NEffective_7 = c(p_copri_two_epoch_demography[3, 1], p_copri_two_epoch_demography[3, 3], p_copri_two_epoch_demography[3, 5])
p_copri_two_epoch_Time_7 = c(-p_copri_two_epoch_demography[3, 2], -p_copri_two_epoch_demography[3, 4], p_copri_two_epoch_demography[3, 6])
p_copri_two_epoch_demography_7 = data.frame(p_copri_two_epoch_Time_7, p_copri_two_epoch_NEffective_7)
p_copri_two_epoch_NEffective_8 = c(p_copri_two_epoch_demography[4, 1], p_copri_two_epoch_demography[4, 3], p_copri_two_epoch_demography[4, 5])
p_copri_two_epoch_Time_8 = c(-p_copri_two_epoch_demography[4, 2], -p_copri_two_epoch_demography[4, 4], p_copri_two_epoch_demography[4, 6])
p_copri_two_epoch_demography_8 = data.frame(p_copri_two_epoch_Time_8, p_copri_two_epoch_NEffective_8)
p_copri_two_epoch_NEffective_9 = c(p_copri_two_epoch_demography[5, 1], p_copri_two_epoch_demography[5, 3], p_copri_two_epoch_demography[5, 5])
p_copri_two_epoch_Time_9 = c(-p_copri_two_epoch_demography[5, 2], -p_copri_two_epoch_demography[5, 4], p_copri_two_epoch_demography[5, 6])
p_copri_two_epoch_demography_9 = data.frame(p_copri_two_epoch_Time_9, p_copri_two_epoch_NEffective_9)
p_copri_two_epoch_NEffective_10 = c(p_copri_two_epoch_demography[6, 1], p_copri_two_epoch_demography[6, 3], p_copri_two_epoch_demography[6, 5])
p_copri_two_epoch_Time_10 = c(-p_copri_two_epoch_demography[6, 2], -p_copri_two_epoch_demography[6, 4], p_copri_two_epoch_demography[6, 6])
p_copri_two_epoch_demography_10 = data.frame(p_copri_two_epoch_Time_10, p_copri_two_epoch_NEffective_10)
p_copri_two_epoch_NEffective_11 = c(p_copri_two_epoch_demography[7, 1], p_copri_two_epoch_demography[7, 3], p_copri_two_epoch_demography[7, 5])
p_copri_two_epoch_Time_11 = c(-p_copri_two_epoch_demography[7, 2], -p_copri_two_epoch_demography[7, 4], p_copri_two_epoch_demography[7, 6])
p_copri_two_epoch_demography_11 = data.frame(p_copri_two_epoch_Time_11, p_copri_two_epoch_NEffective_11)
p_copri_two_epoch_NEffective_12 = c(p_copri_two_epoch_demography[8, 1], p_copri_two_epoch_demography[8, 3], p_copri_two_epoch_demography[8, 5])
p_copri_two_epoch_Time_12 = c(-p_copri_two_epoch_demography[8, 2], -p_copri_two_epoch_demography[8, 4], p_copri_two_epoch_demography[8, 6])
p_copri_two_epoch_demography_12 = data.frame(p_copri_two_epoch_Time_12, p_copri_two_epoch_NEffective_12)
p_copri_two_epoch_NEffective_13 = c(p_copri_two_epoch_demography[9, 1], p_copri_two_epoch_demography[9, 3], p_copri_two_epoch_demography[9, 5])
p_copri_two_epoch_Time_13 = c(-p_copri_two_epoch_demography[9, 2], -p_copri_two_epoch_demography[9, 4], p_copri_two_epoch_demography[9, 6])
p_copri_two_epoch_demography_13 = data.frame(p_copri_two_epoch_Time_13, p_copri_two_epoch_NEffective_13)
p_copri_two_epoch_NEffective_14 = c(p_copri_two_epoch_demography[10, 1], p_copri_two_epoch_demography[10, 3], p_copri_two_epoch_demography[10, 5])
p_copri_two_epoch_Time_14 = c(-p_copri_two_epoch_demography[10, 2], -p_copri_two_epoch_demography[10, 4], p_copri_two_epoch_demography[10, 6])
p_copri_two_epoch_demography_14 = data.frame(p_copri_two_epoch_Time_14, p_copri_two_epoch_NEffective_14)

p_copri_three_epoch_NEffective_5 = c(p_copri_three_epoch_demography[1, 1], p_copri_three_epoch_demography[1, 3], p_copri_three_epoch_demography[1, 5], p_copri_three_epoch_demography[1, 7])
p_copri_three_epoch_Time_5 = c(-p_copri_three_epoch_demography[1, 2], -p_copri_three_epoch_demography[1, 4], -p_copri_three_epoch_demography[1, 6], p_copri_three_epoch_demography[1, 8])
p_copri_three_epoch_demography_5 = data.frame(p_copri_three_epoch_Time_5, p_copri_three_epoch_NEffective_5)
p_copri_three_epoch_NEffective_6 = c(p_copri_three_epoch_demography[2, 1], p_copri_three_epoch_demography[2, 3], p_copri_three_epoch_demography[2, 5], p_copri_three_epoch_demography[2, 7])
p_copri_three_epoch_Time_6 = c(-p_copri_three_epoch_demography[2, 2], -p_copri_three_epoch_demography[2, 4], -p_copri_three_epoch_demography[2, 6], p_copri_three_epoch_demography[2, 8])
p_copri_three_epoch_demography_6 = data.frame(p_copri_three_epoch_Time_6, p_copri_three_epoch_NEffective_6)
p_copri_three_epoch_NEffective_7 = c(p_copri_three_epoch_demography[3, 1], p_copri_three_epoch_demography[3, 3], p_copri_three_epoch_demography[3, 5], p_copri_three_epoch_demography[3, 7])
p_copri_three_epoch_Time_7 = c(-p_copri_three_epoch_demography[3, 2], -p_copri_three_epoch_demography[3, 4], -p_copri_three_epoch_demography[3, 6], p_copri_three_epoch_demography[3, 8])
p_copri_three_epoch_demography_7 = data.frame(p_copri_three_epoch_Time_7, p_copri_three_epoch_NEffective_7)
p_copri_three_epoch_NEffective_8 = c(p_copri_three_epoch_demography[4, 1], p_copri_three_epoch_demography[4, 3], p_copri_three_epoch_demography[4, 5], p_copri_three_epoch_demography[4, 7])
p_copri_three_epoch_Time_8 = c(-p_copri_three_epoch_demography[4, 2], -p_copri_three_epoch_demography[4, 4], -p_copri_three_epoch_demography[4, 6], p_copri_three_epoch_demography[4, 8])
p_copri_three_epoch_demography_8 = data.frame(p_copri_three_epoch_Time_8, p_copri_three_epoch_NEffective_8)
p_copri_three_epoch_NEffective_9 = c(p_copri_three_epoch_demography[5, 1], p_copri_three_epoch_demography[5, 3], p_copri_three_epoch_demography[5, 5], p_copri_three_epoch_demography[5, 7])
p_copri_three_epoch_Time_9 = c(-p_copri_three_epoch_demography[5, 2], -p_copri_three_epoch_demography[5, 4], -p_copri_three_epoch_demography[5, 6], p_copri_three_epoch_demography[5, 8])
p_copri_three_epoch_demography_9 = data.frame(p_copri_three_epoch_Time_9, p_copri_three_epoch_NEffective_9)
p_copri_three_epoch_NEffective_10 = c(p_copri_three_epoch_demography[6, 1], p_copri_three_epoch_demography[6, 3], p_copri_three_epoch_demography[6, 5], p_copri_three_epoch_demography[6, 7])
p_copri_three_epoch_Time_10 = c(-p_copri_three_epoch_demography[6, 2], -p_copri_three_epoch_demography[6, 4], -p_copri_three_epoch_demography[6, 6], p_copri_three_epoch_demography[6, 8])
p_copri_three_epoch_demography_10 = data.frame(p_copri_three_epoch_Time_10, p_copri_three_epoch_NEffective_10)
p_copri_three_epoch_NEffective_11 = c(p_copri_three_epoch_demography[7, 1], p_copri_three_epoch_demography[7, 3], p_copri_three_epoch_demography[7, 5], p_copri_three_epoch_demography[7, 7])
p_copri_three_epoch_Time_11 = c(-p_copri_three_epoch_demography[7, 2], -p_copri_three_epoch_demography[7, 4], -p_copri_three_epoch_demography[7, 6], p_copri_three_epoch_demography[7, 8])
p_copri_three_epoch_demography_11 = data.frame(p_copri_three_epoch_Time_11, p_copri_three_epoch_NEffective_11)
p_copri_three_epoch_NEffective_12 = c(p_copri_three_epoch_demography[8, 1], p_copri_three_epoch_demography[8, 3], p_copri_three_epoch_demography[8, 5], p_copri_three_epoch_demography[8, 7])
p_copri_three_epoch_Time_12 = c(-p_copri_three_epoch_demography[8, 2], -p_copri_three_epoch_demography[8, 4], -p_copri_three_epoch_demography[8, 6], p_copri_three_epoch_demography[8, 8])
p_copri_three_epoch_demography_12 = data.frame(p_copri_three_epoch_Time_12, p_copri_three_epoch_NEffective_12)
p_copri_three_epoch_NEffective_13 = c(p_copri_three_epoch_demography[9, 1], p_copri_three_epoch_demography[9, 3], p_copri_three_epoch_demography[9, 5], p_copri_three_epoch_demography[9, 7])
p_copri_three_epoch_Time_13 = c(-p_copri_three_epoch_demography[9, 2], -p_copri_three_epoch_demography[9, 4], -p_copri_three_epoch_demography[9, 6], p_copri_three_epoch_demography[9, 8])
p_copri_three_epoch_demography_13 = data.frame(p_copri_three_epoch_Time_13, p_copri_three_epoch_NEffective_13)
p_copri_three_epoch_NEffective_14 = c(p_copri_three_epoch_demography[10, 1], p_copri_three_epoch_demography[10, 3], p_copri_three_epoch_demography[10, 5], p_copri_three_epoch_demography[10, 7])
p_copri_three_epoch_Time_14 = c(-p_copri_three_epoch_demography[10, 2], -p_copri_three_epoch_demography[10, 4], -p_copri_three_epoch_demography[10, 6], p_copri_three_epoch_demography[10, 8])
p_copri_three_epoch_demography_14 = data.frame(p_copri_three_epoch_Time_14, p_copri_three_epoch_NEffective_14)

ggplot(p_copri_two_epoch_demography_5, aes(p_copri_two_epoch_Time_5, p_copri_two_epoch_NEffective_5, color='N=5')) + geom_step(linewidth=1, linetype='dashed') + 
  # xlim(-4000000, 0) +
  ylim(0, 1E9) +
  geom_step(data=p_copri_two_epoch_demography_6, aes(p_copri_two_epoch_Time_6, p_copri_two_epoch_NEffective_6, color='N=6'), linewidth=1, linetype='dashed') +
  geom_step(data=p_copri_two_epoch_demography_7, aes(p_copri_two_epoch_Time_7, p_copri_two_epoch_NEffective_7, color='N=7'), linewidth=1, linetype='dashed') +
  geom_step(data=p_copri_two_epoch_demography_8, aes(p_copri_two_epoch_Time_8, p_copri_two_epoch_NEffective_8, color='N=8'), linewidth=1, linetype='dashed') +
  geom_step(data=p_copri_two_epoch_demography_9, aes(p_copri_two_epoch_Time_9, p_copri_two_epoch_NEffective_9, color='N=9'), linewidth=1, linetype='dashed') +
  geom_step(data=p_copri_two_epoch_demography_10, aes(p_copri_two_epoch_Time_10, p_copri_two_epoch_NEffective_10, color='N=10'), linewidth=1, linetype='dashed') +
  geom_step(data=p_copri_two_epoch_demography_11, aes(p_copri_two_epoch_Time_11, p_copri_two_epoch_NEffective_11, color='N=11'), linewidth=1, linetype='dashed') +
  geom_step(data=p_copri_two_epoch_demography_12, aes(p_copri_two_epoch_Time_12, p_copri_two_epoch_NEffective_12, color='N=12'), linewidth=1, linetype='dashed') +
  # geom_step(data=p_copri_two_epoch_demography_13, aes(p_copri_two_epoch_Time_13, p_copri_two_epoch_NEffective_13, color='N=13'), linewidth=1, linetype='dashed') +
  # geom_step(data=p_copri_two_epoch_demography_14, aes(p_copri_two_epoch_Time_14, p_copri_two_epoch_NEffective_14, color='N=14'), linewidth=1, linetype='dashed') +
  # geom_step(data=p_copri_three_epoch_demography_5, aes(p_copri_three_epoch_Time_5, p_copri_three_epoch_NEffective_5, color='N=5'), linewidth=1, linetype='solid') +
  # geom_step(data=p_copri_three_epoch_demography_6, aes(p_copri_three_epoch_Time_6, p_copri_three_epoch_NEffective_6, color='N=6'), linewidth=1, linetype='solid') +
  # geom_step(data=p_copri_three_epoch_demography_7, aes(p_copri_three_epoch_Time_7, p_copri_three_epoch_NEffective_7, color='N=7'), linewidth=1, linetype='solid') +
  # geom_step(data=p_copri_three_epoch_demography_8, aes(p_copri_three_epoch_Time_8, p_copri_three_epoch_NEffective_8, color='N=8'), linewidth=1, linetype='solid') +
  # geom_step(data=p_copri_three_epoch_demography_9, aes(p_copri_three_epoch_Time_9, p_copri_three_epoch_NEffective_9, color='N=9'), linewidth=1, linetype='solid') +
  # geom_step(data=p_copri_three_epoch_demography_10, aes(p_copri_three_epoch_Time_10, p_copri_three_epoch_NEffective_10, color='N=10'), linewidth=1, linetype='solid') +
  # geom_step(data=p_copri_three_epoch_demography_11, aes(p_copri_three_epoch_Time_11, p_copri_three_epoch_NEffective_11, color='N=11'), linewidth=1, linetype='solid') +
  # geom_step(data=p_copri_three_epoch_demography_12, aes(p_copri_three_epoch_Time_12, p_copri_three_epoch_NEffective_12, color='N=12'), linewidth=1, linetype='solid') +
  geom_step(data=p_copri_three_epoch_demography_13, aes(p_copri_three_epoch_Time_13, p_copri_three_epoch_NEffective_13, color='N=13'), linewidth=1, linetype='solid') +
  geom_step(data=p_copri_three_epoch_demography_14, aes(p_copri_three_epoch_Time_14, p_copri_three_epoch_NEffective_14, color='N=14'), linewidth=1, linetype='solid') +
  scale_color_manual(name='Sample Size',
                     breaks=c('N=5', 'N=6', 'N=7', 'N=8', 'N=9', 'N=10', 'N=11', 'N=12', 'N=13', 'N=14'),
                     values=c('N=5'='#7f3b08',
                       'N=6'='#b35806',
                       'N=7'='#e08214',
                       'N=8'='#fdb863',
                       'N=9'='#fee0b6',
                       'N=10'='#d8daeb',
                       'N=11'='#b2abd2',
                       'N=12'='#8073ac',
                       'N=13'='#542788',
                       'N=14'='#2d004b'))+
  theme_bw() +
  ylab('Effective Population Size') +
  xlab('Time in Years') +
  ggtitle('P. copri Best-fitting Demography')

ggplot(p_copri_two_epoch_demography_5, aes(p_copri_two_epoch_Time_5, p_copri_two_epoch_NEffective_5)) + geom_step(color='#7f3b08', linewidth=1, linetype='dotted') + 
  xlim(-4000000, 0) +
  ylim(0, 1E9) +
  geom_step(data=p_copri_two_epoch_demography_6, aes(p_copri_two_epoch_Time_6, p_copri_two_epoch_NEffective_6), color='#b35806', linewidth=1, linetype='dotted') +
  geom_step(data=p_copri_two_epoch_demography_7, aes(p_copri_two_epoch_Time_7, p_copri_two_epoch_NEffective_7), color='#e08214', linewidth=1, linetype='dotted') +
  geom_step(data=p_copri_two_epoch_demography_8, aes(p_copri_two_epoch_Time_8, p_copri_two_epoch_NEffective_8), color='#fdb863', linewidth=1, linetype='dotted') +
  geom_step(data=p_copri_two_epoch_demography_9, aes(p_copri_two_epoch_Time_9, p_copri_two_epoch_NEffective_9), color='#fee0b6', linewidth=1, linetype='dotted') +
  geom_step(data=p_copri_two_epoch_demography_10, aes(p_copri_two_epoch_Time_10, p_copri_two_epoch_NEffective_10), color='#d8daeb', linewidth=1, linetype='dotted') +
  geom_step(data=p_copri_two_epoch_demography_11, aes(p_copri_two_epoch_Time_11, p_copri_two_epoch_NEffective_11), color='#b2abd2', linewidth=1, linetype='dotted') +
  geom_step(data=p_copri_two_epoch_demography_12, aes(p_copri_two_epoch_Time_12, p_copri_two_epoch_NEffective_12), color='#8073ac', linewidth=1, linetype='dotted') +
  geom_step(data=p_copri_two_epoch_demography_13, aes(p_copri_two_epoch_Time_13, p_copri_two_epoch_NEffective_13), color='#542788', linewidth=1, linetype='dotted') +
  geom_step(data=p_copri_two_epoch_demography_14, aes(p_copri_two_epoch_Time_14, p_copri_two_epoch_NEffective_14), color='#2d004b', linewidth=1, linetype='dotted') +
  theme_bw() +
  ylab('Effective Population Size') +
  xlab('Time in Years') +
  ggtitle('P. copri Two Epoch Demography') +
  scale_x_continuous(pseudolog10_trans)

ggplot(p_copri_three_epoch_demography_5, aes(p_copri_three_epoch_Time_5, p_copri_three_epoch_NEffective_5)) + geom_step(color='#7f3b08', linewidth=1, linetype='solid') + 
  xlim(-4000000, 0) +
  ylim(0, 1E9) +
  geom_step(data=p_copri_three_epoch_demography_6, aes(p_copri_three_epoch_Time_6, p_copri_three_epoch_NEffective_6), color='#b35806', linewidth=1, linetype='solid') +
  geom_step(data=p_copri_three_epoch_demography_7, aes(p_copri_three_epoch_Time_7, p_copri_three_epoch_NEffective_7), color='#e08214', linewidth=1, linetype='solid') +
  geom_step(data=p_copri_three_epoch_demography_8, aes(p_copri_three_epoch_Time_8, p_copri_three_epoch_NEffective_8), color='#fdb863', linewidth=1, linetype='solid') +
  geom_step(data=p_copri_three_epoch_demography_9, aes(p_copri_three_epoch_Time_9, p_copri_three_epoch_NEffective_9), color='#fee0b6', linewidth=1, linetype='solid') +
  geom_step(data=p_copri_three_epoch_demography_10, aes(p_copri_three_epoch_Time_10, p_copri_three_epoch_NEffective_10), color='#d8daeb', linewidth=1, linetype='solid') +
  geom_step(data=p_copri_three_epoch_demography_11, aes(p_copri_three_epoch_Time_11, p_copri_three_epoch_NEffective_11), color='#b2abd2', linewidth=1, linetype='solid') +
  geom_step(data=p_copri_three_epoch_demography_12, aes(p_copri_three_epoch_Time_12, p_copri_three_epoch_NEffective_12), color='#8073ac', linewidth=1, linetype='solid') +
  geom_step(data=p_copri_three_epoch_demography_13, aes(p_copri_three_epoch_Time_13, p_copri_three_epoch_NEffective_13), color='#542788', linewidth=1, linetype='solid') +
  geom_step(data=p_copri_three_epoch_demography_14, aes(p_copri_three_epoch_Time_14, p_copri_three_epoch_NEffective_14), color='#2d004b', linewidth=1, linetype='solid') +
  theme_bw() +
  ylab('Effective Population Size') +
  xlab('Time in Years') +
  ggtitle('P. copri Three Epoch Demography') +
  scale_x_continuous(pseudolog10_trans)


# 1KG_EUR 10-800:80
EUR_empirical_file_list = list()
EUR_one_epoch_file_list = list()
EUR_two_epoch_file_list = list()
EUR_three_epoch_file_list = list()
EUR_one_epoch_AIC = c()
EUR_one_epoch_LL = c()
EUR_one_epoch_theta = c()
EUR_one_epoch_allele_sum = 8058343
EUR_two_epoch_AIC = c()
EUR_two_epoch_LL = c()
EUR_two_epoch_theta = c()
EUR_two_epoch_nu = c()
EUR_two_epoch_tau = c()
EUR_two_epoch_allele_sum = 8058343
EUR_three_epoch_AIC = c()
EUR_three_epoch_LL = c()
EUR_three_epoch_theta = c()
EUR_three_epoch_nuB = c()
EUR_three_epoch_nuF = c()
EUR_three_epoch_tauB = c()
EUR_three_epoch_tauF = c()
EUR_three_epoch_allele_sum = 8058343

# Loop through subdirectories and get relevant files
for (i in seq(10, 800, by = 80)) {
  subdirectory <- paste0("../Analysis/1kg_EUR_", i)
  EUR_empirical_file_path <- file.path(subdirectory, "syn_downsampled_sfs.txt")
  EUR_one_epoch_file_path <- file.path(subdirectory, "one_epoch_demography.txt")
  EUR_two_epoch_file_path <- file.path(subdirectory, "two_epoch_demography.txt")
  EUR_three_epoch_file_path <- file.path(subdirectory, "three_epoch_demography.txt")
  
  # Check if the file exists before attempting to read and print its contents
  if (file.exists(EUR_empirical_file_path)) {
    this_empirical_sfs = read_input_sfs(EUR_empirical_file_path)
    EUR_empirical_file_list[[subdirectory]] = this_empirical_sfs
  }
  if (file.exists(EUR_one_epoch_file_path)) {
    this_one_epoch_sfs = sfs_from_demography(EUR_one_epoch_file_path)
    EUR_one_epoch_file_list[[subdirectory]] = this_one_epoch_sfs
    EUR_one_epoch_AIC = c(EUR_one_epoch_AIC, AIC_from_demography(EUR_one_epoch_file_path))
    EUR_one_epoch_LL = c(EUR_one_epoch_LL, LL_from_demography(EUR_one_epoch_file_path))
    EUR_one_epoch_theta = c(EUR_one_epoch_theta, theta_from_demography(EUR_one_epoch_file_path))
    # EUR_one_epoch_allele_sum = c(EUR_one_epoch_allele_sum, sum(this_one_epoch_sfs))
  }
  if (file.exists(EUR_two_epoch_file_path)) {
    this_two_epoch_sfs = sfs_from_demography(EUR_two_epoch_file_path)
    EUR_two_epoch_file_list[[subdirectory]] = this_two_epoch_sfs
    EUR_two_epoch_AIC = c(EUR_two_epoch_AIC, AIC_from_demography(EUR_two_epoch_file_path))
    EUR_two_epoch_LL = c(EUR_two_epoch_LL, LL_from_demography(EUR_two_epoch_file_path))
    EUR_two_epoch_theta = c(EUR_two_epoch_theta, theta_from_demography(EUR_two_epoch_file_path))
    EUR_two_epoch_nu = c(EUR_two_epoch_nu, nu_from_demography(EUR_two_epoch_file_path))
    EUR_two_epoch_tau = c(EUR_two_epoch_tau, tau_from_demography(EUR_two_epoch_file_path))
    # EUR_two_epoch_allele_sum = c(EUR_two_epoch_allele_sum, sum(this_two_epoch_sfs))
  }
  if (file.exists(EUR_three_epoch_file_path)) {
    this_three_epoch_sfs = sfs_from_demography(EUR_three_epoch_file_path)
    EUR_three_epoch_file_list[[subdirectory]] = this_three_epoch_sfs
    EUR_three_epoch_AIC = c(EUR_three_epoch_AIC, AIC_from_demography(EUR_three_epoch_file_path))
    EUR_three_epoch_LL = c(EUR_three_epoch_LL, LL_from_demography(EUR_three_epoch_file_path))
    EUR_three_epoch_theta = c(EUR_three_epoch_theta, theta_from_demography(EUR_three_epoch_file_path))
    EUR_three_epoch_nuB = c(EUR_three_epoch_nuB, nuB_from_demography(EUR_three_epoch_file_path))
    EUR_three_epoch_nuF = c(EUR_three_epoch_nuF, nuF_from_demography(EUR_three_epoch_file_path))
    EUR_three_epoch_tauB = c(EUR_three_epoch_tauB, tauB_from_demography(EUR_three_epoch_file_path))
    EUR_three_epoch_tauF = c(EUR_three_epoch_tauF, tauF_from_demography(EUR_three_epoch_file_path))
    # EUR_three_epoch_allele_sum = c(EUR_three_epoch_allele_sum, sum(this_three_epoch_sfs))
  }  
}

EUR_AIC_df = data.frame(EUR_one_epoch_AIC, EUR_two_epoch_AIC, EUR_three_epoch_AIC)
# Reshape the data from wide to long format
EUR_df_long <- tidyr::gather(EUR_AIC_df, key = "Epoch", value = "AIC", EUR_one_epoch_AIC:EUR_three_epoch_AIC)

# Increase the x-axis index by 4
EUR_df_long$Index <- rep(seq(10, 800, by = 80), times = 3)

# Create the line plot with ggplot2
ggplot(EUR_df_long, aes(x = Index, y = AIC, color = Epoch)) +
  geom_line() +
  geom_point() +
  labs(title = "1KG EUR AIC values by sample size",
       x = "Sample Size",
       y = "AIC") +
  scale_y_log10() +
  scale_x_continuous(breaks=EUR_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('One-epoch', 'Three-epoch', 'Two-epoch')) +
  theme_bw()

EUR_lambda_two_one = 2 * (EUR_two_epoch_LL - EUR_one_epoch_LL)
EUR_lambda_three_one = 2 * (EUR_three_epoch_LL - EUR_one_epoch_LL)
EUR_lambda_three_two = 2 * (EUR_three_epoch_LL - EUR_two_epoch_LL)

EUR_lambda_df = data.frame(EUR_lambda_two_one, EUR_lambda_three_one, EUR_lambda_three_two)
# Reshape the data from wide to long format
EUR_df_long_lambda <- tidyr::gather(EUR_lambda_df, key = "Full_vs_Null", value = "Lambda", EUR_lambda_two_one:EUR_lambda_three_two)
# Increase the x-axis index by 4
EUR_df_long_lambda$Index <- rep(seq(10, 800, by = 80), times = 3)

# Create the line plot with ggplot2
ggplot(EUR_df_long_lambda, aes(x = Index, y = Lambda, color = Full_vs_Null)) +
  geom_line() +
  geom_point() +
  labs(title = "1KG EUR Lambda values by sample size (N=10-730:80)",
       x = "Sample Size",
       y = "2 * Lambda") +
  # scale_y_log10() +
  scale_x_continuous(breaks=EUR_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('Three vs. One', 'Three vs. Two', 'Two vs. One')) +
  theme_bw()

EUR_one_epoch_residual = c()
EUR_two_epoch_residual = c()
EUR_three_epoch_residual = c()

for (i in 1:10) {
  EUR_one_epoch_residual = c(EUR_one_epoch_residual, compute_residual(unlist(EUR_empirical_file_list[i]), unlist(EUR_one_epoch_file_list[i])))
  EUR_two_epoch_residual = c(EUR_two_epoch_residual, compute_residual(unlist(EUR_empirical_file_list[i]), unlist(EUR_two_epoch_file_list[i])))
  EUR_three_epoch_residual = c(EUR_three_epoch_residual, compute_residual(unlist(EUR_empirical_file_list[i]), unlist(EUR_three_epoch_file_list[i])))
}

EUR_residual_df = data.frame(EUR_one_epoch_residual, EUR_two_epoch_residual, EUR_three_epoch_residual)
# Reshape the data from wide to long format
EUR_df_long_residual <- tidyr::gather(EUR_residual_df, key = "Epoch", value = "residual", EUR_one_epoch_residual:EUR_three_epoch_residual)

# Increase the x-axis index by 4
EUR_df_long_residual$Index <- rep(seq(10, 800, by = 80), times = 3)

# Create the line plot with ggplot2
ggplot(EUR_df_long_residual, aes(x = Index, y = residual, color = Epoch)) +
  geom_line() +
  geom_point() +
  labs(title = "EUR residual values by sample size",
       x = "Sample Size",
       y = "Residual") +
  scale_y_log10() +
  scale_x_continuous(breaks=EUR_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('One-epoch', 'Three-epoch', 'Two-epoch')) +
  theme_bw()

ggplot(EUR_df_long, aes(x = Index, y = AIC, color = Epoch)) +
  geom_line(linetype=3) +
  geom_point() +
  labs(title = "1KG EUR AIC and residual by sample size (N=10-730:80)",
       x = "Sample Size",
       y = "AIC") +
  scale_y_log10(sec.axis = sec_axis(~.*1, name="Residual")) +
  scale_x_continuous(breaks=EUR_df_long$Index) +
  geom_line(data=EUR_df_long_residual, aes(x = Index, y = residual*1, color = Epoch)) +
  scale_color_manual(values = c("blue", "orange", "green", "violet", "red", "seagreen"),
    label=c('One-epoch AIC', 'One-epoch residual',
      'Three-epoch AIC', 'Three-epoch residual',
      'Two-epoch AIC', 'Two-epoch residual')) +
  theme_bw()

# 1KG_EUR population genetic constants

EUR_mu = 1.5E-8
EUR_allele_sum = 8058343

# NAnc = theta / (4 * allele_sum * mu)
# generations = 2 * tau * theta / (4 * mu * allele_sum)
# years = generations / 365
# NCurr = nu * NAnc
# generations_b = 2 * tauB * theta / (4 * mu * allele_sum)
# generations_f = 2 * tauF * theta / (4 * mu * allele_sum)
# NBottle = nuB * NAnc
# NSince = nuF * NAnc


EUR_one_epoch_NAnc = EUR_one_epoch_theta / (4 * EUR_one_epoch_allele_sum * EUR_mu)
EUR_two_epoch_NAnc = EUR_two_epoch_theta / (4 * EUR_two_epoch_allele_sum * EUR_mu)
EUR_two_epoch_NCurr = EUR_two_epoch_nu * EUR_two_epoch_NAnc
EUR_two_epoch_Time = 2 * 25 * EUR_two_epoch_tau * EUR_two_epoch_theta / (4 * EUR_mu * EUR_two_epoch_allele_sum)
EUR_three_epoch_NAnc = EUR_three_epoch_theta / (4 * EUR_three_epoch_allele_sum * EUR_mu)
EUR_three_epoch_NBottle = EUR_three_epoch_nuB * EUR_three_epoch_NAnc
EUR_three_epoch_NCurr = EUR_three_epoch_nuF * EUR_three_epoch_NAnc
EUR_three_epoch_TimeBottleEnd = 2 * 25 * EUR_three_epoch_tauF * EUR_three_epoch_theta / (4 * EUR_mu * EUR_three_epoch_allele_sum)
EUR_three_epoch_TimeBottleStart = 2 * 25 * EUR_three_epoch_tauB * EUR_three_epoch_theta / (4 * EUR_mu * EUR_three_epoch_allele_sum) + EUR_three_epoch_TimeBottleEnd
EUR_three_epoch_TimeTotal = EUR_three_epoch_TimeBottleStart + EUR_three_epoch_TimeBottleEnd

EUR_two_epoch_max_time = rep(1.25E6, 10)
# EUR_two_epoch_max_time = rep(2E4, 10)
EUR_two_epoch_current_time = rep(0, 10)
EUR_two_epoch_demography = data.frame(EUR_two_epoch_NAnc, EUR_two_epoch_max_time, 
  EUR_two_epoch_NCurr, EUR_two_epoch_Time, 
  EUR_two_epoch_NCurr, EUR_two_epoch_current_time)

# EUR_three_epoch_max_time = rep(100000000, 10)
# EUR_three_epoch_max_time = rep(1.25E6, 10)
EUR_three_epoch_max_time = rep(1.25E6, 10)
EUR_three_epoch_current_time = rep(0, 10)
EUR_three_epoch_demography = data.frame(EUR_three_epoch_NAnc, EUR_three_epoch_max_time,
  EUR_three_epoch_NBottle, EUR_three_epoch_TimeBottleStart,
  EUR_three_epoch_NCurr, EUR_three_epoch_TimeBottleEnd,
  EUR_three_epoch_NCurr, EUR_three_epoch_current_time)

EUR_two_epoch_NEffective_10 = c(EUR_two_epoch_demography[1, 1], EUR_two_epoch_demography[1, 3], EUR_two_epoch_demography[1, 5])
EUR_two_epoch_Time_10 = c(-EUR_two_epoch_demography[1, 2], -EUR_two_epoch_demography[1, 4], EUR_two_epoch_demography[1, 6])
EUR_two_epoch_demography_10 = data.frame(EUR_two_epoch_Time_10, EUR_two_epoch_NEffective_10)
EUR_two_epoch_NEffective_90 = c(EUR_two_epoch_demography[2, 1], EUR_two_epoch_demography[2, 3], EUR_two_epoch_demography[2, 5])
EUR_two_epoch_Time_90 = c(-EUR_two_epoch_demography[2, 2], -EUR_two_epoch_demography[2, 4], EUR_two_epoch_demography[2, 6])
EUR_two_epoch_demography_90 = data.frame(EUR_two_epoch_Time_90, EUR_two_epoch_NEffective_90)
EUR_two_epoch_NEffective_170 = c(EUR_two_epoch_demography[3, 1], EUR_two_epoch_demography[3, 3], EUR_two_epoch_demography[3, 5])
EUR_two_epoch_Time_170 = c(-EUR_two_epoch_demography[3, 2], -EUR_two_epoch_demography[3, 4], EUR_two_epoch_demography[3, 6])
EUR_two_epoch_demography_170 = data.frame(EUR_two_epoch_Time_170, EUR_two_epoch_NEffective_170)
EUR_two_epoch_NEffective_250 = c(EUR_two_epoch_demography[4, 1], EUR_two_epoch_demography[4, 3], EUR_two_epoch_demography[4, 5])
EUR_two_epoch_Time_250 = c(-EUR_two_epoch_demography[4, 2], -EUR_two_epoch_demography[4, 4], EUR_two_epoch_demography[4, 6])
EUR_two_epoch_demography_250 = data.frame(EUR_two_epoch_Time_250, EUR_two_epoch_NEffective_250)
EUR_two_epoch_NEffective_330 = c(EUR_two_epoch_demography[5, 1], EUR_two_epoch_demography[5, 3], EUR_two_epoch_demography[5, 5])
EUR_two_epoch_Time_330 = c(-EUR_two_epoch_demography[5, 2], -EUR_two_epoch_demography[5, 4], EUR_two_epoch_demography[5, 6])
EUR_two_epoch_demography_330 = data.frame(EUR_two_epoch_Time_330, EUR_two_epoch_NEffective_330)
EUR_two_epoch_NEffective_410 = c(EUR_two_epoch_demography[6, 1], EUR_two_epoch_demography[6, 3], EUR_two_epoch_demography[6, 5])
EUR_two_epoch_Time_410 = c(-EUR_two_epoch_demography[6, 2], -EUR_two_epoch_demography[6, 4], EUR_two_epoch_demography[6, 6])
EUR_two_epoch_demography_410 = data.frame(EUR_two_epoch_Time_410, EUR_two_epoch_NEffective_410)
EUR_two_epoch_NEffective_490 = c(EUR_two_epoch_demography[7, 1], EUR_two_epoch_demography[7, 3], EUR_two_epoch_demography[7, 5])
EUR_two_epoch_Time_490 = c(-EUR_two_epoch_demography[7, 2], -EUR_two_epoch_demography[7, 4], EUR_two_epoch_demography[7, 6])
EUR_two_epoch_demography_490 = data.frame(EUR_two_epoch_Time_490, EUR_two_epoch_NEffective_490)
EUR_two_epoch_NEffective_570 = c(EUR_two_epoch_demography[8, 1], EUR_two_epoch_demography[8, 3], EUR_two_epoch_demography[8, 5])
EUR_two_epoch_Time_570 = c(-EUR_two_epoch_demography[8, 2], -EUR_two_epoch_demography[8, 4], EUR_two_epoch_demography[8, 6])
EUR_two_epoch_demography_570 = data.frame(EUR_two_epoch_Time_570, EUR_two_epoch_NEffective_570)
EUR_two_epoch_NEffective_650 = c(EUR_two_epoch_demography[9, 1], EUR_two_epoch_demography[9, 3], EUR_two_epoch_demography[9, 5])
EUR_two_epoch_Time_650 = c(-EUR_two_epoch_demography[9, 2], -EUR_two_epoch_demography[9, 4], EUR_two_epoch_demography[9, 6])
EUR_two_epoch_demography_650 = data.frame(EUR_two_epoch_Time_650, EUR_two_epoch_NEffective_650)
EUR_two_epoch_NEffective_730 = c(EUR_two_epoch_demography[10, 1], EUR_two_epoch_demography[10, 3], EUR_two_epoch_demography[10, 5])
EUR_two_epoch_Time_730 = c(-EUR_two_epoch_demography[10, 2], -EUR_two_epoch_demography[10, 4], EUR_two_epoch_demography[10, 6])
EUR_two_epoch_demography_730 = data.frame(EUR_two_epoch_Time_730, EUR_two_epoch_NEffective_730)

EUR_three_epoch_NEffective_10 = c(EUR_three_epoch_demography[1, 1], EUR_three_epoch_demography[1, 3], EUR_three_epoch_demography[1, 5], EUR_three_epoch_demography[1, 7])
EUR_three_epoch_Time_10 = c(-EUR_three_epoch_demography[1, 2], -EUR_three_epoch_demography[1, 4], -EUR_three_epoch_demography[1, 6], EUR_three_epoch_demography[1, 8])
EUR_three_epoch_demography_10 = data.frame(EUR_three_epoch_Time_10, EUR_three_epoch_NEffective_10)
EUR_three_epoch_NEffective_90 = c(EUR_three_epoch_demography[2, 1], EUR_three_epoch_demography[2, 3], EUR_three_epoch_demography[2, 5], EUR_three_epoch_demography[2, 7])
EUR_three_epoch_Time_90 = c(-EUR_three_epoch_demography[2, 2], -EUR_three_epoch_demography[2, 4], -EUR_three_epoch_demography[2, 6], EUR_three_epoch_demography[2, 8])
EUR_three_epoch_demography_90 = data.frame(EUR_three_epoch_Time_90, EUR_three_epoch_NEffective_90)
EUR_three_epoch_NEffective_170 = c(EUR_three_epoch_demography[3, 1], EUR_three_epoch_demography[3, 3], EUR_three_epoch_demography[3, 5], EUR_three_epoch_demography[3, 7])
EUR_three_epoch_Time_170 = c(-EUR_three_epoch_demography[3, 2], -EUR_three_epoch_demography[3, 4], -EUR_three_epoch_demography[3, 6], EUR_three_epoch_demography[3, 8])
EUR_three_epoch_demography_170 = data.frame(EUR_three_epoch_Time_170, EUR_three_epoch_NEffective_170)
EUR_three_epoch_NEffective_250 = c(EUR_three_epoch_demography[4, 1], EUR_three_epoch_demography[4, 3], EUR_three_epoch_demography[4, 5], EUR_three_epoch_demography[4, 7])
EUR_three_epoch_Time_250 = c(-EUR_three_epoch_demography[4, 2], -EUR_three_epoch_demography[4, 4], -EUR_three_epoch_demography[4, 6], EUR_three_epoch_demography[4, 8])
EUR_three_epoch_demography_250 = data.frame(EUR_three_epoch_Time_250, EUR_three_epoch_NEffective_250)
EUR_three_epoch_NEffective_330 = c(EUR_three_epoch_demography[5, 1], EUR_three_epoch_demography[5, 3], EUR_three_epoch_demography[5, 5], EUR_three_epoch_demography[5, 7])
EUR_three_epoch_Time_330 = c(-EUR_three_epoch_demography[5, 2], -EUR_three_epoch_demography[5, 4], -EUR_three_epoch_demography[5, 6], EUR_three_epoch_demography[5, 8])
EUR_three_epoch_demography_330 = data.frame(EUR_three_epoch_Time_330, EUR_three_epoch_NEffective_330)
EUR_three_epoch_NEffective_410 = c(EUR_three_epoch_demography[6, 1], EUR_three_epoch_demography[6, 3], EUR_three_epoch_demography[6, 5], EUR_three_epoch_demography[6, 7])
EUR_three_epoch_Time_410 = c(-EUR_three_epoch_demography[6, 2], -EUR_three_epoch_demography[6, 4], -EUR_three_epoch_demography[6, 6], EUR_three_epoch_demography[6, 8])
EUR_three_epoch_demography_410 = data.frame(EUR_three_epoch_Time_410, EUR_three_epoch_NEffective_410)
EUR_three_epoch_NEffective_490 = c(EUR_three_epoch_demography[7, 1], EUR_three_epoch_demography[7, 3], EUR_three_epoch_demography[7, 5], EUR_three_epoch_demography[7, 7])
EUR_three_epoch_Time_490 = c(-EUR_three_epoch_demography[7, 2], -EUR_three_epoch_demography[7, 4], -EUR_three_epoch_demography[7, 6], EUR_three_epoch_demography[7, 8])
EUR_three_epoch_demography_490 = data.frame(EUR_three_epoch_Time_490, EUR_three_epoch_NEffective_490)
EUR_three_epoch_NEffective_570 = c(EUR_three_epoch_demography[8, 1], EUR_three_epoch_demography[8, 3], EUR_three_epoch_demography[8, 5], EUR_three_epoch_demography[8, 7])
EUR_three_epoch_Time_570 = c(-EUR_three_epoch_demography[8, 2], -EUR_three_epoch_demography[8, 4], -EUR_three_epoch_demography[8, 6], EUR_three_epoch_demography[8, 8])
EUR_three_epoch_demography_570 = data.frame(EUR_three_epoch_Time_570, EUR_three_epoch_NEffective_570)
EUR_three_epoch_NEffective_650 = c(EUR_three_epoch_demography[9, 1], EUR_three_epoch_demography[9, 3], EUR_three_epoch_demography[9, 5], EUR_three_epoch_demography[9, 7])
EUR_three_epoch_Time_650 = c(-EUR_three_epoch_demography[9, 2], -EUR_three_epoch_demography[9, 4], -EUR_three_epoch_demography[9, 6], EUR_three_epoch_demography[9, 8])
EUR_three_epoch_demography_650 = data.frame(EUR_three_epoch_Time_650, EUR_three_epoch_NEffective_650)
EUR_three_epoch_NEffective_730 = c(EUR_three_epoch_demography[10, 1], EUR_three_epoch_demography[10, 3], EUR_three_epoch_demography[10, 5], EUR_three_epoch_demography[10, 7])
EUR_three_epoch_Time_730 = c(-EUR_three_epoch_demography[10, 2], -EUR_three_epoch_demography[10, 4], -EUR_three_epoch_demography[10, 6], EUR_three_epoch_demography[10, 8])
EUR_three_epoch_demography_730 = data.frame(EUR_three_epoch_Time_730, EUR_three_epoch_NEffective_730)

ggplot(EUR_two_epoch_demography_10, aes(EUR_two_epoch_Time_10, EUR_two_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='dotted') + 
  geom_step(data=EUR_two_epoch_demography_90, aes(EUR_two_epoch_Time_90, EUR_two_epoch_NEffective_90, color='N=90'), linewidth=1, linetype='dotted') +
  geom_step(data=EUR_two_epoch_demography_170, aes(EUR_two_epoch_Time_170, EUR_two_epoch_NEffective_170, color='N=170'), linewidth=1, linetype='dotted') +
  geom_step(data=EUR_two_epoch_demography_250, aes(EUR_two_epoch_Time_250, EUR_two_epoch_NEffective_250, color='N=250'), linewidth=1, linetype='dotted') +
  geom_step(data=EUR_two_epoch_demography_330, aes(EUR_two_epoch_Time_330, EUR_two_epoch_NEffective_330, color='N=330'), linewidth=1, linetype='dotted') +
  geom_step(data=EUR_two_epoch_demography_410, aes(EUR_two_epoch_Time_410, EUR_two_epoch_NEffective_410, color='N=410'), linewidth=1, linetype='dotted') +
  geom_step(data=EUR_two_epoch_demography_490, aes(EUR_two_epoch_Time_490, EUR_two_epoch_NEffective_490, color='N=490'), linewidth=1, linetype='dotted') +
  geom_step(data=EUR_two_epoch_demography_570, aes(EUR_two_epoch_Time_570, EUR_two_epoch_NEffective_570, color='N=570'), linewidth=1, linetype='dotted') +
  geom_step(data=EUR_two_epoch_demography_650, aes(EUR_two_epoch_Time_650, EUR_two_epoch_NEffective_650, color='N=650'), linewidth=1, linetype='dotted') +
  geom_step(data=EUR_two_epoch_demography_730, aes(EUR_two_epoch_Time_730, EUR_two_epoch_NEffective_730, color='N=730'), linewidth=1, linetype='dotted') +
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
  ggtitle('1KG EUR two Epoch Demography (N=10-730:80)')

# ggplot(EUR_two_epoch_demography_330, aes(EUR_two_epoch_Time_330, EUR_two_epoch_NEffective_330)) + geom_step(color='#d8daeb', linewidth=1, linetype='dotted') + 
#   # geom_step(data=EUR_two_epoch_demography_90, aes(EUR_two_epoch_Time_90, EUR_two_epoch_NEffective_90), color='#b35806', linewidth=1, linetype='dotted') +
#   # geom_step(data=EUR_two_epoch_demography_170, aes(EUR_two_epoch_Time_170, EUR_two_epoch_NEffective_170), color='#e08214', linewidth=1, linetype='dotted') +
#   # geom_step(data=EUR_two_epoch_demography_250, aes(EUR_two_epoch_Time_250, EUR_two_epoch_NEffective_250), color='#fdb863', linewidth=1, linetype='dotted') +
#   # geom_step(data=EUR_two_epoch_demography_330, aes(EUR_two_epoch_Time_330, EUR_two_epoch_NEffective_330), color='#fee0b6', linewidth=1, linetype='dotted') +
#   geom_step(data=EUR_two_epoch_demography_410, aes(EUR_two_epoch_Time_410, EUR_two_epoch_NEffective_410), color='#d8daeb', linewidth=1, linetype='dotted') +
#   geom_step(data=EUR_two_epoch_demography_490, aes(EUR_two_epoch_Time_490, EUR_two_epoch_NEffective_490), color='#b2abd2', linewidth=1, linetype='dotted') +
#   geom_step(data=EUR_two_epoch_demography_570, aes(EUR_two_epoch_Time_570, EUR_two_epoch_NEffective_570), color='#8073ac', linewidth=1, linetype='dotted') +
#   geom_step(data=EUR_two_epoch_demography_650, aes(EUR_two_epoch_Time_650, EUR_two_epoch_NEffective_650), color='#542788', linewidth=1, linetype='dotted') +
#   geom_step(data=EUR_two_epoch_demography_730, aes(EUR_two_epoch_Time_730, EUR_two_epoch_NEffective_730), color='#2d004b', linewidth=1, linetype='dotted') +
#   theme_bw() +
#   ylab('Effective Population Size') +
#   xlab('Time in Years') +
#   ggtitle('1KG EUR two Epoch Demography, 330-730:80')

ggplot(EUR_two_epoch_demography_10, aes(EUR_two_epoch_Time_10, EUR_two_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='dashed') + 
  # geom_step(data=EUR_two_epoch_demography_90, aes(EUR_two_epoch_Time_90, EUR_two_epoch_NEffective_90, color='N=90'), linewidth=1, linetype='dashed') +
  # geom_step(data=EUR_two_epoch_demography_170, aes(EUR_two_epoch_Time_170, EUR_two_epoch_NEffective_170, color='N=170'), linewidth=1, linetype='dashed') +
  # geom_step(data=EUR_two_epoch_demography_250, aes(EUR_two_epoch_Time_250, EUR_two_epoch_NEffective_250, color='N=250'), linewidth=1, linetype='dashed') +
  # geom_step(data=EUR_two_epoch_demography_330, aes(EUR_two_epoch_Time_330, EUR_two_epoch_NEffective_330, color='N=330'), linewidth=1, linetype='dashed') +
  # geom_step(data=EUR_two_epoch_demography_410, aes(EUR_two_epoch_Time_410, EUR_two_epoch_NEffective_410, color='N=410'), linewidth=1, linetype='dashed') +
  # geom_step(data=EUR_two_epoch_demography_490, aes(EUR_two_epoch_Time_490, EUR_two_epoch_NEffective_490, color='N=490'), linewidth=1, linetype='dashed') +
  # geom_step(data=EUR_two_epoch_demography_570, aes(EUR_two_epoch_Time_570, EUR_two_epoch_NEffective_570, color='N=570'), linewidth=1, linetype='dashed') +
  # geom_step(data=EUR_two_epoch_demography_650, aes(EUR_two_epoch_Time_650, EUR_two_epoch_NEffective_650, color='N=650'), linewidth=1, linetype='dashed') +
  # geom_step(data=EUR_two_epoch_demography_730, aes(EUR_two_epoch_Time_730, EUR_two_epoch_NEffective_730, color='N=730'), linewidth=1, linetype='dashed') +
  # geom_step(data=EUR_three_epoch_demography_10, aes(EUR_three_epoch_Time_10, EUR_three_epoch_NEffective_10, color='N=10'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_90, aes(EUR_three_epoch_Time_90, EUR_three_epoch_NEffective_90, color='N=90'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_170, aes(EUR_three_epoch_Time_170, EUR_three_epoch_NEffective_170, color='N=170'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_250, aes(EUR_three_epoch_Time_250, EUR_three_epoch_NEffective_250, color='N=250'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_330, aes(EUR_three_epoch_Time_330, EUR_three_epoch_NEffective_330, color='N=330'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_410, aes(EUR_three_epoch_Time_410, EUR_three_epoch_NEffective_410, color='N=410'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_490, aes(EUR_three_epoch_Time_490, EUR_three_epoch_NEffective_490, color='N=490'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_570, aes(EUR_three_epoch_Time_570, EUR_three_epoch_NEffective_570, color='N=570'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_650, aes(EUR_three_epoch_Time_650, EUR_three_epoch_NEffective_650, color='N=650'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_730, aes(EUR_three_epoch_Time_730, EUR_three_epoch_NEffective_730, color='N=730'), linewidth=1, linetype='solid') +
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
  ggtitle('1KG EUR Best-fitting Demography (N=10-730:80)')

ggplot(EUR_three_epoch_demography_10, aes(EUR_three_epoch_Time_10, EUR_three_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='solid') + 
  geom_step(data=EUR_three_epoch_demography_90, aes(EUR_three_epoch_Time_90, EUR_three_epoch_NEffective_90, color='N=90'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_170, aes(EUR_three_epoch_Time_170, EUR_three_epoch_NEffective_170, color='N=170'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_250, aes(EUR_three_epoch_Time_250, EUR_three_epoch_NEffective_250, color='N=250'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_330, aes(EUR_three_epoch_Time_330, EUR_three_epoch_NEffective_330, color='N=330'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_410, aes(EUR_three_epoch_Time_410, EUR_three_epoch_NEffective_410, color='N=410'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_490, aes(EUR_three_epoch_Time_490, EUR_three_epoch_NEffective_490, color='N=490'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_570, aes(EUR_three_epoch_Time_570, EUR_three_epoch_NEffective_570, color='N=570'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_650, aes(EUR_three_epoch_Time_650, EUR_three_epoch_NEffective_650, color='N=650'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_730, aes(EUR_three_epoch_Time_730, EUR_three_epoch_NEffective_730, color='N=730'), linewidth=1, linetype='solid') +
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
  ggtitle('1KG EUR Three Epoch Demography (N=10-730:80)')

# ggplot(EUR_three_epoch_demography_90, aes(EUR_three_epoch_Time_90, EUR_three_epoch_NEffective_90)) + geom_step(color='#b35806', linewidth=1, linetype='solid') + 
#   # geom_step(data=EUR_three_epoch_demography_90, aes(EUR_three_epoch_Time_90, EUR_three_epoch_NEffective_90), color='#b35806', linewidth=1, linetype='solid') +
#   geom_step(data=EUR_three_epoch_demography_170, aes(EUR_three_epoch_Time_170, EUR_three_epoch_NEffective_170), color='#e08214', linewidth=1, linetype='solid') +
#   geom_step(data=EUR_three_epoch_demography_250, aes(EUR_three_epoch_Time_250, EUR_three_epoch_NEffective_250), color='#fdb863', linewidth=1, linetype='solid') +
#   geom_step(data=EUR_three_epoch_demography_330, aes(EUR_three_epoch_Time_330, EUR_three_epoch_NEffective_330), color='#fee0b6', linewidth=1, linetype='solid') +
#   geom_step(data=EUR_three_epoch_demography_410, aes(EUR_three_epoch_Time_410, EUR_three_epoch_NEffective_410), color='#d8daeb', linewidth=1, linetype='solid') +
#   geom_step(data=EUR_three_epoch_demography_490, aes(EUR_three_epoch_Time_490, EUR_three_epoch_NEffective_490), color='#b2abd2', linewidth=1, linetype='solid') +
#   geom_step(data=EUR_three_epoch_demography_570, aes(EUR_three_epoch_Time_570, EUR_three_epoch_NEffective_570), color='#8073ac', linewidth=1, linetype='solid') +
#   geom_step(data=EUR_three_epoch_demography_650, aes(EUR_three_epoch_Time_650, EUR_three_epoch_NEffective_650), color='#542788', linewidth=1, linetype='solid') +
#   geom_step(data=EUR_three_epoch_demography_730, aes(EUR_three_epoch_Time_730, EUR_three_epoch_NEffective_730), color='#2d004b', linewidth=1, linetype='solid') +
#   theme_bw() +
#   ylab('Effective Population Size') +
#   xlab('Time in Years') +
#   ggtitle('1KG EUR Three Epoch Demography, 90-730:80')

# NAnc Estimate by Sample Size
sample_size = c(10, 90, 170, 250, 330, 410, 490, 570, 650, 730)

NAnc_df = data.frame(sample_size, EUR_one_epoch_NAnc, EUR_two_epoch_NAnc, EUR_three_epoch_NAnc)
NAnc_df = melt(NAnc_df, id='sample_size')

ggplot(data=NAnc_df, aes(x=sample_size, y=value, color=variable)) + geom_line() +
  xlab('Sample size') +
  ylab('Estimated ancestral effective population size') +
  ggtitle('1KG EUR NAnc by sample size (N=10-730:80)') +
  theme_bw() +
  guides(color=guide_legend(title="Epoch")) +
  scale_color_manual(
    labels=c('One-epoch', 'Two-epoch', 'Three-epoch'),
    values=c('red', 'blue', 'green')) +
  geom_hline(yintercept=12378, color='black', linetype='dashed') +
  scale_x_continuous(breaks=sample_size)

# # 1KG_EUR 10-100:10
EUR_empirical_file_list = list()
EUR_one_epoch_file_list = list()
EUR_two_epoch_file_list = list()
EUR_three_epoch_file_list = list()
EUR_one_epoch_AIC = c()
EUR_one_epoch_LL = c()
EUR_one_epoch_theta = c()
EUR_one_epoch_allele_sum = 8058343
EUR_two_epoch_AIC = c()
EUR_two_epoch_LL = c()
EUR_two_epoch_theta = c()
EUR_two_epoch_nu = c()
EUR_two_epoch_tau = c()
EUR_two_epoch_allele_sum = 8058343
EUR_three_epoch_AIC = c()
EUR_three_epoch_LL = c()
EUR_three_epoch_theta = c()
EUR_three_epoch_nuB = c()
EUR_three_epoch_nuF = c()
EUR_three_epoch_tauB = c()
EUR_three_epoch_tauF = c()
EUR_three_epoch_allele_sum = 8058343

# Loop through subdirectories and get relevant files
for (i in seq(10, 100, by = 10)) {
  subdirectory <- paste0("../Analysis/1kg_EUR_", i)
  EUR_empirical_file_path <- file.path(subdirectory, "syn_downsampled_sfs.txt")
  EUR_one_epoch_file_path <- file.path(subdirectory, "one_epoch_demography.txt")
  EUR_two_epoch_file_path <- file.path(subdirectory, "two_epoch_demography.txt")
  EUR_three_epoch_file_path <- file.path(subdirectory, "three_epoch_demography.txt")
  
  # Check if the file exists before attempting to read and print its contents
  if (file.exists(EUR_empirical_file_path)) {
    this_empirical_sfs = read_input_sfs(EUR_empirical_file_path)
    EUR_empirical_file_list[[subdirectory]] = this_empirical_sfs
  }
  if (file.exists(EUR_one_epoch_file_path)) {
    this_one_epoch_sfs = sfs_from_demography(EUR_one_epoch_file_path)
    EUR_one_epoch_file_list[[subdirectory]] = this_one_epoch_sfs
    EUR_one_epoch_AIC = c(EUR_one_epoch_AIC, AIC_from_demography(EUR_one_epoch_file_path))
    EUR_one_epoch_LL = c(EUR_one_epoch_LL, LL_from_demography(EUR_one_epoch_file_path))
    EUR_one_epoch_theta = c(EUR_one_epoch_theta, theta_from_demography(EUR_one_epoch_file_path))
    # EUR_one_epoch_allele_sum = c(EUR_one_epoch_allele_sum, sum(this_one_epoch_sfs))
  }
  if (file.exists(EUR_two_epoch_file_path)) {
    this_two_epoch_sfs = sfs_from_demography(EUR_two_epoch_file_path)
    EUR_two_epoch_file_list[[subdirectory]] = this_two_epoch_sfs
    EUR_two_epoch_AIC = c(EUR_two_epoch_AIC, AIC_from_demography(EUR_two_epoch_file_path))
    EUR_two_epoch_LL = c(EUR_two_epoch_LL, LL_from_demography(EUR_two_epoch_file_path))
    EUR_two_epoch_theta = c(EUR_two_epoch_theta, theta_from_demography(EUR_two_epoch_file_path))
    EUR_two_epoch_nu = c(EUR_two_epoch_nu, nu_from_demography(EUR_two_epoch_file_path))
    EUR_two_epoch_tau = c(EUR_two_epoch_tau, tau_from_demography(EUR_two_epoch_file_path))
    # EUR_two_epoch_allele_sum = c(EUR_two_epoch_allele_sum, sum(this_two_epoch_sfs))
  }
  if (file.exists(EUR_three_epoch_file_path)) {
    this_three_epoch_sfs = sfs_from_demography(EUR_three_epoch_file_path)
    EUR_three_epoch_file_list[[subdirectory]] = this_three_epoch_sfs
    EUR_three_epoch_AIC = c(EUR_three_epoch_AIC, AIC_from_demography(EUR_three_epoch_file_path))
    EUR_three_epoch_LL = c(EUR_three_epoch_LL, LL_from_demography(EUR_three_epoch_file_path))
    EUR_three_epoch_theta = c(EUR_three_epoch_theta, theta_from_demography(EUR_three_epoch_file_path))
    EUR_three_epoch_nuB = c(EUR_three_epoch_nuB, nuB_from_demography(EUR_three_epoch_file_path))
    EUR_three_epoch_nuF = c(EUR_three_epoch_nuF, nuF_from_demography(EUR_three_epoch_file_path))
    EUR_three_epoch_tauB = c(EUR_three_epoch_tauB, tauB_from_demography(EUR_three_epoch_file_path))
    EUR_three_epoch_tauF = c(EUR_three_epoch_tauF, tauF_from_demography(EUR_three_epoch_file_path))
    # EUR_three_epoch_allele_sum = c(EUR_three_epoch_allele_sum, sum(this_three_epoch_sfs))
  }  
}

EUR_AIC_df = data.frame(EUR_one_epoch_AIC, EUR_two_epoch_AIC, EUR_three_epoch_AIC)
# Reshape the data from wide to long format
EUR_df_long <- tidyr::gather(EUR_AIC_df, key = "Epoch", value = "AIC", EUR_one_epoch_AIC:EUR_three_epoch_AIC)

# Increase the x-axis index by 4
EUR_df_long$Index <- rep(seq(10, 100, by = 10), times = 3)

# Create the line plot with ggplot2
ggplot(EUR_df_long, aes(x = Index, y = AIC, color = Epoch)) +
  geom_line() +
  geom_point() +
  labs(title = "1KG EUR AIC values by sample size",
       x = "Sample Size",
       y = "AIC") +
  scale_y_log10() +
  scale_x_continuous(breaks=EUR_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('One-epoch', 'Three-epoch', 'Two-epoch')) +
  theme_bw()

EUR_lambda_two_one = 2 * (EUR_two_epoch_LL - EUR_one_epoch_LL)
EUR_lambda_three_one = 2 * (EUR_three_epoch_LL - EUR_one_epoch_LL)
EUR_lambda_three_two = 2 * (EUR_three_epoch_LL - EUR_two_epoch_LL)

EUR_lambda_df = data.frame(EUR_lambda_two_one, EUR_lambda_three_one, EUR_lambda_three_two)
# Reshape the data from wide to long format
EUR_df_long_lambda <- tidyr::gather(EUR_lambda_df, key = "Full_vs_Null", value = "Lambda", EUR_lambda_two_one:EUR_lambda_three_two)
# Increase the x-axis index by 4
EUR_df_long_lambda$Index <- rep(seq(10, 100, by = 10), times = 3)

# Create the line plot with ggplot2
ggplot(EUR_df_long_lambda, aes(x = Index, y = Lambda, color = Full_vs_Null)) +
  geom_line() +
  geom_point() +
  labs(title = "1KG EUR Lambda values by sample size (N=10-100:10)",
       x = "Sample Size",
       y = "2 * Lambda") +
  # scale_y_log10() +
  scale_x_continuous(breaks=EUR_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('Three vs. One', 'Three vs. Two', 'Two vs. One')) +
  theme_bw()

EUR_one_epoch_residual = c()
EUR_two_epoch_residual = c()
EUR_three_epoch_residual = c()

for (i in 1:10) {
  EUR_one_epoch_residual = c(EUR_one_epoch_residual, compute_residual(unlist(EUR_empirical_file_list[i]), unlist(EUR_one_epoch_file_list[i])))
  EUR_two_epoch_residual = c(EUR_two_epoch_residual, compute_residual(unlist(EUR_empirical_file_list[i]), unlist(EUR_two_epoch_file_list[i])))
  EUR_three_epoch_residual = c(EUR_three_epoch_residual, compute_residual(unlist(EUR_empirical_file_list[i]), unlist(EUR_three_epoch_file_list[i])))
}

EUR_residual_df = data.frame(EUR_one_epoch_residual, EUR_two_epoch_residual, EUR_three_epoch_residual)
# Reshape the data from wide to long format
EUR_df_long_residual <- tidyr::gather(EUR_residual_df, key = "Epoch", value = "residual", EUR_one_epoch_residual:EUR_three_epoch_residual)

# Increase the x-axis index by 4
EUR_df_long_residual$Index <- rep(seq(10, 100, by = 10), times = 3)

# Create the line plot with ggplot2
ggplot(EUR_df_long_residual, aes(x = Index, y = residual, color = Epoch)) +
  geom_line() +
  geom_point() +
  labs(title = "EUR residual values by sample size",
       x = "Sample Size",
       y = "Residual") +
  scale_y_log10() +
  scale_x_continuous(breaks=EUR_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('One-epoch', 'Three-epoch', 'Two-epoch')) +
  theme_bw()

ggplot(EUR_df_long, aes(x = Index, y = AIC, color = Epoch)) +
  geom_line(linetype=3) +
  geom_point() +
  labs(title = "1KG EUR AIC and residual by sample size (N=10-100:10)",
       x = "Sample Size",
       y = "AIC") +
  scale_y_log10(sec.axis = sec_axis(~.*1, name="Residual")) +
  scale_x_continuous(breaks=EUR_df_long$Index) +
  geom_line(data=EUR_df_long_residual, aes(x = Index, y = residual*1, color = Epoch)) +
  scale_color_manual(values = c("blue", "orange", "green", "violet", "red", "seagreen"),
    label=c('One-epoch AIC', 'One-epoch residual',
      'Three-epoch AIC', 'Three-epoch residual',
      'Two-epoch AIC', 'Two-epoch residual')) +
  theme_bw()

# 1KG_EUR population genetic constants

EUR_mu = 1.5E-8

# NAnc = theta / (4 * allele_sum * mu)
# generations = 2 * tau * theta / (4 * mu * allele_sum)
# years = generations / 365
# NCurr = nu * NAnc
# generations_b = 2 * tauB * theta / (4 * mu * allele_sum)
# generations_f = 2 * tauF * theta / (4 * mu * allele_sum)
# NBottle = nuB * NAnc
# NSince = nuF * NAnc

EUR_one_epoch_NAnc = EUR_one_epoch_theta / (4 * EUR_one_epoch_allele_sum * EUR_mu)
EUR_two_epoch_NAnc = EUR_two_epoch_theta / (4 * EUR_two_epoch_allele_sum * EUR_mu)
EUR_two_epoch_NCurr = EUR_two_epoch_nu * EUR_two_epoch_NAnc
EUR_two_epoch_Time = 2 * 25 * EUR_two_epoch_tau * EUR_two_epoch_theta / (4 * EUR_mu * EUR_two_epoch_allele_sum)
EUR_three_epoch_NAnc = EUR_three_epoch_theta / (4 * EUR_three_epoch_allele_sum * EUR_mu)
EUR_three_epoch_NBottle = EUR_three_epoch_nuB * EUR_three_epoch_NAnc
EUR_three_epoch_NCurr = EUR_three_epoch_nuF * EUR_three_epoch_NAnc
EUR_three_epoch_TimeBottleEnd = 2 * 25 * EUR_three_epoch_tauF * EUR_three_epoch_theta / (4 * EUR_mu * EUR_three_epoch_allele_sum)
EUR_three_epoch_TimeBottleStart = 2 * 25 * EUR_three_epoch_tauB * EUR_three_epoch_theta / (4 * EUR_mu * EUR_three_epoch_allele_sum) + EUR_three_epoch_TimeBottleEnd
EUR_three_epoch_TimeTotal = EUR_three_epoch_TimeBottleStart + EUR_three_epoch_TimeBottleEnd

EUR_two_epoch_max_time = rep(2E6, 10)
# EUR_two_epoch_max_time = rep(2E4, 10)
EUR_two_epoch_current_time = rep(0, 10)
EUR_two_epoch_demography = data.frame(EUR_two_epoch_NAnc, EUR_two_epoch_max_time, 
  EUR_two_epoch_NCurr, EUR_two_epoch_Time, 
  EUR_two_epoch_NCurr, EUR_two_epoch_current_time)

# EUR_three_epoch_max_time = rep(100000000, 10)
# EUR_three_epoch_max_time = rep(5E6, 10)
EUR_three_epoch_max_time = rep(2E6, 10)
EUR_three_epoch_current_time = rep(0, 10)
EUR_three_epoch_demography = data.frame(EUR_three_epoch_NAnc, EUR_three_epoch_max_time,
  EUR_three_epoch_NBottle, EUR_three_epoch_TimeBottleStart,
  EUR_three_epoch_NCurr, EUR_three_epoch_TimeBottleEnd,
  EUR_three_epoch_NCurr, EUR_three_epoch_current_time)

EUR_two_epoch_NEffective_10 = c(EUR_two_epoch_demography[1, 1], EUR_two_epoch_demography[1, 3], EUR_two_epoch_demography[1, 5])
EUR_two_epoch_Time_10 = c(-EUR_two_epoch_demography[1, 2], -EUR_two_epoch_demography[1, 4], EUR_two_epoch_demography[1, 6])
EUR_two_epoch_demography_10 = data.frame(EUR_two_epoch_Time_10, EUR_two_epoch_NEffective_10)
EUR_two_epoch_NEffective_20 = c(EUR_two_epoch_demography[2, 1], EUR_two_epoch_demography[2, 3], EUR_two_epoch_demography[2, 5])
EUR_two_epoch_Time_20 = c(-EUR_two_epoch_demography[2, 2], -EUR_two_epoch_demography[2, 4], EUR_two_epoch_demography[2, 6])
EUR_two_epoch_demography_20 = data.frame(EUR_two_epoch_Time_20, EUR_two_epoch_NEffective_20)
EUR_two_epoch_NEffective_30 = c(EUR_two_epoch_demography[3, 1], EUR_two_epoch_demography[3, 3], EUR_two_epoch_demography[3, 5])
EUR_two_epoch_Time_30 = c(-EUR_two_epoch_demography[3, 2], -EUR_two_epoch_demography[3, 4], EUR_two_epoch_demography[3, 6])
EUR_two_epoch_demography_30 = data.frame(EUR_two_epoch_Time_30, EUR_two_epoch_NEffective_30)
EUR_two_epoch_NEffective_40 = c(EUR_two_epoch_demography[4, 1], EUR_two_epoch_demography[4, 3], EUR_two_epoch_demography[4, 5])
EUR_two_epoch_Time_40 = c(-EUR_two_epoch_demography[4, 2], -EUR_two_epoch_demography[4, 4], EUR_two_epoch_demography[4, 6])
EUR_two_epoch_demography_40 = data.frame(EUR_two_epoch_Time_40, EUR_two_epoch_NEffective_40)
EUR_two_epoch_NEffective_50 = c(EUR_two_epoch_demography[5, 1], EUR_two_epoch_demography[5, 3], EUR_two_epoch_demography[5, 5])
EUR_two_epoch_Time_50 = c(-EUR_two_epoch_demography[5, 2], -EUR_two_epoch_demography[5, 4], EUR_two_epoch_demography[5, 6])
EUR_two_epoch_demography_50 = data.frame(EUR_two_epoch_Time_50, EUR_two_epoch_NEffective_50)
EUR_two_epoch_NEffective_60 = c(EUR_two_epoch_demography[6, 1], EUR_two_epoch_demography[6, 3], EUR_two_epoch_demography[6, 5])
EUR_two_epoch_Time_60 = c(-EUR_two_epoch_demography[6, 2], -EUR_two_epoch_demography[6, 4], EUR_two_epoch_demography[6, 6])
EUR_two_epoch_demography_60 = data.frame(EUR_two_epoch_Time_60, EUR_two_epoch_NEffective_60)
EUR_two_epoch_NEffective_70 = c(EUR_two_epoch_demography[7, 1], EUR_two_epoch_demography[7, 3], EUR_two_epoch_demography[7, 5])
EUR_two_epoch_Time_70 = c(-EUR_two_epoch_demography[7, 2], -EUR_two_epoch_demography[7, 4], EUR_two_epoch_demography[7, 6])
EUR_two_epoch_demography_70 = data.frame(EUR_two_epoch_Time_70, EUR_two_epoch_NEffective_70)
EUR_two_epoch_NEffective_80 = c(EUR_two_epoch_demography[8, 1], EUR_two_epoch_demography[8, 3], EUR_two_epoch_demography[8, 5])
EUR_two_epoch_Time_80 = c(-EUR_two_epoch_demography[8, 2], -EUR_two_epoch_demography[8, 4], EUR_two_epoch_demography[8, 6])
EUR_two_epoch_demography_80 = data.frame(EUR_two_epoch_Time_80, EUR_two_epoch_NEffective_80)
EUR_two_epoch_NEffective_90 = c(EUR_two_epoch_demography[9, 1], EUR_two_epoch_demography[9, 3], EUR_two_epoch_demography[9, 5])
EUR_two_epoch_Time_90 = c(-EUR_two_epoch_demography[9, 2], -EUR_two_epoch_demography[9, 4], EUR_two_epoch_demography[9, 6])
EUR_two_epoch_demography_90 = data.frame(EUR_two_epoch_Time_90, EUR_two_epoch_NEffective_90)
EUR_two_epoch_NEffective_100 = c(EUR_two_epoch_demography[10, 1], EUR_two_epoch_demography[10, 3], EUR_two_epoch_demography[10, 5])
EUR_two_epoch_Time_100 = c(-EUR_two_epoch_demography[10, 2], -EUR_two_epoch_demography[10, 4], EUR_two_epoch_demography[10, 6])
EUR_two_epoch_demography_100 = data.frame(EUR_two_epoch_Time_100, EUR_two_epoch_NEffective_100)

EUR_three_epoch_NEffective_10 = c(EUR_three_epoch_demography[1, 1], EUR_three_epoch_demography[1, 3], EUR_three_epoch_demography[1, 5], EUR_three_epoch_demography[1, 7])
EUR_three_epoch_Time_10 = c(-EUR_three_epoch_demography[1, 2], -EUR_three_epoch_demography[1, 4], -EUR_three_epoch_demography[1, 6], EUR_three_epoch_demography[1, 8])
EUR_three_epoch_demography_10 = data.frame(EUR_three_epoch_Time_10, EUR_three_epoch_NEffective_10)
EUR_three_epoch_NEffective_20 = c(EUR_three_epoch_demography[2, 1], EUR_three_epoch_demography[2, 3], EUR_three_epoch_demography[2, 5], EUR_three_epoch_demography[2, 7])
EUR_three_epoch_Time_20 = c(-EUR_three_epoch_demography[2, 2], -EUR_three_epoch_demography[2, 4], -EUR_three_epoch_demography[2, 6], EUR_three_epoch_demography[2, 8])
EUR_three_epoch_demography_20 = data.frame(EUR_three_epoch_Time_20, EUR_three_epoch_NEffective_20)
EUR_three_epoch_NEffective_30 = c(EUR_three_epoch_demography[3, 1], EUR_three_epoch_demography[3, 3], EUR_three_epoch_demography[3, 5], EUR_three_epoch_demography[3, 7])
EUR_three_epoch_Time_30 = c(-EUR_three_epoch_demography[3, 2], -EUR_three_epoch_demography[3, 4], -EUR_three_epoch_demography[3, 6], EUR_three_epoch_demography[3, 8])
EUR_three_epoch_demography_30 = data.frame(EUR_three_epoch_Time_30, EUR_three_epoch_NEffective_30)
EUR_three_epoch_NEffective_40 = c(EUR_three_epoch_demography[4, 1], EUR_three_epoch_demography[4, 3], EUR_three_epoch_demography[4, 5], EUR_three_epoch_demography[4, 7])
EUR_three_epoch_Time_40 = c(-EUR_three_epoch_demography[4, 2], -EUR_three_epoch_demography[4, 4], -EUR_three_epoch_demography[4, 6], EUR_three_epoch_demography[4, 8])
EUR_three_epoch_demography_40 = data.frame(EUR_three_epoch_Time_40, EUR_three_epoch_NEffective_40)
EUR_three_epoch_NEffective_50 = c(EUR_three_epoch_demography[5, 1], EUR_three_epoch_demography[5, 3], EUR_three_epoch_demography[5, 5], EUR_three_epoch_demography[5, 7])
EUR_three_epoch_Time_50 = c(-EUR_three_epoch_demography[5, 2], -EUR_three_epoch_demography[5, 4], -EUR_three_epoch_demography[5, 6], EUR_three_epoch_demography[5, 8])
EUR_three_epoch_demography_50 = data.frame(EUR_three_epoch_Time_50, EUR_three_epoch_NEffective_50)
EUR_three_epoch_NEffective_60 = c(EUR_three_epoch_demography[6, 1], EUR_three_epoch_demography[6, 3], EUR_three_epoch_demography[6, 5], EUR_three_epoch_demography[6, 7])
EUR_three_epoch_Time_60 = c(-EUR_three_epoch_demography[6, 2], -EUR_three_epoch_demography[6, 4], -EUR_three_epoch_demography[6, 6], EUR_three_epoch_demography[6, 8])
EUR_three_epoch_demography_60 = data.frame(EUR_three_epoch_Time_60, EUR_three_epoch_NEffective_60)
EUR_three_epoch_NEffective_70 = c(EUR_three_epoch_demography[7, 1], EUR_three_epoch_demography[7, 3], EUR_three_epoch_demography[7, 5], EUR_three_epoch_demography[7, 7])
EUR_three_epoch_Time_70 = c(-EUR_three_epoch_demography[7, 2], -EUR_three_epoch_demography[7, 4], -EUR_three_epoch_demography[7, 6], EUR_three_epoch_demography[7, 8])
EUR_three_epoch_demography_70 = data.frame(EUR_three_epoch_Time_70, EUR_three_epoch_NEffective_70)
EUR_three_epoch_NEffective_80 = c(EUR_three_epoch_demography[8, 1], EUR_three_epoch_demography[8, 3], EUR_three_epoch_demography[8, 5], EUR_three_epoch_demography[8, 7])
EUR_three_epoch_Time_80 = c(-EUR_three_epoch_demography[8, 2], -EUR_three_epoch_demography[8, 4], -EUR_three_epoch_demography[8, 6], EUR_three_epoch_demography[8, 8])
EUR_three_epoch_demography_80 = data.frame(EUR_three_epoch_Time_80, EUR_three_epoch_NEffective_80)
EUR_three_epoch_NEffective_90 = c(EUR_three_epoch_demography[9, 1], EUR_three_epoch_demography[9, 3], EUR_three_epoch_demography[9, 5], EUR_three_epoch_demography[9, 7])
EUR_three_epoch_Time_90 = c(-EUR_three_epoch_demography[9, 2], -EUR_three_epoch_demography[9, 4], -EUR_three_epoch_demography[9, 6], EUR_three_epoch_demography[9, 8])
EUR_three_epoch_demography_90 = data.frame(EUR_three_epoch_Time_90, EUR_three_epoch_NEffective_90)
EUR_three_epoch_NEffective_100 = c(EUR_three_epoch_demography[10, 1], EUR_three_epoch_demography[10, 3], EUR_three_epoch_demography[10, 5], EUR_three_epoch_demography[10, 7])
EUR_three_epoch_Time_100 = c(-EUR_three_epoch_demography[10, 2], -EUR_three_epoch_demography[10, 4], -EUR_three_epoch_demography[10, 6], EUR_three_epoch_demography[10, 8])
EUR_three_epoch_demography_100 = data.frame(EUR_three_epoch_Time_100, EUR_three_epoch_NEffective_100)

ggplot(EUR_two_epoch_demography_10, aes(EUR_two_epoch_Time_10, EUR_two_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='dotted') + 
  geom_step(data=EUR_two_epoch_demography_20, aes(EUR_two_epoch_Time_20, EUR_two_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='dotted') +
  geom_step(data=EUR_two_epoch_demography_30, aes(EUR_two_epoch_Time_30, EUR_two_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='dotted') +
  geom_step(data=EUR_two_epoch_demography_40, aes(EUR_two_epoch_Time_40, EUR_two_epoch_NEffective_40, color='N=40'), linewidth=1, linetype='dotted') +
  geom_step(data=EUR_two_epoch_demography_50, aes(EUR_two_epoch_Time_50, EUR_two_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='dotted') +
  geom_step(data=EUR_two_epoch_demography_60, aes(EUR_two_epoch_Time_60, EUR_two_epoch_NEffective_60, color='N=60'), linewidth=1, linetype='dotted') +
  geom_step(data=EUR_two_epoch_demography_70, aes(EUR_two_epoch_Time_70, EUR_two_epoch_NEffective_70, color='N=70'), linewidth=1, linetype='dotted') +
  geom_step(data=EUR_two_epoch_demography_80, aes(EUR_two_epoch_Time_80, EUR_two_epoch_NEffective_80, color='N=80'), linewidth=1, linetype='dotted') +
  geom_step(data=EUR_two_epoch_demography_90, aes(EUR_two_epoch_Time_90, EUR_two_epoch_NEffective_90, color='N=90'), linewidth=1, linetype='dotted') +
  geom_step(data=EUR_two_epoch_demography_100, aes(EUR_two_epoch_Time_100, EUR_two_epoch_NEffective_100, color='N=100'), linewidth=1, linetype='dotted') +
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
  ggtitle('1KG EUR two Epoch Demography (N=10-100:10)')

ggplot(EUR_two_epoch_demography_10, aes(EUR_two_epoch_Time_10, EUR_two_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='dashed') + 
  # geom_step(data=EUR_two_epoch_demography_20, aes(EUR_two_epoch_Time_20, EUR_two_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='dashed') +
  # geom_step(data=EUR_two_epoch_demography_30, aes(EUR_two_epoch_Time_30, EUR_two_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='dashed') +
  # geom_step(data=EUR_two_epoch_demography_40, aes(EUR_two_epoch_Time_40, EUR_two_epoch_NEffective_40, color='N=40'), linewidth=1, linetype='dashed') +
  # geom_step(data=EUR_two_epoch_demography_50, aes(EUR_two_epoch_Time_50, EUR_two_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='dashed') +
  # geom_step(data=EUR_two_epoch_demography_60, aes(EUR_two_epoch_Time_60, EUR_two_epoch_NEffective_60, color='N=60'), linewidth=1, linetype='dashed') +
  # geom_step(data=EUR_two_epoch_demography_70, aes(EUR_two_epoch_Time_70, EUR_two_epoch_NEffective_70, color='N=70'), linewidth=1, linetype='dashed') +
  # geom_step(data=EUR_two_epoch_demography_80, aes(EUR_two_epoch_Time_80, EUR_two_epoch_NEffective_80, color='N=80'), linewidth=1, linetype='dashed') +
  # geom_step(data=EUR_two_epoch_demography_90, aes(EUR_two_epoch_Time_90, EUR_two_epoch_NEffective_90, color='N=90'), linewidth=1, linetype='dashed') +
  # geom_step(data=EUR_two_epoch_demography_100, aes(EUR_two_epoch_Time_100, EUR_two_epoch_NEffective_100, color='#N=100'), linewidth=1, linetype='dashed') +
  # geom_step(data=EUR_three_epoch_demography_10, aes(EUR_three_epoch_Time_10, EUR_three_epoch_NEffective_10, color='N=10'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_20, aes(EUR_three_epoch_Time_20, EUR_three_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_30, aes(EUR_three_epoch_Time_30, EUR_three_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_40, aes(EUR_three_epoch_Time_40, EUR_three_epoch_NEffective_40, color='N=40'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_50, aes(EUR_three_epoch_Time_50, EUR_three_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_60, aes(EUR_three_epoch_Time_60, EUR_three_epoch_NEffective_60, color='N=60'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_70, aes(EUR_three_epoch_Time_70, EUR_three_epoch_NEffective_70, color='N=70'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_80, aes(EUR_three_epoch_Time_80, EUR_three_epoch_NEffective_80, color='N=80'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_90, aes(EUR_three_epoch_Time_90, EUR_three_epoch_NEffective_90, color='N=90'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_100, aes(EUR_three_epoch_Time_100, EUR_three_epoch_NEffective_100, color='N=100'), linewidth=1, linetype='solid') +
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
  ggtitle('1KG EUR Best-fitting Demography (N=10-100:10)')

ggplot(EUR_three_epoch_demography_10, aes(EUR_three_epoch_Time_10, EUR_three_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='solid') + 
  geom_step(data=EUR_three_epoch_demography_20, aes(EUR_three_epoch_Time_20, EUR_three_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_30, aes(EUR_three_epoch_Time_30, EUR_three_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_40, aes(EUR_three_epoch_Time_40, EUR_three_epoch_NEffective_40, color='N=40'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_50, aes(EUR_three_epoch_Time_50, EUR_three_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_60, aes(EUR_three_epoch_Time_60, EUR_three_epoch_NEffective_60, color='N=60'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_70, aes(EUR_three_epoch_Time_70, EUR_three_epoch_NEffective_70, color='N=70'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_80, aes(EUR_three_epoch_Time_80, EUR_three_epoch_NEffective_80, color='N=80'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_90, aes(EUR_three_epoch_Time_90, EUR_three_epoch_NEffective_90, color='N=90'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_100, aes(EUR_three_epoch_Time_100, EUR_three_epoch_NEffective_100, color='N=100'), linewidth=1, linetype='solid') +
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
  ggtitle('1KG EUR Three Epoch Demography (N=10-100:10)')

# ggplot(EUR_three_epoch_demography_20, aes(EUR_three_epoch_Time_20, EUR_three_epoch_NEffective_20color='#b35806')) + geom_step(linewidth=1, linetype='solid') + 
#   # geom_step(data=EUR_three_epoch_demography_20, aes(EUR_three_epoch_Time_20, EUR_three_epoch_NEffective_20, color='#b35806'), linewidth=1, linetype='solid') +
#   geom_step(data=EUR_three_epoch_demography_30, aes(EUR_three_epoch_Time_30, EUR_three_epoch_NEffective_30, color='#e08214'), linewidth=1, linetype='solid') +
#   geom_step(data=EUR_three_epoch_demography_40, aes(EUR_three_epoch_Time_40, EUR_three_epoch_NEffective_40, color='#fdb863'), linewidth=1, linetype='solid') +
#   geom_step(data=EUR_three_epoch_demography_50, aes(EUR_three_epoch_Time_50, EUR_three_epoch_NEffective_50, color='#fee0b6'), linewidth=1, linetype='solid') +
#   geom_step(data=EUR_three_epoch_demography_60, aes(EUR_three_epoch_Time_60, EUR_three_epoch_NEffective_60, color='#d8daeb'), linewidth=1, linetype='solid') +
#   geom_step(data=EUR_three_epoch_demography_70, aes(EUR_three_epoch_Time_70, EUR_three_epoch_NEffective_70, color='#b2abd2'), linewidth=1, linetype='solid') +
#   geom_step(data=EUR_three_epoch_demography_80, aes(EUR_three_epoch_Time_80, EUR_three_epoch_NEffective_80, color='#8073ac'), linewidth=1, linetype='solid') +
#   geom_step(data=EUR_three_epoch_demography_90, aes(EUR_three_epoch_Time_90, EUR_three_epoch_NEffective_90, color='#542788'), linewidth=1, linetype='solid') +
#   geom_step(data=EUR_three_epoch_demography_100, aes(EUR_three_epoch_Time_100, EUR_three_epoch_NEffective_100, color='#2d004b'), linewidth=1, linetype='solid') +
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
#   ggtitle('1KG EUR Three Epoch Demography, 10-100:10')

# NAnc Estimate by Sample Size
sample_size = c(10, 20, 30, 40, 50, 60, 70, 80, 90, 100)

NAnc_df = data.frame(sample_size, EUR_one_epoch_NAnc, EUR_two_epoch_NAnc, EUR_three_epoch_NAnc)
NAnc_df = melt(NAnc_df, id='sample_size')

ggplot(data=NAnc_df, aes(x=sample_size, y=value, color=variable)) + geom_line() +
  xlab('Sample size') +
  ylab('Estimated ancestral effective population size') +
  ggtitle('1KG EUR NAnc by sample size (N=10-100:10)') +
  theme_bw() +
  guides(color=guide_legend(title="Epoch")) +
  scale_color_manual(
    labels=c('One-epoch', 'Two-epoch', 'Three-epoch'),
    values=c('red', 'blue', 'green')) +
  geom_hline(yintercept=12378, color='black', linetype='dashed') +
  scale_x_continuous(breaks=sample_size)


# # 1KG_EUR 10-19:1
EUR_empirical_file_list = list()
EUR_one_epoch_file_list = list()
EUR_two_epoch_file_list = list()
EUR_three_epoch_file_list = list()
EUR_one_epoch_AIC = c()
EUR_one_epoch_LL = c()
EUR_one_epoch_theta = c()
EUR_one_epoch_allele_sum = 8058343
EUR_two_epoch_AIC = c()
EUR_two_epoch_LL = c()
EUR_two_epoch_theta = c()
EUR_two_epoch_nu = c()
EUR_two_epoch_tau = c()
EUR_two_epoch_allele_sum = 8058343
EUR_three_epoch_AIC = c()
EUR_three_epoch_LL = c()
EUR_three_epoch_theta = c()
EUR_three_epoch_nuB = c()
EUR_three_epoch_nuF = c()
EUR_three_epoch_tauB = c()
EUR_three_epoch_tauF = c()
EUR_three_epoch_allele_sum = 8058343

# Loop through subdirectories and get relevant files
for (i in seq(10, 19, by = 1)) {
  subdirectory <- paste0("../Analysis/1kg_EUR_", i)
  EUR_empirical_file_path <- file.path(subdirectory, "syn_downsampled_sfs.txt")
  EUR_one_epoch_file_path <- file.path(subdirectory, "one_epoch_demography.txt")
  EUR_two_epoch_file_path <- file.path(subdirectory, "two_epoch_demography.txt")
  EUR_three_epoch_file_path <- file.path(subdirectory, "three_epoch_demography.txt")
  
  # Check if the file exists before attempting to read and print its contents
  if (file.exists(EUR_empirical_file_path)) {
    this_empirical_sfs = read_input_sfs(EUR_empirical_file_path)
    EUR_empirical_file_list[[subdirectory]] = this_empirical_sfs
  }
  if (file.exists(EUR_one_epoch_file_path)) {
    this_one_epoch_sfs = sfs_from_demography(EUR_one_epoch_file_path)
    EUR_one_epoch_file_list[[subdirectory]] = this_one_epoch_sfs
    EUR_one_epoch_AIC = c(EUR_one_epoch_AIC, AIC_from_demography(EUR_one_epoch_file_path))
    EUR_one_epoch_LL = c(EUR_one_epoch_LL, LL_from_demography(EUR_one_epoch_file_path))
    EUR_one_epoch_theta = c(EUR_one_epoch_theta, theta_from_demography(EUR_one_epoch_file_path))
    # EUR_one_epoch_allele_sum = c(EUR_one_epoch_allele_sum, sum(this_one_epoch_sfs))
  }
  if (file.exists(EUR_two_epoch_file_path)) {
    this_two_epoch_sfs = sfs_from_demography(EUR_two_epoch_file_path)
    EUR_two_epoch_file_list[[subdirectory]] = this_two_epoch_sfs
    EUR_two_epoch_AIC = c(EUR_two_epoch_AIC, AIC_from_demography(EUR_two_epoch_file_path))
    EUR_two_epoch_LL = c(EUR_two_epoch_LL, LL_from_demography(EUR_two_epoch_file_path))
    EUR_two_epoch_theta = c(EUR_two_epoch_theta, theta_from_demography(EUR_two_epoch_file_path))
    EUR_two_epoch_nu = c(EUR_two_epoch_nu, nu_from_demography(EUR_two_epoch_file_path))
    EUR_two_epoch_tau = c(EUR_two_epoch_tau, tau_from_demography(EUR_two_epoch_file_path))
    # EUR_two_epoch_allele_sum = c(EUR_two_epoch_allele_sum, sum(this_two_epoch_sfs))
  }
  if (file.exists(EUR_three_epoch_file_path)) {
    this_three_epoch_sfs = sfs_from_demography(EUR_three_epoch_file_path)
    EUR_three_epoch_file_list[[subdirectory]] = this_three_epoch_sfs
    EUR_three_epoch_AIC = c(EUR_three_epoch_AIC, AIC_from_demography(EUR_three_epoch_file_path))
    EUR_three_epoch_LL = c(EUR_three_epoch_LL, LL_from_demography(EUR_three_epoch_file_path))
    EUR_three_epoch_theta = c(EUR_three_epoch_theta, theta_from_demography(EUR_three_epoch_file_path))
    EUR_three_epoch_nuB = c(EUR_three_epoch_nuB, nuB_from_demography(EUR_three_epoch_file_path))
    EUR_three_epoch_nuF = c(EUR_three_epoch_nuF, nuF_from_demography(EUR_three_epoch_file_path))
    EUR_three_epoch_tauB = c(EUR_three_epoch_tauB, tauB_from_demography(EUR_three_epoch_file_path))
    EUR_three_epoch_tauF = c(EUR_three_epoch_tauF, tauF_from_demography(EUR_three_epoch_file_path))
    # EUR_three_epoch_allele_sum = c(EUR_three_epoch_allele_sum, sum(this_three_epoch_sfs))
  }  
}

EUR_AIC_df = data.frame(EUR_one_epoch_AIC, EUR_two_epoch_AIC, EUR_three_epoch_AIC)
# Reshape the data from wide to long format
EUR_df_long <- tidyr::gather(EUR_AIC_df, key = "Epoch", value = "AIC", EUR_one_epoch_AIC:EUR_three_epoch_AIC)

# Increase the x-axis index by 4
EUR_df_long$Index <- rep(seq(10, 19, by = 1), times = 3)

# Create the line plot with ggplot2
ggplot(EUR_df_long, aes(x = Index, y = AIC, color = Epoch)) +
  geom_line() +
  geom_point() +
  labs(title = "1KG EUR AIC values by sample size (N=10-19:1)",
       x = "Sample Size",
       y = "AIC") +
  scale_y_log10() +
  scale_x_continuous(breaks=EUR_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('One-epoch', 'Three-epoch', 'Two-epoch')) +
  theme_bw()

EUR_lambda_two_one = 2 * (EUR_two_epoch_LL - EUR_one_epoch_LL)
EUR_lambda_three_one = 2 * (EUR_three_epoch_LL - EUR_one_epoch_LL)
EUR_lambda_three_two = 2 * (EUR_three_epoch_LL - EUR_two_epoch_LL)

EUR_lambda_df = data.frame(EUR_lambda_two_one, EUR_lambda_three_one, EUR_lambda_three_two)
# Reshape the data from wide to long format
EUR_df_long_lambda <- tidyr::gather(EUR_lambda_df, key = "Full_vs_Null", value = "Lambda", EUR_lambda_two_one:EUR_lambda_three_two)
# Increase the x-axis index by 4
EUR_df_long_lambda$Index <- rep(seq(10, 19, by = 1), times = 3)

# Create the line plot with ggplot2
ggplot(EUR_df_long_lambda, aes(x = Index, y = Lambda, color = Full_vs_Null)) +
  geom_line() +
  geom_point() +
  labs(title = "1KG EUR Lambda values by sample size (N=10-19:1)",
       x = "Sample Size",
       y = "2 * Lambda") +
  # scale_y_log10() +
  scale_x_continuous(breaks=EUR_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('Three vs. One', 'Three vs. Two', 'Two vs. One')) +
  theme_bw()

# Create the line plot with ggplot2
ggplot(EUR_df_long_lambda, aes(x = Index, y = Lambda, color = Full_vs_Null)) +
  geom_line() +
  geom_point() +
  labs(title = "1KG EUR Lambda values by sample size (N=10-19:1)",
       x = "Sample Size",
       y = "2 * Lambda") +
  # scale_y_log10() +
  scale_x_continuous(breaks=EUR_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('Three vs. One', 'Three vs. Two', 'Two vs. One')) +
  theme_bw() +
  ylim(-5, 10)

EUR_one_epoch_residual = c()
EUR_two_epoch_residual = c()
EUR_three_epoch_residual = c()

for (i in 1:10) {
  EUR_one_epoch_residual = c(EUR_one_epoch_residual, compute_residual(unlist(EUR_empirical_file_list[i]), unlist(EUR_one_epoch_file_list[i])))
  EUR_two_epoch_residual = c(EUR_two_epoch_residual, compute_residual(unlist(EUR_empirical_file_list[i]), unlist(EUR_two_epoch_file_list[i])))
  EUR_three_epoch_residual = c(EUR_three_epoch_residual, compute_residual(unlist(EUR_empirical_file_list[i]), unlist(EUR_three_epoch_file_list[i])))
}

EUR_residual_df = data.frame(EUR_one_epoch_residual, EUR_two_epoch_residual, EUR_three_epoch_residual)
# Reshape the data from wide to long format
EUR_df_long_residual <- tidyr::gather(EUR_residual_df, key = "Epoch", value = "residual", EUR_one_epoch_residual:EUR_three_epoch_residual)

# Increase the x-axis index by 4
EUR_df_long_residual$Index <- rep(seq(10, 19, by = 1), times = 3)

# Create the line plot with ggplot2
ggplot(EUR_df_long_residual, aes(x = Index, y = residual, color = Epoch)) +
  geom_line() +
  geom_point() +
  labs(title = "EUR residual values by sample size (N=10-19:1)",
       x = "Sample Size",
       y = "Residual") +
  scale_y_log10() +
  scale_x_continuous(breaks=EUR_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('One-epoch', 'Three-epoch', 'Two-epoch')) +
  theme_bw()

ggplot(EUR_df_long, aes(x = Index, y = AIC, color = Epoch)) +
  geom_line(linetype=3) +
  geom_point() +
  labs(title = "1KG EUR AIC and residual by sample size (N=10-19:1)",
       x = "Sample Size",
       y = "AIC") +
  scale_y_log10(sec.axis = sec_axis(~.*1, name="Residual")) +
  scale_x_continuous(breaks=EUR_df_long$Index) +
  geom_line(data=EUR_df_long_residual, aes(x = Index, y = residual*1, color = Epoch)) +
  scale_color_manual(values = c("blue", "orange", "green", "violet", "red", "seagreen"),
    label=c('One-epoch AIC', 'One-epoch residual',
      'Three-epoch AIC', 'Three-epoch residual',
      'Two-epoch AIC', 'Two-epoch residual')) +
  theme_bw()

# 1KG_EUR population genetic constants

EUR_mu = 1.5E-8

# NAnc = theta / (4 * allele_sum * mu)
# generations = 2 * tau * theta / (4 * mu * allele_sum)
# years = generations / 365
# NCurr = nu * NAnc
# generations_b = 2 * tauB * theta / (4 * mu * allele_sum)
# generations_f = 2 * tauF * theta / (4 * mu * allele_sum)
# NBottle = nuB * NAnc
# NSince = nuF * NAnc

EUR_one_epoch_NAnc = EUR_one_epoch_theta / (4 * EUR_one_epoch_allele_sum * EUR_mu)
EUR_two_epoch_NAnc = EUR_two_epoch_theta / (4 * EUR_two_epoch_allele_sum * EUR_mu)
EUR_two_epoch_NCurr = EUR_two_epoch_nu * EUR_two_epoch_NAnc
EUR_two_epoch_Time = 2 * 25 * EUR_two_epoch_tau * EUR_two_epoch_theta / (4 * EUR_mu * EUR_two_epoch_allele_sum)
EUR_three_epoch_NAnc = EUR_three_epoch_theta / (4 * EUR_three_epoch_allele_sum * EUR_mu)
EUR_three_epoch_NBottle = EUR_three_epoch_nuB * EUR_three_epoch_NAnc
EUR_three_epoch_NCurr = EUR_three_epoch_nuF * EUR_three_epoch_NAnc
EUR_three_epoch_TimeBottleEnd = 2 * 25 * EUR_three_epoch_tauF * EUR_three_epoch_theta / (4 * EUR_mu * EUR_three_epoch_allele_sum)
EUR_three_epoch_TimeBottleStart = 2 * 25 * EUR_three_epoch_tauB * EUR_three_epoch_theta / (4 * EUR_mu * EUR_three_epoch_allele_sum) + EUR_three_epoch_TimeBottleEnd
EUR_three_epoch_TimeTotal = EUR_three_epoch_TimeBottleStart + EUR_three_epoch_TimeBottleEnd

EUR_two_epoch_max_time = rep(1.25E6, 10)
# EUR_two_epoch_max_time = rep(2E4, 10)
EUR_two_epoch_current_time = rep(0, 10)
EUR_two_epoch_demography = data.frame(EUR_two_epoch_NAnc, EUR_two_epoch_max_time, 
  EUR_two_epoch_NCurr, EUR_two_epoch_Time, 
  EUR_two_epoch_NCurr, EUR_two_epoch_current_time)

# EUR_three_epoch_max_time = rep(100000000, 10)
# EUR_three_epoch_max_time = rep(5E6, 10)
EUR_three_epoch_max_time = rep(1.25E6, 10)
EUR_three_epoch_current_time = rep(0, 10)
EUR_three_epoch_demography = data.frame(EUR_three_epoch_NAnc, EUR_three_epoch_max_time,
  EUR_three_epoch_NBottle, EUR_three_epoch_TimeBottleStart,
  EUR_three_epoch_NCurr, EUR_three_epoch_TimeBottleEnd,
  EUR_three_epoch_NCurr, EUR_three_epoch_current_time)

EUR_two_epoch_NEffective_10 = c(EUR_two_epoch_demography[1, 1], EUR_two_epoch_demography[1, 3], EUR_two_epoch_demography[1, 5])
EUR_two_epoch_Time_10 = c(-EUR_two_epoch_demography[1, 2], -EUR_two_epoch_demography[1, 4], EUR_two_epoch_demography[1, 6])
EUR_two_epoch_demography_10 = data.frame(EUR_two_epoch_Time_10, EUR_two_epoch_NEffective_10)
EUR_two_epoch_NEffective_11 = c(EUR_two_epoch_demography[2, 1], EUR_two_epoch_demography[2, 3], EUR_two_epoch_demography[2, 5])
EUR_two_epoch_Time_11 = c(-EUR_two_epoch_demography[2, 2], -EUR_two_epoch_demography[2, 4], EUR_two_epoch_demography[2, 6])
EUR_two_epoch_demography_11 = data.frame(EUR_two_epoch_Time_11, EUR_two_epoch_NEffective_11)
EUR_two_epoch_NEffective_12 = c(EUR_two_epoch_demography[3, 1], EUR_two_epoch_demography[3, 3], EUR_two_epoch_demography[3, 5])
EUR_two_epoch_Time_12 = c(-EUR_two_epoch_demography[3, 2], -EUR_two_epoch_demography[3, 4], EUR_two_epoch_demography[3, 6])
EUR_two_epoch_demography_12 = data.frame(EUR_two_epoch_Time_12, EUR_two_epoch_NEffective_12)
EUR_two_epoch_NEffective_13 = c(EUR_two_epoch_demography[4, 1], EUR_two_epoch_demography[4, 3], EUR_two_epoch_demography[4, 5])
EUR_two_epoch_Time_13 = c(-EUR_two_epoch_demography[4, 2], -EUR_two_epoch_demography[4, 4], EUR_two_epoch_demography[4, 6])
EUR_two_epoch_demography_13 = data.frame(EUR_two_epoch_Time_13, EUR_two_epoch_NEffective_13)
EUR_two_epoch_NEffective_14 = c(EUR_two_epoch_demography[5, 1], EUR_two_epoch_demography[5, 3], EUR_two_epoch_demography[5, 5])
EUR_two_epoch_Time_14 = c(-EUR_two_epoch_demography[5, 2], -EUR_two_epoch_demography[5, 4], EUR_two_epoch_demography[5, 6])
EUR_two_epoch_demography_14 = data.frame(EUR_two_epoch_Time_14, EUR_two_epoch_NEffective_14)
EUR_two_epoch_NEffective_15 = c(EUR_two_epoch_demography[6, 1], EUR_two_epoch_demography[6, 3], EUR_two_epoch_demography[6, 5])
EUR_two_epoch_Time_15 = c(-EUR_two_epoch_demography[6, 2], -EUR_two_epoch_demography[6, 4], EUR_two_epoch_demography[6, 6])
EUR_two_epoch_demography_15 = data.frame(EUR_two_epoch_Time_15, EUR_two_epoch_NEffective_15)
EUR_two_epoch_NEffective_16 = c(EUR_two_epoch_demography[7, 1], EUR_two_epoch_demography[7, 3], EUR_two_epoch_demography[7, 5])
EUR_two_epoch_Time_16 = c(-EUR_two_epoch_demography[7, 2], -EUR_two_epoch_demography[7, 4], EUR_two_epoch_demography[7, 6])
EUR_two_epoch_demography_16 = data.frame(EUR_two_epoch_Time_16, EUR_two_epoch_NEffective_16)
EUR_two_epoch_NEffective_17 = c(EUR_two_epoch_demography[8, 1], EUR_two_epoch_demography[8, 3], EUR_two_epoch_demography[8, 5])
EUR_two_epoch_Time_17 = c(-EUR_two_epoch_demography[8, 2], -EUR_two_epoch_demography[8, 4], EUR_two_epoch_demography[8, 6])
EUR_two_epoch_demography_17 = data.frame(EUR_two_epoch_Time_17, EUR_two_epoch_NEffective_17)
EUR_two_epoch_NEffective_18 = c(EUR_two_epoch_demography[9, 1], EUR_two_epoch_demography[9, 3], EUR_two_epoch_demography[9, 5])
EUR_two_epoch_Time_18 = c(-EUR_two_epoch_demography[9, 2], -EUR_two_epoch_demography[9, 4], EUR_two_epoch_demography[9, 6])
EUR_two_epoch_demography_18 = data.frame(EUR_two_epoch_Time_18, EUR_two_epoch_NEffective_18)
EUR_two_epoch_NEffective_19 = c(EUR_two_epoch_demography[10, 1], EUR_two_epoch_demography[10, 3], EUR_two_epoch_demography[10, 5])
EUR_two_epoch_Time_19 = c(-EUR_two_epoch_demography[10, 2], -EUR_two_epoch_demography[10, 4], EUR_two_epoch_demography[10, 6])
EUR_two_epoch_demography_19 = data.frame(EUR_two_epoch_Time_19, EUR_two_epoch_NEffective_19)

EUR_three_epoch_NEffective_10 = c(EUR_three_epoch_demography[1, 1], EUR_three_epoch_demography[1, 3], EUR_three_epoch_demography[1, 5], EUR_three_epoch_demography[1, 7])
EUR_three_epoch_Time_10 = c(-EUR_three_epoch_demography[1, 2], -EUR_three_epoch_demography[1, 4], -EUR_three_epoch_demography[1, 6], EUR_three_epoch_demography[1, 8])
EUR_three_epoch_demography_10 = data.frame(EUR_three_epoch_Time_10, EUR_three_epoch_NEffective_10)
EUR_three_epoch_NEffective_11 = c(EUR_three_epoch_demography[2, 1], EUR_three_epoch_demography[2, 3], EUR_three_epoch_demography[2, 5], EUR_three_epoch_demography[2, 7])
EUR_three_epoch_Time_11 = c(-EUR_three_epoch_demography[2, 2], -EUR_three_epoch_demography[2, 4], -EUR_three_epoch_demography[2, 6], EUR_three_epoch_demography[2, 8])
EUR_three_epoch_demography_11 = data.frame(EUR_three_epoch_Time_11, EUR_three_epoch_NEffective_11)
EUR_three_epoch_NEffective_12 = c(EUR_three_epoch_demography[3, 1], EUR_three_epoch_demography[3, 3], EUR_three_epoch_demography[3, 5], EUR_three_epoch_demography[3, 7])
EUR_three_epoch_Time_12 = c(-EUR_three_epoch_demography[3, 2], -EUR_three_epoch_demography[3, 4], -EUR_three_epoch_demography[3, 6], EUR_three_epoch_demography[3, 8])
EUR_three_epoch_demography_12 = data.frame(EUR_three_epoch_Time_12, EUR_three_epoch_NEffective_12)
EUR_three_epoch_NEffective_13 = c(EUR_three_epoch_demography[4, 1], EUR_three_epoch_demography[4, 3], EUR_three_epoch_demography[4, 5], EUR_three_epoch_demography[4, 7])
EUR_three_epoch_Time_13 = c(-EUR_three_epoch_demography[4, 2], -EUR_three_epoch_demography[4, 4], -EUR_three_epoch_demography[4, 6], EUR_three_epoch_demography[4, 8])
EUR_three_epoch_demography_13 = data.frame(EUR_three_epoch_Time_13, EUR_three_epoch_NEffective_13)
EUR_three_epoch_NEffective_14 = c(EUR_three_epoch_demography[5, 1], EUR_three_epoch_demography[5, 3], EUR_three_epoch_demography[5, 5], EUR_three_epoch_demography[5, 7])
EUR_three_epoch_Time_14 = c(-EUR_three_epoch_demography[5, 2], -EUR_three_epoch_demography[5, 4], -EUR_three_epoch_demography[5, 6], EUR_three_epoch_demography[5, 8])
EUR_three_epoch_demography_14 = data.frame(EUR_three_epoch_Time_14, EUR_three_epoch_NEffective_14)
EUR_three_epoch_NEffective_15 = c(EUR_three_epoch_demography[6, 1], EUR_three_epoch_demography[6, 3], EUR_three_epoch_demography[6, 5], EUR_three_epoch_demography[6, 7])
EUR_three_epoch_Time_15 = c(-EUR_three_epoch_demography[6, 2], -EUR_three_epoch_demography[6, 4], -EUR_three_epoch_demography[6, 6], EUR_three_epoch_demography[6, 8])
EUR_three_epoch_demography_15 = data.frame(EUR_three_epoch_Time_15, EUR_three_epoch_NEffective_15)
EUR_three_epoch_NEffective_16 = c(EUR_three_epoch_demography[7, 1], EUR_three_epoch_demography[7, 3], EUR_three_epoch_demography[7, 5], EUR_three_epoch_demography[7, 7])
EUR_three_epoch_Time_16 = c(-EUR_three_epoch_demography[7, 2], -EUR_three_epoch_demography[7, 4], -EUR_three_epoch_demography[7, 6], EUR_three_epoch_demography[7, 8])
EUR_three_epoch_demography_16 = data.frame(EUR_three_epoch_Time_16, EUR_three_epoch_NEffective_16)
EUR_three_epoch_NEffective_17 = c(EUR_three_epoch_demography[8, 1], EUR_three_epoch_demography[8, 3], EUR_three_epoch_demography[8, 5], EUR_three_epoch_demography[8, 7])
EUR_three_epoch_Time_17 = c(-EUR_three_epoch_demography[8, 2], -EUR_three_epoch_demography[8, 4], -EUR_three_epoch_demography[8, 6], EUR_three_epoch_demography[8, 8])
EUR_three_epoch_demography_17 = data.frame(EUR_three_epoch_Time_17, EUR_three_epoch_NEffective_17)
EUR_three_epoch_NEffective_18 = c(EUR_three_epoch_demography[9, 1], EUR_three_epoch_demography[9, 3], EUR_three_epoch_demography[9, 5], EUR_three_epoch_demography[9, 7])
EUR_three_epoch_Time_18 = c(-EUR_three_epoch_demography[9, 2], -EUR_three_epoch_demography[9, 4], -EUR_three_epoch_demography[9, 6], EUR_three_epoch_demography[9, 8])
EUR_three_epoch_demography_18 = data.frame(EUR_three_epoch_Time_18, EUR_three_epoch_NEffective_18)
EUR_three_epoch_NEffective_19 = c(EUR_three_epoch_demography[10, 1], EUR_three_epoch_demography[10, 3], EUR_three_epoch_demography[10, 5], EUR_three_epoch_demography[10, 7])
EUR_three_epoch_Time_19 = c(-EUR_three_epoch_demography[10, 2], -EUR_three_epoch_demography[10, 4], -EUR_three_epoch_demography[10, 6], EUR_three_epoch_demography[10, 8])
EUR_three_epoch_demography_19 = data.frame(EUR_three_epoch_Time_19, EUR_three_epoch_NEffective_19)

ggplot(EUR_two_epoch_demography_10, aes(EUR_two_epoch_Time_10, EUR_two_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='dotted') + 
  geom_step(data=EUR_two_epoch_demography_11, aes(EUR_two_epoch_Time_11, EUR_two_epoch_NEffective_11, color='N=11'), linewidth=1, linetype='dotted') +
  geom_step(data=EUR_two_epoch_demography_12, aes(EUR_two_epoch_Time_12, EUR_two_epoch_NEffective_12, color='N=12'), linewidth=1, linetype='dotted') +
  geom_step(data=EUR_two_epoch_demography_13, aes(EUR_two_epoch_Time_13, EUR_two_epoch_NEffective_13, color='N=13'), linewidth=1, linetype='dotted') +
  geom_step(data=EUR_two_epoch_demography_14, aes(EUR_two_epoch_Time_14, EUR_two_epoch_NEffective_14, color='N=14'), linewidth=1, linetype='dotted') +
  geom_step(data=EUR_two_epoch_demography_15, aes(EUR_two_epoch_Time_15, EUR_two_epoch_NEffective_15, color='N=15'), linewidth=1, linetype='dotted') +
  geom_step(data=EUR_two_epoch_demography_16, aes(EUR_two_epoch_Time_16, EUR_two_epoch_NEffective_16, color='N=16'), linewidth=1, linetype='dotted') +
  geom_step(data=EUR_two_epoch_demography_17, aes(EUR_two_epoch_Time_17, EUR_two_epoch_NEffective_17, color='N=17'), linewidth=1, linetype='dotted') +
  geom_step(data=EUR_two_epoch_demography_18, aes(EUR_two_epoch_Time_18, EUR_two_epoch_NEffective_18, color='N=18'), linewidth=1, linetype='dotted') +
  geom_step(data=EUR_two_epoch_demography_19, aes(EUR_two_epoch_Time_19, EUR_two_epoch_NEffective_19, color='N=19'), linewidth=1, linetype='dotted') +
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
  ggtitle('1KG EUR two Epoch Demography (N=10-19:1)')

ggplot(EUR_two_epoch_demography_10, aes(EUR_two_epoch_Time_10, EUR_two_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='dashed') + 
  geom_step(data=EUR_two_epoch_demography_11, aes(EUR_two_epoch_Time_11, EUR_two_epoch_NEffective_11, color='N=11'), linewidth=1, linetype='dashed') +
  geom_step(data=EUR_two_epoch_demography_12, aes(EUR_two_epoch_Time_12, EUR_two_epoch_NEffective_12, color='N=12'), linewidth=1, linetype='dashed') +
  geom_step(data=EUR_two_epoch_demography_13, aes(EUR_two_epoch_Time_13, EUR_two_epoch_NEffective_13, color='N=13'), linewidth=1, linetype='dashed') +
  geom_step(data=EUR_two_epoch_demography_14, aes(EUR_two_epoch_Time_14, EUR_two_epoch_NEffective_14, color='N=14'), linewidth=1, linetype='dashed') +
  geom_step(data=EUR_two_epoch_demography_15, aes(EUR_two_epoch_Time_15, EUR_two_epoch_NEffective_15, color='N=15'), linewidth=1, linetype='dashed') +
  # geom_step(data=EUR_two_epoch_demography_16, aes(EUR_two_epoch_Time_16, EUR_two_epoch_NEffective_16, color='N=16'), linewidth=1, linetype='dashed') +
  # geom_step(data=EUR_two_epoch_demography_17, aes(EUR_two_epoch_Time_17, EUR_two_epoch_NEffective_17, color='N=17'), linewidth=1, linetype='dashed') +
  # geom_step(data=EUR_two_epoch_demography_18, aes(EUR_two_epoch_Time_18, EUR_two_epoch_NEffective_18, color='N=18'), linewidth=1, linetype='dashed') +
  # geom_step(data=EUR_two_epoch_demography_19, aes(EUR_two_epoch_Time_19, EUR_two_epoch_NEffective_19, color='N=19'), linewidth=1, linetype='dashed') +
  # geom_step(data=EUR_three_epoch_demography_10, aes(EUR_three_epoch_Time_10, EUR_three_epoch_NEffective_10, color='N=10'), linewidth=1, linetype='solid') +
  # geom_step(data=EUR_three_epoch_demography_11, aes(EUR_three_epoch_Time_11, EUR_three_epoch_NEffective_11, color='N=11'), linewidth=1, linetype='solid') +
  # geom_step(data=EUR_three_epoch_demography_12, aes(EUR_three_epoch_Time_12, EUR_three_epoch_NEffective_12, color='N=12'), linewidth=1, linetype='solid') +
  # geom_step(data=EUR_three_epoch_demography_13, aes(EUR_three_epoch_Time_13, EUR_three_epoch_NEffective_13, color='N=13'), linewidth=1, linetype='solid') +
  # geom_step(data=EUR_three_epoch_demography_14, aes(EUR_three_epoch_Time_14, EUR_three_epoch_NEffective_14, color='N=14'), linewidth=1, linetype='solid') +
  # geom_step(data=EUR_three_epoch_demography_15, aes(EUR_three_epoch_Time_15, EUR_three_epoch_NEffective_15, color='N=15'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_16, aes(EUR_three_epoch_Time_16, EUR_three_epoch_NEffective_16, color='N=16'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_17, aes(EUR_three_epoch_Time_17, EUR_three_epoch_NEffective_17, color='N=17'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_18, aes(EUR_three_epoch_Time_18, EUR_three_epoch_NEffective_18, color='N=18'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_19, aes(EUR_three_epoch_Time_19, EUR_three_epoch_NEffective_19, color='N=19'), linewidth=1, linetype='solid') +
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
  ggtitle('1KG EUR Best-fitting Demography (N=10-19:1)')

ggplot(EUR_three_epoch_demography_10, aes(EUR_three_epoch_Time_10, EUR_three_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='solid') + 
  geom_step(data=EUR_three_epoch_demography_11, aes(EUR_three_epoch_Time_11, EUR_three_epoch_NEffective_11, color='N=11'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_12, aes(EUR_three_epoch_Time_12, EUR_three_epoch_NEffective_12, color='N=12'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_13, aes(EUR_three_epoch_Time_13, EUR_three_epoch_NEffective_13, color='N=13'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_14, aes(EUR_three_epoch_Time_14, EUR_three_epoch_NEffective_14, color='N=14'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_15, aes(EUR_three_epoch_Time_15, EUR_three_epoch_NEffective_15, color='N=15'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_16, aes(EUR_three_epoch_Time_16, EUR_three_epoch_NEffective_16, color='N=16'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_17, aes(EUR_three_epoch_Time_17, EUR_three_epoch_NEffective_17, color='N=17'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_18, aes(EUR_three_epoch_Time_18, EUR_three_epoch_NEffective_18, color='N=18'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_19, aes(EUR_three_epoch_Time_19, EUR_three_epoch_NEffective_19, color='N=19'), linewidth=1, linetype='solid') +
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
  ggtitle('1KG EUR Three Epoch Demography (N=10-19:1)')

# ggplot(EUR_three_epoch_demography_11, aes(EUR_three_epoch_Time_11, EUR_three_epoch_NEffective_11)) + geom_step(color='#b35806', linewidth=1, linetype='solid') + 
#   # geom_step(data=EUR_three_epoch_demography_11, aes(EUR_three_epoch_Time_11, EUR_three_epoch_NEffective_11), color='#b35806', linewidth=1, linetype='solid') +
#   geom_step(data=EUR_three_epoch_demography_12, aes(EUR_three_epoch_Time_12, EUR_three_epoch_NEffective_12), color='#e08214', linewidth=1, linetype='solid') +
#   geom_step(data=EUR_three_epoch_demography_13, aes(EUR_three_epoch_Time_13, EUR_three_epoch_NEffective_13), color='#fdb863', linewidth=1, linetype='solid') +
#   geom_step(data=EUR_three_epoch_demography_14, aes(EUR_three_epoch_Time_14, EUR_three_epoch_NEffective_14), color='#fee0b6', linewidth=1, linetype='solid') +
#   geom_step(data=EUR_three_epoch_demography_15, aes(EUR_three_epoch_Time_15, EUR_three_epoch_NEffective_15), color='#d8daeb', linewidth=1, linetype='solid') +
#   geom_step(data=EUR_three_epoch_demography_16, aes(EUR_three_epoch_Time_16, EUR_three_epoch_NEffective_16), color='#b2abd2', linewidth=1, linetype='solid') +
#   geom_step(data=EUR_three_epoch_demography_17, aes(EUR_three_epoch_Time_17, EUR_three_epoch_NEffective_17), color='#8073ac', linewidth=1, linetype='solid') +
#   geom_step(data=EUR_three_epoch_demography_18, aes(EUR_three_epoch_Time_18, EUR_three_epoch_NEffective_18), color='#542788', linewidth=1, linetype='solid') +
#   geom_step(data=EUR_three_epoch_demography_19, aes(EUR_three_epoch_Time_19, EUR_three_epoch_NEffective_19), color='#2d004b', linewidth=1, linetype='solid') +
#   theme_bw() +
#   ylab('Effective Population Size') +
#   xlab('Time in Years') +
#   ggtitle('1KG EUR Three Epoch Demography (N=10-19:1)')

# NAnc Estimate by Sample Size
sample_size = c(10, 11, 12, 13, 14, 15, 16, 17, 18, 19)

NAnc_df = data.frame(sample_size, EUR_one_epoch_NAnc, EUR_two_epoch_NAnc, EUR_three_epoch_NAnc)
NAnc_df = melt(NAnc_df, id='sample_size')

ggplot(data=NAnc_df, aes(x=sample_size, y=value, color=variable)) + geom_line() +
  xlab('Sample size') +
  ylab('Estimated ancestral effective population size') +
  ggtitle('1KG EUR NAnc by sample size (N=10-19:1)') +
  theme_bw() +
  guides(color=guide_legend(title="Epoch")) +
  scale_color_manual(
    labels=c('One-epoch', 'Two-epoch', 'Three-epoch'),
    values=c('red', 'blue', 'green')) +
  geom_hline(yintercept=12378, color='black', linetype='dashed') +
  scale_x_continuous(breaks=sample_size)

# # 1KG_EUR 10-100:10
EUR_empirical_file_list = list()
EUR_one_epoch_file_list = list()
EUR_two_epoch_file_list = list()
EUR_three_epoch_file_list = list()
EUR_one_epoch_AIC = c()
EUR_one_epoch_LL = c()
EUR_one_epoch_theta = c()
EUR_one_epoch_allele_sum = 8058343
EUR_two_epoch_AIC = c()
EUR_two_epoch_LL = c()
EUR_two_epoch_theta = c()
EUR_two_epoch_nu = c()
EUR_two_epoch_tau = c()
EUR_two_epoch_allele_sum = 8058343
EUR_three_epoch_AIC = c()
EUR_three_epoch_LL = c()
EUR_three_epoch_theta = c()
EUR_three_epoch_nuB = c()
EUR_three_epoch_nuF = c()
EUR_three_epoch_tauB = c()
EUR_three_epoch_tauF = c()
EUR_three_epoch_allele_sum = 8058343

# Loop through subdirectories and get relevant files
for (i in seq(10, 100, by = 10)) {
  subdirectory <- paste0("../Analysis/1kg_EUR_", i)
  EUR_empirical_file_path <- file.path(subdirectory, "syn_downsampled_sfs.txt")
  EUR_one_epoch_file_path <- file.path(subdirectory, "one_epoch_demography.txt")
  EUR_two_epoch_file_path <- file.path(subdirectory, "two_epoch_demography.txt")
  EUR_three_epoch_file_path <- file.path(subdirectory, "three_epoch_demography.txt")
  
  # Check if the file exists before attempting to read and print its contents
  if (file.exists(EUR_empirical_file_path)) {
    this_empirical_sfs = read_input_sfs(EUR_empirical_file_path)
    EUR_empirical_file_list[[subdirectory]] = this_empirical_sfs
  }
  if (file.exists(EUR_one_epoch_file_path)) {
    this_one_epoch_sfs = sfs_from_demography(EUR_one_epoch_file_path)
    EUR_one_epoch_file_list[[subdirectory]] = this_one_epoch_sfs
    EUR_one_epoch_AIC = c(EUR_one_epoch_AIC, AIC_from_demography(EUR_one_epoch_file_path))
    EUR_one_epoch_LL = c(EUR_one_epoch_LL, LL_from_demography(EUR_one_epoch_file_path))
    EUR_one_epoch_theta = c(EUR_one_epoch_theta, theta_from_demography(EUR_one_epoch_file_path))
    # EUR_one_epoch_allele_sum = c(EUR_one_epoch_allele_sum, sum(this_one_epoch_sfs))
  }
  if (file.exists(EUR_two_epoch_file_path)) {
    this_two_epoch_sfs = sfs_from_demography(EUR_two_epoch_file_path)
    EUR_two_epoch_file_list[[subdirectory]] = this_two_epoch_sfs
    EUR_two_epoch_AIC = c(EUR_two_epoch_AIC, AIC_from_demography(EUR_two_epoch_file_path))
    EUR_two_epoch_LL = c(EUR_two_epoch_LL, LL_from_demography(EUR_two_epoch_file_path))
    EUR_two_epoch_theta = c(EUR_two_epoch_theta, theta_from_demography(EUR_two_epoch_file_path))
    EUR_two_epoch_nu = c(EUR_two_epoch_nu, nu_from_demography(EUR_two_epoch_file_path))
    EUR_two_epoch_tau = c(EUR_two_epoch_tau, tau_from_demography(EUR_two_epoch_file_path))
    # EUR_two_epoch_allele_sum = c(EUR_two_epoch_allele_sum, sum(this_two_epoch_sfs))
  }
  if (file.exists(EUR_three_epoch_file_path)) {
    this_three_epoch_sfs = sfs_from_demography(EUR_three_epoch_file_path)
    EUR_three_epoch_file_list[[subdirectory]] = this_three_epoch_sfs
    EUR_three_epoch_AIC = c(EUR_three_epoch_AIC, AIC_from_demography(EUR_three_epoch_file_path))
    EUR_three_epoch_LL = c(EUR_three_epoch_LL, LL_from_demography(EUR_three_epoch_file_path))
    EUR_three_epoch_theta = c(EUR_three_epoch_theta, theta_from_demography(EUR_three_epoch_file_path))
    EUR_three_epoch_nuB = c(EUR_three_epoch_nuB, nuB_from_demography(EUR_three_epoch_file_path))
    EUR_three_epoch_nuF = c(EUR_three_epoch_nuF, nuF_from_demography(EUR_three_epoch_file_path))
    EUR_three_epoch_tauB = c(EUR_three_epoch_tauB, tauB_from_demography(EUR_three_epoch_file_path))
    EUR_three_epoch_tauF = c(EUR_three_epoch_tauF, tauF_from_demography(EUR_three_epoch_file_path))
    # EUR_three_epoch_allele_sum = c(EUR_three_epoch_allele_sum, sum(this_three_epoch_sfs))
  }  
}

EUR_AIC_df = data.frame(EUR_one_epoch_AIC, EUR_two_epoch_AIC, EUR_three_epoch_AIC)
# Reshape the data from wide to long format
EUR_df_long <- tidyr::gather(EUR_AIC_df, key = "Epoch", value = "AIC", EUR_one_epoch_AIC:EUR_three_epoch_AIC)

# Increase the x-axis index by 4
EUR_df_long$Index <- rep(seq(10, 100, by = 10), times = 3)

# Create the line plot with ggplot2
ggplot(EUR_df_long, aes(x = Index, y = AIC, color = Epoch)) +
  geom_line() +
  geom_point() +
  labs(title = "1KG EUR AIC values by sample size",
       x = "Sample Size",
       y = "AIC") +
  scale_y_log10() +
  scale_x_continuous(breaks=EUR_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('One-epoch', 'Three-epoch', 'Two-epoch')) +
  theme_bw()

EUR_lambda_two_one = 2 * (EUR_two_epoch_LL - EUR_one_epoch_LL)
EUR_lambda_three_one = 2 * (EUR_three_epoch_LL - EUR_one_epoch_LL)
EUR_lambda_three_two = 2 * (EUR_three_epoch_LL - EUR_two_epoch_LL)

EUR_lambda_df = data.frame(EUR_lambda_two_one, EUR_lambda_three_one, EUR_lambda_three_two)
# Reshape the data from wide to long format
EUR_df_long_lambda <- tidyr::gather(EUR_lambda_df, key = "Full_vs_Null", value = "Lambda", EUR_lambda_two_one:EUR_lambda_three_two)
# Increase the x-axis index by 4
EUR_df_long_lambda$Index <- rep(seq(10, 100, by = 10), times = 3)

# Create the line plot with ggplot2
ggplot(EUR_df_long_lambda, aes(x = Index, y = Lambda, color = Full_vs_Null)) +
  geom_line() +
  geom_point() +
  labs(title = "1KG EUR Lambda values by sample size (N=10-100:10)",
       x = "Sample Size",
       y = "2 * Lambda") +
  # scale_y_log10() +
  scale_x_continuous(breaks=EUR_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('Three vs. One', 'Three vs. Two', 'Two vs. One')) +
  theme_bw()

EUR_one_epoch_residual = c()
EUR_two_epoch_residual = c()
EUR_three_epoch_residual = c()

for (i in 1:10) {
  EUR_one_epoch_residual = c(EUR_one_epoch_residual, compute_residual(unlist(EUR_empirical_file_list[i]), unlist(EUR_one_epoch_file_list[i])))
  EUR_two_epoch_residual = c(EUR_two_epoch_residual, compute_residual(unlist(EUR_empirical_file_list[i]), unlist(EUR_two_epoch_file_list[i])))
  EUR_three_epoch_residual = c(EUR_three_epoch_residual, compute_residual(unlist(EUR_empirical_file_list[i]), unlist(EUR_three_epoch_file_list[i])))
}

EUR_residual_df = data.frame(EUR_one_epoch_residual, EUR_two_epoch_residual, EUR_three_epoch_residual)
# Reshape the data from wide to long format
EUR_df_long_residual <- tidyr::gather(EUR_residual_df, key = "Epoch", value = "residual", EUR_one_epoch_residual:EUR_three_epoch_residual)

# Increase the x-axis index by 4
EUR_df_long_residual$Index <- rep(seq(10, 100, by = 10), times = 3)

# Create the line plot with ggplot2
ggplot(EUR_df_long_residual, aes(x = Index, y = residual, color = Epoch)) +
  geom_line() +
  geom_point() +
  labs(title = "EUR residual values by sample size",
       x = "Sample Size",
       y = "Residual") +
  scale_y_log10() +
  scale_x_continuous(breaks=EUR_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('One-epoch', 'Three-epoch', 'Two-epoch')) +
  theme_bw()

ggplot(EUR_df_long, aes(x = Index, y = AIC, color = Epoch)) +
  geom_line(linetype=3) +
  geom_point() +
  labs(title = "1KG EUR AIC and residual by sample size (N=10-100:10)",
       x = "Sample Size",
       y = "AIC") +
  scale_y_log10(sec.axis = sec_axis(~.*1, name="Residual")) +
  scale_x_continuous(breaks=EUR_df_long$Index) +
  geom_line(data=EUR_df_long_residual, aes(x = Index, y = residual*1, color = Epoch)) +
  scale_color_manual(values = c("blue", "orange", "green", "violet", "red", "seagreen"),
    label=c('One-epoch AIC', 'One-epoch residual',
      'Three-epoch AIC', 'Three-epoch residual',
      'Two-epoch AIC', 'Two-epoch residual')) +
  theme_bw()

# 1KG_EUR population genetic constants

EUR_mu = 1.5E-8

# NAnc = theta / (4 * allele_sum * mu)
# generations = 2 * tau * theta / (4 * mu * allele_sum)
# years = generations / 365
# NCurr = nu * NAnc
# generations_b = 2 * tauB * theta / (4 * mu * allele_sum)
# generations_f = 2 * tauF * theta / (4 * mu * allele_sum)
# NBottle = nuB * NAnc
# NSince = nuF * NAnc

EUR_one_epoch_NAnc = EUR_one_epoch_theta / (4 * EUR_one_epoch_allele_sum * EUR_mu)
EUR_two_epoch_NAnc = EUR_two_epoch_theta / (4 * EUR_two_epoch_allele_sum * EUR_mu)
EUR_two_epoch_NCurr = EUR_two_epoch_nu * EUR_two_epoch_NAnc
EUR_two_epoch_Time = 2 * 25 * EUR_two_epoch_tau * EUR_two_epoch_theta / (4 * EUR_mu * EUR_two_epoch_allele_sum)
EUR_three_epoch_NAnc = EUR_three_epoch_theta / (4 * EUR_three_epoch_allele_sum * EUR_mu)
EUR_three_epoch_NBottle = EUR_three_epoch_nuB * EUR_three_epoch_NAnc
EUR_three_epoch_NCurr = EUR_three_epoch_nuF * EUR_three_epoch_NAnc
EUR_three_epoch_TimeBottleEnd = 2 * 25 * EUR_three_epoch_tauF * EUR_three_epoch_theta / (4 * EUR_mu * EUR_three_epoch_allele_sum)
EUR_three_epoch_TimeBottleStart = 2 * 25 * EUR_three_epoch_tauB * EUR_three_epoch_theta / (4 * EUR_mu * EUR_three_epoch_allele_sum) + EUR_three_epoch_TimeBottleEnd
EUR_three_epoch_TimeTotal = EUR_three_epoch_TimeBottleStart + EUR_three_epoch_TimeBottleEnd

EUR_two_epoch_max_time = rep(2E6, 10)
# EUR_two_epoch_max_time = rep(2E4, 10)
EUR_two_epoch_current_time = rep(0, 10)
EUR_two_epoch_demography = data.frame(EUR_two_epoch_NAnc, EUR_two_epoch_max_time, 
  EUR_two_epoch_NCurr, EUR_two_epoch_Time, 
  EUR_two_epoch_NCurr, EUR_two_epoch_current_time)

# EUR_three_epoch_max_time = rep(100000000, 10)
# EUR_three_epoch_max_time = rep(5E6, 10)
EUR_three_epoch_max_time = rep(2E6, 10)
EUR_three_epoch_current_time = rep(0, 10)
EUR_three_epoch_demography = data.frame(EUR_three_epoch_NAnc, EUR_three_epoch_max_time,
  EUR_three_epoch_NBottle, EUR_three_epoch_TimeBottleStart,
  EUR_three_epoch_NCurr, EUR_three_epoch_TimeBottleEnd,
  EUR_three_epoch_NCurr, EUR_three_epoch_current_time)

EUR_two_epoch_NEffective_10 = c(EUR_two_epoch_demography[1, 1], EUR_two_epoch_demography[1, 3], EUR_two_epoch_demography[1, 5])
EUR_two_epoch_Time_10 = c(-EUR_two_epoch_demography[1, 2], -EUR_two_epoch_demography[1, 4], EUR_two_epoch_demography[1, 6])
EUR_two_epoch_demography_10 = data.frame(EUR_two_epoch_Time_10, EUR_two_epoch_NEffective_10)
EUR_two_epoch_NEffective_20 = c(EUR_two_epoch_demography[2, 1], EUR_two_epoch_demography[2, 3], EUR_two_epoch_demography[2, 5])
EUR_two_epoch_Time_20 = c(-EUR_two_epoch_demography[2, 2], -EUR_two_epoch_demography[2, 4], EUR_two_epoch_demography[2, 6])
EUR_two_epoch_demography_20 = data.frame(EUR_two_epoch_Time_20, EUR_two_epoch_NEffective_20)
EUR_two_epoch_NEffective_30 = c(EUR_two_epoch_demography[3, 1], EUR_two_epoch_demography[3, 3], EUR_two_epoch_demography[3, 5])
EUR_two_epoch_Time_30 = c(-EUR_two_epoch_demography[3, 2], -EUR_two_epoch_demography[3, 4], EUR_two_epoch_demography[3, 6])
EUR_two_epoch_demography_30 = data.frame(EUR_two_epoch_Time_30, EUR_two_epoch_NEffective_30)
EUR_two_epoch_NEffective_40 = c(EUR_two_epoch_demography[4, 1], EUR_two_epoch_demography[4, 3], EUR_two_epoch_demography[4, 5])
EUR_two_epoch_Time_40 = c(-EUR_two_epoch_demography[4, 2], -EUR_two_epoch_demography[4, 4], EUR_two_epoch_demography[4, 6])
EUR_two_epoch_demography_40 = data.frame(EUR_two_epoch_Time_40, EUR_two_epoch_NEffective_40)
EUR_two_epoch_NEffective_50 = c(EUR_two_epoch_demography[5, 1], EUR_two_epoch_demography[5, 3], EUR_two_epoch_demography[5, 5])
EUR_two_epoch_Time_50 = c(-EUR_two_epoch_demography[5, 2], -EUR_two_epoch_demography[5, 4], EUR_two_epoch_demography[5, 6])
EUR_two_epoch_demography_50 = data.frame(EUR_two_epoch_Time_50, EUR_two_epoch_NEffective_50)
EUR_two_epoch_NEffective_60 = c(EUR_two_epoch_demography[6, 1], EUR_two_epoch_demography[6, 3], EUR_two_epoch_demography[6, 5])
EUR_two_epoch_Time_60 = c(-EUR_two_epoch_demography[6, 2], -EUR_two_epoch_demography[6, 4], EUR_two_epoch_demography[6, 6])
EUR_two_epoch_demography_60 = data.frame(EUR_two_epoch_Time_60, EUR_two_epoch_NEffective_60)
EUR_two_epoch_NEffective_70 = c(EUR_two_epoch_demography[7, 1], EUR_two_epoch_demography[7, 3], EUR_two_epoch_demography[7, 5])
EUR_two_epoch_Time_70 = c(-EUR_two_epoch_demography[7, 2], -EUR_two_epoch_demography[7, 4], EUR_two_epoch_demography[7, 6])
EUR_two_epoch_demography_70 = data.frame(EUR_two_epoch_Time_70, EUR_two_epoch_NEffective_70)
EUR_two_epoch_NEffective_80 = c(EUR_two_epoch_demography[8, 1], EUR_two_epoch_demography[8, 3], EUR_two_epoch_demography[8, 5])
EUR_two_epoch_Time_80 = c(-EUR_two_epoch_demography[8, 2], -EUR_two_epoch_demography[8, 4], EUR_two_epoch_demography[8, 6])
EUR_two_epoch_demography_80 = data.frame(EUR_two_epoch_Time_80, EUR_two_epoch_NEffective_80)
EUR_two_epoch_NEffective_90 = c(EUR_two_epoch_demography[9, 1], EUR_two_epoch_demography[9, 3], EUR_two_epoch_demography[9, 5])
EUR_two_epoch_Time_90 = c(-EUR_two_epoch_demography[9, 2], -EUR_two_epoch_demography[9, 4], EUR_two_epoch_demography[9, 6])
EUR_two_epoch_demography_90 = data.frame(EUR_two_epoch_Time_90, EUR_two_epoch_NEffective_90)
EUR_two_epoch_NEffective_100 = c(EUR_two_epoch_demography[10, 1], EUR_two_epoch_demography[10, 3], EUR_two_epoch_demography[10, 5])
EUR_two_epoch_Time_100 = c(-EUR_two_epoch_demography[10, 2], -EUR_two_epoch_demography[10, 4], EUR_two_epoch_demography[10, 6])
EUR_two_epoch_demography_100 = data.frame(EUR_two_epoch_Time_100, EUR_two_epoch_NEffective_100)

EUR_three_epoch_NEffective_10 = c(EUR_three_epoch_demography[1, 1], EUR_three_epoch_demography[1, 3], EUR_three_epoch_demography[1, 5], EUR_three_epoch_demography[1, 7])
EUR_three_epoch_Time_10 = c(-EUR_three_epoch_demography[1, 2], -EUR_three_epoch_demography[1, 4], -EUR_three_epoch_demography[1, 6], EUR_three_epoch_demography[1, 8])
EUR_three_epoch_demography_10 = data.frame(EUR_three_epoch_Time_10, EUR_three_epoch_NEffective_10)
EUR_three_epoch_NEffective_20 = c(EUR_three_epoch_demography[2, 1], EUR_three_epoch_demography[2, 3], EUR_three_epoch_demography[2, 5], EUR_three_epoch_demography[2, 7])
EUR_three_epoch_Time_20 = c(-EUR_three_epoch_demography[2, 2], -EUR_three_epoch_demography[2, 4], -EUR_three_epoch_demography[2, 6], EUR_three_epoch_demography[2, 8])
EUR_three_epoch_demography_20 = data.frame(EUR_three_epoch_Time_20, EUR_three_epoch_NEffective_20)
EUR_three_epoch_NEffective_30 = c(EUR_three_epoch_demography[3, 1], EUR_three_epoch_demography[3, 3], EUR_three_epoch_demography[3, 5], EUR_three_epoch_demography[3, 7])
EUR_three_epoch_Time_30 = c(-EUR_three_epoch_demography[3, 2], -EUR_three_epoch_demography[3, 4], -EUR_three_epoch_demography[3, 6], EUR_three_epoch_demography[3, 8])
EUR_three_epoch_demography_30 = data.frame(EUR_three_epoch_Time_30, EUR_three_epoch_NEffective_30)
EUR_three_epoch_NEffective_40 = c(EUR_three_epoch_demography[4, 1], EUR_three_epoch_demography[4, 3], EUR_three_epoch_demography[4, 5], EUR_three_epoch_demography[4, 7])
EUR_three_epoch_Time_40 = c(-EUR_three_epoch_demography[4, 2], -EUR_three_epoch_demography[4, 4], -EUR_three_epoch_demography[4, 6], EUR_three_epoch_demography[4, 8])
EUR_three_epoch_demography_40 = data.frame(EUR_three_epoch_Time_40, EUR_three_epoch_NEffective_40)
EUR_three_epoch_NEffective_50 = c(EUR_three_epoch_demography[5, 1], EUR_three_epoch_demography[5, 3], EUR_three_epoch_demography[5, 5], EUR_three_epoch_demography[5, 7])
EUR_three_epoch_Time_50 = c(-EUR_three_epoch_demography[5, 2], -EUR_three_epoch_demography[5, 4], -EUR_three_epoch_demography[5, 6], EUR_three_epoch_demography[5, 8])
EUR_three_epoch_demography_50 = data.frame(EUR_three_epoch_Time_50, EUR_three_epoch_NEffective_50)
EUR_three_epoch_NEffective_60 = c(EUR_three_epoch_demography[6, 1], EUR_three_epoch_demography[6, 3], EUR_three_epoch_demography[6, 5], EUR_three_epoch_demography[6, 7])
EUR_three_epoch_Time_60 = c(-EUR_three_epoch_demography[6, 2], -EUR_three_epoch_demography[6, 4], -EUR_three_epoch_demography[6, 6], EUR_three_epoch_demography[6, 8])
EUR_three_epoch_demography_60 = data.frame(EUR_three_epoch_Time_60, EUR_three_epoch_NEffective_60)
EUR_three_epoch_NEffective_70 = c(EUR_three_epoch_demography[7, 1], EUR_three_epoch_demography[7, 3], EUR_three_epoch_demography[7, 5], EUR_three_epoch_demography[7, 7])
EUR_three_epoch_Time_70 = c(-EUR_three_epoch_demography[7, 2], -EUR_three_epoch_demography[7, 4], -EUR_three_epoch_demography[7, 6], EUR_three_epoch_demography[7, 8])
EUR_three_epoch_demography_70 = data.frame(EUR_three_epoch_Time_70, EUR_three_epoch_NEffective_70)
EUR_three_epoch_NEffective_80 = c(EUR_three_epoch_demography[8, 1], EUR_three_epoch_demography[8, 3], EUR_three_epoch_demography[8, 5], EUR_three_epoch_demography[8, 7])
EUR_three_epoch_Time_80 = c(-EUR_three_epoch_demography[8, 2], -EUR_three_epoch_demography[8, 4], -EUR_three_epoch_demography[8, 6], EUR_three_epoch_demography[8, 8])
EUR_three_epoch_demography_80 = data.frame(EUR_three_epoch_Time_80, EUR_three_epoch_NEffective_80)
EUR_three_epoch_NEffective_90 = c(EUR_three_epoch_demography[9, 1], EUR_three_epoch_demography[9, 3], EUR_three_epoch_demography[9, 5], EUR_three_epoch_demography[9, 7])
EUR_three_epoch_Time_90 = c(-EUR_three_epoch_demography[9, 2], -EUR_three_epoch_demography[9, 4], -EUR_three_epoch_demography[9, 6], EUR_three_epoch_demography[9, 8])
EUR_three_epoch_demography_90 = data.frame(EUR_three_epoch_Time_90, EUR_three_epoch_NEffective_90)
EUR_three_epoch_NEffective_100 = c(EUR_three_epoch_demography[10, 1], EUR_three_epoch_demography[10, 3], EUR_three_epoch_demography[10, 5], EUR_three_epoch_demography[10, 7])
EUR_three_epoch_Time_100 = c(-EUR_three_epoch_demography[10, 2], -EUR_three_epoch_demography[10, 4], -EUR_three_epoch_demography[10, 6], EUR_three_epoch_demography[10, 8])
EUR_three_epoch_demography_100 = data.frame(EUR_three_epoch_Time_100, EUR_three_epoch_NEffective_100)

ggplot(EUR_two_epoch_demography_10, aes(EUR_two_epoch_Time_10, EUR_two_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='dotted') + 
  geom_step(data=EUR_two_epoch_demography_20, aes(EUR_two_epoch_Time_20, EUR_two_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='dotted') +
  geom_step(data=EUR_two_epoch_demography_30, aes(EUR_two_epoch_Time_30, EUR_two_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='dotted') +
  geom_step(data=EUR_two_epoch_demography_40, aes(EUR_two_epoch_Time_40, EUR_two_epoch_NEffective_40, color='N=40'), linewidth=1, linetype='dotted') +
  geom_step(data=EUR_two_epoch_demography_50, aes(EUR_two_epoch_Time_50, EUR_two_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='dotted') +
  geom_step(data=EUR_two_epoch_demography_60, aes(EUR_two_epoch_Time_60, EUR_two_epoch_NEffective_60, color='N=60'), linewidth=1, linetype='dotted') +
  geom_step(data=EUR_two_epoch_demography_70, aes(EUR_two_epoch_Time_70, EUR_two_epoch_NEffective_70, color='N=70'), linewidth=1, linetype='dotted') +
  geom_step(data=EUR_two_epoch_demography_80, aes(EUR_two_epoch_Time_80, EUR_two_epoch_NEffective_80, color='N=80'), linewidth=1, linetype='dotted') +
  geom_step(data=EUR_two_epoch_demography_90, aes(EUR_two_epoch_Time_90, EUR_two_epoch_NEffective_90, color='N=90'), linewidth=1, linetype='dotted') +
  geom_step(data=EUR_two_epoch_demography_100, aes(EUR_two_epoch_Time_100, EUR_two_epoch_NEffective_100, color='N=100'), linewidth=1, linetype='dotted') +
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
  ggtitle('1KG EUR two Epoch Demography (N=10-100:10)')

ggplot(EUR_two_epoch_demography_10, aes(EUR_two_epoch_Time_10, EUR_two_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='dashed') + 
  # geom_step(data=EUR_two_epoch_demography_20, aes(EUR_two_epoch_Time_20, EUR_two_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='dashed') +
  # geom_step(data=EUR_two_epoch_demography_30, aes(EUR_two_epoch_Time_30, EUR_two_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='dashed') +
  # geom_step(data=EUR_two_epoch_demography_40, aes(EUR_two_epoch_Time_40, EUR_two_epoch_NEffective_40, color='N=40'), linewidth=1, linetype='dashed') +
  # geom_step(data=EUR_two_epoch_demography_50, aes(EUR_two_epoch_Time_50, EUR_two_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='dashed') +
  # geom_step(data=EUR_two_epoch_demography_60, aes(EUR_two_epoch_Time_60, EUR_two_epoch_NEffective_60, color='N=60'), linewidth=1, linetype='dashed') +
  # geom_step(data=EUR_two_epoch_demography_70, aes(EUR_two_epoch_Time_70, EUR_two_epoch_NEffective_70, color='N=70'), linewidth=1, linetype='dashed') +
  # geom_step(data=EUR_two_epoch_demography_80, aes(EUR_two_epoch_Time_80, EUR_two_epoch_NEffective_80, color='N=80'), linewidth=1, linetype='dashed') +
  # geom_step(data=EUR_two_epoch_demography_90, aes(EUR_two_epoch_Time_90, EUR_two_epoch_NEffective_90, color='N=90'), linewidth=1, linetype='dashed') +
  # geom_step(data=EUR_two_epoch_demography_100, aes(EUR_two_epoch_Time_100, EUR_two_epoch_NEffective_100, color='#N=100'), linewidth=1, linetype='dashed') +
  # geom_step(data=EUR_three_epoch_demography_10, aes(EUR_three_epoch_Time_10, EUR_three_epoch_NEffective_10, color='N=10'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_20, aes(EUR_three_epoch_Time_20, EUR_three_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_30, aes(EUR_three_epoch_Time_30, EUR_three_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_40, aes(EUR_three_epoch_Time_40, EUR_three_epoch_NEffective_40, color='N=40'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_50, aes(EUR_three_epoch_Time_50, EUR_three_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_60, aes(EUR_three_epoch_Time_60, EUR_three_epoch_NEffective_60, color='N=60'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_70, aes(EUR_three_epoch_Time_70, EUR_three_epoch_NEffective_70, color='N=70'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_80, aes(EUR_three_epoch_Time_80, EUR_three_epoch_NEffective_80, color='N=80'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_90, aes(EUR_three_epoch_Time_90, EUR_three_epoch_NEffective_90, color='N=90'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_100, aes(EUR_three_epoch_Time_100, EUR_three_epoch_NEffective_100, color='N=100'), linewidth=1, linetype='solid') +
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
  ggtitle('1KG EUR Best-fitting Demography (N=10-100:10)')

ggplot(EUR_three_epoch_demography_10, aes(EUR_three_epoch_Time_10, EUR_three_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='solid') + 
  geom_step(data=EUR_three_epoch_demography_20, aes(EUR_three_epoch_Time_20, EUR_three_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_30, aes(EUR_three_epoch_Time_30, EUR_three_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_40, aes(EUR_three_epoch_Time_40, EUR_three_epoch_NEffective_40, color='N=40'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_50, aes(EUR_three_epoch_Time_50, EUR_three_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_60, aes(EUR_three_epoch_Time_60, EUR_three_epoch_NEffective_60, color='N=60'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_70, aes(EUR_three_epoch_Time_70, EUR_three_epoch_NEffective_70, color='N=70'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_80, aes(EUR_three_epoch_Time_80, EUR_three_epoch_NEffective_80, color='N=80'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_90, aes(EUR_three_epoch_Time_90, EUR_three_epoch_NEffective_90, color='N=90'), linewidth=1, linetype='solid') +
  geom_step(data=EUR_three_epoch_demography_100, aes(EUR_three_epoch_Time_100, EUR_three_epoch_NEffective_100, color='N=100'), linewidth=1, linetype='solid') +
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
  ggtitle('1KG EUR Three Epoch Demography (N=10-100:10)')

# ggplot(EUR_three_epoch_demography_20, aes(EUR_three_epoch_Time_20, EUR_three_epoch_NEffective_20color='#b35806')) + geom_step(linewidth=1, linetype='solid') + 
#   # geom_step(data=EUR_three_epoch_demography_20, aes(EUR_three_epoch_Time_20, EUR_three_epoch_NEffective_20, color='#b35806'), linewidth=1, linetype='solid') +
#   geom_step(data=EUR_three_epoch_demography_30, aes(EUR_three_epoch_Time_30, EUR_three_epoch_NEffective_30, color='#e08214'), linewidth=1, linetype='solid') +
#   geom_step(data=EUR_three_epoch_demography_40, aes(EUR_three_epoch_Time_40, EUR_three_epoch_NEffective_40, color='#fdb863'), linewidth=1, linetype='solid') +
#   geom_step(data=EUR_three_epoch_demography_50, aes(EUR_three_epoch_Time_50, EUR_three_epoch_NEffective_50, color='#fee0b6'), linewidth=1, linetype='solid') +
#   geom_step(data=EUR_three_epoch_demography_60, aes(EUR_three_epoch_Time_60, EUR_three_epoch_NEffective_60, color='#d8daeb'), linewidth=1, linetype='solid') +
#   geom_step(data=EUR_three_epoch_demography_70, aes(EUR_three_epoch_Time_70, EUR_three_epoch_NEffective_70, color='#b2abd2'), linewidth=1, linetype='solid') +
#   geom_step(data=EUR_three_epoch_demography_80, aes(EUR_three_epoch_Time_80, EUR_three_epoch_NEffective_80, color='#8073ac'), linewidth=1, linetype='solid') +
#   geom_step(data=EUR_three_epoch_demography_90, aes(EUR_three_epoch_Time_90, EUR_three_epoch_NEffective_90, color='#542788'), linewidth=1, linetype='solid') +
#   geom_step(data=EUR_three_epoch_demography_100, aes(EUR_three_epoch_Time_100, EUR_three_epoch_NEffective_100, color='#2d004b'), linewidth=1, linetype='solid') +
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
#   ggtitle('1KG EUR Three Epoch Demography, 10-100:10')

# NAnc Estimate by Sample Size
sample_size = c(10, 20, 30, 40, 50, 60, 70, 80, 90, 100)

NAnc_df = data.frame(sample_size, EUR_one_epoch_NAnc, EUR_two_epoch_NAnc, EUR_three_epoch_NAnc)
NAnc_df = melt(NAnc_df, id='sample_size')

ggplot(data=NAnc_df, aes(x=sample_size, y=value, color=variable)) + geom_line() +
  xlab('Sample size') +
  ylab('Estimated ancestral effective population size') +
  ggtitle('1KG EUR NAnc by sample size (N=10-100:10)') +
  theme_bw() +
  guides(color=guide_legend(title="Epoch")) +
  scale_color_manual(
    labels=c('One-epoch', 'Two-epoch', 'Three-epoch'),
    values=c('red', 'blue', 'green')) +
  geom_hline(yintercept=12378, color='black', linetype='dashed') +
  scale_x_continuous(breaks=sample_size)

