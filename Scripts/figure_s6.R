# figure_s6.R

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

sample_size = seq(from=10, to=160, by=10)

EUR_IBS_nu = c()
EUR_IBS_time = c()
EUR_IBS_tau = c()
EUR_IBS_tajima_D = c()
EUR_IBS_lambda_32 = c()
EUR_IBS_lambda_21 = c()
EUR_IBS_one_LL = c()
EUR_IBS_two_LL = c()
EUR_IBS_three_LL = c()

EUR_IBS_nu_min = c()
EUR_IBS_nu_max = c()
EUR_IBS_tau_min = c()
EUR_IBS_tau_max = c()

EUR_IBS_nu_b = c()
EUR_IBS_nu_f = c()

for (i in sample_size) {
  EUR_IBS_sfs = paste0(
    "../Analysis/1KG_IBS_", i, '/syn_downsampled_sfs.txt')
  EUR_IBS_demography = paste0(
    "../Analysis/1KG_IBS_", i, '/two_epoch_demography.txt')
  EUR_IBS_demography_1 = paste0(
    "../Analysis/1KG_IBS_", i, '/one_epoch_demography.txt')
  EUR_IBS_demography_3 = paste0(
    "../Analysis/1KG_IBS_", i, '/three_epoch_demography.txt')
  EUR_IBS_likelihood = paste0(
   "../Analysis/1KG_IBS_", i, '/likelihood_surface.csv')
  # EUR_IBS_nu = c(EUR_IBS_nu, nu_from_demography(EUR_IBS_demography))
  EUR_IBS_time = c(EUR_IBS_time, time_from_demography(EUR_IBS_demography))
  # EUR_IBS_tau = c(EUR_IBS_tau, tau_from_demography(EUR_IBS_demography))
  EUR_IBS_summary = paste0(
    "../Analysis/1KG_IBS_", i, '/summary.txt')
  
  EUR_IBS_tajima_D = c(EUR_IBS_tajima_D, read_summary_statistics(EUR_IBS_summary)[3])
  this_EUR_IBS_one_LL = LL_from_demography(EUR_IBS_demography_1)
  this_EUR_IBS_two_LL = LL_from_demography(EUR_IBS_demography)
  this_EUR_IBS_three_LL = LL_from_demography(EUR_IBS_demography_3)
  EUR_IBS_one_LL = c(EUR_IBS_one_LL, this_EUR_IBS_one_LL)
  EUR_IBS_two_LL = c(EUR_IBS_two_LL, this_EUR_IBS_two_LL)
  EUR_IBS_three_LL = c(EUR_IBS_three_LL, this_EUR_IBS_three_LL)
  EUR_IBS_LL_diff_32 = this_EUR_IBS_three_LL - this_EUR_IBS_two_LL
  EUR_IBS_LL_diff_21 = this_EUR_IBS_two_LL - this_EUR_IBS_one_LL
  EUR_IBS_lambda_32 = c(EUR_IBS_lambda_32, 2 * EUR_IBS_LL_diff_32)
  EUR_IBS_lambda_21 = c(EUR_IBS_lambda_21, 2 * EUR_IBS_LL_diff_21)
  
  EUR_IBS_nu = c(EUR_IBS_nu, nu_from_demography(EUR_IBS_demography))
  # EUR_IBS_nu = c(EUR_IBS_nu, find_CI_bounds(EUR_IBS_likelihood)$nu_MLE)
  # EUR_IBS_nu_min = c(EUR_IBS_nu_min, find_CI_bounds(EUR_IBS_likelihood)$nu_min)
  # EUR_IBS_nu_max = c(EUR_IBS_nu_max, find_CI_bounds(EUR_IBS_likelihood)$nu_max)
  # EUR_IBS_tau = c(EUR_IBS_tau, find_CI_bounds(EUR_IBS_likelihood)$tau_MLE)
  EUR_IBS_tau = c(EUR_IBS_tau, tau_from_demography(EUR_IBS_demography))
  # EUR_IBS_tau_min = c(EUR_IBS_tau_min, find_CI_bounds(EUR_IBS_likelihood)$tau_min)  
  # EUR_IBS_tau_max = c(EUR_IBS_tau_max, find_CI_bounds(EUR_IBS_likelihood)$tau_max)
  
  EUR_IBS_nu_b = c(EUR_IBS_nu_b, nuB_from_demography(EUR_IBS_demography_3))
  EUR_IBS_nu_f = c(EUR_IBS_nu_f, nuF_from_demography(EUR_IBS_demography_3))
}

