## Tennessen simulation

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

# # Tennessen_3EpE 10-800:80
# ThreeEpochE_empirical_file_list = list()
# ThreeEpochE_one_epoch_file_list = list()
# ThreeEpochE_two_epoch_file_list = list()
# ThreeEpochE_three_epoch_file_list = list()
# ThreeEpochE_one_epoch_AIC = c()
# ThreeEpochE_one_epoch_LL = c()
# ThreeEpochE_one_epoch_theta = c()
# ThreeEpochE_one_epoch_allele_sum = c()
# ThreeEpochE_two_epoch_AIC = c()
# ThreeEpochE_two_epoch_LL = c()
# ThreeEpochE_two_epoch_theta = c()
# ThreeEpochE_two_epoch_nu = c()
# ThreeEpochE_two_epoch_tau = c()
# ThreeEpochE_two_epoch_allele_sum = c()
# ThreeEpochE_three_epoch_AIC = c()
# ThreeEpochE_three_epoch_LL = c()
# ThreeEpochE_three_epoch_theta = c()
# ThreeEpochE_three_epoch_nuB = c()
# ThreeEpochE_three_epoch_nuF = c()
# ThreeEpochE_three_epoch_tauB = c()
# ThreeEpochE_three_epoch_tauF = c()
# ThreeEpochE_three_epoch_allele_sum = c()
# 
# # Loop through subdirectories and get relevant files
# for (i in seq(10, 800, by = 80)) {
#   subdirectory <- paste0("../Analysis/ThreeEpochExpansion_", i)
#   ThreeEpochE_empirical_file_path <- file.path(subdirectory, "syn_downsampled_sfs.txt")
#   ThreeEpochE_one_epoch_file_path <- file.path(subdirectory, "one_epoch_demography.txt")
#   ThreeEpochE_two_epoch_file_path <- file.path(subdirectory, "two_epoch_demography.txt")
#   ThreeEpochE_three_epoch_file_path <- file.path(subdirectory, "three_epoch_demography.txt")
#   
#   # Check if the file exists before attempting to read and print its contents
#   if (file.exists(ThreeEpochE_empirical_file_path)) {
#     this_empirical_sfs = read_input_sfs(ThreeEpochE_empirical_file_path)
#     ThreeEpochE_empirical_file_list[[subdirectory]] = this_empirical_sfs
#   }
#   if (file.exists(ThreeEpochE_one_epoch_file_path)) {
#     this_one_epoch_sfs = sfs_from_demography(ThreeEpochE_one_epoch_file_path)
#     ThreeEpochE_one_epoch_file_list[[subdirectory]] = this_one_epoch_sfs
#     ThreeEpochE_one_epoch_AIC = c(ThreeEpochE_one_epoch_AIC, AIC_from_demography(ThreeEpochE_one_epoch_file_path))
#     ThreeEpochE_one_epoch_LL = c(ThreeEpochE_one_epoch_LL, LL_from_demography(ThreeEpochE_one_epoch_file_path))
#     ThreeEpochE_one_epoch_theta = c(ThreeEpochE_one_epoch_theta, theta_from_demography(ThreeEpochE_one_epoch_file_path))
#     ThreeEpochE_one_epoch_allele_sum = c(ThreeEpochE_one_epoch_allele_sum, sum(this_one_epoch_sfs))
#   }
#   if (file.exists(ThreeEpochE_two_epoch_file_path)) {
#     this_two_epoch_sfs = sfs_from_demography(ThreeEpochE_two_epoch_file_path)
#     ThreeEpochE_two_epoch_file_list[[subdirectory]] = this_two_epoch_sfs
#     ThreeEpochE_two_epoch_AIC = c(ThreeEpochE_two_epoch_AIC, AIC_from_demography(ThreeEpochE_two_epoch_file_path))
#     ThreeEpochE_two_epoch_LL = c(ThreeEpochE_two_epoch_LL, LL_from_demography(ThreeEpochE_two_epoch_file_path))
#     ThreeEpochE_two_epoch_theta = c(ThreeEpochE_two_epoch_theta, theta_from_demography(ThreeEpochE_two_epoch_file_path))
#     ThreeEpochE_two_epoch_nu = c(ThreeEpochE_two_epoch_nu, nu_from_demography(ThreeEpochE_two_epoch_file_path))
#     ThreeEpochE_two_epoch_tau = c(ThreeEpochE_two_epoch_tau, tau_from_demography(ThreeEpochE_two_epoch_file_path))
#     ThreeEpochE_two_epoch_allele_sum = c(ThreeEpochE_two_epoch_allele_sum, sum(this_two_epoch_sfs))
#   }
#   if (file.exists(ThreeEpochE_three_epoch_file_path)) {
#     this_three_epoch_sfs = sfs_from_demography(ThreeEpochE_three_epoch_file_path)
#     ThreeEpochE_three_epoch_file_list[[subdirectory]] = this_three_epoch_sfs
#     ThreeEpochE_three_epoch_AIC = c(ThreeEpochE_three_epoch_AIC, AIC_from_demography(ThreeEpochE_three_epoch_file_path))
#     ThreeEpochE_three_epoch_LL = c(ThreeEpochE_three_epoch_LL, LL_from_demography(ThreeEpochE_three_epoch_file_path))
#     ThreeEpochE_three_epoch_theta = c(ThreeEpochE_three_epoch_theta, theta_from_demography(ThreeEpochE_three_epoch_file_path))
#     ThreeEpochE_three_epoch_nuB = c(ThreeEpochE_three_epoch_nuB, nuB_from_demography(ThreeEpochE_three_epoch_file_path))
#     ThreeEpochE_three_epoch_nuF = c(ThreeEpochE_three_epoch_nuF, nuF_from_demography(ThreeEpochE_three_epoch_file_path))
#     ThreeEpochE_three_epoch_tauB = c(ThreeEpochE_three_epoch_tauB, tauB_from_demography(ThreeEpochE_three_epoch_file_path))
#     ThreeEpochE_three_epoch_tauF = c(ThreeEpochE_three_epoch_tauF, tauF_from_demography(ThreeEpochE_three_epoch_file_path))
#     ThreeEpochE_three_epoch_allele_sum = c(ThreeEpochE_three_epoch_allele_sum, sum(this_three_epoch_sfs))
#   }  
# }
# 
# ThreeEpochE_AIC_df = data.frame(ThreeEpochE_one_epoch_AIC, ThreeEpochE_two_epoch_AIC, ThreeEpochE_three_epoch_AIC)
# # Reshape the data from wide to long format
# ThreeEpochE_df_long <- tidyr::gather(ThreeEpochE_AIC_df, key = "Epoch", value = "AIC", ThreeEpochE_one_epoch_AIC:ThreeEpochE_three_epoch_AIC)
# 
# # Increase the x-axis index by 4
# ThreeEpochE_df_long$Index <- rep(seq(10, 800, by = 80), times = 3)
# 
# # Create the line plot with ggplot2
# ggplot(ThreeEpochE_df_long, aes(x = Index, y = AIC, color = Epoch)) +
#   geom_line() +
#   geom_point() +
#   labs(title = "Simulated 3EpE AIC values by sample size",
#        x = "Sample Size",
#        y = "AIC") +
#   scale_y_log10() +
#   scale_x_continuous(breaks=ThreeEpochE_df_long$Index) +
#   scale_color_manual(values = c("blue", "green", "red"),
#     label=c('One-epoch', 'Three-epoch', 'Two-epoch')) +
#   theme_bw()
# 
# ThreeEpochE_lambda_two_one = 2 * (ThreeEpochE_two_epoch_LL - ThreeEpochE_one_epoch_LL)
# ThreeEpochE_lambda_three_one = 2 * (ThreeEpochE_three_epoch_LL - ThreeEpochE_one_epoch_LL)
# ThreeEpochE_lambda_three_two = 2 * (ThreeEpochE_three_epoch_LL - ThreeEpochE_two_epoch_LL)
# 
# ThreeEpochE_lambda_df = data.frame(ThreeEpochE_lambda_two_one, ThreeEpochE_lambda_three_one, ThreeEpochE_lambda_three_two)
# # Reshape the data from wide to long format
# ThreeEpochE_df_long_lambda <- tidyr::gather(ThreeEpochE_lambda_df, key = "Full_vs_Null", value = "Lambda", ThreeEpochE_lambda_two_one:ThreeEpochE_lambda_three_two)
# # Increase the x-axis index by 4
# ThreeEpochE_df_long_lambda$Index <- rep(seq(10, 800, by = 80), times = 3)
# 
# # Create the line plot with ggplot2
# ggplot(ThreeEpochE_df_long_lambda, aes(x = Index, y = Lambda, color = Full_vs_Null)) +
#   geom_line() +
#   geom_point() +
#   labs(title = "Simulated 3EpE Lambda values by sample size (N=10-730:80)",
#        x = "Sample Size",
#        y = "2 * Lambda") +
#   # scale_y_log10() +
#   scale_x_continuous(breaks=ThreeEpochE_df_long$Index) +
#   scale_color_manual(values = c("blue", "green", "red"),
#     label=c('Three vs. One', 'Three vs. Two', 'Two vs. One')) +
#   theme_bw()
# 
# ThreeEpochE_one_epoch_residual = c()
# ThreeEpochE_two_epoch_residual = c()
# ThreeEpochE_three_epoch_residual = c()
# 
# for (i in 1:10) {
#   ThreeEpochE_one_epoch_residual = c(ThreeEpochE_one_epoch_residual, compute_residual(unlist(ThreeEpochE_empirical_file_list[i]), unlist(ThreeEpochE_one_epoch_file_list[i])))
#   ThreeEpochE_two_epoch_residual = c(ThreeEpochE_two_epoch_residual, compute_residual(unlist(ThreeEpochE_empirical_file_list[i]), unlist(ThreeEpochE_two_epoch_file_list[i])))
#   ThreeEpochE_three_epoch_residual = c(ThreeEpochE_three_epoch_residual, compute_residual(unlist(ThreeEpochE_empirical_file_list[i]), unlist(ThreeEpochE_three_epoch_file_list[i])))
# }
# 
# ThreeEpochE_residual_df = data.frame(ThreeEpochE_one_epoch_residual, ThreeEpochE_two_epoch_residual, ThreeEpochE_three_epoch_residual)
# # Reshape the data from wide to long format
# ThreeEpochE_df_long_residual <- tidyr::gather(ThreeEpochE_residual_df, key = "Epoch", value = "residual", ThreeEpochE_one_epoch_residual:ThreeEpochE_three_epoch_residual)
# 
# # Increase the x-axis index by 4
# ThreeEpochE_df_long_residual$Index <- rep(seq(10, 800, by = 80), times = 3)
# 
# # Create the line plot with ggplot2
# ggplot(ThreeEpochE_df_long_residual, aes(x = Index, y = residual, color = Epoch)) +
#   geom_line() +
#   geom_point() +
#   labs(title = "3EpE residual values by sample size",
#        x = "Sample Size",
#        y = "Residual") +
#   scale_y_log10() +
#   scale_x_continuous(breaks=ThreeEpochE_df_long$Index) +
#   scale_color_manual(values = c("blue", "green", "red"),
#     label=c('One-epoch', 'Three-epoch', 'Two-epoch')) +
#   theme_bw()
# 
# ggplot(ThreeEpochE_df_long, aes(x = Index, y = AIC, color = Epoch)) +
#   geom_line(linetype=3) +
#   geom_point() +
#   labs(title = "Simulated 3EpE AIC and residual by sample size (N=10-730:80)",
#        x = "Sample Size",
#        y = "AIC") +
#   scale_y_log10(sec.axis = sec_axis(~.*1, name="Residual")) +
#   scale_x_continuous(breaks=ThreeEpochE_df_long$Index) +
#   geom_line(data=ThreeEpochE_df_long_residual, aes(x = Index, y = residual*1, color = Epoch)) +
#   scale_color_manual(values = c("blue", "orange", "green", "violet", "red", "seagreen"),
#     label=c('One-epoch AIC', 'One-epoch residual',
#       'Three-epoch AIC', 'Three-epoch residual',
#       'Two-epoch AIC', 'Two-epoch residual')) +
#   theme_bw()
# 
# # Tennessen_3EpE population genetic constants
# 
# ThreeEpochE_mu = 1.5E-8
# # ThreeEpochE_allele_sum = 8058343
# 
# # NAnc = theta / (4 * allele_sum * mu)
# # generations = 2 * tau * theta / (4 * mu * allele_sum)
# # years = generations / 365
# # NCurr = nu * NAnc
# # generations_b = 2 * tauB * theta / (4 * mu * allele_sum)
# # generations_f = 2 * tauF * theta / (4 * mu * allele_sum)
# # NBottle = nuB * NAnc
# # NSince = nuF * NAnc
# 
# 
# ThreeEpochE_one_epoch_NAnc = ThreeEpochE_one_epoch_theta / (4 * ThreeEpochE_one_epoch_allele_sum * ThreeEpochE_mu)
# ThreeEpochE_two_epoch_NAnc = ThreeEpochE_two_epoch_theta / (4 * ThreeEpochE_two_epoch_allele_sum * ThreeEpochE_mu)
# ThreeEpochE_two_epoch_NCurr = ThreeEpochE_two_epoch_nu * ThreeEpochE_two_epoch_NAnc
# ThreeEpochE_two_epoch_Time = 2 * 25 * ThreeEpochE_two_epoch_tau * ThreeEpochE_two_epoch_theta / (4 * ThreeEpochE_mu * ThreeEpochE_two_epoch_allele_sum)
# ThreeEpochE_three_epoch_NAnc = ThreeEpochE_three_epoch_theta / (4 * ThreeEpochE_three_epoch_allele_sum * ThreeEpochE_mu)
# ThreeEpochE_three_epoch_NBottle = ThreeEpochE_three_epoch_nuB * ThreeEpochE_three_epoch_NAnc
# ThreeEpochE_three_epoch_NCurr = ThreeEpochE_three_epoch_nuF * ThreeEpochE_three_epoch_NAnc
# ThreeEpochE_three_epoch_TimeBottleEnd = 2 * 25 * ThreeEpochE_three_epoch_tauF * ThreeEpochE_three_epoch_theta / (4 * ThreeEpochE_mu * ThreeEpochE_three_epoch_allele_sum)
# ThreeEpochE_three_epoch_TimeBottleStart = 2 * 25 * ThreeEpochE_three_epoch_tauB * ThreeEpochE_three_epoch_theta / (4 * ThreeEpochE_mu * ThreeEpochE_three_epoch_allele_sum) + ThreeEpochE_three_epoch_TimeBottleEnd
# ThreeEpochE_three_epoch_TimeTotal = ThreeEpochE_three_epoch_TimeBottleStart + ThreeEpochE_three_epoch_TimeBottleEnd
# 
# two_epoch_max_time = max(ThreeEpochE_two_epoch_Time)
# three_epoch_max_time = max(ThreeEpochE_three_epoch_TimeBottleStart)
# ThreeEpochE_two_epoch_max_time = rep(two_epoch_max_time, 10)
# # ThreeEpochE_two_epoch_max_time = rep(2E4, 10)
# ThreeEpochE_two_epoch_current_time = rep(0, 10)
# ThreeEpochE_two_epoch_demography = data.frame(ThreeEpochE_two_epoch_NAnc, ThreeEpochE_two_epoch_max_time, 
#   ThreeEpochE_two_epoch_NCurr, ThreeEpochE_two_epoch_Time, 
#   ThreeEpochE_two_epoch_NCurr, ThreeEpochE_two_epoch_current_time)
# 
# # ThreeEpochE_three_epoch_max_time = rep(100000000, 10)
# # ThreeEpochE_three_epoch_max_time = rep(5E6, 10)
# ThreeEpochE_three_epoch_max_time = rep(three_epoch_max_time, 10)
# ThreeEpochE_three_epoch_current_time = rep(0, 10)
# ThreeEpochE_three_epoch_demography = data.frame(ThreeEpochE_three_epoch_NAnc, ThreeEpochE_three_epoch_max_time,
#   ThreeEpochE_three_epoch_NBottle, ThreeEpochE_three_epoch_TimeBottleStart,
#   ThreeEpochE_three_epoch_NCurr, ThreeEpochE_three_epoch_TimeBottleEnd,
#   ThreeEpochE_three_epoch_NCurr, ThreeEpochE_three_epoch_current_time)
# 
# ThreeEpochE_two_epoch_NEffective_10 = c(ThreeEpochE_two_epoch_demography[1, 1], ThreeEpochE_two_epoch_demography[1, 3], ThreeEpochE_two_epoch_demography[1, 5])
# ThreeEpochE_two_epoch_Time_10 = c(-ThreeEpochE_two_epoch_demography[1, 2], -ThreeEpochE_two_epoch_demography[1, 4], ThreeEpochE_two_epoch_demography[1, 6])
# ThreeEpochE_two_epoch_demography_10 = data.frame(ThreeEpochE_two_epoch_Time_10, ThreeEpochE_two_epoch_NEffective_10)
# ThreeEpochE_two_epoch_NEffective_90 = c(ThreeEpochE_two_epoch_demography[2, 1], ThreeEpochE_two_epoch_demography[2, 3], ThreeEpochE_two_epoch_demography[2, 5])
# ThreeEpochE_two_epoch_Time_90 = c(-ThreeEpochE_two_epoch_demography[2, 2], -ThreeEpochE_two_epoch_demography[2, 4], ThreeEpochE_two_epoch_demography[2, 6])
# ThreeEpochE_two_epoch_demography_90 = data.frame(ThreeEpochE_two_epoch_Time_90, ThreeEpochE_two_epoch_NEffective_90)
# ThreeEpochE_two_epoch_NEffective_170 = c(ThreeEpochE_two_epoch_demography[3, 1], ThreeEpochE_two_epoch_demography[3, 3], ThreeEpochE_two_epoch_demography[3, 5])
# ThreeEpochE_two_epoch_Time_170 = c(-ThreeEpochE_two_epoch_demography[3, 2], -ThreeEpochE_two_epoch_demography[3, 4], ThreeEpochE_two_epoch_demography[3, 6])
# ThreeEpochE_two_epoch_demography_170 = data.frame(ThreeEpochE_two_epoch_Time_170, ThreeEpochE_two_epoch_NEffective_170)
# ThreeEpochE_two_epoch_NEffective_250 = c(ThreeEpochE_two_epoch_demography[4, 1], ThreeEpochE_two_epoch_demography[4, 3], ThreeEpochE_two_epoch_demography[4, 5])
# ThreeEpochE_two_epoch_Time_250 = c(-ThreeEpochE_two_epoch_demography[4, 2], -ThreeEpochE_two_epoch_demography[4, 4], ThreeEpochE_two_epoch_demography[4, 6])
# ThreeEpochE_two_epoch_demography_250 = data.frame(ThreeEpochE_two_epoch_Time_250, ThreeEpochE_two_epoch_NEffective_250)
# ThreeEpochE_two_epoch_NEffective_330 = c(ThreeEpochE_two_epoch_demography[5, 1], ThreeEpochE_two_epoch_demography[5, 3], ThreeEpochE_two_epoch_demography[5, 5])
# ThreeEpochE_two_epoch_Time_330 = c(-ThreeEpochE_two_epoch_demography[5, 2], -ThreeEpochE_two_epoch_demography[5, 4], ThreeEpochE_two_epoch_demography[5, 6])
# ThreeEpochE_two_epoch_demography_330 = data.frame(ThreeEpochE_two_epoch_Time_330, ThreeEpochE_two_epoch_NEffective_330)
# ThreeEpochE_two_epoch_NEffective_410 = c(ThreeEpochE_two_epoch_demography[6, 1], ThreeEpochE_two_epoch_demography[6, 3], ThreeEpochE_two_epoch_demography[6, 5])
# ThreeEpochE_two_epoch_Time_410 = c(-ThreeEpochE_two_epoch_demography[6, 2], -ThreeEpochE_two_epoch_demography[6, 4], ThreeEpochE_two_epoch_demography[6, 6])
# ThreeEpochE_two_epoch_demography_410 = data.frame(ThreeEpochE_two_epoch_Time_410, ThreeEpochE_two_epoch_NEffective_410)
# ThreeEpochE_two_epoch_NEffective_490 = c(ThreeEpochE_two_epoch_demography[7, 1], ThreeEpochE_two_epoch_demography[7, 3], ThreeEpochE_two_epoch_demography[7, 5])
# ThreeEpochE_two_epoch_Time_490 = c(-ThreeEpochE_two_epoch_demography[7, 2], -ThreeEpochE_two_epoch_demography[7, 4], ThreeEpochE_two_epoch_demography[7, 6])
# ThreeEpochE_two_epoch_demography_490 = data.frame(ThreeEpochE_two_epoch_Time_490, ThreeEpochE_two_epoch_NEffective_490)
# ThreeEpochE_two_epoch_NEffective_570 = c(ThreeEpochE_two_epoch_demography[8, 1], ThreeEpochE_two_epoch_demography[8, 3], ThreeEpochE_two_epoch_demography[8, 5])
# ThreeEpochE_two_epoch_Time_570 = c(-ThreeEpochE_two_epoch_demography[8, 2], -ThreeEpochE_two_epoch_demography[8, 4], ThreeEpochE_two_epoch_demography[8, 6])
# ThreeEpochE_two_epoch_demography_570 = data.frame(ThreeEpochE_two_epoch_Time_570, ThreeEpochE_two_epoch_NEffective_570)
# ThreeEpochE_two_epoch_NEffective_650 = c(ThreeEpochE_two_epoch_demography[9, 1], ThreeEpochE_two_epoch_demography[9, 3], ThreeEpochE_two_epoch_demography[9, 5])
# ThreeEpochE_two_epoch_Time_650 = c(-ThreeEpochE_two_epoch_demography[9, 2], -ThreeEpochE_two_epoch_demography[9, 4], ThreeEpochE_two_epoch_demography[9, 6])
# ThreeEpochE_two_epoch_demography_650 = data.frame(ThreeEpochE_two_epoch_Time_650, ThreeEpochE_two_epoch_NEffective_650)
# ThreeEpochE_two_epoch_NEffective_730 = c(ThreeEpochE_two_epoch_demography[10, 1], ThreeEpochE_two_epoch_demography[10, 3], ThreeEpochE_two_epoch_demography[10, 5])
# ThreeEpochE_two_epoch_Time_730 = c(-ThreeEpochE_two_epoch_demography[10, 2], -ThreeEpochE_two_epoch_demography[10, 4], ThreeEpochE_two_epoch_demography[10, 6])
# ThreeEpochE_two_epoch_demography_730 = data.frame(ThreeEpochE_two_epoch_Time_730, ThreeEpochE_two_epoch_NEffective_730)
# 
# ThreeEpochE_three_epoch_NEffective_10 = c(ThreeEpochE_three_epoch_demography[1, 1], ThreeEpochE_three_epoch_demography[1, 3], ThreeEpochE_three_epoch_demography[1, 5], ThreeEpochE_three_epoch_demography[1, 7])
# ThreeEpochE_three_epoch_Time_10 = c(-ThreeEpochE_three_epoch_demography[1, 2], -ThreeEpochE_three_epoch_demography[1, 4], -ThreeEpochE_three_epoch_demography[1, 6], ThreeEpochE_three_epoch_demography[1, 8])
# ThreeEpochE_three_epoch_demography_10 = data.frame(ThreeEpochE_three_epoch_Time_10, ThreeEpochE_three_epoch_NEffective_10)
# ThreeEpochE_three_epoch_NEffective_90 = c(ThreeEpochE_three_epoch_demography[2, 1], ThreeEpochE_three_epoch_demography[2, 3], ThreeEpochE_three_epoch_demography[2, 5], ThreeEpochE_three_epoch_demography[2, 7])
# ThreeEpochE_three_epoch_Time_90 = c(-ThreeEpochE_three_epoch_demography[2, 2], -ThreeEpochE_three_epoch_demography[2, 4], -ThreeEpochE_three_epoch_demography[2, 6], ThreeEpochE_three_epoch_demography[2, 8])
# ThreeEpochE_three_epoch_demography_90 = data.frame(ThreeEpochE_three_epoch_Time_90, ThreeEpochE_three_epoch_NEffective_90)
# ThreeEpochE_three_epoch_NEffective_170 = c(ThreeEpochE_three_epoch_demography[3, 1], ThreeEpochE_three_epoch_demography[3, 3], ThreeEpochE_three_epoch_demography[3, 5], ThreeEpochE_three_epoch_demography[3, 7])
# ThreeEpochE_three_epoch_Time_170 = c(-ThreeEpochE_three_epoch_demography[3, 2], -ThreeEpochE_three_epoch_demography[3, 4], -ThreeEpochE_three_epoch_demography[3, 6], ThreeEpochE_three_epoch_demography[3, 8])
# ThreeEpochE_three_epoch_demography_170 = data.frame(ThreeEpochE_three_epoch_Time_170, ThreeEpochE_three_epoch_NEffective_170)
# ThreeEpochE_three_epoch_NEffective_250 = c(ThreeEpochE_three_epoch_demography[4, 1], ThreeEpochE_three_epoch_demography[4, 3], ThreeEpochE_three_epoch_demography[4, 5], ThreeEpochE_three_epoch_demography[4, 7])
# ThreeEpochE_three_epoch_Time_250 = c(-ThreeEpochE_three_epoch_demography[4, 2], -ThreeEpochE_three_epoch_demography[4, 4], -ThreeEpochE_three_epoch_demography[4, 6], ThreeEpochE_three_epoch_demography[4, 8])
# ThreeEpochE_three_epoch_demography_250 = data.frame(ThreeEpochE_three_epoch_Time_250, ThreeEpochE_three_epoch_NEffective_250)
# ThreeEpochE_three_epoch_NEffective_330 = c(ThreeEpochE_three_epoch_demography[5, 1], ThreeEpochE_three_epoch_demography[5, 3], ThreeEpochE_three_epoch_demography[5, 5], ThreeEpochE_three_epoch_demography[5, 7])
# ThreeEpochE_three_epoch_Time_330 = c(-ThreeEpochE_three_epoch_demography[5, 2], -ThreeEpochE_three_epoch_demography[5, 4], -ThreeEpochE_three_epoch_demography[5, 6], ThreeEpochE_three_epoch_demography[5, 8])
# ThreeEpochE_three_epoch_demography_330 = data.frame(ThreeEpochE_three_epoch_Time_330, ThreeEpochE_three_epoch_NEffective_330)
# ThreeEpochE_three_epoch_NEffective_410 = c(ThreeEpochE_three_epoch_demography[6, 1], ThreeEpochE_three_epoch_demography[6, 3], ThreeEpochE_three_epoch_demography[6, 5], ThreeEpochE_three_epoch_demography[6, 7])
# ThreeEpochE_three_epoch_Time_410 = c(-ThreeEpochE_three_epoch_demography[6, 2], -ThreeEpochE_three_epoch_demography[6, 4], -ThreeEpochE_three_epoch_demography[6, 6], ThreeEpochE_three_epoch_demography[6, 8])
# ThreeEpochE_three_epoch_demography_410 = data.frame(ThreeEpochE_three_epoch_Time_410, ThreeEpochE_three_epoch_NEffective_410)
# ThreeEpochE_three_epoch_NEffective_490 = c(ThreeEpochE_three_epoch_demography[7, 1], ThreeEpochE_three_epoch_demography[7, 3], ThreeEpochE_three_epoch_demography[7, 5], ThreeEpochE_three_epoch_demography[7, 7])
# ThreeEpochE_three_epoch_Time_490 = c(-ThreeEpochE_three_epoch_demography[7, 2], -ThreeEpochE_three_epoch_demography[7, 4], -ThreeEpochE_three_epoch_demography[7, 6], ThreeEpochE_three_epoch_demography[7, 8])
# ThreeEpochE_three_epoch_demography_490 = data.frame(ThreeEpochE_three_epoch_Time_490, ThreeEpochE_three_epoch_NEffective_490)
# ThreeEpochE_three_epoch_NEffective_570 = c(ThreeEpochE_three_epoch_demography[8, 1], ThreeEpochE_three_epoch_demography[8, 3], ThreeEpochE_three_epoch_demography[8, 5], ThreeEpochE_three_epoch_demography[8, 7])
# ThreeEpochE_three_epoch_Time_570 = c(-ThreeEpochE_three_epoch_demography[8, 2], -ThreeEpochE_three_epoch_demography[8, 4], -ThreeEpochE_three_epoch_demography[8, 6], ThreeEpochE_three_epoch_demography[8, 8])
# ThreeEpochE_three_epoch_demography_570 = data.frame(ThreeEpochE_three_epoch_Time_570, ThreeEpochE_three_epoch_NEffective_570)
# ThreeEpochE_three_epoch_NEffective_650 = c(ThreeEpochE_three_epoch_demography[9, 1], ThreeEpochE_three_epoch_demography[9, 3], ThreeEpochE_three_epoch_demography[9, 5], ThreeEpochE_three_epoch_demography[9, 7])
# ThreeEpochE_three_epoch_Time_650 = c(-ThreeEpochE_three_epoch_demography[9, 2], -ThreeEpochE_three_epoch_demography[9, 4], -ThreeEpochE_three_epoch_demography[9, 6], ThreeEpochE_three_epoch_demography[9, 8])
# ThreeEpochE_three_epoch_demography_650 = data.frame(ThreeEpochE_three_epoch_Time_650, ThreeEpochE_three_epoch_NEffective_650)
# ThreeEpochE_three_epoch_NEffective_730 = c(ThreeEpochE_three_epoch_demography[10, 1], ThreeEpochE_three_epoch_demography[10, 3], ThreeEpochE_three_epoch_demography[10, 5], ThreeEpochE_three_epoch_demography[10, 7])
# ThreeEpochE_three_epoch_Time_730 = c(-ThreeEpochE_three_epoch_demography[10, 2], -ThreeEpochE_three_epoch_demography[10, 4], -ThreeEpochE_three_epoch_demography[10, 6], ThreeEpochE_three_epoch_demography[10, 8])
# ThreeEpochE_three_epoch_demography_730 = data.frame(ThreeEpochE_three_epoch_Time_730, ThreeEpochE_three_epoch_NEffective_730)
# 
# ggplot(ThreeEpochE_two_epoch_demography_10, aes(ThreeEpochE_two_epoch_Time_10, ThreeEpochE_two_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='dotted') + 
#   geom_step(data=ThreeEpochE_two_epoch_demography_90, aes(ThreeEpochE_two_epoch_Time_90, ThreeEpochE_two_epoch_NEffective_90, color='N=90'), linewidth=1, linetype='dotted') +
#   geom_step(data=ThreeEpochE_two_epoch_demography_170, aes(ThreeEpochE_two_epoch_Time_170, ThreeEpochE_two_epoch_NEffective_170, color='N=170'), linewidth=1, linetype='dotted') +
#   geom_step(data=ThreeEpochE_two_epoch_demography_250, aes(ThreeEpochE_two_epoch_Time_250, ThreeEpochE_two_epoch_NEffective_250, color='N=250'), linewidth=1, linetype='dotted') +
#   geom_step(data=ThreeEpochE_two_epoch_demography_330, aes(ThreeEpochE_two_epoch_Time_330, ThreeEpochE_two_epoch_NEffective_330, color='N=330'), linewidth=1, linetype='dotted') +
#   geom_step(data=ThreeEpochE_two_epoch_demography_410, aes(ThreeEpochE_two_epoch_Time_410, ThreeEpochE_two_epoch_NEffective_410, color='N=410'), linewidth=1, linetype='dotted') +
#   geom_step(data=ThreeEpochE_two_epoch_demography_490, aes(ThreeEpochE_two_epoch_Time_490, ThreeEpochE_two_epoch_NEffective_490, color='N=490'), linewidth=1, linetype='dotted') +
#   geom_step(data=ThreeEpochE_two_epoch_demography_570, aes(ThreeEpochE_two_epoch_Time_570, ThreeEpochE_two_epoch_NEffective_570, color='N=570'), linewidth=1, linetype='dotted') +
#   geom_step(data=ThreeEpochE_two_epoch_demography_650, aes(ThreeEpochE_two_epoch_Time_650, ThreeEpochE_two_epoch_NEffective_650, color='N=650'), linewidth=1, linetype='dotted') +
#   geom_step(data=ThreeEpochE_two_epoch_demography_730, aes(ThreeEpochE_two_epoch_Time_730, ThreeEpochE_two_epoch_NEffective_730, color='N=730'), linewidth=1, linetype='dotted') +
#   scale_color_manual(name='Sample Size',
#                      breaks=c('N=10', 'N=90', 'N=170', 'N=250', 'N=330', 'N=410', 'N=490', 'N=570', 'N=650', 'N=730'),
#                      values=c('N=10'='#7f3b08',
#                        'N=90'='#b35806',
#                        'N=170'='#e08214',
#                        'N=250'='#fdb863',
#                        'N=330'='#fee0b6',
#                        'N=410'='#d8daeb',
#                        'N=490'='#b2abd2',
#                        'N=570'='#8073ac',
#                        'N=650'='#542788',
#                        'N=730'='#2d004b')) +
#   theme_bw() +
#   ylab('Effective Population Size') +
#   xlab('Time in Years') +
#   ggtitle('Simulated 3EpE two Epoch Demography (N=10-730:80)')
# 
# # ggplot(ThreeEpochE_two_epoch_demography_330, aes(ThreeEpochE_two_epoch_Time_330, ThreeEpochE_two_epoch_NEffective_330)) + geom_step(color='#d8daeb', linewidth=1, linetype='dotted') + 
# #   # geom_step(data=ThreeEpochE_two_epoch_demography_90, aes(ThreeEpochE_two_epoch_Time_90, ThreeEpochE_two_epoch_NEffective_90), color='#b35806', linewidth=1, linetype='dotted') +
# #   # geom_step(data=ThreeEpochE_two_epoch_demography_170, aes(ThreeEpochE_two_epoch_Time_170, ThreeEpochE_two_epoch_NEffective_170), color='#e08214', linewidth=1, linetype='dotted') +
# #   # geom_step(data=ThreeEpochE_two_epoch_demography_250, aes(ThreeEpochE_two_epoch_Time_250, ThreeEpochE_two_epoch_NEffective_250), color='#fdb863', linewidth=1, linetype='dotted') +
# #   # geom_step(data=ThreeEpochE_two_epoch_demography_330, aes(ThreeEpochE_two_epoch_Time_330, ThreeEpochE_two_epoch_NEffective_330), color='#fee0b6', linewidth=1, linetype='dotted') +
# #   geom_step(data=ThreeEpochE_two_epoch_demography_410, aes(ThreeEpochE_two_epoch_Time_410, ThreeEpochE_two_epoch_NEffective_410), color='#d8daeb', linewidth=1, linetype='dotted') +
# #   geom_step(data=ThreeEpochE_two_epoch_demography_490, aes(ThreeEpochE_two_epoch_Time_490, ThreeEpochE_two_epoch_NEffective_490), color='#b2abd2', linewidth=1, linetype='dotted') +
# #   geom_step(data=ThreeEpochE_two_epoch_demography_570, aes(ThreeEpochE_two_epoch_Time_570, ThreeEpochE_two_epoch_NEffective_570), color='#8073ac', linewidth=1, linetype='dotted') +
# #   geom_step(data=ThreeEpochE_two_epoch_demography_650, aes(ThreeEpochE_two_epoch_Time_650, ThreeEpochE_two_epoch_NEffective_650), color='#542788', linewidth=1, linetype='dotted') +
# #   geom_step(data=ThreeEpochE_two_epoch_demography_730, aes(ThreeEpochE_two_epoch_Time_730, ThreeEpochE_two_epoch_NEffective_730), color='#2d004b', linewidth=1, linetype='dotted') +
# #   theme_bw() +
# #   ylab('Effective Population Size') +
# #   xlab('Time in Years') +
# #   ggtitle('Simulated 3EpE two Epoch Demography, 330-730:80')
# 
# ggplot(ThreeEpochE_two_epoch_demography_10, aes(ThreeEpochE_two_epoch_Time_10, ThreeEpochE_two_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='dashed') + 
#   # geom_step(data=ThreeEpochE_two_epoch_demography_90, aes(ThreeEpochE_two_epoch_Time_90, ThreeEpochE_two_epoch_NEffective_90, color='N=90'), linewidth=1, linetype='dashed') +
#   # geom_step(data=ThreeEpochE_two_epoch_demography_170, aes(ThreeEpochE_two_epoch_Time_170, ThreeEpochE_two_epoch_NEffective_170, color='N=170'), linewidth=1, linetype='dashed') +
#   # geom_step(data=ThreeEpochE_two_epoch_demography_250, aes(ThreeEpochE_two_epoch_Time_250, ThreeEpochE_two_epoch_NEffective_250, color='N=250'), linewidth=1, linetype='dashed') +
#   # geom_step(data=ThreeEpochE_two_epoch_demography_330, aes(ThreeEpochE_two_epoch_Time_330, ThreeEpochE_two_epoch_NEffective_330, color='N=330'), linewidth=1, linetype='dashed') +
#   # geom_step(data=ThreeEpochE_two_epoch_demography_410, aes(ThreeEpochE_two_epoch_Time_410, ThreeEpochE_two_epoch_NEffective_410, color='N=410'), linewidth=1, linetype='dashed') +
#   # geom_step(data=ThreeEpochE_two_epoch_demography_490, aes(ThreeEpochE_two_epoch_Time_490, ThreeEpochE_two_epoch_NEffective_490, color='N=490'), linewidth=1, linetype='dashed') +
#   # geom_step(data=ThreeEpochE_two_epoch_demography_570, aes(ThreeEpochE_two_epoch_Time_570, ThreeEpochE_two_epoch_NEffective_570, color='N=570'), linewidth=1, linetype='dashed') +
#   # geom_step(data=ThreeEpochE_two_epoch_demography_650, aes(ThreeEpochE_two_epoch_Time_650, ThreeEpochE_two_epoch_NEffective_650, color='N=650'), linewidth=1, linetype='dashed') +
#   # geom_step(data=ThreeEpochE_two_epoch_demography_730, aes(ThreeEpochE_two_epoch_Time_730, ThreeEpochE_two_epoch_NEffective_730, color='N=730'), linewidth=1, linetype='dashed') +
#   # geom_step(data=ThreeEpochE_three_epoch_demography_10, aes(ThreeEpochE_three_epoch_Time_10, ThreeEpochE_three_epoch_NEffective_10, color='N=10'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_90, aes(ThreeEpochE_three_epoch_Time_90, ThreeEpochE_three_epoch_NEffective_90, color='N=90'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_170, aes(ThreeEpochE_three_epoch_Time_170, ThreeEpochE_three_epoch_NEffective_170, color='N=170'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_250, aes(ThreeEpochE_three_epoch_Time_250, ThreeEpochE_three_epoch_NEffective_250, color='N=250'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_330, aes(ThreeEpochE_three_epoch_Time_330, ThreeEpochE_three_epoch_NEffective_330, color='N=330'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_410, aes(ThreeEpochE_three_epoch_Time_410, ThreeEpochE_three_epoch_NEffective_410, color='N=410'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_490, aes(ThreeEpochE_three_epoch_Time_490, ThreeEpochE_three_epoch_NEffective_490, color='N=490'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_570, aes(ThreeEpochE_three_epoch_Time_570, ThreeEpochE_three_epoch_NEffective_570, color='N=570'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_650, aes(ThreeEpochE_three_epoch_Time_650, ThreeEpochE_three_epoch_NEffective_650, color='N=650'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_730, aes(ThreeEpochE_three_epoch_Time_730, ThreeEpochE_three_epoch_NEffective_730, color='N=730'), linewidth=1, linetype='solid') +
#   theme_bw() +
#   scale_color_manual(name='Sample Size',
#                      breaks=c('N=10', 'N=90', 'N=170', 'N=250', 'N=330', 'N=410', 'N=490', 'N=570', 'N=650', 'N=730'),
#                      values=c('N=10'='#7f3b08',
#                        'N=90'='#b35806',
#                        'N=170'='#e08214',
#                        'N=250'='#fdb863',
#                        'N=330'='#fee0b6',
#                        'N=410'='#d8daeb',
#                        'N=490'='#b2abd2',
#                        'N=570'='#8073ac',
#                        'N=650'='#542788',
#                        'N=730'='#2d004b'))+
#   ylab('Effective Population Size') +
#   xlab('Time in Years') +
#   ggtitle('Simulated 3EpE Best-fitting Demography (N=10-730:80)')
# 
# ggplot(ThreeEpochE_three_epoch_demography_10, aes(ThreeEpochE_three_epoch_Time_10, ThreeEpochE_three_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='solid') + 
#   geom_step(data=ThreeEpochE_three_epoch_demography_90, aes(ThreeEpochE_three_epoch_Time_90, ThreeEpochE_three_epoch_NEffective_90, color='N=90'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_170, aes(ThreeEpochE_three_epoch_Time_170, ThreeEpochE_three_epoch_NEffective_170, color='N=170'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_250, aes(ThreeEpochE_three_epoch_Time_250, ThreeEpochE_three_epoch_NEffective_250, color='N=250'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_330, aes(ThreeEpochE_three_epoch_Time_330, ThreeEpochE_three_epoch_NEffective_330, color='N=330'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_410, aes(ThreeEpochE_three_epoch_Time_410, ThreeEpochE_three_epoch_NEffective_410, color='N=410'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_490, aes(ThreeEpochE_three_epoch_Time_490, ThreeEpochE_three_epoch_NEffective_490, color='N=490'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_570, aes(ThreeEpochE_three_epoch_Time_570, ThreeEpochE_three_epoch_NEffective_570, color='N=570'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_650, aes(ThreeEpochE_three_epoch_Time_650, ThreeEpochE_three_epoch_NEffective_650, color='N=650'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_730, aes(ThreeEpochE_three_epoch_Time_730, ThreeEpochE_three_epoch_NEffective_730, color='N=730'), linewidth=1, linetype='solid') +
#   scale_color_manual(name='Sample Size',
#                      breaks=c('N=10', 'N=90', 'N=170', 'N=250', 'N=330', 'N=410', 'N=490', 'N=570', 'N=650', 'N=730'),
#                      values=c('N=10'='#7f3b08',
#                        'N=90'='#b35806',
#                        'N=170'='#e08214',
#                        'N=250'='#fdb863',
#                        'N=330'='#fee0b6',
#                        'N=410'='#d8daeb',
#                        'N=490'='#b2abd2',
#                        'N=570'='#8073ac',
#                        'N=650'='#542788',
#                        'N=730'='#2d004b')) +
#   theme_bw() +
#   ylab('Effective Population Size') +
#   xlab('Time in Years') +
#   ggtitle('Simulated 3EpE Three Epoch Demography (N=10-730:80)')
# 
# # ggplot(ThreeEpochE_three_epoch_demography_90, aes(ThreeEpochE_three_epoch_Time_90, ThreeEpochE_three_epoch_NEffective_90)) + geom_step(color='#b35806', linewidth=1, linetype='solid') + 
# #   # geom_step(data=ThreeEpochE_three_epoch_demography_90, aes(ThreeEpochE_three_epoch_Time_90, ThreeEpochE_three_epoch_NEffective_90), color='#b35806', linewidth=1, linetype='solid') +
# #   geom_step(data=ThreeEpochE_three_epoch_demography_170, aes(ThreeEpochE_three_epoch_Time_170, ThreeEpochE_three_epoch_NEffective_170), color='#e08214', linewidth=1, linetype='solid') +
# #   geom_step(data=ThreeEpochE_three_epoch_demography_250, aes(ThreeEpochE_three_epoch_Time_250, ThreeEpochE_three_epoch_NEffective_250), color='#fdb863', linewidth=1, linetype='solid') +
# #   geom_step(data=ThreeEpochE_three_epoch_demography_330, aes(ThreeEpochE_three_epoch_Time_330, ThreeEpochE_three_epoch_NEffective_330), color='#fee0b6', linewidth=1, linetype='solid') +
# #   geom_step(data=ThreeEpochE_three_epoch_demography_410, aes(ThreeEpochE_three_epoch_Time_410, ThreeEpochE_three_epoch_NEffective_410), color='#d8daeb', linewidth=1, linetype='solid') +
# #   geom_step(data=ThreeEpochE_three_epoch_demography_490, aes(ThreeEpochE_three_epoch_Time_490, ThreeEpochE_three_epoch_NEffective_490), color='#b2abd2', linewidth=1, linetype='solid') +
# #   geom_step(data=ThreeEpochE_three_epoch_demography_570, aes(ThreeEpochE_three_epoch_Time_570, ThreeEpochE_three_epoch_NEffective_570), color='#8073ac', linewidth=1, linetype='solid') +
# #   geom_step(data=ThreeEpochE_three_epoch_demography_650, aes(ThreeEpochE_three_epoch_Time_650, ThreeEpochE_three_epoch_NEffective_650), color='#542788', linewidth=1, linetype='solid') +
# #   geom_step(data=ThreeEpochE_three_epoch_demography_730, aes(ThreeEpochE_three_epoch_Time_730, ThreeEpochE_three_epoch_NEffective_730), color='#2d004b', linewidth=1, linetype='solid') +
# #   theme_bw() +
# #   ylab('Effective Population Size') +
# #   xlab('Time in Years') +
# #   ggtitle('Simulated 3EpE Three Epoch Demography, 90-730:80')
# 
# # NAnc Estimate by Sample Size
# sample_size = c(10, 90, 170, 250, 330, 410, 490, 570, 650, 730)
# 
# NAnc_df = data.frame(sample_size, ThreeEpochE_one_epoch_NAnc, ThreeEpochE_two_epoch_NAnc, ThreeEpochE_three_epoch_NAnc)
# NAnc_df = melt(NAnc_df, id='sample_size')
# 
# ggplot(data=NAnc_df, aes(x=sample_size, y=value, color=variable)) + geom_line() +
#   xlab('Sample size') +
#   ylab('Estimated ancestral effective population size') +
#   ggtitle('Simulated 3EpE NAnc by sample size (N=10-730:80)') +
#   theme_bw() +
#   guides(color=guide_legend(title="Epoch")) +
#   scale_color_manual(
#     labels=c('One-epoch', 'Two-epoch', 'Three-epoch'),
#     values=c('red', 'blue', 'green')) +
#   geom_hline(yintercept=12378, color='black', linetype='dashed') +
#   scale_x_continuous(breaks=sample_size)
# 
# # # Tennessen_3EpE 10-100:10
# ThreeEpochE_empirical_file_list = list()
# ThreeEpochE_one_epoch_file_list = list()
# ThreeEpochE_two_epoch_file_list = list()
# ThreeEpochE_three_epoch_file_list = list()
# ThreeEpochE_one_epoch_AIC = c()
# ThreeEpochE_one_epoch_LL = c()
# ThreeEpochE_one_epoch_theta = c()
# ThreeEpochE_one_epoch_allele_sum = c()
# ThreeEpochE_two_epoch_AIC = c()
# ThreeEpochE_two_epoch_LL = c()
# ThreeEpochE_two_epoch_theta = c()
# ThreeEpochE_two_epoch_nu = c()
# ThreeEpochE_two_epoch_tau = c()
# ThreeEpochE_two_epoch_allele_sum = c()
# ThreeEpochE_three_epoch_AIC = c()
# ThreeEpochE_three_epoch_LL = c()
# ThreeEpochE_three_epoch_theta = c()
# ThreeEpochE_three_epoch_nuB = c()
# ThreeEpochE_three_epoch_nuF = c()
# ThreeEpochE_three_epoch_tauB = c()
# ThreeEpochE_three_epoch_tauF = c()
# ThreeEpochE_three_epoch_allele_sum = c()
# 
# # Loop through subdirectories and get relevant files
# for (i in seq(10, 100, by = 10)) {
#   subdirectory <- paste0("../Analysis/ThreeEpochExpansion_", i)
#   ThreeEpochE_empirical_file_path <- file.path(subdirectory, "syn_downsampled_sfs.txt")
#   ThreeEpochE_one_epoch_file_path <- file.path(subdirectory, "one_epoch_demography.txt")
#   ThreeEpochE_two_epoch_file_path <- file.path(subdirectory, "two_epoch_demography.txt")
#   ThreeEpochE_three_epoch_file_path <- file.path(subdirectory, "three_epoch_demography.txt")
#   
#   # Check if the file exists before attempting to read and print its contents
#   if (file.exists(ThreeEpochE_empirical_file_path)) {
#     this_empirical_sfs = read_input_sfs(ThreeEpochE_empirical_file_path)
#     ThreeEpochE_empirical_file_list[[subdirectory]] = this_empirical_sfs
#   }
#   if (file.exists(ThreeEpochE_one_epoch_file_path)) {
#     this_one_epoch_sfs = sfs_from_demography(ThreeEpochE_one_epoch_file_path)
#     ThreeEpochE_one_epoch_file_list[[subdirectory]] = this_one_epoch_sfs
#     ThreeEpochE_one_epoch_AIC = c(ThreeEpochE_one_epoch_AIC, AIC_from_demography(ThreeEpochE_one_epoch_file_path))
#     ThreeEpochE_one_epoch_LL = c(ThreeEpochE_one_epoch_LL, LL_from_demography(ThreeEpochE_one_epoch_file_path))
#     ThreeEpochE_one_epoch_theta = c(ThreeEpochE_one_epoch_theta, theta_from_demography(ThreeEpochE_one_epoch_file_path))
#     ThreeEpochE_one_epoch_allele_sum = c(ThreeEpochE_one_epoch_allele_sum, sum(this_one_epoch_sfs))
#   }
#   if (file.exists(ThreeEpochE_two_epoch_file_path)) {
#     this_two_epoch_sfs = sfs_from_demography(ThreeEpochE_two_epoch_file_path)
#     ThreeEpochE_two_epoch_file_list[[subdirectory]] = this_two_epoch_sfs
#     ThreeEpochE_two_epoch_AIC = c(ThreeEpochE_two_epoch_AIC, AIC_from_demography(ThreeEpochE_two_epoch_file_path))
#     ThreeEpochE_two_epoch_LL = c(ThreeEpochE_two_epoch_LL, LL_from_demography(ThreeEpochE_two_epoch_file_path))
#     ThreeEpochE_two_epoch_theta = c(ThreeEpochE_two_epoch_theta, theta_from_demography(ThreeEpochE_two_epoch_file_path))
#     ThreeEpochE_two_epoch_nu = c(ThreeEpochE_two_epoch_nu, nu_from_demography(ThreeEpochE_two_epoch_file_path))
#     ThreeEpochE_two_epoch_tau = c(ThreeEpochE_two_epoch_tau, tau_from_demography(ThreeEpochE_two_epoch_file_path))
#     ThreeEpochE_two_epoch_allele_sum = c(ThreeEpochE_two_epoch_allele_sum, sum(this_two_epoch_sfs))
#   }
#   if (file.exists(ThreeEpochE_three_epoch_file_path)) {
#     this_three_epoch_sfs = sfs_from_demography(ThreeEpochE_three_epoch_file_path)
#     ThreeEpochE_three_epoch_file_list[[subdirectory]] = this_three_epoch_sfs
#     ThreeEpochE_three_epoch_AIC = c(ThreeEpochE_three_epoch_AIC, AIC_from_demography(ThreeEpochE_three_epoch_file_path))
#     ThreeEpochE_three_epoch_LL = c(ThreeEpochE_three_epoch_LL, LL_from_demography(ThreeEpochE_three_epoch_file_path))
#     ThreeEpochE_three_epoch_theta = c(ThreeEpochE_three_epoch_theta, theta_from_demography(ThreeEpochE_three_epoch_file_path))
#     ThreeEpochE_three_epoch_nuB = c(ThreeEpochE_three_epoch_nuB, nuB_from_demography(ThreeEpochE_three_epoch_file_path))
#     ThreeEpochE_three_epoch_nuF = c(ThreeEpochE_three_epoch_nuF, nuF_from_demography(ThreeEpochE_three_epoch_file_path))
#     ThreeEpochE_three_epoch_tauB = c(ThreeEpochE_three_epoch_tauB, tauB_from_demography(ThreeEpochE_three_epoch_file_path))
#     ThreeEpochE_three_epoch_tauF = c(ThreeEpochE_three_epoch_tauF, tauF_from_demography(ThreeEpochE_three_epoch_file_path))
#     ThreeEpochE_three_epoch_allele_sum = c(ThreeEpochE_three_epoch_allele_sum, sum(this_three_epoch_sfs))
#   }  
# }
# 
# ThreeEpochE_AIC_df = data.frame(ThreeEpochE_one_epoch_AIC, ThreeEpochE_two_epoch_AIC, ThreeEpochE_three_epoch_AIC)
# # Reshape the data from wide to long format
# ThreeEpochE_df_long <- tidyr::gather(ThreeEpochE_AIC_df, key = "Epoch", value = "AIC", ThreeEpochE_one_epoch_AIC:ThreeEpochE_three_epoch_AIC)
# 
# # Increase the x-axis index by 4
# ThreeEpochE_df_long$Index <- rep(seq(10, 100, by = 10), times = 3)
# 
# # Create the line plot with ggplot2
# ggplot(ThreeEpochE_df_long, aes(x = Index, y = AIC, color = Epoch)) +
#   geom_line() +
#   geom_point() +
#   labs(title = "Simulated 3EpE AIC values by sample size",
#        x = "Sample Size",
#        y = "AIC") +
#   scale_y_log10() +
#   scale_x_continuous(breaks=ThreeEpochE_df_long$Index) +
#   scale_color_manual(values = c("blue", "green", "red"),
#     label=c('One-epoch', 'Three-epoch', 'Two-epoch')) +
#   theme_bw()
# 
# ThreeEpochE_lambda_two_one = 2 * (ThreeEpochE_two_epoch_LL - ThreeEpochE_one_epoch_LL)
# ThreeEpochE_lambda_three_one = 2 * (ThreeEpochE_three_epoch_LL - ThreeEpochE_one_epoch_LL)
# ThreeEpochE_lambda_three_two = 2 * (ThreeEpochE_three_epoch_LL - ThreeEpochE_two_epoch_LL)
# 
# ThreeEpochE_lambda_df = data.frame(ThreeEpochE_lambda_two_one, ThreeEpochE_lambda_three_one, ThreeEpochE_lambda_three_two)
# # Reshape the data from wide to long format
# ThreeEpochE_df_long_lambda <- tidyr::gather(ThreeEpochE_lambda_df, key = "Full_vs_Null", value = "Lambda", ThreeEpochE_lambda_two_one:ThreeEpochE_lambda_three_two)
# # Increase the x-axis index by 4
# ThreeEpochE_df_long_lambda$Index <- rep(seq(10, 100, by = 10), times = 3)
# 
# # Create the line plot with ggplot2
# ggplot(ThreeEpochE_df_long_lambda, aes(x = Index, y = Lambda, color = Full_vs_Null)) +
#   geom_line() +
#   geom_point() +
#   labs(title = "Simulated 3EpE Lambda values by sample size (N=10-100:10)",
#        x = "Sample Size",
#        y = "2 * Lambda") +
#   # scale_y_log10() +
#   scale_x_continuous(breaks=ThreeEpochE_df_long$Index) +
#   scale_color_manual(values = c("blue", "green", "red"),
#     label=c('Three vs. One', 'Three vs. Two', 'Two vs. One')) +
#   theme_bw()
# 
# ThreeEpochE_one_epoch_residual = c()
# ThreeEpochE_two_epoch_residual = c()
# ThreeEpochE_three_epoch_residual = c()
# 
# for (i in 1:10) {
#   ThreeEpochE_one_epoch_residual = c(ThreeEpochE_one_epoch_residual, compute_residual(unlist(ThreeEpochE_empirical_file_list[i]), unlist(ThreeEpochE_one_epoch_file_list[i])))
#   ThreeEpochE_two_epoch_residual = c(ThreeEpochE_two_epoch_residual, compute_residual(unlist(ThreeEpochE_empirical_file_list[i]), unlist(ThreeEpochE_two_epoch_file_list[i])))
#   ThreeEpochE_three_epoch_residual = c(ThreeEpochE_three_epoch_residual, compute_residual(unlist(ThreeEpochE_empirical_file_list[i]), unlist(ThreeEpochE_three_epoch_file_list[i])))
# }
# 
# ThreeEpochE_residual_df = data.frame(ThreeEpochE_one_epoch_residual, ThreeEpochE_two_epoch_residual, ThreeEpochE_three_epoch_residual)
# # Reshape the data from wide to long format
# ThreeEpochE_df_long_residual <- tidyr::gather(ThreeEpochE_residual_df, key = "Epoch", value = "residual", ThreeEpochE_one_epoch_residual:ThreeEpochE_three_epoch_residual)
# 
# # Increase the x-axis index by 4
# ThreeEpochE_df_long_residual$Index <- rep(seq(10, 100, by = 10), times = 3)
# 
# # Create the line plot with ggplot2
# ggplot(ThreeEpochE_df_long_residual, aes(x = Index, y = residual, color = Epoch)) +
#   geom_line() +
#   geom_point() +
#   labs(title = "3EpE residual values by sample size",
#        x = "Sample Size",
#        y = "Residual") +
#   scale_y_log10() +
#   scale_x_continuous(breaks=ThreeEpochE_df_long$Index) +
#   scale_color_manual(values = c("blue", "green", "red"),
#     label=c('One-epoch', 'Three-epoch', 'Two-epoch')) +
#   theme_bw()
# 
# ggplot(ThreeEpochE_df_long, aes(x = Index, y = AIC, color = Epoch)) +
#   geom_line(linetype=3) +
#   geom_point() +
#   labs(title = "Simulated 3EpE AIC and residual by sample size (N=10-100:10)",
#        x = "Sample Size",
#        y = "AIC") +
#   scale_y_log10(sec.axis = sec_axis(~.*1, name="Residual")) +
#   scale_x_continuous(breaks=ThreeEpochE_df_long$Index) +
#   geom_line(data=ThreeEpochE_df_long_residual, aes(x = Index, y = residual*1, color = Epoch)) +
#   scale_color_manual(values = c("blue", "orange", "green", "violet", "red", "seagreen"),
#     label=c('One-epoch AIC', 'One-epoch residual',
#       'Three-epoch AIC', 'Three-epoch residual',
#       'Two-epoch AIC', 'Two-epoch residual')) +
#   theme_bw()
# 
# # Tennessen_3EpE population genetic constants
# 
# ThreeEpochE_mu = 1.5E-8
# 
# # NAnc = theta / (4 * allele_sum * mu)
# # generations = 2 * tau * theta / (4 * mu * allele_sum)
# # years = generations / 365
# # NCurr = nu * NAnc
# # generations_b = 2 * tauB * theta / (4 * mu * allele_sum)
# # generations_f = 2 * tauF * theta / (4 * mu * allele_sum)
# # NBottle = nuB * NAnc
# # NSince = nuF * NAnc
# 
# ThreeEpochE_one_epoch_NAnc = ThreeEpochE_one_epoch_theta / (4 * ThreeEpochE_one_epoch_allele_sum * ThreeEpochE_mu)
# ThreeEpochE_two_epoch_NAnc = ThreeEpochE_two_epoch_theta / (4 * ThreeEpochE_two_epoch_allele_sum * ThreeEpochE_mu)
# ThreeEpochE_two_epoch_NCurr = ThreeEpochE_two_epoch_nu * ThreeEpochE_two_epoch_NAnc
# ThreeEpochE_two_epoch_Time = 2 * 25 * ThreeEpochE_two_epoch_tau * ThreeEpochE_two_epoch_theta / (4 * ThreeEpochE_mu * ThreeEpochE_two_epoch_allele_sum)
# ThreeEpochE_three_epoch_NAnc = ThreeEpochE_three_epoch_theta / (4 * ThreeEpochE_three_epoch_allele_sum * ThreeEpochE_mu)
# ThreeEpochE_three_epoch_NBottle = ThreeEpochE_three_epoch_nuB * ThreeEpochE_three_epoch_NAnc
# ThreeEpochE_three_epoch_NCurr = ThreeEpochE_three_epoch_nuF * ThreeEpochE_three_epoch_NAnc
# ThreeEpochE_three_epoch_TimeBottleEnd = 2 * 25 * ThreeEpochE_three_epoch_tauF * ThreeEpochE_three_epoch_theta / (4 * ThreeEpochE_mu * ThreeEpochE_three_epoch_allele_sum)
# ThreeEpochE_three_epoch_TimeBottleStart = 2 * 25 * ThreeEpochE_three_epoch_tauB * ThreeEpochE_three_epoch_theta / (4 * ThreeEpochE_mu * ThreeEpochE_three_epoch_allele_sum) + ThreeEpochE_three_epoch_TimeBottleEnd
# ThreeEpochE_three_epoch_TimeTotal = ThreeEpochE_three_epoch_TimeBottleStart + ThreeEpochE_three_epoch_TimeBottleEnd
# 
# two_epoch_max_time = max(ThreeEpochE_two_epoch_Time)
# three_epoch_max_time = max(ThreeEpochE_three_epoch_TimeBottleStart)
# ThreeEpochE_two_epoch_max_time = rep(two_epoch_max_time, 10)
# # ThreeEpochE_two_epoch_max_time = rep(2E4, 10)
# ThreeEpochE_two_epoch_current_time = rep(0, 10)
# ThreeEpochE_two_epoch_demography = data.frame(ThreeEpochE_two_epoch_NAnc, ThreeEpochE_two_epoch_max_time, 
#   ThreeEpochE_two_epoch_NCurr, ThreeEpochE_two_epoch_Time, 
#   ThreeEpochE_two_epoch_NCurr, ThreeEpochE_two_epoch_current_time)
# 
# # ThreeEpochE_three_epoch_max_time = rep(100000000, 10)
# # ThreeEpochE_three_epoch_max_time = rep(5E6, 10)
# ThreeEpochE_three_epoch_max_time = rep(three_epoch_max_time, 10)
# ThreeEpochE_three_epoch_current_time = rep(0, 10)
# ThreeEpochE_three_epoch_demography = data.frame(ThreeEpochE_three_epoch_NAnc, ThreeEpochE_three_epoch_max_time,
#   ThreeEpochE_three_epoch_NBottle, ThreeEpochE_three_epoch_TimeBottleStart,
#   ThreeEpochE_three_epoch_NCurr, ThreeEpochE_three_epoch_TimeBottleEnd,
#   ThreeEpochE_three_epoch_NCurr, ThreeEpochE_three_epoch_current_time)
# 
# ThreeEpochE_two_epoch_NEffective_10 = c(ThreeEpochE_two_epoch_demography[1, 1], ThreeEpochE_two_epoch_demography[1, 3], ThreeEpochE_two_epoch_demography[1, 5])
# ThreeEpochE_two_epoch_Time_10 = c(-ThreeEpochE_two_epoch_demography[1, 2], -ThreeEpochE_two_epoch_demography[1, 4], ThreeEpochE_two_epoch_demography[1, 6])
# ThreeEpochE_two_epoch_demography_10 = data.frame(ThreeEpochE_two_epoch_Time_10, ThreeEpochE_two_epoch_NEffective_10)
# ThreeEpochE_two_epoch_NEffective_20 = c(ThreeEpochE_two_epoch_demography[2, 1], ThreeEpochE_two_epoch_demography[2, 3], ThreeEpochE_two_epoch_demography[2, 5])
# ThreeEpochE_two_epoch_Time_20 = c(-ThreeEpochE_two_epoch_demography[2, 2], -ThreeEpochE_two_epoch_demography[2, 4], ThreeEpochE_two_epoch_demography[2, 6])
# ThreeEpochE_two_epoch_demography_20 = data.frame(ThreeEpochE_two_epoch_Time_20, ThreeEpochE_two_epoch_NEffective_20)
# ThreeEpochE_two_epoch_NEffective_30 = c(ThreeEpochE_two_epoch_demography[3, 1], ThreeEpochE_two_epoch_demography[3, 3], ThreeEpochE_two_epoch_demography[3, 5])
# ThreeEpochE_two_epoch_Time_30 = c(-ThreeEpochE_two_epoch_demography[3, 2], -ThreeEpochE_two_epoch_demography[3, 4], ThreeEpochE_two_epoch_demography[3, 6])
# ThreeEpochE_two_epoch_demography_30 = data.frame(ThreeEpochE_two_epoch_Time_30, ThreeEpochE_two_epoch_NEffective_30)
# ThreeEpochE_two_epoch_NEffective_40 = c(ThreeEpochE_two_epoch_demography[4, 1], ThreeEpochE_two_epoch_demography[4, 3], ThreeEpochE_two_epoch_demography[4, 5])
# ThreeEpochE_two_epoch_Time_40 = c(-ThreeEpochE_two_epoch_demography[4, 2], -ThreeEpochE_two_epoch_demography[4, 4], ThreeEpochE_two_epoch_demography[4, 6])
# ThreeEpochE_two_epoch_demography_40 = data.frame(ThreeEpochE_two_epoch_Time_40, ThreeEpochE_two_epoch_NEffective_40)
# ThreeEpochE_two_epoch_NEffective_50 = c(ThreeEpochE_two_epoch_demography[5, 1], ThreeEpochE_two_epoch_demography[5, 3], ThreeEpochE_two_epoch_demography[5, 5])
# ThreeEpochE_two_epoch_Time_50 = c(-ThreeEpochE_two_epoch_demography[5, 2], -ThreeEpochE_two_epoch_demography[5, 4], ThreeEpochE_two_epoch_demography[5, 6])
# ThreeEpochE_two_epoch_demography_50 = data.frame(ThreeEpochE_two_epoch_Time_50, ThreeEpochE_two_epoch_NEffective_50)
# ThreeEpochE_two_epoch_NEffective_60 = c(ThreeEpochE_two_epoch_demography[6, 1], ThreeEpochE_two_epoch_demography[6, 3], ThreeEpochE_two_epoch_demography[6, 5])
# ThreeEpochE_two_epoch_Time_60 = c(-ThreeEpochE_two_epoch_demography[6, 2], -ThreeEpochE_two_epoch_demography[6, 4], ThreeEpochE_two_epoch_demography[6, 6])
# ThreeEpochE_two_epoch_demography_60 = data.frame(ThreeEpochE_two_epoch_Time_60, ThreeEpochE_two_epoch_NEffective_60)
# ThreeEpochE_two_epoch_NEffective_70 = c(ThreeEpochE_two_epoch_demography[7, 1], ThreeEpochE_two_epoch_demography[7, 3], ThreeEpochE_two_epoch_demography[7, 5])
# ThreeEpochE_two_epoch_Time_70 = c(-ThreeEpochE_two_epoch_demography[7, 2], -ThreeEpochE_two_epoch_demography[7, 4], ThreeEpochE_two_epoch_demography[7, 6])
# ThreeEpochE_two_epoch_demography_70 = data.frame(ThreeEpochE_two_epoch_Time_70, ThreeEpochE_two_epoch_NEffective_70)
# ThreeEpochE_two_epoch_NEffective_80 = c(ThreeEpochE_two_epoch_demography[8, 1], ThreeEpochE_two_epoch_demography[8, 3], ThreeEpochE_two_epoch_demography[8, 5])
# ThreeEpochE_two_epoch_Time_80 = c(-ThreeEpochE_two_epoch_demography[8, 2], -ThreeEpochE_two_epoch_demography[8, 4], ThreeEpochE_two_epoch_demography[8, 6])
# ThreeEpochE_two_epoch_demography_80 = data.frame(ThreeEpochE_two_epoch_Time_80, ThreeEpochE_two_epoch_NEffective_80)
# ThreeEpochE_two_epoch_NEffective_90 = c(ThreeEpochE_two_epoch_demography[9, 1], ThreeEpochE_two_epoch_demography[9, 3], ThreeEpochE_two_epoch_demography[9, 5])
# ThreeEpochE_two_epoch_Time_90 = c(-ThreeEpochE_two_epoch_demography[9, 2], -ThreeEpochE_two_epoch_demography[9, 4], ThreeEpochE_two_epoch_demography[9, 6])
# ThreeEpochE_two_epoch_demography_90 = data.frame(ThreeEpochE_two_epoch_Time_90, ThreeEpochE_two_epoch_NEffective_90)
# ThreeEpochE_two_epoch_NEffective_100 = c(ThreeEpochE_two_epoch_demography[10, 1], ThreeEpochE_two_epoch_demography[10, 3], ThreeEpochE_two_epoch_demography[10, 5])
# ThreeEpochE_two_epoch_Time_100 = c(-ThreeEpochE_two_epoch_demography[10, 2], -ThreeEpochE_two_epoch_demography[10, 4], ThreeEpochE_two_epoch_demography[10, 6])
# ThreeEpochE_two_epoch_demography_100 = data.frame(ThreeEpochE_two_epoch_Time_100, ThreeEpochE_two_epoch_NEffective_100)
# 
# ThreeEpochE_three_epoch_NEffective_10 = c(ThreeEpochE_three_epoch_demography[1, 1], ThreeEpochE_three_epoch_demography[1, 3], ThreeEpochE_three_epoch_demography[1, 5], ThreeEpochE_three_epoch_demography[1, 7])
# ThreeEpochE_three_epoch_Time_10 = c(-ThreeEpochE_three_epoch_demography[1, 2], -ThreeEpochE_three_epoch_demography[1, 4], -ThreeEpochE_three_epoch_demography[1, 6], ThreeEpochE_three_epoch_demography[1, 8])
# ThreeEpochE_three_epoch_demography_10 = data.frame(ThreeEpochE_three_epoch_Time_10, ThreeEpochE_three_epoch_NEffective_10)
# ThreeEpochE_three_epoch_NEffective_20 = c(ThreeEpochE_three_epoch_demography[2, 1], ThreeEpochE_three_epoch_demography[2, 3], ThreeEpochE_three_epoch_demography[2, 5], ThreeEpochE_three_epoch_demography[2, 7])
# ThreeEpochE_three_epoch_Time_20 = c(-ThreeEpochE_three_epoch_demography[2, 2], -ThreeEpochE_three_epoch_demography[2, 4], -ThreeEpochE_three_epoch_demography[2, 6], ThreeEpochE_three_epoch_demography[2, 8])
# ThreeEpochE_three_epoch_demography_20 = data.frame(ThreeEpochE_three_epoch_Time_20, ThreeEpochE_three_epoch_NEffective_20)
# ThreeEpochE_three_epoch_NEffective_30 = c(ThreeEpochE_three_epoch_demography[3, 1], ThreeEpochE_three_epoch_demography[3, 3], ThreeEpochE_three_epoch_demography[3, 5], ThreeEpochE_three_epoch_demography[3, 7])
# ThreeEpochE_three_epoch_Time_30 = c(-ThreeEpochE_three_epoch_demography[3, 2], -ThreeEpochE_three_epoch_demography[3, 4], -ThreeEpochE_three_epoch_demography[3, 6], ThreeEpochE_three_epoch_demography[3, 8])
# ThreeEpochE_three_epoch_demography_30 = data.frame(ThreeEpochE_three_epoch_Time_30, ThreeEpochE_three_epoch_NEffective_30)
# ThreeEpochE_three_epoch_NEffective_40 = c(ThreeEpochE_three_epoch_demography[4, 1], ThreeEpochE_three_epoch_demography[4, 3], ThreeEpochE_three_epoch_demography[4, 5], ThreeEpochE_three_epoch_demography[4, 7])
# ThreeEpochE_three_epoch_Time_40 = c(-ThreeEpochE_three_epoch_demography[4, 2], -ThreeEpochE_three_epoch_demography[4, 4], -ThreeEpochE_three_epoch_demography[4, 6], ThreeEpochE_three_epoch_demography[4, 8])
# ThreeEpochE_three_epoch_demography_40 = data.frame(ThreeEpochE_three_epoch_Time_40, ThreeEpochE_three_epoch_NEffective_40)
# ThreeEpochE_three_epoch_NEffective_50 = c(ThreeEpochE_three_epoch_demography[5, 1], ThreeEpochE_three_epoch_demography[5, 3], ThreeEpochE_three_epoch_demography[5, 5], ThreeEpochE_three_epoch_demography[5, 7])
# ThreeEpochE_three_epoch_Time_50 = c(-ThreeEpochE_three_epoch_demography[5, 2], -ThreeEpochE_three_epoch_demography[5, 4], -ThreeEpochE_three_epoch_demography[5, 6], ThreeEpochE_three_epoch_demography[5, 8])
# ThreeEpochE_three_epoch_demography_50 = data.frame(ThreeEpochE_three_epoch_Time_50, ThreeEpochE_three_epoch_NEffective_50)
# ThreeEpochE_three_epoch_NEffective_60 = c(ThreeEpochE_three_epoch_demography[6, 1], ThreeEpochE_three_epoch_demography[6, 3], ThreeEpochE_three_epoch_demography[6, 5], ThreeEpochE_three_epoch_demography[6, 7])
# ThreeEpochE_three_epoch_Time_60 = c(-ThreeEpochE_three_epoch_demography[6, 2], -ThreeEpochE_three_epoch_demography[6, 4], -ThreeEpochE_three_epoch_demography[6, 6], ThreeEpochE_three_epoch_demography[6, 8])
# ThreeEpochE_three_epoch_demography_60 = data.frame(ThreeEpochE_three_epoch_Time_60, ThreeEpochE_three_epoch_NEffective_60)
# ThreeEpochE_three_epoch_NEffective_70 = c(ThreeEpochE_three_epoch_demography[7, 1], ThreeEpochE_three_epoch_demography[7, 3], ThreeEpochE_three_epoch_demography[7, 5], ThreeEpochE_three_epoch_demography[7, 7])
# ThreeEpochE_three_epoch_Time_70 = c(-ThreeEpochE_three_epoch_demography[7, 2], -ThreeEpochE_three_epoch_demography[7, 4], -ThreeEpochE_three_epoch_demography[7, 6], ThreeEpochE_three_epoch_demography[7, 8])
# ThreeEpochE_three_epoch_demography_70 = data.frame(ThreeEpochE_three_epoch_Time_70, ThreeEpochE_three_epoch_NEffective_70)
# ThreeEpochE_three_epoch_NEffective_80 = c(ThreeEpochE_three_epoch_demography[8, 1], ThreeEpochE_three_epoch_demography[8, 3], ThreeEpochE_three_epoch_demography[8, 5], ThreeEpochE_three_epoch_demography[8, 7])
# ThreeEpochE_three_epoch_Time_80 = c(-ThreeEpochE_three_epoch_demography[8, 2], -ThreeEpochE_three_epoch_demography[8, 4], -ThreeEpochE_three_epoch_demography[8, 6], ThreeEpochE_three_epoch_demography[8, 8])
# ThreeEpochE_three_epoch_demography_80 = data.frame(ThreeEpochE_three_epoch_Time_80, ThreeEpochE_three_epoch_NEffective_80)
# ThreeEpochE_three_epoch_NEffective_90 = c(ThreeEpochE_three_epoch_demography[9, 1], ThreeEpochE_three_epoch_demography[9, 3], ThreeEpochE_three_epoch_demography[9, 5], ThreeEpochE_three_epoch_demography[9, 7])
# ThreeEpochE_three_epoch_Time_90 = c(-ThreeEpochE_three_epoch_demography[9, 2], -ThreeEpochE_three_epoch_demography[9, 4], -ThreeEpochE_three_epoch_demography[9, 6], ThreeEpochE_three_epoch_demography[9, 8])
# ThreeEpochE_three_epoch_demography_90 = data.frame(ThreeEpochE_three_epoch_Time_90, ThreeEpochE_three_epoch_NEffective_90)
# ThreeEpochE_three_epoch_NEffective_100 = c(ThreeEpochE_three_epoch_demography[10, 1], ThreeEpochE_three_epoch_demography[10, 3], ThreeEpochE_three_epoch_demography[10, 5], ThreeEpochE_three_epoch_demography[10, 7])
# ThreeEpochE_three_epoch_Time_100 = c(-ThreeEpochE_three_epoch_demography[10, 2], -ThreeEpochE_three_epoch_demography[10, 4], -ThreeEpochE_three_epoch_demography[10, 6], ThreeEpochE_three_epoch_demography[10, 8])
# ThreeEpochE_three_epoch_demography_100 = data.frame(ThreeEpochE_three_epoch_Time_100, ThreeEpochE_three_epoch_NEffective_100)
# 
# ggplot(ThreeEpochE_two_epoch_demography_10, aes(ThreeEpochE_two_epoch_Time_10, ThreeEpochE_two_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='dotted') + 
#   geom_step(data=ThreeEpochE_two_epoch_demography_20, aes(ThreeEpochE_two_epoch_Time_20, ThreeEpochE_two_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='dotted') +
#   geom_step(data=ThreeEpochE_two_epoch_demography_30, aes(ThreeEpochE_two_epoch_Time_30, ThreeEpochE_two_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='dotted') +
#   geom_step(data=ThreeEpochE_two_epoch_demography_40, aes(ThreeEpochE_two_epoch_Time_40, ThreeEpochE_two_epoch_NEffective_40, color='N=40'), linewidth=1, linetype='dotted') +
#   geom_step(data=ThreeEpochE_two_epoch_demography_50, aes(ThreeEpochE_two_epoch_Time_50, ThreeEpochE_two_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='dotted') +
#   geom_step(data=ThreeEpochE_two_epoch_demography_60, aes(ThreeEpochE_two_epoch_Time_60, ThreeEpochE_two_epoch_NEffective_60, color='N=60'), linewidth=1, linetype='dotted') +
#   geom_step(data=ThreeEpochE_two_epoch_demography_70, aes(ThreeEpochE_two_epoch_Time_70, ThreeEpochE_two_epoch_NEffective_70, color='N=70'), linewidth=1, linetype='dotted') +
#   geom_step(data=ThreeEpochE_two_epoch_demography_80, aes(ThreeEpochE_two_epoch_Time_80, ThreeEpochE_two_epoch_NEffective_80, color='N=80'), linewidth=1, linetype='dotted') +
#   geom_step(data=ThreeEpochE_two_epoch_demography_90, aes(ThreeEpochE_two_epoch_Time_90, ThreeEpochE_two_epoch_NEffective_90, color='N=90'), linewidth=1, linetype='dotted') +
#   geom_step(data=ThreeEpochE_two_epoch_demography_100, aes(ThreeEpochE_two_epoch_Time_100, ThreeEpochE_two_epoch_NEffective_100, color='N=100'), linewidth=1, linetype='dotted') +
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
#   ggtitle('Simulated 3EpE two Epoch Demography (N=10-100:10)')
# 
# ggplot(ThreeEpochE_two_epoch_demography_10, aes(ThreeEpochE_two_epoch_Time_10, ThreeEpochE_two_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='dashed') + 
#   # geom_step(data=ThreeEpochE_two_epoch_demography_20, aes(ThreeEpochE_two_epoch_Time_20, ThreeEpochE_two_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='dashed') +
#   # geom_step(data=ThreeEpochE_two_epoch_demography_30, aes(ThreeEpochE_two_epoch_Time_30, ThreeEpochE_two_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='dashed') +
#   # geom_step(data=ThreeEpochE_two_epoch_demography_40, aes(ThreeEpochE_two_epoch_Time_40, ThreeEpochE_two_epoch_NEffective_40, color='N=40'), linewidth=1, linetype='dashed') +
#   # geom_step(data=ThreeEpochE_two_epoch_demography_50, aes(ThreeEpochE_two_epoch_Time_50, ThreeEpochE_two_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='dashed') +
#   # geom_step(data=ThreeEpochE_two_epoch_demography_60, aes(ThreeEpochE_two_epoch_Time_60, ThreeEpochE_two_epoch_NEffective_60, color='N=60'), linewidth=1, linetype='dashed') +
#   # geom_step(data=ThreeEpochE_two_epoch_demography_70, aes(ThreeEpochE_two_epoch_Time_70, ThreeEpochE_two_epoch_NEffective_70, color='N=70'), linewidth=1, linetype='dashed') +
#   # geom_step(data=ThreeEpochE_two_epoch_demography_80, aes(ThreeEpochE_two_epoch_Time_80, ThreeEpochE_two_epoch_NEffective_80, color='N=80'), linewidth=1, linetype='dashed') +
#   # geom_step(data=ThreeEpochE_two_epoch_demography_90, aes(ThreeEpochE_two_epoch_Time_90, ThreeEpochE_two_epoch_NEffective_90, color='N=90'), linewidth=1, linetype='dashed') +
#   # geom_step(data=ThreeEpochE_two_epoch_demography_100, aes(ThreeEpochE_two_epoch_Time_100, ThreeEpochE_two_epoch_NEffective_100, color='#N=100'), linewidth=1, linetype='dashed') +
#   # geom_step(data=ThreeEpochE_three_epoch_demography_10, aes(ThreeEpochE_three_epoch_Time_10, ThreeEpochE_three_epoch_NEffective_10, color='N=10'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_20, aes(ThreeEpochE_three_epoch_Time_20, ThreeEpochE_three_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_30, aes(ThreeEpochE_three_epoch_Time_30, ThreeEpochE_three_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_40, aes(ThreeEpochE_three_epoch_Time_40, ThreeEpochE_three_epoch_NEffective_40, color='N=40'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_50, aes(ThreeEpochE_three_epoch_Time_50, ThreeEpochE_three_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_60, aes(ThreeEpochE_three_epoch_Time_60, ThreeEpochE_three_epoch_NEffective_60, color='N=60'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_70, aes(ThreeEpochE_three_epoch_Time_70, ThreeEpochE_three_epoch_NEffective_70, color='N=70'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_80, aes(ThreeEpochE_three_epoch_Time_80, ThreeEpochE_three_epoch_NEffective_80, color='N=80'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_90, aes(ThreeEpochE_three_epoch_Time_90, ThreeEpochE_three_epoch_NEffective_90, color='N=90'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_100, aes(ThreeEpochE_three_epoch_Time_100, ThreeEpochE_three_epoch_NEffective_100, color='N=100'), linewidth=1, linetype='solid') +
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
#   ggtitle('Simulated 3EpE Best-fitting Demography (N=10-100:10)')
# 
# ggplot(ThreeEpochE_three_epoch_demography_10, aes(ThreeEpochE_three_epoch_Time_10, ThreeEpochE_three_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='solid') + 
#   geom_step(data=ThreeEpochE_three_epoch_demography_20, aes(ThreeEpochE_three_epoch_Time_20, ThreeEpochE_three_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_30, aes(ThreeEpochE_three_epoch_Time_30, ThreeEpochE_three_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_40, aes(ThreeEpochE_three_epoch_Time_40, ThreeEpochE_three_epoch_NEffective_40, color='N=40'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_50, aes(ThreeEpochE_three_epoch_Time_50, ThreeEpochE_three_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_60, aes(ThreeEpochE_three_epoch_Time_60, ThreeEpochE_three_epoch_NEffective_60, color='N=60'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_70, aes(ThreeEpochE_three_epoch_Time_70, ThreeEpochE_three_epoch_NEffective_70, color='N=70'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_80, aes(ThreeEpochE_three_epoch_Time_80, ThreeEpochE_three_epoch_NEffective_80, color='N=80'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_90, aes(ThreeEpochE_three_epoch_Time_90, ThreeEpochE_three_epoch_NEffective_90, color='N=90'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_100, aes(ThreeEpochE_three_epoch_Time_100, ThreeEpochE_three_epoch_NEffective_100, color='N=100'), linewidth=1, linetype='solid') +
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
#   ggtitle('Simulated 3EpE Three Epoch Demography (N=10-100:10)')
# 
# # ggplot(ThreeEpochE_three_epoch_demography_20, aes(ThreeEpochE_three_epoch_Time_20, ThreeEpochE_three_epoch_NEffective_20color='#b35806')) + geom_step(linewidth=1, linetype='solid') + 
# #   # geom_step(data=ThreeEpochE_three_epoch_demography_20, aes(ThreeEpochE_three_epoch_Time_20, ThreeEpochE_three_epoch_NEffective_20, color='#b35806'), linewidth=1, linetype='solid') +
# #   geom_step(data=ThreeEpochE_three_epoch_demography_30, aes(ThreeEpochE_three_epoch_Time_30, ThreeEpochE_three_epoch_NEffective_30, color='#e08214'), linewidth=1, linetype='solid') +
# #   geom_step(data=ThreeEpochE_three_epoch_demography_40, aes(ThreeEpochE_three_epoch_Time_40, ThreeEpochE_three_epoch_NEffective_40, color='#fdb863'), linewidth=1, linetype='solid') +
# #   geom_step(data=ThreeEpochE_three_epoch_demography_50, aes(ThreeEpochE_three_epoch_Time_50, ThreeEpochE_three_epoch_NEffective_50, color='#fee0b6'), linewidth=1, linetype='solid') +
# #   geom_step(data=ThreeEpochE_three_epoch_demography_60, aes(ThreeEpochE_three_epoch_Time_60, ThreeEpochE_three_epoch_NEffective_60, color='#d8daeb'), linewidth=1, linetype='solid') +
# #   geom_step(data=ThreeEpochE_three_epoch_demography_70, aes(ThreeEpochE_three_epoch_Time_70, ThreeEpochE_three_epoch_NEffective_70, color='#b2abd2'), linewidth=1, linetype='solid') +
# #   geom_step(data=ThreeEpochE_three_epoch_demography_80, aes(ThreeEpochE_three_epoch_Time_80, ThreeEpochE_three_epoch_NEffective_80, color='#8073ac'), linewidth=1, linetype='solid') +
# #   geom_step(data=ThreeEpochE_three_epoch_demography_90, aes(ThreeEpochE_three_epoch_Time_90, ThreeEpochE_three_epoch_NEffective_90, color='#542788'), linewidth=1, linetype='solid') +
# #   geom_step(data=ThreeEpochE_three_epoch_demography_100, aes(ThreeEpochE_three_epoch_Time_100, ThreeEpochE_three_epoch_NEffective_100, color='#2d004b'), linewidth=1, linetype='solid') +
# #   scale_color_manual(name='Sample Size',
# #                      breaks=c('N=10', 'N=20', 'N=30', 'N=40', 'N=50', 'N=60', 'N=70', 'N=80', 'N=90', 'N=100'),
# #                      values=c('N=10'='#7f3b08',
# #                        'N=20'='#b35806',
# #                        'N=30'='#e08214',
# #                        'N=40'='#fdb863',
# #                        'N=50'='#fee0b6',
# #                        'N=60'='#d8daeb',
# #                        'N=70'='#b2abd2',
# #                        'N=80'='#8073ac',
# #                        'N=90'='#542788',
# #                        'N=100'='#2d004b')) +
# #   theme_bw() +
# #   ylab('Effective Population Size') +
# #   xlab('Time in Years') +
# #   ggtitle('Simulated 3EpE Three Epoch Demography, 10-100:10')
# 
# # NAnc Estimate by Sample Size
# sample_size = c(10, 20, 30, 40, 50, 60, 70, 80, 90, 100)
# 
# NAnc_df = data.frame(sample_size, ThreeEpochE_one_epoch_NAnc, ThreeEpochE_two_epoch_NAnc, ThreeEpochE_three_epoch_NAnc)
# NAnc_df = melt(NAnc_df, id='sample_size')
# 
# ggplot(data=NAnc_df, aes(x=sample_size, y=value, color=variable)) + geom_line() +
#   xlab('Sample size') +
#   ylab('Estimated ancestral effective population size') +
#   ggtitle('Simulated 3EpE NAnc by sample size (N=10-100:10)') +
#   theme_bw() +
#   guides(color=guide_legend(title="Epoch")) +
#   scale_color_manual(
#     labels=c('One-epoch', 'Two-epoch', 'Three-epoch'),
#     values=c('red', 'blue', 'green')) +
#   geom_hline(yintercept=12378, color='black', linetype='dashed') +
#   scale_x_continuous(breaks=sample_size)
# 
# 
# # # Tennessen_3EpE 10-19:1
# ThreeEpochE_empirical_file_list = list()
# ThreeEpochE_one_epoch_file_list = list()
# ThreeEpochE_two_epoch_file_list = list()
# ThreeEpochE_three_epoch_file_list = list()
# ThreeEpochE_one_epoch_AIC = c()
# ThreeEpochE_one_epoch_LL = c()
# ThreeEpochE_one_epoch_theta = c()
# ThreeEpochE_one_epoch_allele_sum = c()
# ThreeEpochE_two_epoch_AIC = c()
# ThreeEpochE_two_epoch_LL = c()
# ThreeEpochE_two_epoch_theta = c()
# ThreeEpochE_two_epoch_nu = c()
# ThreeEpochE_two_epoch_tau = c()
# ThreeEpochE_two_epoch_allele_sum = c()
# ThreeEpochE_three_epoch_AIC = c()
# ThreeEpochE_three_epoch_LL = c()
# ThreeEpochE_three_epoch_theta = c()
# ThreeEpochE_three_epoch_nuB = c()
# ThreeEpochE_three_epoch_nuF = c()
# ThreeEpochE_three_epoch_tauB = c()
# ThreeEpochE_three_epoch_tauF = c()
# ThreeEpochE_three_epoch_allele_sum = c()
# 
# # Loop through subdirectories and get relevant files
# for (i in seq(10, 19, by = 1)) {
#   subdirectory <- paste0("../Analysis/ThreeEpochExpansion_", i)
#   ThreeEpochE_empirical_file_path <- file.path(subdirectory, "syn_downsampled_sfs.txt")
#   ThreeEpochE_one_epoch_file_path <- file.path(subdirectory, "one_epoch_demography.txt")
#   ThreeEpochE_two_epoch_file_path <- file.path(subdirectory, "two_epoch_demography.txt")
#   ThreeEpochE_three_epoch_file_path <- file.path(subdirectory, "three_epoch_demography.txt")
#   
#   # Check if the file exists before attempting to read and print its contents
#   if (file.exists(ThreeEpochE_empirical_file_path)) {
#     this_empirical_sfs = read_input_sfs(ThreeEpochE_empirical_file_path)
#     ThreeEpochE_empirical_file_list[[subdirectory]] = this_empirical_sfs
#   }
#   if (file.exists(ThreeEpochE_one_epoch_file_path)) {
#     this_one_epoch_sfs = sfs_from_demography(ThreeEpochE_one_epoch_file_path)
#     ThreeEpochE_one_epoch_file_list[[subdirectory]] = this_one_epoch_sfs
#     ThreeEpochE_one_epoch_AIC = c(ThreeEpochE_one_epoch_AIC, AIC_from_demography(ThreeEpochE_one_epoch_file_path))
#     ThreeEpochE_one_epoch_LL = c(ThreeEpochE_one_epoch_LL, LL_from_demography(ThreeEpochE_one_epoch_file_path))
#     ThreeEpochE_one_epoch_theta = c(ThreeEpochE_one_epoch_theta, theta_from_demography(ThreeEpochE_one_epoch_file_path))
#     ThreeEpochE_one_epoch_allele_sum = c(ThreeEpochE_one_epoch_allele_sum, sum(this_one_epoch_sfs))
#   }
#   if (file.exists(ThreeEpochE_two_epoch_file_path)) {
#     this_two_epoch_sfs = sfs_from_demography(ThreeEpochE_two_epoch_file_path)
#     ThreeEpochE_two_epoch_file_list[[subdirectory]] = this_two_epoch_sfs
#     ThreeEpochE_two_epoch_AIC = c(ThreeEpochE_two_epoch_AIC, AIC_from_demography(ThreeEpochE_two_epoch_file_path))
#     ThreeEpochE_two_epoch_LL = c(ThreeEpochE_two_epoch_LL, LL_from_demography(ThreeEpochE_two_epoch_file_path))
#     ThreeEpochE_two_epoch_theta = c(ThreeEpochE_two_epoch_theta, theta_from_demography(ThreeEpochE_two_epoch_file_path))
#     ThreeEpochE_two_epoch_nu = c(ThreeEpochE_two_epoch_nu, nu_from_demography(ThreeEpochE_two_epoch_file_path))
#     ThreeEpochE_two_epoch_tau = c(ThreeEpochE_two_epoch_tau, tau_from_demography(ThreeEpochE_two_epoch_file_path))
#     ThreeEpochE_two_epoch_allele_sum = c(ThreeEpochE_two_epoch_allele_sum, sum(this_two_epoch_sfs))
#   }
#   if (file.exists(ThreeEpochE_three_epoch_file_path)) {
#     this_three_epoch_sfs = sfs_from_demography(ThreeEpochE_three_epoch_file_path)
#     ThreeEpochE_three_epoch_file_list[[subdirectory]] = this_three_epoch_sfs
#     ThreeEpochE_three_epoch_AIC = c(ThreeEpochE_three_epoch_AIC, AIC_from_demography(ThreeEpochE_three_epoch_file_path))
#     ThreeEpochE_three_epoch_LL = c(ThreeEpochE_three_epoch_LL, LL_from_demography(ThreeEpochE_three_epoch_file_path))
#     ThreeEpochE_three_epoch_theta = c(ThreeEpochE_three_epoch_theta, theta_from_demography(ThreeEpochE_three_epoch_file_path))
#     ThreeEpochE_three_epoch_nuB = c(ThreeEpochE_three_epoch_nuB, nuB_from_demography(ThreeEpochE_three_epoch_file_path))
#     ThreeEpochE_three_epoch_nuF = c(ThreeEpochE_three_epoch_nuF, nuF_from_demography(ThreeEpochE_three_epoch_file_path))
#     ThreeEpochE_three_epoch_tauB = c(ThreeEpochE_three_epoch_tauB, tauB_from_demography(ThreeEpochE_three_epoch_file_path))
#     ThreeEpochE_three_epoch_tauF = c(ThreeEpochE_three_epoch_tauF, tauF_from_demography(ThreeEpochE_three_epoch_file_path))
#     ThreeEpochE_three_epoch_allele_sum = c(ThreeEpochE_three_epoch_allele_sum, sum(this_three_epoch_sfs))
#   }  
# }
# 
# ThreeEpochE_AIC_df = data.frame(ThreeEpochE_one_epoch_AIC, ThreeEpochE_two_epoch_AIC, ThreeEpochE_three_epoch_AIC)
# # Reshape the data from wide to long format
# ThreeEpochE_df_long <- tidyr::gather(ThreeEpochE_AIC_df, key = "Epoch", value = "AIC", ThreeEpochE_one_epoch_AIC:ThreeEpochE_three_epoch_AIC)
# 
# # Increase the x-axis index by 4
# ThreeEpochE_df_long$Index <- rep(seq(10, 19, by = 1), times = 3)
# 
# # Create the line plot with ggplot2
# ggplot(ThreeEpochE_df_long, aes(x = Index, y = AIC, color = Epoch)) +
#   geom_line() +
#   geom_point() +
#   labs(title = "Simulated 3EpE AIC values by sample size (N=10-19:1)",
#        x = "Sample Size",
#        y = "AIC") +
#   scale_y_log10() +
#   scale_x_continuous(breaks=ThreeEpochE_df_long$Index) +
#   scale_color_manual(values = c("blue", "green", "red"),
#     label=c('One-epoch', 'Three-epoch', 'Two-epoch')) +
#   theme_bw()
# 
# ThreeEpochE_lambda_two_one = 2 * (ThreeEpochE_two_epoch_LL - ThreeEpochE_one_epoch_LL)
# ThreeEpochE_lambda_three_one = 2 * (ThreeEpochE_three_epoch_LL - ThreeEpochE_one_epoch_LL)
# ThreeEpochE_lambda_three_two = 2 * (ThreeEpochE_three_epoch_LL - ThreeEpochE_two_epoch_LL)
# 
# ThreeEpochE_lambda_df = data.frame(ThreeEpochE_lambda_two_one, ThreeEpochE_lambda_three_one, ThreeEpochE_lambda_three_two)
# # Reshape the data from wide to long format
# ThreeEpochE_df_long_lambda <- tidyr::gather(ThreeEpochE_lambda_df, key = "Full_vs_Null", value = "Lambda", ThreeEpochE_lambda_two_one:ThreeEpochE_lambda_three_two)
# # Increase the x-axis index by 4
# ThreeEpochE_df_long_lambda$Index <- rep(seq(10, 19, by = 1), times = 3)
# 
# # Create the line plot with ggplot2
# ggplot(ThreeEpochE_df_long_lambda, aes(x = Index, y = Lambda, color = Full_vs_Null)) +
#   geom_line() +
#   geom_point() +
#   labs(title = "Simulated 3EpE Lambda values by sample size (N=10-19:1)",
#        x = "Sample Size",
#        y = "2 * Lambda") +
#   # scale_y_log10() +
#   scale_x_continuous(breaks=ThreeEpochE_df_long$Index) +
#   scale_color_manual(values = c("blue", "green", "red"),
#     label=c('Three vs. One', 'Three vs. Two', 'Two vs. One')) +
#   theme_bw()
# 
# # Create the line plot with ggplot2
# ggplot(ThreeEpochE_df_long_lambda, aes(x = Index, y = Lambda, color = Full_vs_Null)) +
#   geom_line() +
#   geom_point() +
#   labs(title = "Simulated 3EpE Lambda values by sample size (N=10-19:1)",
#        x = "Sample Size",
#        y = "2 * Lambda") +
#   # scale_y_log10() +
#   scale_x_continuous(breaks=ThreeEpochE_df_long$Index) +
#   scale_color_manual(values = c("blue", "green", "red"),
#     label=c('Three vs. One', 'Three vs. Two', 'Two vs. One')) +
#   theme_bw() +
#   ylim(-5, 10)
# 
# ThreeEpochE_one_epoch_residual = c()
# ThreeEpochE_two_epoch_residual = c()
# ThreeEpochE_three_epoch_residual = c()
# 
# for (i in 1:10) {
#   ThreeEpochE_one_epoch_residual = c(ThreeEpochE_one_epoch_residual, compute_residual(unlist(ThreeEpochE_empirical_file_list[i]), unlist(ThreeEpochE_one_epoch_file_list[i])))
#   ThreeEpochE_two_epoch_residual = c(ThreeEpochE_two_epoch_residual, compute_residual(unlist(ThreeEpochE_empirical_file_list[i]), unlist(ThreeEpochE_two_epoch_file_list[i])))
#   ThreeEpochE_three_epoch_residual = c(ThreeEpochE_three_epoch_residual, compute_residual(unlist(ThreeEpochE_empirical_file_list[i]), unlist(ThreeEpochE_three_epoch_file_list[i])))
# }
# 
# ThreeEpochE_residual_df = data.frame(ThreeEpochE_one_epoch_residual, ThreeEpochE_two_epoch_residual, ThreeEpochE_three_epoch_residual)
# # Reshape the data from wide to long format
# ThreeEpochE_df_long_residual <- tidyr::gather(ThreeEpochE_residual_df, key = "Epoch", value = "residual", ThreeEpochE_one_epoch_residual:ThreeEpochE_three_epoch_residual)
# 
# # Increase the x-axis index by 4
# ThreeEpochE_df_long_residual$Index <- rep(seq(10, 19, by = 1), times = 3)
# 
# # Create the line plot with ggplot2
# ggplot(ThreeEpochE_df_long_residual, aes(x = Index, y = residual, color = Epoch)) +
#   geom_line() +
#   geom_point() +
#   labs(title = "3EpE residual values by sample size (N=10-19:1)",
#        x = "Sample Size",
#        y = "Residual") +
#   scale_y_log10() +
#   scale_x_continuous(breaks=ThreeEpochE_df_long$Index) +
#   scale_color_manual(values = c("blue", "green", "red"),
#     label=c('One-epoch', 'Three-epoch', 'Two-epoch')) +
#   theme_bw()
# 
# ggplot(ThreeEpochE_df_long, aes(x = Index, y = AIC, color = Epoch)) +
#   geom_line(linetype=3) +
#   geom_point() +
#   labs(title = "Simulated 3EpE AIC and residual by sample size (N=10-19:1)",
#        x = "Sample Size",
#        y = "AIC") +
#   scale_y_log10(sec.axis = sec_axis(~.*1, name="Residual")) +
#   scale_x_continuous(breaks=ThreeEpochE_df_long$Index) +
#   geom_line(data=ThreeEpochE_df_long_residual, aes(x = Index, y = residual*1, color = Epoch)) +
#   scale_color_manual(values = c("blue", "orange", "green", "violet", "red", "seagreen"),
#     label=c('One-epoch AIC', 'One-epoch residual',
#       'Three-epoch AIC', 'Three-epoch residual',
#       'Two-epoch AIC', 'Two-epoch residual')) +
#   theme_bw()
# 
# # Tennessen_3EpE population genetic constants
# 
# ThreeEpochE_mu = 1.5E-8
# 
# # NAnc = theta / (4 * allele_sum * mu)
# # generations = 2 * tau * theta / (4 * mu * allele_sum)
# # years = generations / 365
# # NCurr = nu * NAnc
# # generations_b = 2 * tauB * theta / (4 * mu * allele_sum)
# # generations_f = 2 * tauF * theta / (4 * mu * allele_sum)
# # NBottle = nuB * NAnc
# # NSince = nuF * NAnc
# 
# ThreeEpochE_one_epoch_NAnc = ThreeEpochE_one_epoch_theta / (4 * ThreeEpochE_one_epoch_allele_sum * ThreeEpochE_mu)
# ThreeEpochE_two_epoch_NAnc = ThreeEpochE_two_epoch_theta / (4 * ThreeEpochE_two_epoch_allele_sum * ThreeEpochE_mu)
# ThreeEpochE_two_epoch_NCurr = ThreeEpochE_two_epoch_nu * ThreeEpochE_two_epoch_NAnc
# ThreeEpochE_two_epoch_Time = 2 * 25 * ThreeEpochE_two_epoch_tau * ThreeEpochE_two_epoch_theta / (4 * ThreeEpochE_mu * ThreeEpochE_two_epoch_allele_sum)
# ThreeEpochE_three_epoch_NAnc = ThreeEpochE_three_epoch_theta / (4 * ThreeEpochE_three_epoch_allele_sum * ThreeEpochE_mu)
# ThreeEpochE_three_epoch_NBottle = ThreeEpochE_three_epoch_nuB * ThreeEpochE_three_epoch_NAnc
# ThreeEpochE_three_epoch_NCurr = ThreeEpochE_three_epoch_nuF * ThreeEpochE_three_epoch_NAnc
# ThreeEpochE_three_epoch_TimeBottleEnd = 2 * 25 * ThreeEpochE_three_epoch_tauF * ThreeEpochE_three_epoch_theta / (4 * ThreeEpochE_mu * ThreeEpochE_three_epoch_allele_sum)
# ThreeEpochE_three_epoch_TimeBottleStart = 2 * 25 * ThreeEpochE_three_epoch_tauB * ThreeEpochE_three_epoch_theta / (4 * ThreeEpochE_mu * ThreeEpochE_three_epoch_allele_sum) + ThreeEpochE_three_epoch_TimeBottleEnd
# ThreeEpochE_three_epoch_TimeTotal = ThreeEpochE_three_epoch_TimeBottleStart + ThreeEpochE_three_epoch_TimeBottleEnd
# 
# two_epoch_max_time = max(ThreeEpochE_two_epoch_Time)
# three_epoch_max_time = max(ThreeEpochE_three_epoch_TimeBottleStart)
# ThreeEpochE_two_epoch_max_time = rep(two_epoch_max_time, 10)
# # ThreeEpochE_two_epoch_max_time = rep(2E4, 10)
# ThreeEpochE_two_epoch_current_time = rep(0, 10)
# ThreeEpochE_two_epoch_demography = data.frame(ThreeEpochE_two_epoch_NAnc, ThreeEpochE_two_epoch_max_time, 
#   ThreeEpochE_two_epoch_NCurr, ThreeEpochE_two_epoch_Time, 
#   ThreeEpochE_two_epoch_NCurr, ThreeEpochE_two_epoch_current_time)
# 
# # ThreeEpochE_three_epoch_max_time = rep(100000000, 10)
# # ThreeEpochE_three_epoch_max_time = rep(5E6, 10)
# ThreeEpochE_three_epoch_max_time = rep(three_epoch_max_time, 10)
# ThreeEpochE_three_epoch_current_time = rep(0, 10)
# ThreeEpochE_three_epoch_demography = data.frame(ThreeEpochE_three_epoch_NAnc, ThreeEpochE_three_epoch_max_time,
#   ThreeEpochE_three_epoch_NBottle, ThreeEpochE_three_epoch_TimeBottleStart,
#   ThreeEpochE_three_epoch_NCurr, ThreeEpochE_three_epoch_TimeBottleEnd,
#   ThreeEpochE_three_epoch_NCurr, ThreeEpochE_three_epoch_current_time)
# 
# ThreeEpochE_two_epoch_NEffective_10 = c(ThreeEpochE_two_epoch_demography[1, 1], ThreeEpochE_two_epoch_demography[1, 3], ThreeEpochE_two_epoch_demography[1, 5])
# ThreeEpochE_two_epoch_Time_10 = c(-ThreeEpochE_two_epoch_demography[1, 2], -ThreeEpochE_two_epoch_demography[1, 4], ThreeEpochE_two_epoch_demography[1, 6])
# ThreeEpochE_two_epoch_demography_10 = data.frame(ThreeEpochE_two_epoch_Time_10, ThreeEpochE_two_epoch_NEffective_10)
# ThreeEpochE_two_epoch_NEffective_11 = c(ThreeEpochE_two_epoch_demography[2, 1], ThreeEpochE_two_epoch_demography[2, 3], ThreeEpochE_two_epoch_demography[2, 5])
# ThreeEpochE_two_epoch_Time_11 = c(-ThreeEpochE_two_epoch_demography[2, 2], -ThreeEpochE_two_epoch_demography[2, 4], ThreeEpochE_two_epoch_demography[2, 6])
# ThreeEpochE_two_epoch_demography_11 = data.frame(ThreeEpochE_two_epoch_Time_11, ThreeEpochE_two_epoch_NEffective_11)
# ThreeEpochE_two_epoch_NEffective_12 = c(ThreeEpochE_two_epoch_demography[3, 1], ThreeEpochE_two_epoch_demography[3, 3], ThreeEpochE_two_epoch_demography[3, 5])
# ThreeEpochE_two_epoch_Time_12 = c(-ThreeEpochE_two_epoch_demography[3, 2], -ThreeEpochE_two_epoch_demography[3, 4], ThreeEpochE_two_epoch_demography[3, 6])
# ThreeEpochE_two_epoch_demography_12 = data.frame(ThreeEpochE_two_epoch_Time_12, ThreeEpochE_two_epoch_NEffective_12)
# ThreeEpochE_two_epoch_NEffective_13 = c(ThreeEpochE_two_epoch_demography[4, 1], ThreeEpochE_two_epoch_demography[4, 3], ThreeEpochE_two_epoch_demography[4, 5])
# ThreeEpochE_two_epoch_Time_13 = c(-ThreeEpochE_two_epoch_demography[4, 2], -ThreeEpochE_two_epoch_demography[4, 4], ThreeEpochE_two_epoch_demography[4, 6])
# ThreeEpochE_two_epoch_demography_13 = data.frame(ThreeEpochE_two_epoch_Time_13, ThreeEpochE_two_epoch_NEffective_13)
# ThreeEpochE_two_epoch_NEffective_14 = c(ThreeEpochE_two_epoch_demography[5, 1], ThreeEpochE_two_epoch_demography[5, 3], ThreeEpochE_two_epoch_demography[5, 5])
# ThreeEpochE_two_epoch_Time_14 = c(-ThreeEpochE_two_epoch_demography[5, 2], -ThreeEpochE_two_epoch_demography[5, 4], ThreeEpochE_two_epoch_demography[5, 6])
# ThreeEpochE_two_epoch_demography_14 = data.frame(ThreeEpochE_two_epoch_Time_14, ThreeEpochE_two_epoch_NEffective_14)
# ThreeEpochE_two_epoch_NEffective_15 = c(ThreeEpochE_two_epoch_demography[6, 1], ThreeEpochE_two_epoch_demography[6, 3], ThreeEpochE_two_epoch_demography[6, 5])
# ThreeEpochE_two_epoch_Time_15 = c(-ThreeEpochE_two_epoch_demography[6, 2], -ThreeEpochE_two_epoch_demography[6, 4], ThreeEpochE_two_epoch_demography[6, 6])
# ThreeEpochE_two_epoch_demography_15 = data.frame(ThreeEpochE_two_epoch_Time_15, ThreeEpochE_two_epoch_NEffective_15)
# ThreeEpochE_two_epoch_NEffective_16 = c(ThreeEpochE_two_epoch_demography[7, 1], ThreeEpochE_two_epoch_demography[7, 3], ThreeEpochE_two_epoch_demography[7, 5])
# ThreeEpochE_two_epoch_Time_16 = c(-ThreeEpochE_two_epoch_demography[7, 2], -ThreeEpochE_two_epoch_demography[7, 4], ThreeEpochE_two_epoch_demography[7, 6])
# ThreeEpochE_two_epoch_demography_16 = data.frame(ThreeEpochE_two_epoch_Time_16, ThreeEpochE_two_epoch_NEffective_16)
# ThreeEpochE_two_epoch_NEffective_17 = c(ThreeEpochE_two_epoch_demography[8, 1], ThreeEpochE_two_epoch_demography[8, 3], ThreeEpochE_two_epoch_demography[8, 5])
# ThreeEpochE_two_epoch_Time_17 = c(-ThreeEpochE_two_epoch_demography[8, 2], -ThreeEpochE_two_epoch_demography[8, 4], ThreeEpochE_two_epoch_demography[8, 6])
# ThreeEpochE_two_epoch_demography_17 = data.frame(ThreeEpochE_two_epoch_Time_17, ThreeEpochE_two_epoch_NEffective_17)
# ThreeEpochE_two_epoch_NEffective_18 = c(ThreeEpochE_two_epoch_demography[9, 1], ThreeEpochE_two_epoch_demography[9, 3], ThreeEpochE_two_epoch_demography[9, 5])
# ThreeEpochE_two_epoch_Time_18 = c(-ThreeEpochE_two_epoch_demography[9, 2], -ThreeEpochE_two_epoch_demography[9, 4], ThreeEpochE_two_epoch_demography[9, 6])
# ThreeEpochE_two_epoch_demography_18 = data.frame(ThreeEpochE_two_epoch_Time_18, ThreeEpochE_two_epoch_NEffective_18)
# ThreeEpochE_two_epoch_NEffective_19 = c(ThreeEpochE_two_epoch_demography[10, 1], ThreeEpochE_two_epoch_demography[10, 3], ThreeEpochE_two_epoch_demography[10, 5])
# ThreeEpochE_two_epoch_Time_19 = c(-ThreeEpochE_two_epoch_demography[10, 2], -ThreeEpochE_two_epoch_demography[10, 4], ThreeEpochE_two_epoch_demography[10, 6])
# ThreeEpochE_two_epoch_demography_19 = data.frame(ThreeEpochE_two_epoch_Time_19, ThreeEpochE_two_epoch_NEffective_19)
# 
# ThreeEpochE_three_epoch_NEffective_10 = c(ThreeEpochE_three_epoch_demography[1, 1], ThreeEpochE_three_epoch_demography[1, 3], ThreeEpochE_three_epoch_demography[1, 5], ThreeEpochE_three_epoch_demography[1, 7])
# ThreeEpochE_three_epoch_Time_10 = c(-ThreeEpochE_three_epoch_demography[1, 2], -ThreeEpochE_three_epoch_demography[1, 4], -ThreeEpochE_three_epoch_demography[1, 6], ThreeEpochE_three_epoch_demography[1, 8])
# ThreeEpochE_three_epoch_demography_10 = data.frame(ThreeEpochE_three_epoch_Time_10, ThreeEpochE_three_epoch_NEffective_10)
# ThreeEpochE_three_epoch_NEffective_11 = c(ThreeEpochE_three_epoch_demography[2, 1], ThreeEpochE_three_epoch_demography[2, 3], ThreeEpochE_three_epoch_demography[2, 5], ThreeEpochE_three_epoch_demography[2, 7])
# ThreeEpochE_three_epoch_Time_11 = c(-ThreeEpochE_three_epoch_demography[2, 2], -ThreeEpochE_three_epoch_demography[2, 4], -ThreeEpochE_three_epoch_demography[2, 6], ThreeEpochE_three_epoch_demography[2, 8])
# ThreeEpochE_three_epoch_demography_11 = data.frame(ThreeEpochE_three_epoch_Time_11, ThreeEpochE_three_epoch_NEffective_11)
# ThreeEpochE_three_epoch_NEffective_12 = c(ThreeEpochE_three_epoch_demography[3, 1], ThreeEpochE_three_epoch_demography[3, 3], ThreeEpochE_three_epoch_demography[3, 5], ThreeEpochE_three_epoch_demography[3, 7])
# ThreeEpochE_three_epoch_Time_12 = c(-ThreeEpochE_three_epoch_demography[3, 2], -ThreeEpochE_three_epoch_demography[3, 4], -ThreeEpochE_three_epoch_demography[3, 6], ThreeEpochE_three_epoch_demography[3, 8])
# ThreeEpochE_three_epoch_demography_12 = data.frame(ThreeEpochE_three_epoch_Time_12, ThreeEpochE_three_epoch_NEffective_12)
# ThreeEpochE_three_epoch_NEffective_13 = c(ThreeEpochE_three_epoch_demography[4, 1], ThreeEpochE_three_epoch_demography[4, 3], ThreeEpochE_three_epoch_demography[4, 5], ThreeEpochE_three_epoch_demography[4, 7])
# ThreeEpochE_three_epoch_Time_13 = c(-ThreeEpochE_three_epoch_demography[4, 2], -ThreeEpochE_three_epoch_demography[4, 4], -ThreeEpochE_three_epoch_demography[4, 6], ThreeEpochE_three_epoch_demography[4, 8])
# ThreeEpochE_three_epoch_demography_13 = data.frame(ThreeEpochE_three_epoch_Time_13, ThreeEpochE_three_epoch_NEffective_13)
# ThreeEpochE_three_epoch_NEffective_14 = c(ThreeEpochE_three_epoch_demography[5, 1], ThreeEpochE_three_epoch_demography[5, 3], ThreeEpochE_three_epoch_demography[5, 5], ThreeEpochE_three_epoch_demography[5, 7])
# ThreeEpochE_three_epoch_Time_14 = c(-ThreeEpochE_three_epoch_demography[5, 2], -ThreeEpochE_three_epoch_demography[5, 4], -ThreeEpochE_three_epoch_demography[5, 6], ThreeEpochE_three_epoch_demography[5, 8])
# ThreeEpochE_three_epoch_demography_14 = data.frame(ThreeEpochE_three_epoch_Time_14, ThreeEpochE_three_epoch_NEffective_14)
# ThreeEpochE_three_epoch_NEffective_15 = c(ThreeEpochE_three_epoch_demography[6, 1], ThreeEpochE_three_epoch_demography[6, 3], ThreeEpochE_three_epoch_demography[6, 5], ThreeEpochE_three_epoch_demography[6, 7])
# ThreeEpochE_three_epoch_Time_15 = c(-ThreeEpochE_three_epoch_demography[6, 2], -ThreeEpochE_three_epoch_demography[6, 4], -ThreeEpochE_three_epoch_demography[6, 6], ThreeEpochE_three_epoch_demography[6, 8])
# ThreeEpochE_three_epoch_demography_15 = data.frame(ThreeEpochE_three_epoch_Time_15, ThreeEpochE_three_epoch_NEffective_15)
# ThreeEpochE_three_epoch_NEffective_16 = c(ThreeEpochE_three_epoch_demography[7, 1], ThreeEpochE_three_epoch_demography[7, 3], ThreeEpochE_three_epoch_demography[7, 5], ThreeEpochE_three_epoch_demography[7, 7])
# ThreeEpochE_three_epoch_Time_16 = c(-ThreeEpochE_three_epoch_demography[7, 2], -ThreeEpochE_three_epoch_demography[7, 4], -ThreeEpochE_three_epoch_demography[7, 6], ThreeEpochE_three_epoch_demography[7, 8])
# ThreeEpochE_three_epoch_demography_16 = data.frame(ThreeEpochE_three_epoch_Time_16, ThreeEpochE_three_epoch_NEffective_16)
# ThreeEpochE_three_epoch_NEffective_17 = c(ThreeEpochE_three_epoch_demography[8, 1], ThreeEpochE_three_epoch_demography[8, 3], ThreeEpochE_three_epoch_demography[8, 5], ThreeEpochE_three_epoch_demography[8, 7])
# ThreeEpochE_three_epoch_Time_17 = c(-ThreeEpochE_three_epoch_demography[8, 2], -ThreeEpochE_three_epoch_demography[8, 4], -ThreeEpochE_three_epoch_demography[8, 6], ThreeEpochE_three_epoch_demography[8, 8])
# ThreeEpochE_three_epoch_demography_17 = data.frame(ThreeEpochE_three_epoch_Time_17, ThreeEpochE_three_epoch_NEffective_17)
# ThreeEpochE_three_epoch_NEffective_18 = c(ThreeEpochE_three_epoch_demography[9, 1], ThreeEpochE_three_epoch_demography[9, 3], ThreeEpochE_three_epoch_demography[9, 5], ThreeEpochE_three_epoch_demography[9, 7])
# ThreeEpochE_three_epoch_Time_18 = c(-ThreeEpochE_three_epoch_demography[9, 2], -ThreeEpochE_three_epoch_demography[9, 4], -ThreeEpochE_three_epoch_demography[9, 6], ThreeEpochE_three_epoch_demography[9, 8])
# ThreeEpochE_three_epoch_demography_18 = data.frame(ThreeEpochE_three_epoch_Time_18, ThreeEpochE_three_epoch_NEffective_18)
# ThreeEpochE_three_epoch_NEffective_19 = c(ThreeEpochE_three_epoch_demography[10, 1], ThreeEpochE_three_epoch_demography[10, 3], ThreeEpochE_three_epoch_demography[10, 5], ThreeEpochE_three_epoch_demography[10, 7])
# ThreeEpochE_three_epoch_Time_19 = c(-ThreeEpochE_three_epoch_demography[10, 2], -ThreeEpochE_three_epoch_demography[10, 4], -ThreeEpochE_three_epoch_demography[10, 6], ThreeEpochE_three_epoch_demography[10, 8])
# ThreeEpochE_three_epoch_demography_19 = data.frame(ThreeEpochE_three_epoch_Time_19, ThreeEpochE_three_epoch_NEffective_19)
# 
# ggplot(ThreeEpochE_two_epoch_demography_10, aes(ThreeEpochE_two_epoch_Time_10, ThreeEpochE_two_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='dotted') + 
#   geom_step(data=ThreeEpochE_two_epoch_demography_11, aes(ThreeEpochE_two_epoch_Time_11, ThreeEpochE_two_epoch_NEffective_11, color='N=11'), linewidth=1, linetype='dotted') +
#   geom_step(data=ThreeEpochE_two_epoch_demography_12, aes(ThreeEpochE_two_epoch_Time_12, ThreeEpochE_two_epoch_NEffective_12, color='N=12'), linewidth=1, linetype='dotted') +
#   geom_step(data=ThreeEpochE_two_epoch_demography_13, aes(ThreeEpochE_two_epoch_Time_13, ThreeEpochE_two_epoch_NEffective_13, color='N=13'), linewidth=1, linetype='dotted') +
#   geom_step(data=ThreeEpochE_two_epoch_demography_14, aes(ThreeEpochE_two_epoch_Time_14, ThreeEpochE_two_epoch_NEffective_14, color='N=14'), linewidth=1, linetype='dotted') +
#   geom_step(data=ThreeEpochE_two_epoch_demography_15, aes(ThreeEpochE_two_epoch_Time_15, ThreeEpochE_two_epoch_NEffective_15, color='N=15'), linewidth=1, linetype='dotted') +
#   geom_step(data=ThreeEpochE_two_epoch_demography_16, aes(ThreeEpochE_two_epoch_Time_16, ThreeEpochE_two_epoch_NEffective_16, color='N=16'), linewidth=1, linetype='dotted') +
#   geom_step(data=ThreeEpochE_two_epoch_demography_17, aes(ThreeEpochE_two_epoch_Time_17, ThreeEpochE_two_epoch_NEffective_17, color='N=17'), linewidth=1, linetype='dotted') +
#   geom_step(data=ThreeEpochE_two_epoch_demography_18, aes(ThreeEpochE_two_epoch_Time_18, ThreeEpochE_two_epoch_NEffective_18, color='N=18'), linewidth=1, linetype='dotted') +
#   geom_step(data=ThreeEpochE_two_epoch_demography_19, aes(ThreeEpochE_two_epoch_Time_19, ThreeEpochE_two_epoch_NEffective_19, color='N=19'), linewidth=1, linetype='dotted') +
#   scale_color_manual(name='Sample Size',
#                      breaks=c('N=10', 'N=11', 'N=12', 'N=13', 'N=14', 'N=15', 'N=16', 'N=17', 'N=18', 'N=19'),
#                      values=c('N=10'='#7f3b08',
#                        'N=11'='#b35806',
#                        'N=12'='#e08214',
#                        'N=13'='#fdb863',
#                        'N=14'='#fee0b6',
#                        'N=15'='#d8daeb',
#                        'N=16'='#b2abd2',
#                        'N=17'='#8073ac',
#                        'N=18'='#542788',
#                        'N=19'='#2d004b')) +
#   theme_bw() +
#   ylab('Effective Population Size') +
#   xlab('Time in Years') +
#   ggtitle('Simulated 3EpE two Epoch Demography (N=10-19:1)')
# 
# ggplot(ThreeEpochE_two_epoch_demography_10, aes(ThreeEpochE_two_epoch_Time_10, ThreeEpochE_two_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='dashed') + 
#   geom_step(data=ThreeEpochE_two_epoch_demography_11, aes(ThreeEpochE_two_epoch_Time_11, ThreeEpochE_two_epoch_NEffective_11, color='N=11'), linewidth=1, linetype='dashed') +
#   geom_step(data=ThreeEpochE_two_epoch_demography_12, aes(ThreeEpochE_two_epoch_Time_12, ThreeEpochE_two_epoch_NEffective_12, color='N=12'), linewidth=1, linetype='dashed') +
#   geom_step(data=ThreeEpochE_two_epoch_demography_13, aes(ThreeEpochE_two_epoch_Time_13, ThreeEpochE_two_epoch_NEffective_13, color='N=13'), linewidth=1, linetype='dashed') +
#   geom_step(data=ThreeEpochE_two_epoch_demography_14, aes(ThreeEpochE_two_epoch_Time_14, ThreeEpochE_two_epoch_NEffective_14, color='N=14'), linewidth=1, linetype='dashed') +
#   geom_step(data=ThreeEpochE_two_epoch_demography_15, aes(ThreeEpochE_two_epoch_Time_15, ThreeEpochE_two_epoch_NEffective_15, color='N=15'), linewidth=1, linetype='dashed') +
#   # geom_step(data=ThreeEpochE_two_epoch_demography_16, aes(ThreeEpochE_two_epoch_Time_16, ThreeEpochE_two_epoch_NEffective_16, color='N=16'), linewidth=1, linetype='dashed') +
#   # geom_step(data=ThreeEpochE_two_epoch_demography_17, aes(ThreeEpochE_two_epoch_Time_17, ThreeEpochE_two_epoch_NEffective_17, color='N=17'), linewidth=1, linetype='dashed') +
#   # geom_step(data=ThreeEpochE_two_epoch_demography_18, aes(ThreeEpochE_two_epoch_Time_18, ThreeEpochE_two_epoch_NEffective_18, color='N=18'), linewidth=1, linetype='dashed') +
#   # geom_step(data=ThreeEpochE_two_epoch_demography_19, aes(ThreeEpochE_two_epoch_Time_19, ThreeEpochE_two_epoch_NEffective_19, color='N=19'), linewidth=1, linetype='dashed') +
#   # geom_step(data=ThreeEpochE_three_epoch_demography_10, aes(ThreeEpochE_three_epoch_Time_10, ThreeEpochE_three_epoch_NEffective_10, color='N=10'), linewidth=1, linetype='solid') +
#   # geom_step(data=ThreeEpochE_three_epoch_demography_11, aes(ThreeEpochE_three_epoch_Time_11, ThreeEpochE_three_epoch_NEffective_11, color='N=11'), linewidth=1, linetype='solid') +
#   # geom_step(data=ThreeEpochE_three_epoch_demography_12, aes(ThreeEpochE_three_epoch_Time_12, ThreeEpochE_three_epoch_NEffective_12, color='N=12'), linewidth=1, linetype='solid') +
#   # geom_step(data=ThreeEpochE_three_epoch_demography_13, aes(ThreeEpochE_three_epoch_Time_13, ThreeEpochE_three_epoch_NEffective_13, color='N=13'), linewidth=1, linetype='solid') +
#   # geom_step(data=ThreeEpochE_three_epoch_demography_14, aes(ThreeEpochE_three_epoch_Time_14, ThreeEpochE_three_epoch_NEffective_14, color='N=14'), linewidth=1, linetype='solid') +
#   # geom_step(data=ThreeEpochE_three_epoch_demography_15, aes(ThreeEpochE_three_epoch_Time_15, ThreeEpochE_three_epoch_NEffective_15, color='N=15'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_16, aes(ThreeEpochE_three_epoch_Time_16, ThreeEpochE_three_epoch_NEffective_16, color='N=16'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_17, aes(ThreeEpochE_three_epoch_Time_17, ThreeEpochE_three_epoch_NEffective_17, color='N=17'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_18, aes(ThreeEpochE_three_epoch_Time_18, ThreeEpochE_three_epoch_NEffective_18, color='N=18'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_19, aes(ThreeEpochE_three_epoch_Time_19, ThreeEpochE_three_epoch_NEffective_19, color='N=19'), linewidth=1, linetype='solid') +
#   scale_color_manual(name='Sample Size',
#                      breaks=c('N=10', 'N=11', 'N=12', 'N=13', 'N=14', 'N=15', 'N=16', 'N=17', 'N=18', 'N=19'),
#                      values=c('N=10'='#7f3b08',
#                        'N=11'='#b35806',
#                        'N=12'='#e08214',
#                        'N=13'='#fdb863',
#                        'N=14'='#fee0b6',
#                        'N=15'='#d8daeb',
#                        'N=16'='#b2abd2',
#                        'N=17'='#8073ac',
#                        'N=18'='#542788',
#                        'N=19'='#2d004b')) +
#   theme_bw() +
#   ylab('Effective Population Size') +
#   xlab('Time in Years') +
#   ggtitle('Simulated 3EpE Best-fitting Demography (N=10-19:1)')
# 
# ggplot(ThreeEpochE_three_epoch_demography_10, aes(ThreeEpochE_three_epoch_Time_10, ThreeEpochE_three_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='solid') + 
#   geom_step(data=ThreeEpochE_three_epoch_demography_11, aes(ThreeEpochE_three_epoch_Time_11, ThreeEpochE_three_epoch_NEffective_11, color='N=11'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_12, aes(ThreeEpochE_three_epoch_Time_12, ThreeEpochE_three_epoch_NEffective_12, color='N=12'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_13, aes(ThreeEpochE_three_epoch_Time_13, ThreeEpochE_three_epoch_NEffective_13, color='N=13'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_14, aes(ThreeEpochE_three_epoch_Time_14, ThreeEpochE_three_epoch_NEffective_14, color='N=14'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_15, aes(ThreeEpochE_three_epoch_Time_15, ThreeEpochE_three_epoch_NEffective_15, color='N=15'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_16, aes(ThreeEpochE_three_epoch_Time_16, ThreeEpochE_three_epoch_NEffective_16, color='N=16'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_17, aes(ThreeEpochE_three_epoch_Time_17, ThreeEpochE_three_epoch_NEffective_17, color='N=17'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_18, aes(ThreeEpochE_three_epoch_Time_18, ThreeEpochE_three_epoch_NEffective_18, color='N=18'), linewidth=1, linetype='solid') +
#   geom_step(data=ThreeEpochE_three_epoch_demography_19, aes(ThreeEpochE_three_epoch_Time_19, ThreeEpochE_three_epoch_NEffective_19, color='N=19'), linewidth=1, linetype='solid') +
#   scale_color_manual(name='Sample Size',
#                      breaks=c('N=10', 'N=11', 'N=12', 'N=13', 'N=14', 'N=15', 'N=16', 'N=17', 'N=18', 'N=19'),
#                      values=c('N=10'='#7f3b08',
#                        'N=11'='#b35806',
#                        'N=12'='#e08214',
#                        'N=13'='#fdb863',
#                        'N=14'='#fee0b6',
#                        'N=15'='#d8daeb',
#                        'N=16'='#b2abd2',
#                        'N=17'='#8073ac',
#                        'N=18'='#542788',
#                        'N=19'='#2d004b')) +
#   theme_bw() +
#   ylab('Effective Population Size') +
#   xlab('Time in Years') +
#   ggtitle('Simulated 3EpE Three Epoch Demography (N=10-19:1)')
# 
# # ggplot(ThreeEpochE_three_epoch_demography_11, aes(ThreeEpochE_three_epoch_Time_11, ThreeEpochE_three_epoch_NEffective_11)) + geom_step(color='#b35806', linewidth=1, linetype='solid') + 
# #   # geom_step(data=ThreeEpochE_three_epoch_demography_11, aes(ThreeEpochE_three_epoch_Time_11, ThreeEpochE_three_epoch_NEffective_11), color='#b35806', linewidth=1, linetype='solid') +
# #   geom_step(data=ThreeEpochE_three_epoch_demography_12, aes(ThreeEpochE_three_epoch_Time_12, ThreeEpochE_three_epoch_NEffective_12), color='#e08214', linewidth=1, linetype='solid') +
# #   geom_step(data=ThreeEpochE_three_epoch_demography_13, aes(ThreeEpochE_three_epoch_Time_13, ThreeEpochE_three_epoch_NEffective_13), color='#fdb863', linewidth=1, linetype='solid') +
# #   geom_step(data=ThreeEpochE_three_epoch_demography_14, aes(ThreeEpochE_three_epoch_Time_14, ThreeEpochE_three_epoch_NEffective_14), color='#fee0b6', linewidth=1, linetype='solid') +
# #   geom_step(data=ThreeEpochE_three_epoch_demography_15, aes(ThreeEpochE_three_epoch_Time_15, ThreeEpochE_three_epoch_NEffective_15), color='#d8daeb', linewidth=1, linetype='solid') +
# #   geom_step(data=ThreeEpochE_three_epoch_demography_16, aes(ThreeEpochE_three_epoch_Time_16, ThreeEpochE_three_epoch_NEffective_16), color='#b2abd2', linewidth=1, linetype='solid') +
# #   geom_step(data=ThreeEpochE_three_epoch_demography_17, aes(ThreeEpochE_three_epoch_Time_17, ThreeEpochE_three_epoch_NEffective_17), color='#8073ac', linewidth=1, linetype='solid') +
# #   geom_step(data=ThreeEpochE_three_epoch_demography_18, aes(ThreeEpochE_three_epoch_Time_18, ThreeEpochE_three_epoch_NEffective_18), color='#542788', linewidth=1, linetype='solid') +
# #   geom_step(data=ThreeEpochE_three_epoch_demography_19, aes(ThreeEpochE_three_epoch_Time_19, ThreeEpochE_three_epoch_NEffective_19), color='#2d004b', linewidth=1, linetype='solid') +
# #   theme_bw() +
# #   ylab('Effective Population Size') +
# #   xlab('Time in Years') +
# #   ggtitle('Simulated 3EpE Three Epoch Demography (N=10-19:1)')
# 
# # NAnc Estimate by Sample Size
# sample_size = c(10, 11, 12, 13, 14, 15, 16, 17, 18, 19)
# 
# NAnc_df = data.frame(sample_size, ThreeEpochE_one_epoch_NAnc, ThreeEpochE_two_epoch_NAnc, ThreeEpochE_three_epoch_NAnc)
# NAnc_df = melt(NAnc_df, id='sample_size')
# 
# ggplot(data=NAnc_df, aes(x=sample_size, y=value, color=variable)) + geom_line() +
#   xlab('Sample size') +
#   ylab('Estimated ancestral effective population size') +
#   ggtitle('Simulated 3EpE NAnc by sample size (N=10-19:1)') +
#   theme_bw() +
#   guides(color=guide_legend(title="Epoch")) +
#   scale_color_manual(
#     labels=c('One-epoch', 'Two-epoch', 'Three-epoch'),
#     values=c('red', 'blue', 'green')) +
#   geom_hline(yintercept=12378, color='black', linetype='dashed') +
#   scale_x_continuous(breaks=sample_size)


