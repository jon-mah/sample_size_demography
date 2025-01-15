## Tennessen simulation

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

### Figure 5 Three Epoch Expansion Demography

gnomAD_empirical_file_list = list()
gnomAD_one_epoch_file_list = list()
gnomAD_two_epoch_file_list = list()
gnomAD_three_epoch_file_list = list()
gnomAD_one_epoch_AIC = c()
gnomAD_one_epoch_LL = c()
gnomAD_one_epoch_theta = c()
gnomAD_one_epoch_allele_sum = c()
gnomAD_two_epoch_AIC = c()
gnomAD_two_epoch_LL = c()
gnomAD_two_epoch_theta = c()
gnomAD_two_epoch_nu = c()
gnomAD_two_epoch_tau = c()
gnomAD_two_epoch_allele_sum = c()
gnomAD_three_epoch_AIC = c()
gnomAD_three_epoch_LL = c()
gnomAD_three_epoch_theta = c()
gnomAD_three_epoch_nuB = c()
gnomAD_three_epoch_nuF = c()
gnomAD_three_epoch_tauB = c()
gnomAD_three_epoch_tauF = c()
gnomAD_three_epoch_allele_sum = c()


# Loop through subdirectories and get relevant files
for (i in c(10, 20, 30, 50, 100, 150, 200, 300, 500, 700)) {
  subdirectory <- paste0("../Analysis/gnomAD_", i)
  gnomAD_empirical_file_path <- file.path(subdirectory, "syn_downsampled_sfs.txt")
  gnomAD_one_epoch_file_path <- file.path(subdirectory, "one_epoch_demography.txt")
  gnomAD_two_epoch_file_path <- file.path(subdirectory, "two_epoch_demography.txt")
  gnomAD_three_epoch_file_path <- file.path(subdirectory, "three_epoch_demography.txt")
  
  # Check if the file exists before attempting to read and print its contents
  if (file.exists(gnomAD_empirical_file_path)) {
    this_empirical_sfs = read_input_sfs(gnomAD_empirical_file_path)
    gnomAD_empirical_file_list[[subdirectory]] = this_empirical_sfs
  }
  if (file.exists(gnomAD_one_epoch_file_path)) {
    this_one_epoch_sfs = sfs_from_demography(gnomAD_one_epoch_file_path)
    gnomAD_one_epoch_file_list[[subdirectory]] = this_one_epoch_sfs
    gnomAD_one_epoch_AIC = c(gnomAD_one_epoch_AIC, AIC_from_demography(gnomAD_one_epoch_file_path))
    gnomAD_one_epoch_LL = c(gnomAD_one_epoch_LL, LL_from_demography(gnomAD_one_epoch_file_path))
    gnomAD_one_epoch_theta = c(gnomAD_one_epoch_theta, theta_from_demography(gnomAD_one_epoch_file_path))
    gnomAD_one_epoch_allele_sum = c(gnomAD_one_epoch_allele_sum, sum(this_one_epoch_sfs))
  }
  if (file.exists(gnomAD_two_epoch_file_path)) {
    this_two_epoch_sfs = sfs_from_demography(gnomAD_two_epoch_file_path)
    gnomAD_two_epoch_file_list[[subdirectory]] = this_two_epoch_sfs
    gnomAD_two_epoch_AIC = c(gnomAD_two_epoch_AIC, AIC_from_demography(gnomAD_two_epoch_file_path))
    gnomAD_two_epoch_LL = c(gnomAD_two_epoch_LL, LL_from_demography(gnomAD_two_epoch_file_path))
    gnomAD_two_epoch_theta = c(gnomAD_two_epoch_theta, theta_from_demography(gnomAD_two_epoch_file_path))
    gnomAD_two_epoch_nu = c(gnomAD_two_epoch_nu, nu_from_demography(gnomAD_two_epoch_file_path))
    gnomAD_two_epoch_tau = c(gnomAD_two_epoch_tau, tau_from_demography(gnomAD_two_epoch_file_path))
    gnomAD_two_epoch_allele_sum = c(gnomAD_two_epoch_allele_sum, sum(this_two_epoch_sfs))
  }
  if (file.exists(gnomAD_three_epoch_file_path)) {
    this_three_epoch_sfs = sfs_from_demography(gnomAD_three_epoch_file_path)
    gnomAD_three_epoch_file_list[[subdirectory]] = this_three_epoch_sfs
    gnomAD_three_epoch_AIC = c(gnomAD_three_epoch_AIC, AIC_from_demography(gnomAD_three_epoch_file_path))
    gnomAD_three_epoch_LL = c(gnomAD_three_epoch_LL, LL_from_demography(gnomAD_three_epoch_file_path))
    gnomAD_three_epoch_theta = c(gnomAD_three_epoch_theta, theta_from_demography(gnomAD_three_epoch_file_path))
    gnomAD_three_epoch_nuB = c(gnomAD_three_epoch_nuB, nuB_from_demography(gnomAD_three_epoch_file_path))
    gnomAD_three_epoch_nuF = c(gnomAD_three_epoch_nuF, nuF_from_demography(gnomAD_three_epoch_file_path))
    gnomAD_three_epoch_tauB = c(gnomAD_three_epoch_tauB, tauB_from_demography(gnomAD_three_epoch_file_path))
    gnomAD_three_epoch_tauF = c(gnomAD_three_epoch_tauF, tauF_from_demography(gnomAD_three_epoch_file_path))
    gnomAD_three_epoch_allele_sum = c(gnomAD_three_epoch_allele_sum, sum(this_three_epoch_sfs))
  }  
}

