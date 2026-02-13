# figure_2.R

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

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

msprime_nu = c()
msprime_time = c()
msprime_tau = c()
msprime_tajima_D = c()
msprime_lambda_32 = c()
msprime_lambda_21 = c()
msprime_one_LL = c()
msprime_two_LL = c()
msprime_three_LL = c()

# msprime_lambda = rep(0, 80)

msprime_nu_min = c()
msprime_nu_max = c()
msprime_tau_min = c()
msprime_tau_max = c()

msprime_nu_b = c()
msprime_nu_f = c()

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
  msprime_nu_min = c(msprime_nu_min, find_CI_bounds(msprime_likelihood)$nu_min)
  msprime_nu_max = c(msprime_nu_max, find_CI_bounds(msprime_likelihood)$nu_max)
  msprime_tau = c(msprime_tau, find_CI_bounds(msprime_likelihood)$tau_MLE)
  msprime_tau_min = c(msprime_tau_min, find_CI_bounds(msprime_likelihood)$tau_min)  
  msprime_tau_max = c(msprime_tau_max, find_CI_bounds(msprime_likelihood)$tau_max)
  
  msprime_tajima_D = c(msprime_tajima_D, read_summary_statistics(msprime_summary)[3])
  this_msprime_one_LL = LL_from_demography(msprime_demography_1)
  this_msprime_two_LL = LL_from_demography(msprime_demography)
  this_msprime_three_LL = LL_from_demography(msprime_demography_3)
  msprime_one_LL = c(msprime_one_LL, this_msprime_one_LL)
  msprime_two_LL = c(msprime_two_LL, this_msprime_two_LL)
  msprime_three_LL = c(msprime_three_LL, this_msprime_three_LL)
  msprime_LL_diff_32 = this_msprime_three_LL - this_msprime_two_LL
  msprime_lambda_32 = c(msprime_lambda_32, 2 * msprime_LL_diff_32)
  msprime_LL_diff_21 = this_msprime_two_LL - this_msprime_one_LL
  msprime_lambda_21 = c(msprime_lambda_21, 2 * msprime_LL_diff_21)
  msprime_nu_b = c(msprime_nu_b, nuB_from_demography(msprime_demography_3))
  msprime_nu_f = c(msprime_nu_f, nuF_from_demography(msprime_demography_3))
}

nu_label_text = expression(nu == frac(N[current], N[ancestral]))
tau_label_text = expression(tau == frac(generations, 2 * N[ancestral]))
twoLambda_text = expression(2*Lambda)
nu_dataframe = melt(data.frame(
  # dadi_nu,
  msprime_nu
))
nu_dataframe$sample_size = sample_size
# nu_dataframe$dadi_min = dadi_nu_min
# nu_dataframe$dadi_max = dadi_nu_max
nu_dataframe$msprime_min = msprime_nu_min
nu_dataframe$msprime_max = msprime_nu_max

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
  # dadi_tau,
  msprime_tau
))
tau_dataframe$sample_size = sample_size
# tau_dataframe$dadi_min = dadi_tau_min
# tau_dataframe$dadi_max = dadi_tau_max
tau_dataframe$msprime_min = msprime_tau_min
tau_dataframe$msprime_max = msprime_tau_max

# Min tau
min(tau_dataframe[1:9, ]$value)
# Max tau
max(tau_dataframe[1:9, ]$value)

tajima_D_dataframe = melt(data.frame(
  # dadi_tajima_D,
  msprime_tajima_D
))
tajima_D_dataframe$sample_size = sample_size

lambda_dataframe = melt(data.frame(
  dadi_lambda_32,
  dadi_lambda_21,
  msprime_lambda_32,
  msprime_lambda_21
))
lambda_dataframe$sample_size = sample_size

lambda_dataframe_msprime = melt(data.frame(
  msprime_lambda_32,
  msprime_lambda_21
))
lambda_dataframe_msprime$sample_size = sample_size

dadi_nuF_nuB = dadi_nu_f / dadi_nu_b
msprime_nuF_nuB = msprime_nu_f / msprime_nu_b

epoch_ratio_dataframe = melt(data.frame(
  dadi_nu_b,
  dadi_nuF_nuB,
  msprime_nu_b,
  msprime_nuF_nuB
))
epoch_ratio_dataframe$sample_size = sample_size

