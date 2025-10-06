# figure_6.R

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

sample_size = seq(from=10, to=800, by=10)

one_epoch_50 = sfs_from_demography('../Analysis/dadi_3EpB_50/one_epoch_demography.txt')
one_epoch_80 = sfs_from_demography('../Analysis/dadi_3EpB_80/one_epoch_demography.txt')
one_epoch_110 = sfs_from_demography('../Analysis/dadi_3EpB_110/one_epoch_demography.txt')
one_epoch_140 = sfs_from_demography('../Analysis/dadi_3EpB_140/one_epoch_demography.txt')

dadi_sfs_50 = read_input_sfs('../Simulations/dadi_simulations/ThreeEpochBottleneck_50.sfs')
dadi_sfs_80 = read_input_sfs('../Simulations/dadi_simulations/ThreeEpochBottleneck_80.sfs')
dadi_sfs_110 = read_input_sfs('../Simulations/dadi_simulations/ThreeEpochBottleneck_110.sfs')
dadi_sfs_140 = read_input_sfs('../Simulations/dadi_simulations/ThreeEpochBottleneck_140.sfs')

dadi_nu_50 = nu_from_demography('../Analysis/dadi_3EpB_50/two_epoch_demography.txt')
dadi_nu_80 = nu_from_demography('../Analysis/dadi_3EpB_80/two_epoch_demography.txt')
dadi_nu_110 = nu_from_demography('../Analysis/dadi_3EpB_110/two_epoch_demography.txt')
dadi_nu_140 = nu_from_demography('../Analysis/dadi_3EpB_140/two_epoch_demography.txt')

dadi_tau_50 = tau_from_demography('../Analysis/dadi_3EpB_50/two_epoch_demography.txt')
dadi_tau_80 = tau_from_demography('../Analysis/dadi_3EpB_80/two_epoch_demography.txt')
dadi_tau_110 = tau_from_demography('../Analysis/dadi_3EpB_110/two_epoch_demography.txt')
dadi_tau_140 = tau_from_demography('../Analysis/dadi_3EpB_140/two_epoch_demography.txt')

dadi_time_50 = time_from_demography('../Analysis/dadi_3EpB_50/two_epoch_demography.txt')
dadi_time_80 = time_from_demography('../Analysis/dadi_3EpB_80/two_epoch_demography.txt')
dadi_time_110 = time_from_demography('../Analysis/dadi_3EpB_110/two_epoch_demography.txt')
dadi_time_140 = time_from_demography('../Analysis/dadi_3EpB_140/two_epoch_demography.txt')

dadi_theta_50 = theta_from_demography('../Analysis/dadi_3EpB_50/two_epoch_demography.txt')
dadi_theta_80 = theta_from_demography('../Analysis/dadi_3EpB_80/two_epoch_demography.txt')
dadi_theta_110 = theta_from_demography('../Analysis/dadi_3EpB_110/two_epoch_demography.txt')
dadi_theta_140 = theta_from_demography('../Analysis/dadi_3EpB_140/two_epoch_demography.txt')

dadi_simulation_two_epoch_theta = c(dadi_theta_50, dadi_theta_80, dadi_theta_110, dadi_theta_140)
dadi_simulation_two_epoch_nu = c(dadi_nu_50, dadi_nu_80, dadi_nu_110, dadi_nu_140)
dadi_simulation_two_epoch_tau = c(dadi_nu_50, dadi_nu_80, dadi_nu_110, dadi_nu_140)

dadi_simulation_two_epoch_NAnc = dadi_simulation_two_epoch_theta / (4 * 80000000 * 1.5E-8)
dadi_simulation_two_epoch_NCurr = dadi_simulation_two_epoch_nu * dadi_simulation_two_epoch_NAnc
dadi_simulation_two_epoch_Time = c(dadi_time_50, dadi_time_80, dadi_time_110, dadi_time_140)
# ThreeEpochB_two_epoch_Time = 2 * ThreeEpochB_two_epoch_tau * ThreeEpochB_two_epoch_theta / (4 * ThreeEpochB_mu * ThreeEpochB_two_epoch_allele_sum)


