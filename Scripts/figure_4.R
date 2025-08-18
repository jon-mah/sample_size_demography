# figure_4.R

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

sample_size = seq(from=10, to=800, by=10)

dadi_sfs_singletons = c()
dadi_snm_singletons = c()
dadi_singleton_ratio = c()
dadi_singleton_diff = c()

msprime_sfs_singletons = c()
msprime_snm_singletons = c()
msprime_singleton_ratio = c()
msprime_singleton_diff = c()

for (i in sample_size) {
  dadi_sfs = proportional_sfs(read_input_sfs(paste0(
    "../Simulations/dadi_simulations/ThreeEpochBottleneck_", i, '.sfs')))
  dadi_snm_sfs = proportional_sfs(sfs_from_demography(paste0(
    "../Analysis/dadi_3EpB_", i, '/one_epoch_demography.txt')))
  dadi_sfs_singletons = c(dadi_sfs_singletons, dadi_sfs[1])
  dadi_snm_singletons = c(dadi_sfs_singletons, dadi_snm_sfs[1])
  dadi_singleton_ratio = c(dadi_singleton_ratio, dadi_sfs[1] / dadi_snm_sfs[1])
  dadi_singleton_diff = c(dadi_singleton_diff, (dadi_sfs[1] - dadi_snm_sfs[1]))
    
  msprime_sfs = proportional_sfs(read_input_sfs(paste0(
    "../Simulations/simple_simulations/ThreeEpochBottleneck_", i, '_concat.sfs')))
  msprime_snm_sfs = proportional_sfs(sfs_from_demography(paste0(
    "../Analysis/msprime_3EpB_", i, '/one_epoch_demography.txt')))
  msprime_sfs_singletons = c(msprime_sfs_singletons, msprime_sfs[1])
  msprime_snm_singletons = c(msprime_sfs_singletons, msprime_snm_sfs[1])
  msprime_singleton_ratio = c(msprime_singleton_ratio, msprime_sfs[1] / msprime_snm_sfs[1])
  msprime_singleton_diff = c(msprime_singleton_diff, (msprime_sfs[1] - msprime_snm_sfs[1]))
}

singleton_ratio_dataframe = melt(data.frame(
  dadi_singleton_ratio,
  msprime_singleton_ratio
))
singleton_ratio_dataframe$sample_size = sample_size

nu_label_text = expression(nu == frac(N[current], N[ancestral]))
ratio_label_text = expression(frac('Proportion of singletons in data', 'Proportion of singletons in SNM'))

plot_A = ggplot(data=singleton_ratio_dataframe, aes(x=sample_size, y=value, color=variable)) + geom_line(linewidth=1) +
  theme_bw() + guides(color=guide_legend(title="Type of SFS")) +
  xlab('Sample size') +
  ylab(ratio_label_text) +
  ggtitle('Ratio of singleton proportion between data and SNM') +
  scale_colour_manual(
    values = c("#0C7BDC","#FFC20A"),
    labels = c("Dadi", "MSPrime")
  ) +
  scale_y_log10() +
  geom_hline(yintercept = 1, size = 1, linetype = 'dotted')

singleton_diff_dataframe = melt(data.frame(
  dadi_singleton_diff,
  msprime_singleton_diff
))
singleton_diff_dataframe$sample_size = sample_size

diff_label_text = expression('Difference in proportion of singletons between data and SNM')

plot_B = ggplot(data=singleton_diff_dataframe, aes(x=sample_size, y=value, color=variable)) + geom_line(linewidth=1) +
  theme_bw() + guides(color=guide_legend(title="Type of SFS")) +
  xlab('Sample size') +
  ylab(diff_label_text) +
  ggtitle('Difference in singleton proportion between data and SNM') +
  scale_colour_manual(
    values = c("#0C7BDC","#FFC20A"),
    labels = c("Dadi", "MSPrime")
  ) +
  geom_hline(yintercept = 0, size = 1, linetype = 'dotted') +
  theme(legend.position='none')

plot_A + plot_B + plot_layout(nrow=2)
