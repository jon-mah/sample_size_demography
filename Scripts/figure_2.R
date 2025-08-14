# figure_2.R

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

sample_size = seq(from=10, to=800, by=10)

dadi_nu = c()
dadi_time = c()
dadi_tau = c()
dadi_tajima_D = c()
dadi_lambda = c()
dadi_two_LL = c()
dadi_three_LL = c()

dadi_nu_min = c()
dadi_nu_max = c()
dadi_tau_min = c()
dadi_tau_max = c()

msprime_nu = c()
msprime_time = c()
msprime_tau = c()
msprime_tajima_D = c()
# msprime_lambda = c()
msprime_lambda = rep(0, 80)

msprime_nu_min = c()
msprime_nu_max = c()
msprime_tau_min = c()
msprime_tau_max = c()

for (i in sample_size) {
  dadi_sfs = paste0(
    "../Simulations/dadi_simulations/ThreeEpochBottleneck_", i, '.sfs')
  dadi_demography = paste0(
    "../Analysis/dadi_3EpB_", i, '/two_epoch_demography.txt')
  dadi_demography_3 = paste0(
    "../Analysis/dadi_3EpB_", i, '/three_epoch_demography.txt')
  dadi_likelihood = paste0(
    "../Analysis/dadi_3EpB_", i, '/likelihood_surface.csv')
  # dadi_nu = c(dadi_nu, nu_from_demography(dadi_demography))
  dadi_time = c(dadi_time, time_from_demography(dadi_demography))
  dadi_summary = paste0(
    "../Simulations/dadi_simulations/ThreeEpochBottleneck_", i, '_summary.txt')
  
  dadi_tajima_D = c(dadi_tajima_D, read_summary_statistics(dadi_summary)[3])
  this_dadi_two_LL = LL_from_demography(dadi_demography)
  this_dadi_three_LL = LL_from_demography(dadi_demography_3)
  dadi_two_LL = c(dadi_two_LL, this_dadi_two_LL)
  dadi_three_LL = c(dadi_three_LL, this_dadi_three_LL)
  dadi_LL_diff = this_dadi_three_LL - this_dadi_two_LL
  dadi_lambda = c(dadi_lambda, 2 * dadi_LL_diff)
  
  dadi_nu = c(dadi_nu, find_CI_bounds(dadi_likelihood)$nu_MLE)
  dadi_nu_min = c(dadi_nu_min, find_CI_bounds(dadi_likelihood)$nu_min)
  dadi_nu_max = c(dadi_nu_max, find_CI_bounds(dadi_likelihood)$nu_max)
  dadi_tau = c(dadi_tau, find_CI_bounds(dadi_likelihood)$tau_MLE)
  dadi_tau_min = c(dadi_tau_min, find_CI_bounds(dadi_likelihood)$tau_min)  
  dadi_tau_max = c(dadi_tau_max, find_CI_bounds(dadi_likelihood)$tau_max)
  
  msprime_sfs = paste0(
    "../Simulations/simple_simulations/ThreeEpochBottleneck_", i, '_concat.sfs')
  msprime_demography = paste0(
    "../Analysis/msprime_3EpB_", i, '/two_epoch_demography.txt')
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
  # msprime_two_epoch_LL = LL_from_demography(msprime_demography)
  # msprime_three_epoch_LL = LL_from_demography(msprime_demography_3)
  # msprime_LL_diff = msprime_three_epoch_LL - msprime_two_epoch_LL
  # msprime_lambda = c(msprime_lambda, 2 * msprime_LL_diff)
}

nu_label_text = expression(nu == frac(N[current], N[ancestral]))
tau_label_text = expression(tau == frac(generations, 2 * N[ancestral]))

nu_dataframe = melt(data.frame(
  dadi_nu,
  msprime_nu
))
nu_dataframe$sample_size = sample_size
nu_dataframe$dadi_min = dadi_nu_min
nu_dataframe$dadi_max = dadi_nu_max
nu_dataframe$msprime_min = msprime_nu_min
nu_dataframe$msprime_max = msprime_nu_max

nu_dataframe_CI_bounds = melt(data.frame(
  dadi_nu_min,
  dadi_nu_max
))
nu_dataframe_CI_bounds$sample_size = sample_size

tau_dataframe = melt(data.frame(
  dadi_tau,
  msprime_tau
))
tau_dataframe$sample_size = sample_size
tau_dataframe$dadi_min = dadi_tau_min
tau_dataframe$dadi_max = dadi_tau_max
tau_dataframe$msprime_min = msprime_tau_min
tau_dataframe$msprime_max = msprime_tau_max

tajima_D_dataframe = melt(data.frame(
  dadi_tajima_D,
  msprime_tajima_D
))
tajima_D_dataframe$sample_size = sample_size

lambda_dataframe = melt(data.frame(
  dadi_lambda,
  msprime_lambda
))
lambda_dataframe$sample_size = sample_size