two_epoch_max_time = max(dadi_simulation_two_epoch_Time)
dadi_simulation_two_epoch_max_time = rep(two_epoch_max_time * 1.05, 4)
dadi_simulation_two_epoch_current_time = rep(50, 4)
dadi_simulation_two_epoch_demography = data.frame(dadi_simulation_two_epoch_NAnc, dadi_simulation_two_epoch_max_time,
  dadi_simulation_two_epoch_NCurr, dadi_simulation_two_epoch_Time,
  dadi_simulation_two_epoch_NCurr, dadi_simulation_two_epoch_current_time)

dadi_simulation_two_epoch_NEffective_50 = c(dadi_simulation_two_epoch_demography[1, 1], dadi_simulation_two_epoch_demography[1, 3], dadi_simulation_two_epoch_demography[1, 5])
dadi_simulation_two_epoch_Time_50 = c(-dadi_simulation_two_epoch_demography[1, 2], -dadi_simulation_two_epoch_demography[1, 4], dadi_simulation_two_epoch_demography[1, 6])
dadi_simulation_two_epoch_demography_50 = data.frame(dadi_simulation_two_epoch_Time_50, dadi_simulation_two_epoch_NEffective_50)
dadi_simulation_two_epoch_NEffective_80 = c(dadi_simulation_two_epoch_demography[2, 1], dadi_simulation_two_epoch_demography[2, 3], dadi_simulation_two_epoch_demography[2, 5])
dadi_simulation_two_epoch_Time_80 = c(-dadi_simulation_two_epoch_demography[2, 2], -dadi_simulation_two_epoch_demography[2, 4], dadi_simulation_two_epoch_demography[2, 6])
dadi_simulation_two_epoch_demography_80 = data.frame(dadi_simulation_two_epoch_Time_80, dadi_simulation_two_epoch_NEffective_80)
dadi_simulation_two_epoch_NEffective_110 = c(dadi_simulation_two_epoch_demography[3, 1], dadi_simulation_two_epoch_demography[3, 3], dadi_simulation_two_epoch_demography[3, 5])
dadi_simulation_two_epoch_Time_110 = c(-dadi_simulation_two_epoch_demography[3, 2], -dadi_simulation_two_epoch_demography[3, 4], dadi_simulation_two_epoch_demography[3, 6])
dadi_simulation_two_epoch_demography_110 = data.frame(dadi_simulation_two_epoch_Time_110, dadi_simulation_two_epoch_NEffective_110)
dadi_simulation_two_epoch_NEffective_140 = c(dadi_simulation_two_epoch_demography[4, 1], dadi_simulation_two_epoch_demography[4, 3], dadi_simulation_two_epoch_demography[4, 5])
dadi_simulation_two_epoch_Time_140 = c(-dadi_simulation_two_epoch_demography[4, 2], -dadi_simulation_two_epoch_demography[4, 4], dadi_simulation_two_epoch_demography[4, 6])
dadi_simulation_two_epoch_demography_140 = data.frame(dadi_simulation_two_epoch_Time_140, dadi_simulation_two_epoch_NEffective_140)

ThreeEpochB_true_NAnc = 8000
ThreeEpochB_true_NBottle = 800
ThreeEpochB_true_NCurr = 50000
ThreeEpochB_true_TimeBottleEnd = 140
ThreeEpochB_true_TimeBottleStart = 800
# ThreeEpochB_three_epoch_TimeBottleEnd = 2 * ThreeEpochB_three_epoch_tauF * ThreeEpochB_three_epoch_theta / (4 * ThreeEpochB_mu * ThreeEpochB_three_epoch_allele_sum)
# ThreeEpochB_three_epoch_TimeBottleStart = 2 * ThreeEpochB_three_epoch_tauB * ThreeEpochB_three_epoch_theta / (4 * ThreeEpochB_mu * ThreeEpochB_three_epoch_allele_sum) + ThreeEpochB_three_epoch_TimeBottleEnd