nu_label_text = expression(nu == frac(N[current], N[ancestral]))
tau_label_text = expression(tau == frac(generations, 2 * N[ancestral]))

nu_dataframe = melt(data.frame(
  EUR_IBS_nu
))
nu_dataframe$sample_size = sample_size
# nu_dataframe$EUR_IBS_min = EUR_IBS_nu_min
# nu_dataframe$EUR_IBS_max = EUR_IBS_nu_max

tau_dataframe = melt(data.frame(
  EUR_IBS_tau
))
tau_dataframe$sample_size = sample_size
# tau_dataframe$EUR_IBS_min = EUR_IBS_tau_min
# tau_dataframe$EUR_IBS_max = EUR_IBS_tau_max

tajima_D_dataframe = melt(data.frame(
  EUR_IBS_tajima_D
))
tajima_D_dataframe$sample_size = sample_size

lambda_dataframe = melt(data.frame(
  EUR_IBS_lambda_32,
  EUR_IBS_lambda_21
))
lambda_dataframe$sample_size = sample_size

twoLambda_text = expression(2*Lambda)

EUR_IBS_nuF_nuB = EUR_IBS_nu_f / EUR_IBS_nu_b

epoch_ratio_dataframe = melt(data.frame(
  EUR_IBS_nu_b,
  EUR_IBS_nuF_nuB
))
epoch_ratio_dataframe$sample_size = sample_size


plot_A = ggplot(data=nu_dataframe, aes(x=sample_size, y=value, color=variable)) + geom_line(size=1) +
  theme_bw() + guides(color=guide_legend(title="Type of SFS")) +
  # geom_ribbon(aes(ymin = EUR_IBS_min, ymax = EUR_IBS_max), fill = "#0C7BDC", color="#0C7BDC", alpha = 0.2) +
  # geom_ribbon(aes(ymin = snm_min, ymax = snm_max), fill = "#FFC20A", color="#FFC20A", alpha = 0.2) +
  xlab('') +
  ylab(nu_label_text) +
  ggtitle("Ratio of Effective to Ancestral population size") +
  scale_colour_manual(
    values = c("#0C7BDC","#FFC20A"),
    labels = c("Tennessen", "snm")
  ) +
  scale_y_log10() +
  geom_hline(yintercept = 1, size = 1, linetype = 'dashed')


plot_B = ggplot(data=tau_dataframe, aes(x=sample_size, y=value, color=variable)) + geom_line(size=1) +
  theme_bw() + guides(color=guide_legend(title="Type of SFS")) +
  # geom_ribbon(aes(ymin = EUR_IBS_min, ymax = EUR_IBS_max), fill = "#0C7BDC", color="#0C7BDC", alpha = 0.2) +
  # geom_ribbon(aes(ymin = snm_min, ymax = snm_max), fill = "#FFC20A", color="#FFC20A", alpha = 0.2) +
  xlab('Sample size') +
  ylab(tau_label_text) +
  ggtitle('Timing of inferred instantaneous size change') +
  scale_colour_manual(
    values = c("#0C7BDC","#FFC20A"),
    labels = c("EUR (IBS)", "snm")
  ) +
  scale_y_log10() +
  theme(legend.position='none')

# 2Lambda is approximately chi-squared distributed.
# 80 comparisons for 10-300:10, so critical value is 12.79 with Bonferroni correction
qchisq(1 - 0.05/30, df=2)

plot_C = ggplot(data=tajima_D_dataframe, aes(x=sample_size, y=value, color=variable)) + geom_line(size=2) +
  theme_bw() + guides(color=guide_legend(title="Type of SFS")) +
  xlab('') +
  ylab("Tajima's D") +
  ggtitle("Tajima's D for simulated SFS") +
  scale_colour_manual(
    values = c("#0C7BDC","#FFC20A"),
    labels = c("EUR (IBS)", "snm")
  ) +
  geom_hline(yintercept = 0, size = 1, linetype = 'dashed') +
  theme(legend.position='none') +
  ylim(c(-1.25, 1.25))