epoch_ratio_dataframe_dadi = melt(data.frame(
  dadi_nu_b,
  dadi_nuF_nuB
))
epoch_ratio_dataframe_dadi$sample_size = sample_size

epoch_ratio_dataframe_msprime = melt(data.frame(
  msprime_nu_b,
  msprime_nuF_nuB
))
epoch_ratio_dataframe_msprime$sample_size = sample_size

plot_A = ggplot(data=nu_dataframe, aes(x=sample_size, y=value, color=variable)) + geom_line(size=1) +
  theme_bw() + guides(color=guide_legend(title="Type of SFS")) +
  # geom_ribbon(aes(ymin = dadi_min, ymax = dadi_max), fill = "#0C7BDC", color="#0C7BDC", alpha = 0.2) +
  geom_ribbon(aes(ymin = msprime_min, ymax = msprime_max), fill = "#0C7BDC", color="#0C7BDC", alpha = 0.2) +
  xlab('Sample size') +
  ylab(nu_label_text) +
  ggtitle("Ratio of Effective to Ancestral population size") +
  scale_colour_manual(
    values = c("#0C7BDC"),
    labels = c("MSPrime")
  ) +
  scale_y_log10() +
  geom_hline(yintercept = 1, size = 2, linetype = 'dashed')

plot_B = ggplot(data=tau_dataframe, aes(x=sample_size, y=value, color=variable)) + geom_line(size=1) +
  theme_bw() + guides(color=guide_legend(title="Type of SFS")) +
  # geom_ribbon(aes(ymin = dadi_min, ymax = dadi_max), fill = "#0C7BDC", color="#0C7BDC", alpha = 0.2) +
  geom_ribbon(aes(ymin = msprime_min, ymax = msprime_max), fill = "#0C7BDC", color="#0C7BDC", alpha = 0.2) +
  xlab('Sample size') +
  ylab(tau_label_text) +
  ggtitle('Timing of inferred instantaneous size change') +
  scale_y_log10() +
  scale_colour_manual(
    values = c("#0C7BDC", "#FFC20A"),
    labels = c("MSPrime", "Dadi")
  ) +
  theme(legend.position='none')

plot_C = ggplot(data=tajima_D_dataframe, aes(x=sample_size, y=value, color=variable)) + geom_line(size=1) +
  theme_bw() + guides(color=guide_legend(title="Type of SFS")) +
  xlab('Sample size') +
  ylab("Tajima's D") +
  ggtitle("Tajima's D for simulated SFS") +
  scale_colour_manual(
    values = c("#0C7BDC"),
    labels = c("MSPrime")
  ) +
  geom_hline(yintercept = 0, size = 2, linetype = 'dashed') +
  theme(legend.position='none')

plot_D = ggplot(data=lambda_dataframe, aes(x=sample_size, y=value, color=variable)) + geom_line(size=2) +
  theme_bw() + guides(color=guide_legend(title="Demographic model comparison")) +
  xlab('Sample size') +
  ylab(twoLambda_text) +
  ggtitle("Demographic model fit criterion, three-epoch vs. two-epoch") +
  scale_colour_manual(
    values = c("#0C7BDC", "#999ED9", "#FFC20A", "#CA5A08"),
    labels = c("Dadi, three-epoch vs. two-epoch", "Dadi, two-epoch vs. one-epoch",
               "MSPrime, three-epoch vs. two-epoch", "MSPrime, two-epoch vs. one-epoch")
  ) +
  geom_hline(yintercept = 14.75552, size = 1, linetype = 'dashed', color='red')

plot_D_2 = ggplot(data=lambda_dataframe_msprime, aes(x=sample_size, y=value, color=variable)) + geom_line(size=2) +
  theme_bw() + guides(color=guide_legend(title="Demographic model comparison")) +
  xlab('Sample size') +
  ylab(twoLambda_text) +
  ggtitle("Demographic model fit criterion, three-epoch vs. two-epoch") +
  scale_colour_manual(
    values = c("#f768a1", "#ae017e"),
    labels = c("MSPrime, three-epoch vs. two-epoch", "MSPrime, two-epoch vs. one-epoch")
  ) +
  scale_y_log10() +
  geom_hline(yintercept = 14.75552, size = 1, linetype = 'dashed', color='red')

# 2Lambda is approximately chi-squared distributed.
# 80 comparisons for 10-800:10, so critical value is 14.76 with Bonferroni correction
qchisq(1 - 0.05/80, df=2)