gnomAD_AIC_df = data.frame(gnomAD_one_epoch_AIC, gnomAD_two_epoch_AIC, gnomAD_three_epoch_AIC)
# Reshape the data from wide to long format
gnomAD_df_long <- tidyr::gather(gnomAD_AIC_df, key = "Epoch", value = "AIC", gnomAD_one_epoch_AIC:gnomAD_three_epoch_AIC)

# Increase the x-axis index by 4
gnomAD_df_long$Index <- rep(c(10, 20, 30, 50, 100, 150, 200, 300, 500, 700), times = 3)

# Create the line plot with ggplot2
ggplot(gnomAD_df_long, aes(x = Index, y = AIC, color = Epoch)) +
  geom_line() +
  geom_point() +
  labs(title = "gnomAD AIC values by sample size",
       x = "Sample Size",
       y = "AIC") +
  scale_y_log10() +
  scale_x_continuous(breaks=gnomAD_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('One-epoch', 'Three-epoch', 'Two-epoch')) +
  theme_bw()

gnomAD_lambda_two_one = 2 * (gnomAD_two_epoch_LL - gnomAD_one_epoch_LL)
gnomAD_lambda_three_one = 2 * (gnomAD_three_epoch_LL - gnomAD_one_epoch_LL)
gnomAD_lambda_three_two = 2 * (gnomAD_three_epoch_LL - gnomAD_two_epoch_LL)

gnomAD_lambda_df = data.frame(gnomAD_lambda_two_one, gnomAD_lambda_three_one, gnomAD_lambda_three_two)
# Reshape the data from wide to long format
gnomAD_df_long_lambda <- tidyr::gather(gnomAD_lambda_df, key = "Full_vs_Null", value = "Lambda", gnomAD_lambda_two_one:gnomAD_lambda_three_two)
# Increase the x-axis index by 4
gnomAD_df_long_lambda$Index <- rep(c(10, 20, 30, 50, 100, 150, 200, 300, 500, 700), times = 3)

# Create the line plot with ggplot2
ggplot(gnomAD_df_long_lambda, aes(x = Index, y = Lambda, color = Full_vs_Null)) +
  geom_line() +
  geom_point() +
  labs(title = "gnomAD Lambda values by sample size",
       x = "Sample Size",
       y = "2 * Lambda") +
  # scale_y_log10() +
  scale_x_continuous(breaks=gnomAD_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('Three vs. One', 'Three vs. Two', 'Two vs. One')) +
  theme_bw()