plot_A = ggplot(data=nu_dataframe, aes(x=sample_size, y=value, color=variable)) + geom_line(size=1) +
  theme_bw() + guides(color=guide_legend(title="Type of SFS")) +
  geom_ribbon(aes(ymin = dadi_min, ymax = dadi_max), fill = "#0C7BDC", color="#0C7BDC", alpha = 0.2) +
  geom_ribbon(aes(ymin = msprime_min, ymax = msprime_max), fill = "#FFC20A", color="#FFC20A", alpha = 0.2) +
  xlab('Sample size') +
  ylab(nu_label_text) +
  ggtitle("Ratio of Ancestral to Effective population size") +
  scale_colour_manual(
    values = c("#0C7BDC","#FFC20A"),
    labels = c("Dadi", "MSPrime")
  ) +
  scale_y_log10() +
  geom_hline(yintercept = 1, size = 2, linetype = 'dashed')


plot_B = ggplot(data=tau_dataframe, aes(x=sample_size, y=value, color=variable)) + geom_line(size=1) +
  theme_bw() + guides(color=guide_legend(title="Type of SFS")) +
  geom_ribbon(aes(ymin = dadi_min, ymax = dadi_max), fill = "#0C7BDC", color="#0C7BDC", alpha = 0.2) +
  geom_ribbon(aes(ymin = msprime_min, ymax = msprime_max), fill = "#FFC20A", color="#FFC20A", alpha = 0.2) +
  xlab('Sample size') +
  ylab(tau_label_text) +
  ggtitle('Timing of inferred instantaneous size change') +
  scale_colour_manual(
    values = c("#0C7BDC","#FFC20A"),
    labels = c("Dadi", "MSPrime")
  ) +
  scale_y_log10() +
  theme(legend.position='none')

plot_C = ggplot(data=lambda_dataframe, aes(x=sample_size, y=value, color=variable)) + geom_line(size=2) +
  theme_bw() + guides(color=guide_legend(title="Type of SFS")) +
  xlab('Sample size') +
  ylab("2*Lambda") +
  ggtitle("2*Lambda demographic model fit criterion") +
  scale_colour_manual(
    values = c("#0C7BDC","#FFC20A"),
    labels = c("Dadi", "MSPrime")
  ) +
  theme(legend.position='none')

plot_D = ggplot(data=tajima_D_dataframe, aes(x=sample_size, y=value, color=variable)) + geom_line(size=2) +
  theme_bw() + guides(color=guide_legend(title="Type of SFS")) +
  xlab('Sample size') +
  ylab("Tajima's D") +
  ggtitle("Tajima's D for simulated SFS") +
  scale_colour_manual(
    values = c("#0C7BDC","#FFC20A"),
    labels = c("Dadi", "MSPrime")
  ) +
  geom_hline(yintercept = 0, size = 2, linetype = 'dashed') +
  theme(legend.position='none')

plot_E = plot_likelihood_surface_contour('../Analysis/dadi_3EpB_50/likelihood_surface.csv') +
  ggtitle('Likelihood surface for dadi-simulated SFS, k=50') +
  theme(axis.title.x=element_blank()) 

# find_CI_bounds('../Analysis/dadi_3EpB_50/likelihood_surface.csv')$nu_min

plot_F = plot_likelihood_surface_contour('../Analysis/dadi_3EpB_100/likelihood_surface.csv') +
  ggtitle('Likelihood surface for dadi-simulated SFS, k=100') +
  theme(axis.title.x=element_blank(), axis.title.y=element_blank()) 

plot_G = plot_likelihood_surface_contour('../Analysis/dadi_3EpB_200/likelihood_surface.csv') +
  ggtitle('Likelihood surface for dadi-simulated SFS, k=200') +
  theme(axis.title.x=element_blank(), axis.title.y=element_blank()) 

plot_H = plot_likelihood_surface_contour('../Analysis/dadi_3EpB_300/likelihood_surface.csv') +
  ggtitle('Likelihood surface for dadi-simulated SFS, k=300') +
  theme(legend.position='none')

loglik_dataframe = melt(data.frame(
  dadi_two_LL,
  dadi_three_LL
))
loglik_dataframe$sample_size = sample_size

ggplot(data=loglik_dataframe, aes(x=sample_size, y=value, color=variable)) + geom_line(size=2) +
  theme_bw() + guides(color=guide_legend(title="Type of SFS")) +
  xlab('Sample size') +
  ylab("Log likelihood") +
  ggtitle("Log likelihood for simulated SFS") +
  scale_colour_manual(
    values = c("#0C7BDC","#FFC20A"),
    labels = c("Two-epoch", "Three-epoch")
  ) +
  geom_hline(yintercept = 0, size = 2, linetype = 'dashed')


design = "
  AAF
  BBF
  CCH
  DDH
"

plot_A + 
  plot_B + 
  plot_C + 
  plot_D + 
  plot_E + 
  # plot_F + 
  # plot_G +
  plot_H +
  plot_layout(design=design)






for (i in sample_size) {
  print(i)
  print('dadi')
  dadi_likelihood = paste0(
    "../Analysis/dadi_3EpB_", i, '/likelihood_surface.csv')
  plot_likelihood_surface_contour(dadi_likelihood)
  print('msprime')
  msprime_likelihood = paste0(
   "../Analysis/msprime_3EpB_", i, '/likelihood_surface.csv')
  plot_likelihood_surface_contour(msprime_likelihood)
}