plot_E = ggplot(data=epoch_ratio_dataframe, aes(x=sample_size, y=value, color=variable)) + geom_line(size=2) +
  theme_bw() + guides(color=guide_legend(title="Epoch Comparison")) +
  xlab('Sample size') +
  ylab("Ratio of effective population size") +
  ggtitle("Effective population size between epochs") +
  scale_colour_manual(
    values = c("#0C7BDC", "#999ED9", "#FFC20A", "#CA5A08"),
    labels = c("Dadi, Bottleneck vs. Ancestral", "Dadi, Current vs. Bottleneck",
      "MSPrime, Bottleneck vs. Ancestral", "MSPrime, Current vs. Bottleneck")
  ) +
  geom_hline(yintercept = 1, size = 1, linetype = 'dashed', color='red')

plot_E_1 = ggplot(data=epoch_ratio_dataframe_dadi, aes(x=sample_size, y=value, color=variable)) + geom_line(size=2) +
  theme_bw() + guides(color=guide_legend(title="Epoch Comparison")) +
  xlab('Sample size') +
  ylab("Ratio of effective population size") +
  ggtitle("Effective population size between epochs") +
  scale_colour_manual(
    values = c("#0C7BDC", "#999ED9"),
    labels = c("Dadi, Bottleneck vs. Ancestral", "Dadi, Current vs. Bottleneck")
  ) +
  geom_hline(yintercept = 1, size = 1, linetype = 'dashed', color='red')

plot_E_2 = ggplot(data=epoch_ratio_dataframe_msprime, aes(x=sample_size, y=value, color=variable)) + geom_line(size=2) +
  theme_bw() + guides(color=guide_legend(title="Epoch Comparison")) +
  xlab('Sample size') +
  ylab("Ratio of effective population size") +
  ggtitle("Effective population size between epochs") +
  scale_colour_manual(
    values = c("#41ab5d", "#006837"),
    labels = c("MSPrime, Bottleneck vs. Ancestral", "MSPrime, Current vs. Bottleneck")
  ) +
  scale_y_log10() +
  geom_hline(yintercept = 1, size = 1, linetype = 'dashed', color='red')

# plot_E = plot_likelihood_surface_contour('../Analysis/dadi_3EpB_50/likelihood_surface.csv') +
#   ggtitle('Likelihood surface for dadi-simulated SFS, k=50') +
#   theme(axis.title.x=element_blank()) 

# find_CI_bounds('../Analysis/dadi_3EpB_50/likelihood_surface.csv')$nu_min

# plot_F = plot_likelihood_surface_contour('../Analysis/dadi_3EpB_100/likelihood_surface.csv') +
#   ggtitle('Likelihood surface for dadi-simulated SFS, k=100') +
#   theme(axis.title.x=element_blank(), axis.title.y=element_blank()) 

# plot_G = plot_likelihood_surface_contour('../Analysis/dadi_3EpB_200/likelihood_surface.csv') +
#   ggtitle('Likelihood surface for dadi-simulated SFS, k=200') +
#   theme(axis.title.x=element_blank(), axis.title.y=element_blank()) 
# 
# plot_H = plot_likelihood_surface_contour('../Analysis/dadi_3EpB_300/likelihood_surface.csv') +
#   ggtitle('Likelihood surface for dadi-simulated SFS, k=300') +
#   theme(legend.position='none')
# 
# loglik_dataframe = melt(data.frame(
#   dadi_two_LL,
#   dadi_three_LL
# ))
# loglik_dataframe$sample_size = sample_size

# ggplot(data=loglik_dataframe, aes(x=sample_size, y=value, color=variable)) + geom_line(size=2) +
#   theme_bw() + guides(color=guide_legend(title="Type of SFS")) +
#   xlab('Sample size') +
#   ylab("Log likelihood") +
#   ggtitle("Log likelihood for simulated SFS") +
#   scale_colour_manual(
#     values = c("#0C7BDC","#FFC20A"),
#     labels = c("Two-epoch", "Three-epoch")
#   ) +
#   geom_hline(yintercept = 0, size = 2, linetype = 'dashed')
# 
design = "
  CCDD
  AAEE
  BBEE
"

## Figure 2

# 1200 x 800
plot_A + 
  plot_B + 
  plot_C + 
  plot_D_2 + 
  plot_E_2 +
  plot_layout(design=design)