# Create the line plot with ggplot2
ggplot(gnomAD_df_long_lambda, aes(x = Index, y = Lambda, color = Full_vs_Null)) +
  geom_line() +
  geom_point() +
  labs(title = "gnomAD Lambda values by sample size",
       x = "Sample Size",
       y = "2 * Lambda") +
  # scale_y_log10() +
  scale_x_continuous(breaks=gnomAD_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('Three vs. One', 'Three vs. Two', 'Two vs. One')) +
  theme_bw()

gnomAD_one_epoch_residual = c()
gnomAD_two_epoch_residual = c()
gnomAD_three_epoch_residual = c()

for (i in 1:10) {
  gnomAD_one_epoch_residual = c(gnomAD_one_epoch_residual, compute_residual(unlist(gnomAD_empirical_file_list[i]), unlist(gnomAD_one_epoch_file_list[i])))
  gnomAD_two_epoch_residual = c(gnomAD_two_epoch_residual, compute_residual(unlist(gnomAD_empirical_file_list[i]), unlist(gnomAD_two_epoch_file_list[i])))
  gnomAD_three_epoch_residual = c(gnomAD_three_epoch_residual, compute_residual(unlist(gnomAD_empirical_file_list[i]), unlist(gnomAD_three_epoch_file_list[i])))
}

gnomAD_residual_df = data.frame(gnomAD_one_epoch_residual, gnomAD_two_epoch_residual, gnomAD_three_epoch_residual)
# Reshape the data from wide to long format
gnomAD_df_long_residual <- tidyr::gather(gnomAD_residual_df, key = "Epoch", value = "residual", gnomAD_one_epoch_residual:gnomAD_three_epoch_residual)

# Increase the x-axis index by 4
gnomAD_df_long_residual$Index <- rep(c(10, 20, 30, 50, 100, 150, 200, 300, 500, 700), times = 3)

# Create the line plot with ggplot2
ggplot(gnomAD_df_long_residual, aes(x = Index, y = residual, color = Epoch)) +
  geom_line() +
  geom_point() +
  labs(title = "gnomAD residual values by sample size",
       x = "Sample Size",
       y = "Residual") +
  scale_y_log10() +
  scale_x_continuous(breaks=gnomAD_df_long$Index) +
  scale_color_manual(values = c("blue", "green", "red"),
    label=c('One-epoch', 'Three-epoch', 'Two-epoch')) +
  theme_bw()

ggplot(gnomAD_df_long, aes(x = Index, y = AIC, color = Epoch)) +
  geom_line(linetype=3) +
  geom_point() +
  labs(title = "gnomAD AIC and residual by sample size",
       x = "Sample Size",
       y = "AIC") +
  scale_y_log10(sec.axis = sec_axis(~.*1, name="Residual")) +
  scale_x_continuous(breaks=gnomAD_df_long$Index) +
  geom_line(data=gnomAD_df_long_residual, aes(x = Index, y = residual*1, color = Epoch)) +
  scale_color_manual(values = c("blue", "orange", "green", "violet", "red", "seagreen"),
    label=c('One-epoch AIC', 'One-epoch residual',
      'Three-epoch AIC', 'Three-epoch residual',
      'Two-epoch AIC', 'Two-epoch residual')) +
  theme_bw()

# Tennessen_gnomAD population genetic constants

gnomAD_mu = 1.5E-8

# NAnc = theta / (4 * allele_sum * mu)
# generations = 2 * tau * theta / (4 * mu * allele_sum)
# years = generations / 365
# NCurr = nu * NAnc
# generations_b = 2 * tauB * theta / (4 * mu * allele_sum)
# generations_f = 2 * tauF * theta / (4 * mu * allele_sum)
# NBottle = nuB * NAnc
# NSince = nuF * NAnc