##

### Three Epoch Expansion Demography

ThreeEpochE_empirical_file_list = list()
ThreeEpochE_one_epoch_file_list = list()
ThreeEpochE_two_epoch_file_list = list()
ThreeEpochE_three_epoch_file_list = list()
ThreeEpochE_one_epoch_AIC = c()
ThreeEpochE_one_epoch_LL = c()
ThreeEpochE_one_epoch_theta = c()
ThreeEpochE_one_epoch_allele_sum = c()
ThreeEpochE_two_epoch_AIC = c()
ThreeEpochE_two_epoch_LL = c()
ThreeEpochE_two_epoch_theta = c()
ThreeEpochE_two_epoch_nu = c()
ThreeEpochE_two_epoch_tau = c()
ThreeEpochE_two_epoch_allele_sum = c()
ThreeEpochE_three_epoch_AIC = c()
ThreeEpochE_three_epoch_LL = c()
ThreeEpochE_three_epoch_theta = c()
ThreeEpochE_three_epoch_nuB = c()
ThreeEpochE_three_epoch_nuF = c()
ThreeEpochE_three_epoch_tauB = c()
ThreeEpochE_three_epoch_tauF = c()
ThreeEpochE_three_epoch_allele_sum = c()


# Loop through subdirectories and get relevant files
for (i in c(10, 20, 30, 50, 100, 150, 200, 300, 500, 700)) {
  subdirectory <- paste0("../Analysis/ThreeEpochExpansion_", i)
  ThreeEpochE_empirical_file_path <- file.path(subdirectory, "syn_downsampled_sfs.txt")
  ThreeEpochE_one_epoch_file_path <- file.path(subdirectory, "one_epoch_demography.txt")
  ThreeEpochE_two_epoch_file_path <- file.path(subdirectory, "two_epoch_demography.txt")
  ThreeEpochE_three_epoch_file_path <- file.path(subdirectory, "three_epoch_demography.txt")
  
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
    ThreeEpochE_one_epoch_allele_sum = c(ThreeEpochE_one_epoch_allele_sum, sum(this_one_epoch_sfs))
  }
  if (file.exists(ThreeEpochE_two_epoch_file_path)) {
    this_two_epoch_sfs = sfs_from_demography(ThreeEpochE_two_epoch_file_path)
    ThreeEpochE_two_epoch_file_list[[subdirectory]] = this_two_epoch_sfs
    ThreeEpochE_two_epoch_AIC = c(ThreeEpochE_two_epoch_AIC, AIC_from_demography(ThreeEpochE_two_epoch_file_path))
    ThreeEpochE_two_epoch_LL = c(ThreeEpochE_two_epoch_LL, LL_from_demography(ThreeEpochE_two_epoch_file_path))
    ThreeEpochE_two_epoch_theta = c(ThreeEpochE_two_epoch_theta, theta_from_demography(ThreeEpochE_two_epoch_file_path))
    ThreeEpochE_two_epoch_nu = c(ThreeEpochE_two_epoch_nu, nu_from_demography(ThreeEpochE_two_epoch_file_path))
    ThreeEpochE_two_epoch_tau = c(ThreeEpochE_two_epoch_tau, tau_from_demography(ThreeEpochE_two_epoch_file_path))
    ThreeEpochE_two_epoch_allele_sum = c(ThreeEpochE_two_epoch_allele_sum, sum(this_two_epoch_sfs))
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
    ThreeEpochE_three_epoch_allele_sum = c(ThreeEpochE_three_epoch_allele_sum, sum(this_three_epoch_sfs))
  }  
}