design_2 = "
  AADD
  BBFF
  CCGG
"

# 1200 x 800
plot_A + 
  plot_B + 
  plot_C + 
  plot_D + 
  plot_E_1 + plot_E_2 +
  plot_layout(design=design_2)

# for (i in sample_size) {
#   print(i)
#   print('dadi')
#   dadi_likelihood = paste0(
#     "../Analysis/dadi_3EpB_", i, '/likelihood_surface.csv')
#   plot_likelihood_surface_contour(dadi_likelihood)
# }
# 
# for (i in sample_size) {
#   print(i)
#   print('msprime')
#   msprime_likelihood = paste0(
#    "../Analysis/msprime_3EpB_", i, '/likelihood_surface.csv')
#   plot_likelihood_surface_contour(msprime_likelihood)
# }


#### SCalE Talk figures
nu_dataframe = melt(data.frame(
  msprime_nu
))
nu_dataframe$sample_size = sample_size
nu_dataframe$msprime_min = msprime_nu_min
nu_dataframe$msprime_max = msprime_nu_max

nu_dataframe_CI_bounds = melt(data.frame(
  msprime_nu_min,
  msprime_nu_max
))
nu_dataframe_CI_bounds$sample_size = sample_size

tau_dataframe = melt(data.frame(
  msprime_tau
))
tau_dataframe$sample_size = sample_size
tau_dataframe$msprime_min = msprime_tau_min
tau_dataframe$msprime_max = msprime_tau_max

tajima_D_dataframe = melt(data.frame(
  msprime_tajima_D
))
tajima_D_dataframe$sample_size = sample_size

plot_A = ggplot(data=nu_dataframe, aes(x=sample_size, y=value, color=variable)) + geom_line(size=2) +
  theme_bw() + guides(color=guide_legend(title="Type of SFS")) +
  xlab('Sample size') +
  ylab(nu_label_text) +
  ggtitle("Ratio of Effective to Ancestral population size") +
  scale_colour_manual(
    values = c("#FFC20A"),
    labels = c("MSPrime")
  ) +
  geom_ribbon(aes(ymin = msprime_min, ymax = msprime_max), fill = "#FFC20A", color="#FFC20A", alpha = 0.2) +
  scale_y_log10() +
  geom_hline(yintercept = 1, size = 2, linetype = 'dashed') +
  theme(legend.position='none') +
  theme(axis.title.x = element_blank()) +
  theme(axis.title.y = element_text(size = 16))

plot_B = ggplot(data=tau_dataframe, aes(x=sample_size, y=value, color=variable)) + geom_line(size=2) +
  theme_bw() + guides(color=guide_legend(title="Type of SFS")) +
  xlab('Sample size') +
  ylab(tau_label_text) +
  geom_ribbon(aes(ymin = msprime_min, ymax = msprime_max), fill = "#FFC20A", color="#FFC20A", alpha = 0.2) +
  ggtitle('Timing of inferred instantaneous size change') +
  # scale_y_log10() +
  scale_colour_manual(
    values = c("#FFC20A"),
    labels = c("MSPrime")
  ) +
  theme(legend.position='none') +
  theme(axis.title.x = element_text(size = 20)) +
  theme(axis.title.y = element_text(size = 16))

plot_C = ggplot(data=tajima_D_dataframe, aes(x=sample_size, y=value, color=variable)) + geom_line(size=2) +
  theme_bw() + guides(color=guide_legend(title="Type of SFS")) +
  xlab('Sample size') +
  ylab("Tajima's D") +
  ggtitle("Tajima's D for simulated SFS") +
  scale_colour_manual(
    values = c("#FFC20A"),
    labels = c("MSPrime")
  ) +
  geom_hline(yintercept = 0, size = 2, linetype = 'dashed') +
  theme(legend.position='none') +
  theme(axis.title.x = element_blank()) +
  theme(axis.title.y = element_text(size = 16))

plot_C + plot_A + plot_B + plot_layout(nrow=3)
# 600 x 800


#### Supplement

# 200_200

msprime_nu_b_200_200 = c()
msprime_nu_f_200_200 = c()

for (i in sample_size) {
  msprime_demography_3 = paste0(
    "../Analysis/msprime_3EpB_200_200_", i, '/three_epoch_demography.txt')
  msprime_nu_b_200_200 = c(msprime_nu_b_200_200, nuB_from_demography(msprime_demography_3))
  msprime_nu_f_200_200 = c(msprime_nu_f_200_200, nuF_from_demography(msprime_demography_3))
}