gnomAD_one_epoch_NAnc = gnomAD_one_epoch_theta / (4 * gnomAD_one_epoch_allele_sum * gnomAD_mu)
gnomAD_two_epoch_NAnc = gnomAD_two_epoch_theta / (4 * gnomAD_two_epoch_allele_sum * gnomAD_mu)
gnomAD_two_epoch_NCurr = gnomAD_two_epoch_nu * gnomAD_two_epoch_NAnc
gnomAD_two_epoch_Time = 2 * 25 * gnomAD_two_epoch_tau * gnomAD_two_epoch_theta / (4 * gnomAD_mu * gnomAD_two_epoch_allele_sum)
gnomAD_three_epoch_NAnc = gnomAD_three_epoch_theta / (4 * gnomAD_three_epoch_allele_sum * gnomAD_mu)
gnomAD_three_epoch_NBottle = gnomAD_three_epoch_nuB * gnomAD_three_epoch_NAnc
gnomAD_three_epoch_NCurr = gnomAD_three_epoch_nuF * gnomAD_three_epoch_NAnc
gnomAD_three_epoch_TimeBottleEnd = 2 * 25 * gnomAD_three_epoch_tauF * gnomAD_three_epoch_theta / (4 * gnomAD_mu * gnomAD_three_epoch_allele_sum)
gnomAD_three_epoch_TimeBottleStart = 2 * 25 * gnomAD_three_epoch_tauB * gnomAD_three_epoch_theta / (4 * gnomAD_mu * gnomAD_three_epoch_allele_sum) + gnomAD_three_epoch_TimeBottleEnd
gnomAD_three_epoch_TimeTotal = gnomAD_three_epoch_TimeBottleStart + gnomAD_three_epoch_TimeBottleEnd

two_epoch_max_time = max(gnomAD_two_epoch_Time)
# three_epoch_max_time = max(gnomAD_three_epoch_TimeBottleStart)
three_epoch_max_time = 250238473 + 1
two_epoch_max_time = 250238473 + 1
gnomAD_two_epoch_max_time = rep(two_epoch_max_time, 10)
# gnomAD_two_epoch_max_time = rep(2E4, 10)
gnomAD_two_epoch_current_time = rep(0, 10)
gnomAD_two_epoch_demography = data.frame(gnomAD_two_epoch_NAnc, gnomAD_two_epoch_max_time, 
  gnomAD_two_epoch_NCurr, gnomAD_two_epoch_Time, 
  gnomAD_two_epoch_NCurr, gnomAD_two_epoch_current_time)

# gnomAD_three_epoch_max_time = rep(100000000, 10)
# gnomAD_three_epoch_max_time = rep(5E6, 10)
gnomAD_three_epoch_max_time = rep(three_epoch_max_time, 10)
gnomAD_three_epoch_current_time = rep(0, 10)
gnomAD_three_epoch_demography = data.frame(gnomAD_three_epoch_NAnc, gnomAD_three_epoch_max_time,
  gnomAD_three_epoch_NBottle, gnomAD_three_epoch_TimeBottleStart,
  gnomAD_three_epoch_NCurr, gnomAD_three_epoch_TimeBottleEnd,
  gnomAD_three_epoch_NCurr, gnomAD_three_epoch_current_time)