ThreeEpochE_AIC_df = data.frame(ThreeEpochE_one_epoch_AIC, ThreeEpochE_two_epoch_AIC, ThreeEpochE_three_epoch_AIC)
# Reshape the data from wide to long format
ThreeEpochE_df_long <- tidyr::gather(ThreeEpochE_AIC_df, key = "Epoch", value = "AIC", ThreeEpochE_one_epoch_AIC:ThreeEpochE_three_epoch_AIC)

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
    label=c('One-epoch', 'Three-epoch', 'Two-epoch')) +
  theme_bw()

ThreeEpochE_lambda_two_one = 2 * (ThreeEpochE_two_epoch_LL - ThreeEpochE_one_epoch_LL)
ThreeEpochE_lambda_three_one = 2 * (ThreeEpochE_three_epoch_LL - ThreeEpochE_one_epoch_LL)
ThreeEpochE_lambda_three_two = 2 * (ThreeEpochE_three_epoch_LL - ThreeEpochE_two_epoch_LL)

ThreeEpochE_lambda_df = data.frame(ThreeEpochE_lambda_two_one, ThreeEpochE_lambda_three_one, ThreeEpochE_lambda_three_two)
# Reshape the data from wide to long format
ThreeEpochE_df_long_lambda <- tidyr::gather(ThreeEpochE_lambda_df, key = "Full_vs_Null", value = "Lambda", ThreeEpochE_lambda_two_one:ThreeEpochE_lambda_three_two)
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
    label=c('Three vs. One', 'Three vs. Two', 'Two vs. One')) +
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
    label=c('Three vs. One', 'Three vs. Two', 'Two vs. One')) +
  theme_bw()

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
    label=c('One-epoch', 'Three-epoch', 'Two-epoch')) +
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
      'Two-epoch AIC', 'Two-epoch residual')) +
  theme_bw()