msprime_nuF_nuB_200_200 = msprime_nu_f_200_200 / msprime_nu_b_200_200

epoch_ratio_dataframe_msprime_200_200 = melt(data.frame(
  msprime_nu_b_200_200,
  msprime_nuF_nuB_200_200
))
epoch_ratio_dataframe_msprime_200_200$sample_size = sample_size

plot_E_200_200 = ggplot(data=epoch_ratio_dataframe_msprime_200_200, aes(x=sample_size, y=value, color=variable)) + geom_line(size=2) +
  theme_bw() + guides(color=guide_legend(title="Epoch Comparison")) +
  xlab('Sample size') +
  ylab("Ratio of effective population size") +
  ggtitle("Effective population size between epochs, [Anc., 400 g.a., 200 g.a.]") +
  scale_colour_manual(
    values = c("#FFC20A", "#CA5A08"),
    labels = c("MSPrime, Bottleneck vs. Ancestral", "MSPrime, Current vs. Bottleneck")
  ) +
  scale_y_log10() +
  geom_hline(yintercept = 1, size = 1, linetype = 'dashed', color='red')

plot_E_200_200

# 400_200

msprime_nu_b_400_200 = c()
msprime_nu_f_400_200 = c()

for (i in sample_size) {
  msprime_demography_3 = paste0(
    "../Analysis/msprime_3EpB_400_200_", i, '/three_epoch_demography.txt')
  msprime_nu_b_400_200 = c(msprime_nu_b_400_200, nuB_from_demography(msprime_demography_3))
  msprime_nu_f_400_200 = c(msprime_nu_f_400_200, nuF_from_demography(msprime_demography_3))
}

msprime_nuF_nuB_400_200 = msprime_nu_f_400_200 / msprime_nu_b_400_200

epoch_ratio_dataframe_msprime_400_200 = melt(data.frame(
  msprime_nu_b_400_200,
  msprime_nuF_nuB_400_200
))
epoch_ratio_dataframe_msprime_400_200$sample_size = sample_size

plot_E_400_200 = ggplot(data=epoch_ratio_dataframe_msprime_400_200, aes(x=sample_size, y=value, color=variable)) + geom_line(size=2) +
  theme_bw() + guides(color=guide_legend(title="Epoch Comparison")) +
  xlab('Sample size') +
  ylab("Ratio of effective population size") +
  ggtitle("Effective population size between epochs, [Anc., 600 g.a., 200 g.a.]") +
  scale_colour_manual(
    values = c("#FFC20A", "#CA5A08"),
    labels = c("MSPrime, Bottleneck vs. Ancestral", "MSPrime, Current vs. Bottleneck")
  ) +
  scale_y_log10() +
  geom_hline(yintercept = 1, size = 1, linetype = 'dashed', color='red')

plot_E_400_200

# 600_200

msprime_nu_b_600_200 = c()
msprime_nu_f_600_200 = c()

for (i in sample_size) {
  msprime_demography_3 = paste0(
    "../Analysis/msprime_3EpB_600_200_", i, '/three_epoch_demography.txt')
  msprime_nu_b_600_200 = c(msprime_nu_b_600_200, nuB_from_demography(msprime_demography_3))
  msprime_nu_f_600_200 = c(msprime_nu_f_600_200, nuF_from_demography(msprime_demography_3))
}

msprime_nuF_nuB_600_200 = msprime_nu_f_600_200 / msprime_nu_b_600_200

epoch_ratio_dataframe_msprime_600_200 = melt(data.frame(
  msprime_nu_b_600_200,
  msprime_nuF_nuB_600_200
))
epoch_ratio_dataframe_msprime_600_200$sample_size = sample_size

plot_E_600_200 = ggplot(data=epoch_ratio_dataframe_msprime_600_200, aes(x=sample_size, y=value, color=variable)) + geom_line(size=2) +
  theme_bw() + guides(color=guide_legend(title="Epoch Comparison")) +
  xlab('Sample size') +
  ylab("Ratio of effective population size") +
  ggtitle("Effective population size between epochs, [Anc., 800 g.a., 200 g.a.]") +
  scale_colour_manual(
    values = c("#FFC20A", "#CA5A08"),
    labels = c("MSPrime, Bottleneck vs. Ancestral", "MSPrime, Current vs. Bottleneck")
  ) +
  scale_y_log10() +
  geom_hline(yintercept = 1, size = 1, linetype = 'dashed', color='red')