gnomAD_two_epoch_NEffective_10 = c(gnomAD_two_epoch_demography[1, 1], gnomAD_two_epoch_demography[1, 3], gnomAD_two_epoch_demography[1, 5])
gnomAD_two_epoch_Time_10 = c(-gnomAD_two_epoch_demography[1, 2], -gnomAD_two_epoch_demography[1, 4], gnomAD_two_epoch_demography[1, 6])
gnomAD_two_epoch_demography_10 = data.frame(gnomAD_two_epoch_Time_10, gnomAD_two_epoch_NEffective_10)
gnomAD_two_epoch_NEffective_20 = c(gnomAD_two_epoch_demography[2, 1], gnomAD_two_epoch_demography[2, 3], gnomAD_two_epoch_demography[2, 5])
gnomAD_two_epoch_Time_20 = c(-gnomAD_two_epoch_demography[2, 2], -gnomAD_two_epoch_demography[2, 4], gnomAD_two_epoch_demography[2, 6])
gnomAD_two_epoch_demography_20 = data.frame(gnomAD_two_epoch_Time_20, gnomAD_two_epoch_NEffective_20)
gnomAD_two_epoch_NEffective_30 = c(gnomAD_two_epoch_demography[3, 1], gnomAD_two_epoch_demography[3, 3], gnomAD_two_epoch_demography[3, 5])
gnomAD_two_epoch_Time_30 = c(-gnomAD_two_epoch_demography[3, 2], -gnomAD_two_epoch_demography[3, 4], gnomAD_two_epoch_demography[3, 6])
gnomAD_two_epoch_demography_30 = data.frame(gnomAD_two_epoch_Time_30, gnomAD_two_epoch_NEffective_30)
gnomAD_two_epoch_NEffective_50 = c(gnomAD_two_epoch_demography[4, 1], gnomAD_two_epoch_demography[4, 3], gnomAD_two_epoch_demography[4, 5])
gnomAD_two_epoch_Time_50 = c(-gnomAD_two_epoch_demography[4, 2], -gnomAD_two_epoch_demography[4, 4], gnomAD_two_epoch_demography[4, 6])
gnomAD_two_epoch_demography_50 = data.frame(gnomAD_two_epoch_Time_50, gnomAD_two_epoch_NEffective_50)
gnomAD_two_epoch_NEffective_100 = c(gnomAD_two_epoch_demography[5, 1], gnomAD_two_epoch_demography[5, 3], gnomAD_two_epoch_demography[5, 5])
gnomAD_two_epoch_Time_100 = c(-gnomAD_two_epoch_demography[5, 2], -gnomAD_two_epoch_demography[5, 4], gnomAD_two_epoch_demography[5, 6])
gnomAD_two_epoch_demography_100 = data.frame(gnomAD_two_epoch_Time_100, gnomAD_two_epoch_NEffective_100)
gnomAD_two_epoch_NEffective_150 = c(gnomAD_two_epoch_demography[6, 1], gnomAD_two_epoch_demography[6, 3], gnomAD_two_epoch_demography[6, 5])
gnomAD_two_epoch_Time_150 = c(-gnomAD_two_epoch_demography[6, 2], -gnomAD_two_epoch_demography[6, 4], gnomAD_two_epoch_demography[6, 6])
gnomAD_two_epoch_demography_150 = data.frame(gnomAD_two_epoch_Time_150, gnomAD_two_epoch_NEffective_150)
gnomAD_two_epoch_NEffective_200 = c(gnomAD_two_epoch_demography[7, 1], gnomAD_two_epoch_demography[7, 3], gnomAD_two_epoch_demography[7, 5])
gnomAD_two_epoch_Time_200 = c(-gnomAD_two_epoch_demography[7, 2], -gnomAD_two_epoch_demography[7, 4], gnomAD_two_epoch_demography[7, 6])
gnomAD_two_epoch_demography_200 = data.frame(gnomAD_two_epoch_Time_200, gnomAD_two_epoch_NEffective_200)
gnomAD_two_epoch_NEffective_300 = c(gnomAD_two_epoch_demography[8, 1], gnomAD_two_epoch_demography[8, 3], gnomAD_two_epoch_demography[8, 5])
gnomAD_two_epoch_Time_300 = c(-gnomAD_two_epoch_demography[8, 2], -gnomAD_two_epoch_demography[8, 4], gnomAD_two_epoch_demography[8, 6])
gnomAD_two_epoch_demography_300 = data.frame(gnomAD_two_epoch_Time_300, gnomAD_two_epoch_NEffective_300)
gnomAD_two_epoch_NEffective_500 = c(gnomAD_two_epoch_demography[9, 1], gnomAD_two_epoch_demography[9, 3], gnomAD_two_epoch_demography[9, 5])
gnomAD_two_epoch_Time_500 = c(-gnomAD_two_epoch_demography[9, 2], -gnomAD_two_epoch_demography[9, 4], gnomAD_two_epoch_demography[9, 6])
gnomAD_two_epoch_demography_500 = data.frame(gnomAD_two_epoch_Time_500, gnomAD_two_epoch_NEffective_500)
gnomAD_two_epoch_NEffective_700 = c(gnomAD_two_epoch_demography[10, 1], gnomAD_two_epoch_demography[10, 3], gnomAD_two_epoch_demography[10, 5])
gnomAD_two_epoch_Time_700 = c(-gnomAD_two_epoch_demography[10, 2], -gnomAD_two_epoch_demography[10, 4], gnomAD_two_epoch_demography[10, 6])
gnomAD_two_epoch_demography_700 = data.frame(gnomAD_two_epoch_Time_700, gnomAD_two_epoch_NEffective_700)