# Tennessen_3EpE population genetic constants

ThreeEpochE_mu = 1.5E-8

# NAnc = theta / (4 * allele_sum * mu)
# generations = 2 * tau * theta / (4 * mu * allele_sum)
# years = generations / 365
# NCurr = nu * NAnc
# generations_b = 2 * tauB * theta / (4 * mu * allele_sum)
# generations_f = 2 * tauF * theta / (4 * mu * allele_sum)
# NBottle = nuB * NAnc
# NSince = nuF * NAnc

ThreeEpochE_one_epoch_NAnc = ThreeEpochE_one_epoch_theta / (4 * ThreeEpochE_one_epoch_allele_sum * ThreeEpochE_mu)
ThreeEpochE_two_epoch_NAnc = ThreeEpochE_two_epoch_theta / (4 * ThreeEpochE_two_epoch_allele_sum * ThreeEpochE_mu)
ThreeEpochE_two_epoch_NCurr = ThreeEpochE_two_epoch_nu * ThreeEpochE_two_epoch_NAnc
ThreeEpochE_two_epoch_Time = 2 * 25 * ThreeEpochE_two_epoch_tau * ThreeEpochE_two_epoch_theta / (4 * ThreeEpochE_mu * ThreeEpochE_two_epoch_allele_sum)
ThreeEpochE_three_epoch_NAnc = ThreeEpochE_three_epoch_theta / (4 * ThreeEpochE_three_epoch_allele_sum * ThreeEpochE_mu)
ThreeEpochE_three_epoch_NBottle = ThreeEpochE_three_epoch_nuB * ThreeEpochE_three_epoch_NAnc
ThreeEpochE_three_epoch_NCurr = ThreeEpochE_three_epoch_nuF * ThreeEpochE_three_epoch_NAnc
ThreeEpochE_three_epoch_TimeBottleEnd = 2 * 25 * ThreeEpochE_three_epoch_tauF * ThreeEpochE_three_epoch_theta / (4 * ThreeEpochE_mu * ThreeEpochE_three_epoch_allele_sum)
ThreeEpochE_three_epoch_TimeBottleStart = 2 * 25 * ThreeEpochE_three_epoch_tauB * ThreeEpochE_three_epoch_theta / (4 * ThreeEpochE_mu * ThreeEpochE_three_epoch_allele_sum) + ThreeEpochE_three_epoch_TimeBottleEnd
ThreeEpochE_three_epoch_TimeTotal = ThreeEpochE_three_epoch_TimeBottleStart + ThreeEpochE_three_epoch_TimeBottleEnd