ThreeEpochB_true_TimeTotal = 1400
ThreeEpochB_true_TimeCurrent = 50

ThreeEpochB_true_demography = data.frame(ThreeEpochB_true_NAnc, two_epoch_max_time * 1.05,
  ThreeEpochB_true_NBottle, ThreeEpochB_true_TimeBottleStart,
  ThreeEpochB_true_NCurr, ThreeEpochB_true_TimeBottleEnd,
  ThreeEpochB_true_NCurr, ThreeEpochB_true_TimeCurrent)

ThreeEpochB_true_NEffective_params = c(ThreeEpochB_true_demography[1, 1], ThreeEpochB_true_demography[1, 3], ThreeEpochB_true_demography[1, 5], ThreeEpochB_true_demography[1, 7])
ThreeEpochB_true_Time_params = c(-ThreeEpochB_true_demography[1, 2], -ThreeEpochB_true_demography[1, 4], -ThreeEpochB_true_demography[1, 6], ThreeEpochB_true_demography[1, 8])
ThreeEpochB_true_demography_params = data.frame(ThreeEpochB_true_Time_params, ThreeEpochB_true_NEffective_params)

plot_A = compare_simulation_null_sfs_proportional(dadi_sfs_50, one_epoch_50, '#bfd3e6') + 
  ggtitle('50 simulated individuals') + guides(fill='none')
plot_B = compare_simulation_null_sfs_proportional(dadi_sfs_80, one_epoch_80, '#8c96c6') + 
  ggtitle('80 simulated individuals') + guides(fill='none')
plot_C = compare_simulation_null_sfs_proportional(dadi_sfs_110, one_epoch_110, '#88419d') + 
  ggtitle('110 simulated individuals') + guides(fill='none')
plot_D = compare_simulation_null_sfs_proportional(dadi_sfs_140, one_epoch_140, '#4d004b') + 
  ggtitle('140 simulated individuals')

plot_E = ggplot(dadi_simulation_two_epoch_demography_50, aes(dadi_simulation_two_epoch_Time_50, dadi_simulation_two_epoch_NEffective_50, color='N=50')) + geom_step(linewidth=1.5, linetype='solid') +
  geom_step(data=dadi_simulation_two_epoch_demography_80, aes(dadi_simulation_two_epoch_Time_80, dadi_simulation_two_epoch_NEffective_80, color='N=80'), linewidth=1.5, linetype='solid') +
  geom_step(data=dadi_simulation_two_epoch_demography_110, aes(dadi_simulation_two_epoch_Time_110, dadi_simulation_two_epoch_NEffective_110, color='N=110'), linewidth=1.5, linetype='solid') +
  geom_step(data=dadi_simulation_two_epoch_demography_140, aes(dadi_simulation_two_epoch_Time_140, dadi_simulation_two_epoch_NEffective_140, color='N=140'), linewidth=1.5, linetype='solid') +
  geom_step(data=ThreeEpochB_true_demography_params, aes(ThreeEpochB_true_Time_params, ThreeEpochB_true_NEffective_params, color='True'), linewidth=1.5, linetype='solid') +
  scale_color_manual(name='Sample Size',
                     breaks=c('N=50', 'N=80', 'N=110', 'N=140', 'True'),
                     values=c('N=50'='#bfd3e6',
                       'N=80'='#8c96c6',
                       'N=110'='#88419d',
                       'N=140'='#4d004b',
                       'True'='#b30000')) +
  theme_bw() +
  ylab('Effective population size') +
  xlab('Approximate time in years relative to current time') +
  scale_y_log10() +
  ggtitle('Inferred two-epoch demographic model from Dadi simulated SFS')

design = '
ABCD
EEEE
'

plot_A + plot_B + plot_C + plot_D + plot_E + plot_layout(design=design)

# * 4 sample sizes ranging from small to large (ancient to recent)
# * Just Dadi shown in main text, MSPrime for supplement
# * SFS on left-hand, demography plot on right hand [two-epoch fit, for now, best-fit later or in supplement]
# * Show true underlying simulated demography