gnomAD_three_epoch_NEffective_10 = c(gnomAD_three_epoch_demography[1, 1], gnomAD_three_epoch_demography[1, 3], gnomAD_three_epoch_demography[1, 5], gnomAD_three_epoch_demography[1, 7])
gnomAD_three_epoch_Time_10 = c(-gnomAD_three_epoch_demography[1, 2], -gnomAD_three_epoch_demography[1, 4], -gnomAD_three_epoch_demography[1, 6], gnomAD_three_epoch_demography[1, 8])
gnomAD_three_epoch_demography_10 = data.frame(gnomAD_three_epoch_Time_10, gnomAD_three_epoch_NEffective_10)
gnomAD_three_epoch_NEffective_20 = c(gnomAD_three_epoch_demography[2, 1], gnomAD_three_epoch_demography[2, 3], gnomAD_three_epoch_demography[2, 5], gnomAD_three_epoch_demography[2, 7])
gnomAD_three_epoch_Time_20 = c(-gnomAD_three_epoch_demography[2, 2], -gnomAD_three_epoch_demography[2, 4], -gnomAD_three_epoch_demography[2, 6], gnomAD_three_epoch_demography[2, 8])
gnomAD_three_epoch_demography_20 = data.frame(gnomAD_three_epoch_Time_20, gnomAD_three_epoch_NEffective_20)
gnomAD_three_epoch_NEffective_30 = c(gnomAD_three_epoch_demography[3, 1], gnomAD_three_epoch_demography[3, 3], gnomAD_three_epoch_demography[3, 5], gnomAD_three_epoch_demography[3, 7])
gnomAD_three_epoch_Time_30 = c(-gnomAD_three_epoch_demography[3, 2], -gnomAD_three_epoch_demography[3, 4], -gnomAD_three_epoch_demography[3, 6], gnomAD_three_epoch_demography[3, 8])
gnomAD_three_epoch_demography_30 = data.frame(gnomAD_three_epoch_Time_30, gnomAD_three_epoch_NEffective_30)
gnomAD_three_epoch_NEffective_50 = c(gnomAD_three_epoch_demography[4, 1], gnomAD_three_epoch_demography[4, 3], gnomAD_three_epoch_demography[4, 5], gnomAD_three_epoch_demography[4, 7])
gnomAD_three_epoch_Time_50 = c(-gnomAD_three_epoch_demography[4, 2], -gnomAD_three_epoch_demography[4, 4], -gnomAD_three_epoch_demography[4, 6], gnomAD_three_epoch_demography[4, 8])
gnomAD_three_epoch_demography_50 = data.frame(gnomAD_three_epoch_Time_50, gnomAD_three_epoch_NEffective_50)
gnomAD_three_epoch_NEffective_100 = c(gnomAD_three_epoch_demography[5, 1], gnomAD_three_epoch_demography[5, 3], gnomAD_three_epoch_demography[5, 5], gnomAD_three_epoch_demography[5, 7])
gnomAD_three_epoch_Time_100 = c(-gnomAD_three_epoch_demography[5, 2], -gnomAD_three_epoch_demography[5, 4], -gnomAD_three_epoch_demography[5, 6], gnomAD_three_epoch_demography[5, 8])
gnomAD_three_epoch_demography_100 = data.frame(gnomAD_three_epoch_Time_100, gnomAD_three_epoch_NEffective_100)
gnomAD_three_epoch_NEffective_150 = c(gnomAD_three_epoch_demography[6, 1], gnomAD_three_epoch_demography[6, 3], gnomAD_three_epoch_demography[6, 5], gnomAD_three_epoch_demography[6, 7])
gnomAD_three_epoch_Time_150 = c(-gnomAD_three_epoch_demography[6, 2], -gnomAD_three_epoch_demography[6, 4], -gnomAD_three_epoch_demography[6, 6], gnomAD_three_epoch_demography[6, 8])
gnomAD_three_epoch_demography_150 = data.frame(gnomAD_three_epoch_Time_150, gnomAD_three_epoch_NEffective_150)
gnomAD_three_epoch_NEffective_200 = c(gnomAD_three_epoch_demography[7, 1], gnomAD_three_epoch_demography[7, 3], gnomAD_three_epoch_demography[7, 5], gnomAD_three_epoch_demography[7, 7])
gnomAD_three_epoch_Time_200 = c(-gnomAD_three_epoch_demography[7, 2], -gnomAD_three_epoch_demography[7, 4], -gnomAD_three_epoch_demography[7, 6], gnomAD_three_epoch_demography[7, 8])
gnomAD_three_epoch_demography_200 = data.frame(gnomAD_three_epoch_Time_200, gnomAD_three_epoch_NEffective_200)
gnomAD_three_epoch_NEffective_300 = c(gnomAD_three_epoch_demography[8, 1], gnomAD_three_epoch_demography[8, 3], gnomAD_three_epoch_demography[8, 5], gnomAD_three_epoch_demography[8, 7])
gnomAD_three_epoch_Time_300 = c(-gnomAD_three_epoch_demography[8, 2], -gnomAD_three_epoch_demography[8, 4], -gnomAD_three_epoch_demography[8, 6], gnomAD_three_epoch_demography[8, 8])
gnomAD_three_epoch_demography_300 = data.frame(gnomAD_three_epoch_Time_300, gnomAD_three_epoch_NEffective_300)
gnomAD_three_epoch_NEffective_500 = c(gnomAD_three_epoch_demography[9, 1], gnomAD_three_epoch_demography[9, 3], gnomAD_three_epoch_demography[9, 5], gnomAD_three_epoch_demography[9, 7])
gnomAD_three_epoch_Time_500 = c(-gnomAD_three_epoch_demography[9, 2], -gnomAD_three_epoch_demography[9, 4], -gnomAD_three_epoch_demography[9, 6], gnomAD_three_epoch_demography[9, 8])
gnomAD_three_epoch_demography_500 = data.frame(gnomAD_three_epoch_Time_500, gnomAD_three_epoch_NEffective_500)
gnomAD_three_epoch_NEffective_700 = c(gnomAD_three_epoch_demography[10, 1], gnomAD_three_epoch_demography[10, 3], gnomAD_three_epoch_demography[10, 5], gnomAD_three_epoch_demography[10, 7])
gnomAD_three_epoch_Time_700 = c(-gnomAD_three_epoch_demography[10, 2], -gnomAD_three_epoch_demography[10, 4], -gnomAD_three_epoch_demography[10, 6], gnomAD_three_epoch_demography[10, 8])
gnomAD_three_epoch_demography_700 = data.frame(gnomAD_three_epoch_Time_700, gnomAD_three_epoch_NEffective_700)