two_epoch_max_time = max(ThreeEpochE_two_epoch_Time)
# three_epoch_max_time = max(ThreeEpochE_three_epoch_TimeBottleStart)
three_epoch_max_time = 19660623 + 1
# two_epoch_max_time = 13860728 + 1
ThreeEpochE_two_epoch_max_time = rep(two_epoch_max_time, 10)
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

ggplot(ThreeEpochE_two_epoch_demography_10, aes(ThreeEpochE_two_epoch_Time_10, ThreeEpochE_two_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='dotted') + 
  geom_step(data=ThreeEpochE_two_epoch_demography_20, aes(ThreeEpochE_two_epoch_Time_20, ThreeEpochE_two_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='dotted') +
  geom_step(data=ThreeEpochE_two_epoch_demography_30, aes(ThreeEpochE_two_epoch_Time_30, ThreeEpochE_two_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='dotted') +
  geom_step(data=ThreeEpochE_two_epoch_demography_50, aes(ThreeEpochE_two_epoch_Time_50, ThreeEpochE_two_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='dotted') +
  geom_step(data=ThreeEpochE_two_epoch_demography_100, aes(ThreeEpochE_two_epoch_Time_100, ThreeEpochE_two_epoch_NEffective_100, color='N=100'), linewidth=1, linetype='dotted') +
  geom_step(data=ThreeEpochE_two_epoch_demography_150, aes(ThreeEpochE_two_epoch_Time_150, ThreeEpochE_two_epoch_NEffective_150, color='N=150'), linewidth=1, linetype='dotted') +
  geom_step(data=ThreeEpochE_two_epoch_demography_200, aes(ThreeEpochE_two_epoch_Time_200, ThreeEpochE_two_epoch_NEffective_200, color='N=200'), linewidth=1, linetype='dotted') +
  geom_step(data=ThreeEpochE_two_epoch_demography_300, aes(ThreeEpochE_two_epoch_Time_300, ThreeEpochE_two_epoch_NEffective_300, color='N=300'), linewidth=1, linetype='dotted') +
  geom_step(data=ThreeEpochE_two_epoch_demography_500, aes(ThreeEpochE_two_epoch_Time_500, ThreeEpochE_two_epoch_NEffective_500, color='N=500'), linewidth=1, linetype='dotted') +
  geom_step(data=ThreeEpochE_two_epoch_demography_700, aes(ThreeEpochE_two_epoch_Time_700, ThreeEpochE_two_epoch_NEffective_700, color='N=700'), linewidth=1, linetype='dotted') +
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
  ggtitle('Simulated 3EpE two Epoch Demography')

ggplot(ThreeEpochE_two_epoch_demography_10, aes(ThreeEpochE_two_epoch_Time_10, ThreeEpochE_two_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='dashed') + 
  geom_step(data=ThreeEpochE_two_epoch_demography_20, aes(ThreeEpochE_two_epoch_Time_20, ThreeEpochE_two_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='dashed') +
  geom_step(data=ThreeEpochE_two_epoch_demography_30, aes(ThreeEpochE_two_epoch_Time_30, ThreeEpochE_two_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='dashed') +
  geom_step(data=ThreeEpochE_two_epoch_demography_50, aes(ThreeEpochE_two_epoch_Time_50, ThreeEpochE_two_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='dashed') +
  geom_step(data=ThreeEpochE_two_epoch_demography_100, aes(ThreeEpochE_two_epoch_Time_100, ThreeEpochE_two_epoch_NEffective_100, color='N=100'), linewidth=1, linetype='dashed') +
  geom_step(data=ThreeEpochE_two_epoch_demography_150, aes(ThreeEpochE_two_epoch_Time_150, ThreeEpochE_two_epoch_NEffective_150, color='N=150'), linewidth=1, linetype='dashed') +
  geom_step(data=ThreeEpochE_two_epoch_demography_200, aes(ThreeEpochE_two_epoch_Time_200, ThreeEpochE_two_epoch_NEffective_200, color='N=200'), linewidth=1, linetype='dashed') +
  # geom_step(data=ThreeEpochE_two_epoch_demography_300, aes(ThreeEpochE_two_epoch_Time_300, ThreeEpochE_two_epoch_NEffective_300, color='N=300'), linewidth=1, linetype='dashed') +
  geom_step(data=ThreeEpochE_two_epoch_demography_500, aes(ThreeEpochE_two_epoch_Time_500, ThreeEpochE_two_epoch_NEffective_500, color='N=500'), linewidth=1, linetype='dashed') +
  geom_step(data=ThreeEpochE_two_epoch_demography_700, aes(ThreeEpochE_two_epoch_Time_700, ThreeEpochE_two_epoch_NEffective_700, color='N=700'), linewidth=1, linetype='dashed') +
  # geom_step(data=ThreeEpochE_three_epoch_demography_10, aes(ThreeEpochE_three_epoch_Time_10, ThreeEpochE_three_epoch_NEffective_10, color='N=10'), linewidth=1, linetype='solid') +
  # geom_step(data=ThreeEpochE_three_epoch_demography_20, aes(ThreeEpochE_three_epoch_Time_20, ThreeEpochE_three_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='solid') +
  # geom_step(data=ThreeEpochE_three_epoch_demography_30, aes(ThreeEpochE_three_epoch_Time_30, ThreeEpochE_three_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='solid') +
  # geom_step(data=ThreeEpochE_three_epoch_demography_50, aes(ThreeEpochE_three_epoch_Time_50, ThreeEpochE_three_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='solid') +
  # geom_step(data=ThreeEpochE_three_epoch_demography_100, aes(ThreeEpochE_three_epoch_Time_100, ThreeEpochE_three_epoch_NEffective_100, color='N=100'), linewidth=1, linetype='solid') +
  # geom_step(data=ThreeEpochE_three_epoch_demography_150, aes(ThreeEpochE_three_epoch_Time_150, ThreeEpochE_three_epoch_NEffective_150, color='N=150'), linewidth=1, linetype='solid') +
  # geom_step(data=ThreeEpochE_three_epoch_demography_200, aes(ThreeEpochE_three_epoch_Time_200, ThreeEpochE_three_epoch_NEffective_200, color='N=200'), linewidth=1, linetype='solid') +
  geom_step(data=ThreeEpochE_three_epoch_demography_300, aes(ThreeEpochE_three_epoch_Time_300, ThreeEpochE_three_epoch_NEffective_300, color='N=300'), linewidth=1, linetype='solid') +
  # geom_step(data=ThreeEpochE_three_epoch_demography_500, aes(ThreeEpochE_three_epoch_Time_500, ThreeEpochE_three_epoch_NEffective_500, color='N=500'), linewidth=1, linetype='solid') +
  # geom_step(data=ThreeEpochE_three_epoch_demography_700, aes(ThreeEpochE_three_epoch_Time_700, ThreeEpochE_three_epoch_NEffective_700, color='N=700'), linewidth=1, linetype='solid') +
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
  ggtitle('Simulated 3EpE Best-fitting Demography')

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
  xlab('Time in Years') +
  ggtitle('Simulated 3EpE Three Epoch Demography')

ggplot(ThreeEpochE_three_epoch_demography_30, aes(ThreeEpochE_three_epoch_Time_30, ThreeEpochE_three_epoch_NEffective_30, color='N=30')) + geom_step(linewidth=1, linetype='solid') + 
  # geom_step(data=ThreeEpochE_three_epoch_demography_20, aes(ThreeEpochE_three_epoch_Time_20, ThreeEpochE_three_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='solid') +
  # geom_step(data=ThreeEpochE_three_epoch_demography_30, aes(ThreeEpochE_three_epoch_Time_30, ThreeEpochE_three_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='solid') +
  # geom_step(data=ThreeEpochE_three_epoch_demography_50, aes(ThreeEpochE_three_epoch_Time_50, ThreeEpochE_three_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='solid') +
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
  xlab('Time in Years') +
  ggtitle('Simulated 3EpE Three Epoch Demography')


# NAnc Estimate by Sample Size
sample_size = c(10, 20, 30, 50, 100, 150, 200, 300, 500, 700)

ggplot(data=NAnc_df, aes(x=sample_size, y=value, color=variable)) + geom_line() +
  xlab('Sample size') +
  ylab('Estimated ancestral effective population size') +
  ggtitle('Simulated 3EpE NAnc by sample size') +
  theme_bw() +
  guides(color=guide_legend(title="Epoch")) +
  scale_color_manual(
    labels=c('One-epoch', 'Two-epoch', 'Three-epoch'),
    values=c('red', 'blue', 'green')) +
  geom_hline(yintercept=30378, color='black', linetype='dashed') +
  scale_x_continuous(breaks=sample_size)
  