plot_E_600_200

# 800_200

msprime_nu_b_800_200 = c()
msprime_nu_f_800_200 = c()

for (i in sample_size) {
  msprime_demography_3 = paste0(
    "../Analysis/msprime_3EpB_800_200_", i, '/three_epoch_demography.txt')
  msprime_nu_b_800_200 = c(msprime_nu_b_800_200, nuB_from_demography(msprime_demography_3))
  msprime_nu_f_800_200 = c(msprime_nu_f_800_200, nuF_from_demography(msprime_demography_3))
}

msprime_nuF_nuB_800_200 = msprime_nu_f_800_200 / msprime_nu_b_800_200

epoch_ratio_dataframe_msprime_800_200 = melt(data.frame(
  msprime_nu_b_800_200,
  msprime_nuF_nuB_800_200
))
epoch_ratio_dataframe_msprime_800_200$sample_size = sample_size

plot_E_800_200 = ggplot(data=epoch_ratio_dataframe_msprime_800_200, aes(x=sample_size, y=value, color=variable)) + geom_line(size=2) +
  theme_bw() + guides(color=guide_legend(title="Epoch Comparison")) +
  xlab('Sample size') +
  ylab("Ratio of effective population size") +
  ggtitle("Effective population size between epochs, [Anc., 1000 g.a., 200 g.a.]") +
  scale_colour_manual(
    values = c("#FFC20A", "#CA5A08"),
    labels = c("MSPrime, Bottleneck vs. Ancestral", "MSPrime, Current vs. Bottleneck")
  ) +
  scale_y_log10() +
  geom_hline(yintercept = 1, size = 1, linetype = 'dashed', color='red')

plot_E_800_200

# 1000_200

msprime_nu_b_1000_200 = c()
msprime_nu_f_1000_200 = c()

for (i in sample_size) {
  msprime_demography_3 = paste0(
    "../Analysis/msprime_3EpB_1000_200_", i, '/three_epoch_demography.txt')
  msprime_nu_b_1000_200 = c(msprime_nu_b_1000_200, nuB_from_demography(msprime_demography_3))
  msprime_nu_f_1000_200 = c(msprime_nu_f_1000_200, nuF_from_demography(msprime_demography_3))
}

msprime_nuF_nuB_1000_200 = msprime_nu_f_1000_200 / msprime_nu_b_1000_200

epoch_ratio_dataframe_msprime_1000_200 = melt(data.frame(
  msprime_nu_b_1000_200,
  msprime_nuF_nuB_1000_200
))
epoch_ratio_dataframe_msprime_1000_200$sample_size = sample_size

plot_E_1000_200 = ggplot(data=epoch_ratio_dataframe_msprime_1000_200, aes(x=sample_size, y=value, color=variable)) + geom_line(size=2) +
  theme_bw() + guides(color=guide_legend(title="Epoch Comparison")) +
  xlab('Sample size') +
  ylab("Ratio of effective population size") +
  ggtitle("Effective population size between epochs, [Anc., 1200 g.a., 200 g.a.]") +
  scale_colour_manual(
    values = c("#FFC20A", "#CA5A08"),
    labels = c("MSPrime, Bottleneck vs. Ancestral", "MSPrime, Current vs. Bottleneck")
  ) +
  scale_y_log10() +
  geom_hline(yintercept = 1, size = 1, linetype = 'dashed', color='red')

plot_E_1000_200

# 1200_200

msprime_nu_b_1200_200 = c()
msprime_nu_f_1200_200 = c()

for (i in sample_size) {
  msprime_demography_3 = paste0(
    "../Analysis/msprime_3EpB_1200_200_", i, '/three_epoch_demography.txt')
  msprime_nu_b_1200_200 = c(msprime_nu_b_1200_200, nuB_from_demography(msprime_demography_3))
  msprime_nu_f_1200_200 = c(msprime_nu_f_1200_200, nuF_from_demography(msprime_demography_3))
}

msprime_nuF_nuB_1200_200 = msprime_nu_f_1200_200 / msprime_nu_b_1200_200