plot_E = ggplot(data=epoch_ratio_dataframe, aes(x=sample_size, y=value, color=variable)) + geom_line(size=2) +
  theme_bw() + guides(color=guide_legend(title="Epoch Comparison")) +
  xlab('Sample size') +
  ylab("Ratio of effective population size") +
  ggtitle("Effective population size between epochs") +
  scale_colour_manual(
    values = c("#0C7BDC", "#FFC20A"),
    labels = c("EUR (IBS), Bottleneck vs. Ancestral", "EUR (IBS), Current vs. Bottleneck")
  ) +
  geom_hline(yintercept = 1, size = 1, linetype = 'dashed', color='red')

plot_D = ggplot(data=lambda_dataframe, aes(x=sample_size, y=value, color=variable)) + geom_line(size=2) +
  theme_bw() + guides(color=guide_legend(title="Type of SFS")) +
  xlab('') +
  ylab(twoLambda_text) +
  ggtitle("Demographic model fit criterion") +
  scale_colour_manual(
    values = c("#0C7BDC","#FFC20A"),
    labels = c("Three-epoch vs. two-epoch", "Two-epoch vs. one-epoch")
  ) +
  geom_hline(yintercept = 12.79386, size = 1, linetype = 'dashed', color='red') +
  scale_y_log10()

design = "
  CCDD
  AAEE
  BBEE
"

# 1200 x 800
figure_s6 = plot_A + 
  plot_B + 
  plot_C + 
  plot_D + 
  plot_E +
  plot_layout(design=design)

# ggsave('../Summary/figure_6_output.svg', figure_6, width=12, height=8, units='in', dpi=100)


# 
# ### Scale figures
# nu_dataframe = melt(data.frame(
#   EUR_IBS_nu
# ))
# nu_dataframe$sample_size = sample_size
# nu_dataframe$EUR_IBS_min = EUR_IBS_nu_min
# nu_dataframe$EUR_IBS_max = EUR_IBS_nu_max
# 
# tau_dataframe = melt(data.frame(
#   EUR_IBS_tau
# ))
# tau_dataframe$sample_size = sample_size
# tau_dataframe$EUR_IBS_min = EUR_IBS_tau_min
# tau_dataframe$EUR_IBS_max = EUR_IBS_tau_max
# 
# plot_A = ggplot(data=nu_dataframe, aes(x=sample_size, y=value, color=variable)) + geom_line(size=2) +
#   theme_bw() + 
#   # guides(color=guide_legend(title="Type of SFS")) +
#   xlab('Sample size') +
#   ylab(nu_label_text) +
#   ggtitle("Ratio of Effective to Ancestral population size") +
#   scale_colour_manual(
#     values = c("#0C7BDC"),
#     labels = c("1KG 2020, EUR")
#   ) +
#   scale_y_log10() +
#   theme(legend.position='none') +
#   geom_hline(yintercept = 1, size = 1, linetype = 'dashed') +
#   theme(axis.title.x = element_text(size = 20)) +
#   theme(axis.title.y = element_text(size = 16)) +
#   theme(axis.title.x = element_blank())
# 
# plot_B = ggplot(data=tau_dataframe, aes(x=sample_size, y=value, color=variable)) + geom_line(size=2) +
#   theme_bw() + 
#   # guides(color=guide_legend(title="Type of SFS")) +
#   xlab('Sample size') +
#   ylab(tau_label_text) +
#   ggtitle('Timing of inferred instantaneous size change') +
#   scale_colour_manual(
#     values = c("#0C7BDC"),
#     labels = c("1kg 2020, EUR")
#   ) +
#   scale_y_log10() +
#   theme(legend.position='none') +
#   theme(axis.title.x = element_text(size = 20)) +
#   theme(axis.title.y = element_text(size = 16))
# 
# plot_A + plot_B + plot_layout(nrow=2)