ggplot(gnomAD_two_epoch_demography_10, aes(gnomAD_two_epoch_Time_10, gnomAD_two_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='dotted') + 
  geom_step(data=gnomAD_two_epoch_demography_20, aes(gnomAD_two_epoch_Time_20, gnomAD_two_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='dotted') +
  geom_step(data=gnomAD_two_epoch_demography_30, aes(gnomAD_two_epoch_Time_30, gnomAD_two_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='dotted') +
  geom_step(data=gnomAD_two_epoch_demography_50, aes(gnomAD_two_epoch_Time_50, gnomAD_two_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='dotted') +
  geom_step(data=gnomAD_two_epoch_demography_100, aes(gnomAD_two_epoch_Time_100, gnomAD_two_epoch_NEffective_100, color='N=100'), linewidth=1, linetype='dotted') +
  geom_step(data=gnomAD_two_epoch_demography_150, aes(gnomAD_two_epoch_Time_150, gnomAD_two_epoch_NEffective_150, color='N=150'), linewidth=1, linetype='dotted') +
  geom_step(data=gnomAD_two_epoch_demography_200, aes(gnomAD_two_epoch_Time_200, gnomAD_two_epoch_NEffective_200, color='N=200'), linewidth=1, linetype='dotted') +
  geom_step(data=gnomAD_two_epoch_demography_300, aes(gnomAD_two_epoch_Time_300, gnomAD_two_epoch_NEffective_300, color='N=300'), linewidth=1, linetype='dotted') +
  geom_step(data=gnomAD_two_epoch_demography_500, aes(gnomAD_two_epoch_Time_500, gnomAD_two_epoch_NEffective_500, color='N=500'), linewidth=1, linetype='dotted') +
  geom_step(data=gnomAD_two_epoch_demography_700, aes(gnomAD_two_epoch_Time_700, gnomAD_two_epoch_NEffective_700, color='N=700'), linewidth=1, linetype='dotted') +
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
  ggtitle('gnomAD two-epoch demography')

ggplot(gnomAD_three_epoch_demography_10, aes(gnomAD_three_epoch_Time_10, gnomAD_three_epoch_NEffective_10, color='N=10')) + geom_step(linewidth=1, linetype='solid') + 
  geom_step(data=gnomAD_three_epoch_demography_20, aes(gnomAD_three_epoch_Time_20, gnomAD_three_epoch_NEffective_20, color='N=20'), linewidth=1, linetype='solid') +
  geom_step(data=gnomAD_three_epoch_demography_30, aes(gnomAD_three_epoch_Time_30, gnomAD_three_epoch_NEffective_30, color='N=30'), linewidth=1, linetype='solid') +
  geom_step(data=gnomAD_three_epoch_demography_50, aes(gnomAD_three_epoch_Time_50, gnomAD_three_epoch_NEffective_50, color='N=50'), linewidth=1, linetype='solid') +
  geom_step(data=gnomAD_three_epoch_demography_100, aes(gnomAD_three_epoch_Time_100, gnomAD_three_epoch_NEffective_100, color='N=100'), linewidth=1, linetype='solid') +
  geom_step(data=gnomAD_three_epoch_demography_150, aes(gnomAD_three_epoch_Time_150, gnomAD_three_epoch_NEffective_150, color='N=150'), linewidth=1, linetype='solid') +
  geom_step(data=gnomAD_three_epoch_demography_200, aes(gnomAD_three_epoch_Time_200, gnomAD_three_epoch_NEffective_200, color='N=200'), linewidth=1, linetype='solid') +
  geom_step(data=gnomAD_three_epoch_demography_300, aes(gnomAD_three_epoch_Time_300, gnomAD_three_epoch_NEffective_300, color='N=300'), linewidth=1, linetype='solid') +
  geom_step(data=gnomAD_three_epoch_demography_500, aes(gnomAD_three_epoch_Time_500, gnomAD_three_epoch_NEffective_500, color='N=500'), linewidth=1, linetype='solid') +
  geom_step(data=gnomAD_three_epoch_demography_700, aes(gnomAD_three_epoch_Time_700, gnomAD_three_epoch_NEffective_700, color='N=700'), linewidth=1, linetype='solid') +
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
  ggtitle('gnomAD Three Epoch Demography')


# NAnc Estimate by Sample Size
sample_size = c(10, 20, 30, 50, 100, 150, 200, 300, 500, 700)

NAnc_df = data.frame(sample_size, gnomAD_one_epoch_NAnc, gnomAD_two_epoch_NAnc, gnomAD_three_epoch_NAnc)
NAnc_df = melt(NAnc_df, id='sample_size')

ggplot(data=NAnc_df, aes(x=sample_size, y=value, color=variable)) + geom_line() +
  xlab('Sample size') +
  ylab('Estimated ancestral effective population size') +
  ggtitle('gnomAD NAnc by sample size') +
  theme_bw() +
  guides(color=guide_legend(title="Epoch")) +
  scale_color_manual(
    labels=c('One-epoch', 'Two-epoch', 'Three-epoch'),
    values=c('red', 'blue', 'green')) +
  geom_hline(yintercept=30378, color='black', linetype='dashed') +
  scale_x_continuous(breaks=sample_size)
  