epoch_ratio_dataframe_msprime_1200_200 = melt(data.frame(
  msprime_nu_b_1200_200,
  msprime_nuF_nuB_1200_200
))
epoch_ratio_dataframe_msprime_1200_200$sample_size = sample_size

plot_E_1200_200 = ggplot(data=epoch_ratio_dataframe_msprime_1200_200, aes(x=sample_size, y=value, color=variable)) + geom_line(size=2) +
  theme_bw() + guides(color=guide_legend(title="Epoch Comparison")) +
  xlab('Sample size') +
  ylab("Ratio of effective population size") +
  ggtitle("Effective population size between epochs, [Anc., 1400 g.a., 200 g.a.]") +
  scale_colour_manual(
    values = c("#FFC20A", "#CA5A08"),
    labels = c("MSPrime, Bottleneck vs. Ancestral", "MSPrime, Current vs. Bottleneck")
  ) +
  scale_y_log10() +
  geom_hline(yintercept = 1, size = 1, linetype = 'dashed', color='red')

plot_E_1200_200

# 1400_200

msprime_nu_b_1400_200 = c()
msprime_nu_f_1400_200 = c()

for (i in sample_size) {
  msprime_demography_3 = paste0(
    "../Analysis/msprime_3EpB_1400_200_", i, '/three_epoch_demography.txt')
  msprime_nu_b_1400_200 = c(msprime_nu_b_1400_200, nuB_from_demography(msprime_demography_3))
  msprime_nu_f_1400_200 = c(msprime_nu_f_1400_200, nuF_from_demography(msprime_demography_3))
}

msprime_nuF_nuB_1400_200 = msprime_nu_f_1400_200 / msprime_nu_b_1400_200

epoch_ratio_dataframe_msprime_1400_200 = melt(data.frame(
  msprime_nu_b_1400_200,
  msprime_nuF_nuB_1400_200
))
epoch_ratio_dataframe_msprime_1400_200$sample_size = sample_size

plot_E_1400_200 = ggplot(data=epoch_ratio_dataframe_msprime_1400_200, aes(x=sample_size, y=value, color=variable)) + geom_line(size=2) +
  theme_bw() + guides(color=guide_legend(title="Epoch Comparison")) +
  xlab('Sample size') +
  ylab("Ratio of effective population size") +
  ggtitle("Effective population size between epochs, [Anc., 1600 g.a., 200 g.a.]") +
  scale_colour_manual(
    values = c("#FFC20A", "#CA5A08"),
    labels = c("MSPrime, Bottleneck vs. Ancestral", "MSPrime, Current vs. Bottleneck")
  ) +
  scale_y_log10() +
  geom_hline(yintercept = 1, size = 1, linetype = 'dashed', color='red')

plot_E_1400_200

# 1600_200

msprime_nu_b_1600_200 = c()
msprime_nu_f_1600_200 = c()

for (i in sample_size) {
  msprime_demography_3 = paste0(
    "../Analysis/msprime_3EpB_1600_200_", i, '/three_epoch_demography.txt')
  msprime_nu_b_1600_200 = c(msprime_nu_b_1600_200, nuB_from_demography(msprime_demography_3))
  msprime_nu_f_1600_200 = c(msprime_nu_f_1600_200, nuF_from_demography(msprime_demography_3))
}

msprime_nuF_nuB_1600_200 = msprime_nu_f_1600_200 / msprime_nu_b_1600_200

epoch_ratio_dataframe_msprime_1600_200 = melt(data.frame(
  msprime_nu_b_1600_200,
  msprime_nuF_nuB_1600_200
))
epoch_ratio_dataframe_msprime_1600_200$sample_size = sample_size

plot_E_1600_200 = ggplot(data=epoch_ratio_dataframe_msprime_1600_200, aes(x=sample_size, y=value, color=variable)) + geom_line(size=2) +
  theme_bw() + guides(color=guide_legend(title="Epoch Comparison")) +
  xlab('Sample size') +
  ylab("Ratio of effective population size") +
  ggtitle("Effective population size between epochs, [Anc., 1800 g.a., 200 g.a.]") +
  scale_colour_manual(
    values = c("#FFC20A", "#CA5A08"),
    labels = c("MSPrime, Bottleneck vs. Ancestral", "MSPrime, Current vs. Bottleneck")
  ) +
  scale_y_log10() +
  geom_hline(yintercept = 1, size = 1, linetype = 'dashed', color='red')

plot_E_1600_200