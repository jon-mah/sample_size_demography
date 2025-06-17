# generate_sample_size_figures.R

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

global_allele_sum = 20 * 1000000

TwoEpochC_watterson_theta = c()
# TwoEpochC_heterozygosity = c()
TwoEpochC_tajima_d = c()
TwoEpochC_singetons = c()
TwoEpochC_pi = c()
TwoEpochC_zeng_E = c()
TwoEpochC_zeng_theta_L = c()
TwoEpochC_proportion_singletons = c()
TwoEpochC_rare_variant_proportion = c()

TwoEpochE_watterson_theta = c()
# TwoEpochE_heterozygosity = c()
TwoEpochE_tajima_d = c()
TwoEpochE_singletons = c()
TwoEpochE_pi = c()
TwoEpochE_zeng_E = c()
TwoEpochE_zeng_theta_L = c()
TwoEpochE_proportion_singletons = c()
TwoEpochE_rare_variant_proportion = c()

ThreeEpochB_watterson_theta = c()
# ThreeEpochB_heterozygosity = c()
ThreeEpochB_tajima_d = c()
ThreeEpochB_singletons = c()
ThreeEpochB_pi = c()
ThreeEpochB_zeng_E = c()
ThreeEpochB_zeng_theta_L = c()
ThreeEpochB_proportion_singletons = c()
ThreeEpochB_rare_variant_proportion = c()

ThreeEpochC_watterson_theta = c()
# ThreeEpochC_heterozygosity = c()
ThreeEpochC_tajima_d = c()
ThreeEpochC_singletons = c()
ThreeEpochC_pi = c()
ThreeEpochC_zeng_E = c()
ThreeEpochC_zeng_theta_L = c()
ThreeEpochC_proportion_singletons = c()
ThreeEpochC_rare_variant_proportion = c()

ThreeEpochE_watterson_theta = c()
# ThreeEpochE_heterozygosity = c()
ThreeEpochE_tajima_d = c()
ThreeEpochE_singletons = c()
ThreeEpochE_pi = c()
ThreeEpochE_zeng_E = c()
ThreeEpochE_zeng_theta_L = c()
ThreeEpochE_proportion_singletons = c()
ThreeEpochE_rare_variant_proportion = c()

snm_watterson_theta = c()
# snm_heterozygosity = c()
snm_tajima_d = c()
snm_singletons = c()
snm_pi = c()
snm_zeng_E = c()
snm_zeng_theta_L = c()
snm_proportion_singletons = c()
snm_rare_variant_proportion = c()

# Loop through subdirectories and get relevant files
for (i in seq(from=10, to=800, by=10)) {
  subdirectory_2epC <- paste0("../Analysis/TwoEpochContraction_", i)
  subdirectory_2epE <- paste0("../Analysis/TwoEpochExpansion_", i)
  subdirectory_3epB <- paste0("../Analysis/ThreeEpochBottleneck_", i)
  subdirectory_3epC <- paste0("../Analysis/ThreeEpochContraction_", i)
  subdirectory_3epE <- paste0("../Analysis/ThreeEpochExpansion_", i)
  subdirectory_snm <- paste0("../Analysis/snm_", i)
  TwoEpochC_log_file_path <- file.path(subdirectory_2epC, "syn_downsampled.log")
  TwoEpochE_log_file_path <- file.path(subdirectory_2epE, "syn_downsampled.log")
  ThreeEpochB_log_file_path <- file.path(subdirectory_3epB, "syn_downsampled.log")
  ThreeEpochC_log_file_path <- file.path(subdirectory_3epC, "syn_downsampled.log")
  ThreeEpochE_log_file_path <- file.path(subdirectory_3epE, "syn_downsampled.log")
  snm_log_file_path <- file.path(subdirectory_snm, "snm_downsampled.log")
  TwoEpochC_sfs_file_path <- file.path(subdirectory_2epC, "syn_downsampled_sfs.txt")
  TwoEpochE_sfs_file_path <- file.path(subdirectory_2epE, "syn_downsampled_sfs.txt")
  ThreeEpochB_sfs_file_path <- file.path(subdirectory_3epB, "syn_downsampled_sfs.txt")
  ThreeEpochC_sfs_file_path <- file.path(subdirectory_3epC, "syn_downsampled_sfs.txt")
  ThreeEpochE_sfs_file_path <- file.path(subdirectory_3epE, "syn_downsampled_sfs.txt")
  snm_sfs_file_path <- file.path(subdirectory_snm, "snm_downsampled_sfs.txt")

  # Check if the file exists before attempting to read and print its contents
  if (file.exists(TwoEpochC_log_file_path)) {
    TwoEpochC_watterson_theta = c(TwoEpochC_watterson_theta, watterson_theta_from_sfs(TwoEpochC_log_file_path))
    # TwoEpochC_heterozygosity = c(TwoEpochC_heterozygosity, heterozygosity_from_sfs(TwoEpochC_log_file_path))
    TwoEpochC_tajima_d = c(TwoEpochC_tajima_d, tajima_D_from_sfs(TwoEpochC_log_file_path))
    TwoEpochC_pi = c(TwoEpochC_pi, pi_from_sfs_array(read_input_sfs(TwoEpochC_sfs_file_path)))
    TwoEpochC_zeng_E = c(TwoEpochC_zeng_E, zeng_E_from_sfs(TwoEpochC_log_file_path))
    TwoEpochC_zeng_theta_L = c(TwoEpochC_zeng_theta_L, zeng_theta_L_from_sfs(TwoEpochC_log_file_path))
    TwoEpochC_proportion_singletons = c(TwoEpochC_proportion_singletons, 
      read_input_sfs(TwoEpochC_sfs_file_path)[1] / sum(read_input_sfs(TwoEpochC_sfs_file_path)))
    TwoEpochC_rare_variant_proportion = c(TwoEpochC_rare_variant_proportion, calculate_rare_variant_proportion(read_input_sfs(TwoEpochC_sfs_file_path)))
  }
  if (file.exists(TwoEpochE_log_file_path)) {
    TwoEpochE_watterson_theta = c(TwoEpochE_watterson_theta, watterson_theta_from_sfs(TwoEpochE_log_file_path))
    # TwoEpochE_heterozygosity = c(TwoEpochE_heterozygosity, heterozygosity_from_sfs(TwoEpochE_log_file_path))
    TwoEpochE_tajima_d = c(TwoEpochE_tajima_d, tajima_D_from_sfs(TwoEpochE_log_file_path))
    TwoEpochE_pi = c(TwoEpochE_pi, pi_from_sfs_array(read_input_sfs(TwoEpochE_sfs_file_path)))
    TwoEpochE_zeng_E = c(TwoEpochE_zeng_E, zeng_E_from_sfs(TwoEpochE_log_file_path))
    TwoEpochE_zeng_theta_L = c(TwoEpochE_zeng_theta_L, zeng_theta_L_from_sfs(TwoEpochE_log_file_path))
    TwoEpochE_proportion_singletons = c(TwoEpochE_proportion_singletons, 
      read_input_sfs(TwoEpochE_sfs_file_path)[1] / sum(read_input_sfs(TwoEpochE_sfs_file_path)))
    TwoEpochE_rare_variant_proportion = c(TwoEpochE_rare_variant_proportion, calculate_rare_variant_proportion(read_input_sfs(TwoEpochE_sfs_file_path)))
  }
  if (file.exists(ThreeEpochB_log_file_path)) {
    ThreeEpochB_watterson_theta = c(ThreeEpochB_watterson_theta, watterson_theta_from_sfs(ThreeEpochB_log_file_path))
    # ThreeEpochB_heterozygosity = c(ThreeEpochB_heterozygosity, heterozygosity_from_sfs(ThreeEpochB_log_file_path))
    ThreeEpochB_tajima_d = c(ThreeEpochB_tajima_d, tajima_D_from_sfs(ThreeEpochB_log_file_path))
    ThreeEpochB_pi = c(ThreeEpochB_pi, pi_from_sfs_array(read_input_sfs(ThreeEpochB_sfs_file_path)))
    ThreeEpochB_zeng_E = c(ThreeEpochB_zeng_E, zeng_E_from_sfs(ThreeEpochB_log_file_path))
    ThreeEpochB_zeng_theta_L = c(ThreeEpochB_zeng_theta_L, zeng_theta_L_from_sfs(ThreeEpochB_log_file_path))
    ThreeEpochB_proportion_singletons = c(ThreeEpochB_proportion_singletons, 
      read_input_sfs(ThreeEpochB_sfs_file_path)[1] / sum(read_input_sfs(ThreeEpochB_sfs_file_path)))
    ThreeEpochB_rare_variant_proportion = c(ThreeEpochB_rare_variant_proportion, calculate_rare_variant_proportion(read_input_sfs(ThreeEpochB_sfs_file_path)))
  }
  if (file.exists(ThreeEpochC_log_file_path)) {
    ThreeEpochC_watterson_theta = c(ThreeEpochC_watterson_theta, watterson_theta_from_sfs(ThreeEpochC_log_file_path))
    # ThreeEpochC_heterozygosity = c(ThreeEpochC_heterozygosity, heterozygosity_from_sfs(ThreeEpochC_log_file_path))
    ThreeEpochC_tajima_d = c(ThreeEpochC_tajima_d, tajima_D_from_sfs(ThreeEpochC_log_file_path))
    ThreeEpochC_pi = c(ThreeEpochC_pi, pi_from_sfs_array(read_input_sfs(ThreeEpochC_sfs_file_path)))
    ThreeEpochC_zeng_E = c(ThreeEpochC_zeng_E, zeng_E_from_sfs(ThreeEpochC_log_file_path))
    ThreeEpochC_zeng_theta_L = c(ThreeEpochC_zeng_theta_L, zeng_theta_L_from_sfs(ThreeEpochC_log_file_path))
    ThreeEpochC_proportion_singletons = c(ThreeEpochC_proportion_singletons, 
      read_input_sfs(ThreeEpochC_sfs_file_path)[1] / sum(read_input_sfs(ThreeEpochC_sfs_file_path)))
    ThreeEpochC_rare_variant_proportion = c(ThreeEpochC_rare_variant_proportion, calculate_rare_variant_proportion(read_input_sfs(ThreeEpochC_sfs_file_path)))
  }
  if (file.exists(ThreeEpochE_log_file_path)) {
    ThreeEpochE_watterson_theta = c(ThreeEpochE_watterson_theta, watterson_theta_from_sfs(ThreeEpochE_log_file_path))
    # ThreeEpochE_heterozygosity = c(ThreeEpochE_heterozygosity, heterozygosity_from_sfs(ThreeEpochE_log_file_path))
    ThreeEpochE_tajima_d = c(ThreeEpochE_tajima_d, tajima_D_from_sfs(ThreeEpochE_log_file_path))
    ThreeEpochE_pi = c(ThreeEpochE_pi, pi_from_sfs_array(read_input_sfs(ThreeEpochE_sfs_file_path)))
    ThreeEpochE_zeng_E = c(ThreeEpochE_zeng_E, zeng_E_from_sfs(ThreeEpochE_log_file_path))
    ThreeEpochE_zeng_theta_L = c(ThreeEpochE_zeng_theta_L, zeng_theta_L_from_sfs(ThreeEpochE_log_file_path))
    ThreeEpochE_proportion_singletons = c(ThreeEpochE_proportion_singletons, 
      read_input_sfs(ThreeEpochE_sfs_file_path)[1] / sum(read_input_sfs(ThreeEpochE_sfs_file_path)))
    ThreeEpochE_rare_variant_proportion = c(ThreeEpochE_rare_variant_proportion, calculate_rare_variant_proportion(read_input_sfs(ThreeEpochE_sfs_file_path)))
  }
  if (file.exists(snm_log_file_path)) {
    snm_watterson_theta = c(snm_watterson_theta, watterson_theta_from_sfs(snm_log_file_path))
    # snm_heterozygosity = c(snm_heterozygosity, heterozygosity_from_sfs(snm_log_file_path))
    snm_tajima_d = c(snm_tajima_d, tajima_D_from_sfs(snm_log_file_path))
    snm_pi = c(snm_pi, pi_from_sfs_array(read_input_sfs(snm_sfs_file_path)))
    snm_zeng_E = c(snm_zeng_E, zeng_E_from_sfs(snm_log_file_path))
    snm_zeng_theta_L = c(snm_zeng_theta_L, zeng_theta_L_from_sfs(snm_log_file_path))
    snm_proportion_singletons = c(snm_proportion_singletons, 
      read_input_sfs(snm_sfs_file_path)[1] / sum(read_input_sfs(snm_sfs_file_path)))
    snm_rare_variant_proportion = c(snm_rare_variant_proportion, calculate_rare_variant_proportion(read_input_sfs(snm_sfs_file_path)))
  }
}

watterson_df = data.frame(TwoEpochC_watterson_theta,
  TwoEpochE_watterson_theta,
  ThreeEpochB_watterson_theta,
  ThreeEpochC_watterson_theta,
  ThreeEpochE_watterson_theta,
  snm_watterson_theta)

watterson_df$sample_size = seq(from=10, to=800, by=10)

ggplot(data=watterson_df, aes(x=sample_size, y=TwoEpochC_watterson_theta, color='Two Epoch Contraction')) + geom_line(linewidth=2) +
  geom_line(aes(x=sample_size, y=TwoEpochE_watterson_theta, color='Two Epoch Expansion'), linewidth=2) +
  geom_line(aes(x=sample_size, y=ThreeEpochB_watterson_theta, color='Three Epoch Bottleneck'), linewidth=2) +
  geom_line(aes(x=sample_size, y=ThreeEpochC_watterson_theta, color='Three Epoch Contraction'), linewidth=2) +
  geom_line(aes(x=sample_size, y=ThreeEpochE_watterson_theta, color='Three Epoch Expansion'), linewidth=2) +
  geom_line(aes(x=sample_size, y=snm_watterson_theta, color='Standard Neutral Model'), linewidth=2) +
  scale_color_manual(name='Simulated Demographic Scenario',
                     breaks=c('Two Epoch Contraction',
                       'Two Epoch Expansion',
                       'Three Epoch Bottleneck',
                       'Three Epoch Contraction',
                       'Three Epoch Expansion',
                       'Standard Neutral Model'),
                     values=c('Two Epoch Contraction'='#a50026',
                       'Two Epoch Expansion'='#f46d43',
                       'Three Epoch Bottleneck'='#fee090',
                       'Three Epoch Contraction'='#74add1',
                       'Three Epoch Expansion'='#313695',
                       'Standard Neutral Model'='black')) +
  theme_bw() +
  ylab("Watterson's Theta") +
  xlab('Sample Size') +
  # scale_x_log10() +
  ggtitle("Watterson's Theta over sample size for simulated demographic histories")

tajima_d_df = data.frame(TwoEpochC_tajima_d,
  TwoEpochE_tajima_d,
  ThreeEpochB_tajima_d,
  ThreeEpochC_tajima_d,
  ThreeEpochE_tajima_d,
  snm_tajima_d)

tajima_d_df$sample_size = seq(from=10, to=800, by=10)

ggplot(data=tajima_d_df, aes(x=sample_size, y=TwoEpochC_tajima_d, color='Two Epoch Contraction')) + geom_line(linewidth=2) +
  geom_line(aes(x=sample_size, y=TwoEpochE_tajima_d, color='Two Epoch Expansion'), linewidth=2) +
  geom_line(aes(x=sample_size, y=ThreeEpochB_tajima_d, color='Three Epoch Bottleneck'), linewidth=2) +
  geom_line(aes(x=sample_size, y=ThreeEpochC_tajima_d, color='Three Epoch Contraction'), linewidth=2) +
  geom_line(aes(x=sample_size, y=ThreeEpochE_tajima_d, color='Three Epoch Expansion'), linewidth=2) +
  geom_line(aes(x=sample_size, y=snm_tajima_d, color='Standard Neutral Model'), linewidth=2) +
  scale_color_manual(name='Simulated Demographic Scenario',
                     breaks=c('Two Epoch Contraction',
                       'Two Epoch Expansion',
                       'Three Epoch Bottleneck',
                       'Three Epoch Contraction',
                       'Three Epoch Expansion',
                       'Standard Neutral Model'),
                     values=c('Two Epoch Contraction'='#a50026',
                       'Two Epoch Expansion'='#f46d43',
                       'Three Epoch Bottleneck'='#fee090',
                       'Three Epoch Contraction'='#74add1',
                       'Three Epoch Expansion'='#313695',
                       'Standard Neutral Model'='black')) +
  geom_hline(yintercept = 0, linetype='dashed') +
  theme_bw() +
  ylab("Tajima's D") +
  xlab('Sample Size') +
  ggtitle("Tajima's D over sample size for simulated demographic histories")

# pi_df = data.frame(TwoEpochC_pi,
#   TwoEpochE_pi,
#   ThreeEpochB_pi,
#   ThreeEpochC_pi,
#   ThreeEpochE_pi)
# 
# pi_df$sample_size = seq(from=10, to=800, by=10)
# 
# ggplot(data=pi_df, aes(x=sample_size, y=TwoEpochC_pi, color='Two Epoch Contraction')) + geom_line(linewidth=2) +
#   geom_line(aes(x=sample_size, y=TwoEpochE_pi, color='Two Epoch Expansion'), linewidth=2) +
#   geom_line(aes(x=sample_size, y=ThreeEpochB_pi, color='Three Epoch Bottleneck'), linewidth=2) +
#   geom_line(aes(x=sample_size, y=ThreeEpochC_pi, color='Three Epoch Contraction'), linewidth=2) +
#   geom_line(aes(x=sample_size, y=ThreeEpochE_pi, color='Three Epoch Expansion'), linewidth=2) +
#   scale_color_manual(name='Simulated Demographic Scenario',
#                      breaks=c('Two Epoch Contraction',
#                        'Two Epoch Expansion',
#                        'Three Epoch Bottleneck',
#                        'Three Epoch Contraction',
#                        'Three Epoch Expansion'),
#                      values=c('Two Epoch Contraction'='#a50026',
#                        'Two Epoch Expansion'='#f46d43',
#                        'Three Epoch Bottleneck'='#fee090',
#                        'Three Epoch Contraction'='#74add1',
#                        'Three Epoch Expansion'='#313695')) +
#   geom_hline(yintercept = 0, linetype='dashed') +
#   theme_bw() +
#   ylab("Tajima's D") +
#   xlab('Sample Size') +
#   ggtitle("Tajima's D over sample size for simulated demographic histories")

zeng_E_df = data.frame(TwoEpochC_zeng_E,
  TwoEpochE_zeng_E,
  ThreeEpochB_zeng_E,
  ThreeEpochC_zeng_E,
  ThreeEpochE_zeng_E,
  snm_zeng_E)

zeng_E_df$sample_size = seq(from=10, to=800, by=10)

ggplot(data=zeng_E_df, aes(x=sample_size, y=TwoEpochC_zeng_E, color='Two Epoch Contraction')) + geom_line(linewidth=2) +
  geom_line(aes(x=sample_size, y=TwoEpochE_zeng_E, color='Two Epoch Expansion'), linewidth=2) +
  geom_line(aes(x=sample_size, y=ThreeEpochB_zeng_E, color='Three Epoch Bottleneck'), linewidth=2) +
  geom_line(aes(x=sample_size, y=ThreeEpochC_zeng_E, color='Three Epoch Contraction'), linewidth=2) +
  geom_line(aes(x=sample_size, y=ThreeEpochE_zeng_E, color='Three Epoch Expansion'), linewidth=2) +
  geom_line(aes(x=sample_size, y=snm_zeng_E, color='Standard Neutral Model'), linewidth=2) +
  scale_color_manual(name='Simulated Demographic Scenario',
                     breaks=c('Two Epoch Contraction',
                       'Two Epoch Expansion',
                       'Three Epoch Bottleneck',
                       'Three Epoch Contraction',
                       'Three Epoch Expansion',
                       'Standard Neutral Model'),
                     values=c('Two Epoch Contraction'='#a50026',
                       'Two Epoch Expansion'='#f46d43',
                       'Three Epoch Bottleneck'='#fee090',
                       'Three Epoch Contraction'='#74add1',
                       'Three Epoch Expansion'='#313695',
                       'Standard Neutral Model'='black')) +
  geom_hline(yintercept = 0, linetype='dashed') +
  theme_bw() +
  ylab("Zeng's E") +
  xlab('Sample Size') +
  ggtitle("Zeng's E over sample size for simulated demographic histories")

zeng_theta_L_df = data.frame(TwoEpochC_zeng_theta_L,
  TwoEpochE_zeng_theta_L,
  ThreeEpochB_zeng_theta_L,
  ThreeEpochC_zeng_theta_L,
  ThreeEpochE_zeng_theta_L,
  snm_zeng_theta_L)

zeng_theta_L_df$sample_size = seq(from=10, to=800, by=10)

ggplot(data=zeng_theta_L_df, aes(x=sample_size, y=TwoEpochC_zeng_theta_L, color='Two Epoch Contraction')) + geom_line(linewidth=2) +
  geom_line(aes(x=sample_size, y=TwoEpochE_zeng_theta_L, color='Two Epoch Expansion'), linewidth=2) +
  geom_line(aes(x=sample_size, y=ThreeEpochB_zeng_theta_L, color='Three Epoch Bottleneck'), linewidth=2) +
  geom_line(aes(x=sample_size, y=ThreeEpochC_zeng_theta_L, color='Three Epoch Contraction'), linewidth=2) +
  geom_line(aes(x=sample_size, y=ThreeEpochE_zeng_theta_L, color='Three Epoch Expansion'), linewidth=2) +
  geom_line(aes(x=sample_size, y=snm_zeng_theta_L, color='Standard Neutral Model'), linewidth=2) +
  scale_color_manual(name='Simulated Demographic Scenario',
                     breaks=c('Two Epoch Contraction',
                       'Two Epoch Expansion',
                       'Three Epoch Bottleneck',
                       'Three Epoch Contraction',
                       'Three Epoch Expansion',
                       'Standard Neutral Model'),
                     values=c('Two Epoch Contraction'='#a50026',
                       'Two Epoch Expansion'='#f46d43',
                       'Three Epoch Bottleneck'='#fee090',
                       'Three Epoch Contraction'='#74add1',
                       'Three Epoch Expansion'='#313695',
                       'Standard Neutral Model'='black')) +
  theme_bw() +
  ylab("Zeng's ThetaL") +
  xlab('Sample Size') +
  ggtitle("Zeng's ThetaL over sample size for simulated demographic histories")

proportion_singletons_df = data.frame(TwoEpochC_proportion_singletons,
  TwoEpochE_proportion_singletons,
  ThreeEpochB_proportion_singletons,
  ThreeEpochC_proportion_singletons,
  ThreeEpochE_proportion_singletons,
  snm_proportion_singletons)

proportion_singletons_df$sample_size = seq(from=10, to=800, by=10)

ggplot(data=proportion_singletons_df, aes(x=sample_size, y=TwoEpochC_proportion_singletons, color='Two Epoch Contraction')) + geom_line(linewidth=2) +
  geom_line(aes(x=sample_size, y=TwoEpochE_proportion_singletons, color='Two Epoch Expansion'), linewidth=2) +
  geom_line(aes(x=sample_size, y=ThreeEpochB_proportion_singletons, color='Three Epoch Bottleneck'), linewidth=2) +
  geom_line(aes(x=sample_size, y=ThreeEpochC_proportion_singletons, color='Three Epoch Contraction'), linewidth=2) +
  geom_line(aes(x=sample_size, y=ThreeEpochE_proportion_singletons, color='Three Epoch Expansion'), linewidth=2) +
  geom_line(aes(x=sample_size, y=snm_proportion_singletons, color='Standard Neutral Model'), linewidth=2) +
  scale_color_manual(name='Simulated Demographic Scenario',
                     breaks=c('Two Epoch Contraction',
                       'Two Epoch Expansion',
                       'Three Epoch Bottleneck',
                       'Three Epoch Contraction',
                       'Three Epoch Expansion',
                       'Standard Neutral Model'),
                     values=c('Two Epoch Contraction'='#a50026',
                       'Two Epoch Expansion'='#f46d43',
                       'Three Epoch Bottleneck'='#fee090',
                       'Three Epoch Contraction'='#74add1',
                       'Three Epoch Expansion'='#313695',
                       'Standard Neutral Model'='black')) +
  theme_bw() +
  ylab("Proportion of singletons") +
  xlab('Sample Size') +
  scale_x_log10() +
  ggtitle("Proportion of singletons over sample size for simulated demographic histories")

rare_variant_proportion_df = data.frame(TwoEpochC_rare_variant_proportion,
  TwoEpochE_rare_variant_proportion,
  ThreeEpochB_rare_variant_proportion,
  ThreeEpochC_rare_variant_proportion,
  ThreeEpochE_rare_variant_proportion,
  snm_rare_variant_proportion)

rare_variant_proportion_df$sample_size = seq(from=10, to=800, by=10)

ggplot(data=rare_variant_proportion_df, aes(x=sample_size, y=TwoEpochC_rare_variant_proportion, color='Two Epoch Contraction')) + geom_line(linewidth=2) +
  geom_line(aes(x=sample_size, y=TwoEpochE_rare_variant_proportion, color='Two Epoch Expansion'), linewidth=2) +
  geom_line(aes(x=sample_size, y=ThreeEpochB_rare_variant_proportion, color='Three Epoch Bottleneck'), linewidth=2) +
  geom_line(aes(x=sample_size, y=ThreeEpochC_rare_variant_proportion, color='Three Epoch Contraction'), linewidth=2) +
  geom_line(aes(x=sample_size, y=ThreeEpochE_rare_variant_proportion, color='Three Epoch Expansion'), linewidth=2) +
  geom_line(aes(x=sample_size, y=snm_rare_variant_proportion, color='Standard Neutral Model'), linewidth=2) +
  scale_color_manual(name='Simulated Demographic Scenario',
                     breaks=c('Two Epoch Contraction',
                       'Two Epoch Expansion',
                       'Three Epoch Bottleneck',
                       'Three Epoch Contraction',
                       'Three Epoch Expansion',
                       'Standard Neutral Model'),
                     values=c('Two Epoch Contraction'='#a50026',
                       'Two Epoch Expansion'='#f46d43',
                       'Three Epoch Bottleneck'='#fee090',
                       'Three Epoch Contraction'='#74add1',
                       'Three Epoch Expansion'='#313695',
                       'Standard Neutral Model'='black')) +
  theme_bw() +
  ylab("Proportion of singletons") +
  xlab('Sample Size') +
  scale_x_log10() +
  ggtitle("Proportion of SFS comprised of rare variants over sample size for simulated demographic histories")

## Compute statistics for lynch simulations

k5_bottleneck_singletons = c()
k5_bottleneck_singleton_proportion = c()

for (i in 1:1000) {
  file_iter = paste0("k5_bottleneck_", i)
  file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
  k5_bottleneck_singletons = c(k5_bottleneck_singletons, read_unfolded_input_sfs(file_path)[1])
  k5_bottleneck_singleton_proportion = c(k5_bottleneck_singleton_proportion, 
    read_unfolded_input_sfs(file_path)[1] / sum(read_unfolded_input_sfs(file_path)))
}

k5_contraction_singletons = c()
k5_contraction_singleton_proportion = c()

for (i in 1:1000) {
  file_iter = paste0("k5_contraction_", i)
  file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
  k5_contraction_singletons = c(k5_contraction_singletons, read_unfolded_input_sfs(file_path)[1])
  k5_contraction_singleton_proportion = c(k5_contraction_singleton_proportion, 
    read_unfolded_input_sfs(file_path)[1] / sum(read_unfolded_input_sfs(file_path)))  
}

k5_expansion_singletons = c()
k5_expansion_singleton_proportion = c()

for (i in 1:1000) {
  file_iter = paste0("k5_expansion_", i)
  file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
  k5_expansion_singletons = c(k5_expansion_singletons, read_unfolded_input_sfs(file_path)[1])
  k5_expansion_singleton_proportion = c(k5_expansion_singleton_proportion, 
    read_unfolded_input_sfs(file_path)[1] / sum(read_unfolded_input_sfs(file_path)))
}

k5_snm_singletons = c()
k5_snm_singleton_proportion = c()

for (i in 1:1000) {
  file_iter = paste0("k5_snm_", i)
  file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
  k5_snm_singletons = c(k5_snm_singletons, read_unfolded_input_sfs(file_path)[1])
  k5_snm_singleton_proportion = c(k5_snm_singleton_proportion, 
    read_unfolded_input_sfs(file_path)[1] / sum(read_unfolded_input_sfs(file_path)))
}

k5_singleton_df = melt(data.frame(k5_bottleneck_singletons,
  k5_contraction_singletons,
  k5_expansion_singletons,
  k5_snm_singletons))

k5_proportion_df = melt(data.frame(k5_bottleneck_singleton_proportion,
  k5_contraction_singleton_proportion,
  k5_expansion_singleton_proportion,
  k5_snm_singleton_proportion))


# ggplot(k5_singleton_df, aes(x=value, y=variable)) + geom_violin(aes(fill=variable)) + theme_bw() +
#   geom_boxplot(width=0.2) +
#   xlab('Number of singletons') +
#   ylab('Simulation') +
#   theme(legend.title=element_blank()) + 
#   guides(fill="none")
# 
# ggplot(k5_proportion_df, aes(x=value, y=variable)) + geom_violin(aes(fill=variable)) + theme_bw() +
#   geom_boxplot(width=0.2) +
#   xlab('Proportion of singletons') +
#   ylab('Simulation') +
#   theme(legend.title=element_blank()) + 
#   guides(fill="none")

# Doubletons

k5_bottleneck_doubletons = c()
k5_bottleneck_doubleton_proportion = c()

for (i in 1:1000) {
  file_iter = paste0("k5_bottleneck_", i)
  file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
  k5_bottleneck_doubletons = c(k5_bottleneck_doubletons, read_unfolded_input_sfs(file_path)[2])
  k5_bottleneck_doubleton_proportion = c(k5_bottleneck_doubleton_proportion, 
    read_unfolded_input_sfs(file_path)[2] / sum(read_unfolded_input_sfs(file_path)))
}

k5_contraction_doubletons = c()
k5_contraction_doubleton_proportion = c()

for (i in 1:1000) {
  file_iter = paste0("k5_contraction_", i)
  file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
  k5_contraction_doubletons = c(k5_contraction_doubletons, read_unfolded_input_sfs(file_path)[2])
  k5_contraction_doubleton_proportion = c(k5_contraction_doubleton_proportion, 
    read_unfolded_input_sfs(file_path)[2] / sum(read_unfolded_input_sfs(file_path)))  
}

k5_expansion_doubletons = c()
k5_expansion_doubleton_proportion = c()

for (i in 1:1000) {
  file_iter = paste0("k5_expansion_", i)
  file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
  k5_expansion_doubletons = c(k5_expansion_doubletons, read_unfolded_input_sfs(file_path)[2])
  k5_expansion_doubleton_proportion = c(k5_expansion_doubleton_proportion, 
    read_unfolded_input_sfs(file_path)[2] / sum(read_unfolded_input_sfs(file_path)))
}

k5_snm_doubletons = c()
k5_snm_doubleton_proportion = c()

for (i in 1:1000) {
  file_iter = paste0("k5_snm_", i)
  file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
  k5_snm_doubletons = c(k5_snm_doubletons, read_unfolded_input_sfs(file_path)[2])
  k5_snm_doubleton_proportion = c(k5_snm_doubleton_proportion, 
    read_unfolded_input_sfs(file_path)[2] / sum(read_unfolded_input_sfs(file_path)))
}

k5_doubleton_df = melt(data.frame(k5_bottleneck_doubletons,
  k5_contraction_doubletons,
  k5_expansion_doubletons,
  k5_snm_doubletons))

k10_bottleneck_singletons = c()
k10_bottleneck_singleton_proportion = c()

for (i in 1:1000) {
  file_iter = paste0("k10_bottleneck_", i)
  file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
  k10_bottleneck_singletons = c(k10_bottleneck_singletons, read_unfolded_input_sfs(file_path)[1])
  k10_bottleneck_singleton_proportion = c(k10_bottleneck_singleton_proportion, 
    read_unfolded_input_sfs(file_path)[1] / sum(read_unfolded_input_sfs(file_path)))
}

k10_contraction_singletons = c()
k10_contraction_singleton_proportion = c()

for (i in 1:1000) {
  file_iter = paste0("k10_contraction_", i)
  file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
  k10_contraction_singletons = c(k10_contraction_singletons, read_unfolded_input_sfs(file_path)[1])
  k10_contraction_singleton_proportion = c(k10_contraction_singleton_proportion, 
    read_unfolded_input_sfs(file_path)[1] / sum(read_unfolded_input_sfs(file_path)))  
}

k10_expansion_singletons = c()
k10_expansion_singleton_proportion = c()

for (i in 1:1000) {
  file_iter = paste0("k10_expansion_", i)
  file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
  k10_expansion_singletons = c(k10_expansion_singletons, read_unfolded_input_sfs(file_path)[1])
  k10_expansion_singleton_proportion = c(k10_expansion_singleton_proportion, 
    read_unfolded_input_sfs(file_path)[1] / sum(read_unfolded_input_sfs(file_path)))
}

k10_snm_singletons = c()
k10_snm_singleton_proportion = c()

for (i in 1:1000) {
  file_iter = paste0("k10_snm_", i)
  file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
  k10_snm_singletons = c(k10_snm_singletons, read_unfolded_input_sfs(file_path)[1])
  k10_snm_singleton_proportion = c(k10_snm_singleton_proportion, 
    read_unfolded_input_sfs(file_path)[1] / sum(read_unfolded_input_sfs(file_path)))
}

k10_singleton_df = melt(data.frame(k10_bottleneck_singletons,
  k10_contraction_singletons,
  k10_expansion_singletons,
  k10_snm_singletons))

k10_proportion_df = melt(data.frame(k10_bottleneck_singleton_proportion,
  k10_contraction_singleton_proportion,
  k10_expansion_singleton_proportion,
  k10_snm_singleton_proportion))


# ggplot(k10_singleton_df, aes(x=value, y=variable)) + geom_violin(aes(fill=variable)) + theme_bw() +
#   geom_boxplot(width=0.2) +
#   xlab('Number of singletons') +
#   ylab('Simulation') +
#   theme(legend.title=element_blank()) + 
#   guides(fill="none")
# 
# ggplot(k10_proportion_df, aes(x=value, y=variable)) + geom_violin(aes(fill=variable)) + theme_bw() +
#   geom_boxplot(width=0.2) +
#   xlab('Proportion of singletons') +
#   ylab('Simulation') +
#   theme(legend.title=element_blank()) + 
#   guides(fill="none")

# Doubletons

k10_bottleneck_doubletons = c()
k10_bottleneck_doubleton_proportion = c()

for (i in 1:1000) {
  file_iter = paste0("k10_bottleneck_", i)
  file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
  k10_bottleneck_doubletons = c(k10_bottleneck_doubletons, read_unfolded_input_sfs(file_path)[2])
  k10_bottleneck_doubleton_proportion = c(k10_bottleneck_doubleton_proportion, 
    read_unfolded_input_sfs(file_path)[2] / sum(read_unfolded_input_sfs(file_path)))
}

k10_contraction_doubletons = c()
k10_contraction_doubleton_proportion = c()

for (i in 1:1000) {
  file_iter = paste0("k10_contraction_", i)
  file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
  k10_contraction_doubletons = c(k10_contraction_doubletons, read_unfolded_input_sfs(file_path)[2])
  k10_contraction_doubleton_proportion = c(k10_contraction_doubleton_proportion, 
    read_unfolded_input_sfs(file_path)[2] / sum(read_unfolded_input_sfs(file_path)))  
}

k10_expansion_doubletons = c()
k10_expansion_doubleton_proportion = c()

for (i in 1:1000) {
  file_iter = paste0("k10_expansion_", i)
  file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
  k10_expansion_doubletons = c(k10_expansion_doubletons, read_unfolded_input_sfs(file_path)[2])
  k10_expansion_doubleton_proportion = c(k10_expansion_doubleton_proportion, 
    read_unfolded_input_sfs(file_path)[2] / sum(read_unfolded_input_sfs(file_path)))
}

k10_snm_doubletons = c()
k10_snm_doubleton_proportion = c()

for (i in 1:1000) {
  file_iter = paste0("k10_snm_", i)
  file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
  k10_snm_doubletons = c(k10_snm_doubletons, read_unfolded_input_sfs(file_path)[2])
  k10_snm_doubleton_proportion = c(k10_snm_doubleton_proportion, 
    read_unfolded_input_sfs(file_path)[2] / sum(read_unfolded_input_sfs(file_path)))
}

k10_doubleton_df = melt(data.frame(k10_bottleneck_doubletons,
  k10_contraction_doubletons,
  k10_expansion_doubletons,
  k10_snm_doubletons))

k15_bottleneck_singletons = c()
k15_bottleneck_singleton_proportion = c()

for (i in 1:1000) {
  file_iter = paste0("k15_bottleneck_", i)
  file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
  k15_bottleneck_singletons = c(k15_bottleneck_singletons, read_unfolded_input_sfs(file_path)[1])
  k15_bottleneck_singleton_proportion = c(k15_bottleneck_singleton_proportion, 
    read_unfolded_input_sfs(file_path)[1] / sum(read_unfolded_input_sfs(file_path)))
}

k15_contraction_singletons = c()
k15_contraction_singleton_proportion = c()

for (i in 1:1000) {
  file_iter = paste0("k15_contraction_", i)
  file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
  k15_contraction_singletons = c(k15_contraction_singletons, read_unfolded_input_sfs(file_path)[1])
  k15_contraction_singleton_proportion = c(k15_contraction_singleton_proportion, 
    read_unfolded_input_sfs(file_path)[1] / sum(read_unfolded_input_sfs(file_path)))  
}

k15_expansion_singletons = c()
k15_expansion_singleton_proportion = c()

for (i in 1:1000) {
  file_iter = paste0("k15_expansion_", i)
  file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
  k15_expansion_singletons = c(k15_expansion_singletons, read_unfolded_input_sfs(file_path)[1])
  k15_expansion_singleton_proportion = c(k15_expansion_singleton_proportion, 
    read_unfolded_input_sfs(file_path)[1] / sum(read_unfolded_input_sfs(file_path)))
}

k15_snm_singletons = c()
k15_snm_singleton_proportion = c()

for (i in 1:1000) {
  file_iter = paste0("k15_snm_", i)
  file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
  k15_snm_singletons = c(k15_snm_singletons, read_unfolded_input_sfs(file_path)[1])
  k15_snm_singleton_proportion = c(k15_snm_singleton_proportion, 
    read_unfolded_input_sfs(file_path)[1] / sum(read_unfolded_input_sfs(file_path)))
}

k15_singleton_df = melt(data.frame(k15_bottleneck_singletons,
  k15_contraction_singletons,
  k15_expansion_singletons,
  k15_snm_singletons))

k15_proportion_df = melt(data.frame(k15_bottleneck_singleton_proportion,
  k15_contraction_singleton_proportion,
  k15_expansion_singleton_proportion,
  k15_snm_singleton_proportion))


# ggplot(k15_singleton_df, aes(x=value, y=variable)) + geom_violin(aes(fill=variable)) + theme_bw() +
#   geom_boxplot(width=0.2) +
#   xlab('Number of singletons') +
#   ylab('Simulation') +
#   theme(legend.title=element_blank()) + 
#   guides(fill="none")
# 
# ggplot(k15_proportion_df, aes(x=value, y=variable)) + geom_violin(aes(fill=variable)) + theme_bw() +
#   geom_boxplot(width=0.2) +
#   xlab('Proportion of singletons') +
#   ylab('Simulation') +
#   theme(legend.title=element_blank()) + 
#   guides(fill="none")

# Doubletons

k15_bottleneck_doubletons = c()
k15_bottleneck_doubleton_proportion = c()

for (i in 1:1000) {
  file_iter = paste0("k15_bottleneck_", i)
  file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
  k15_bottleneck_doubletons = c(k15_bottleneck_doubletons, read_unfolded_input_sfs(file_path)[2])
  k15_bottleneck_doubleton_proportion = c(k15_bottleneck_doubleton_proportion, 
    read_unfolded_input_sfs(file_path)[2] / sum(read_unfolded_input_sfs(file_path)))
}

k15_contraction_doubletons = c()
k15_contraction_doubleton_proportion = c()

for (i in 1:1000) {
  file_iter = paste0("k15_contraction_", i)
  file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
  k15_contraction_doubletons = c(k15_contraction_doubletons, read_unfolded_input_sfs(file_path)[2])
  k15_contraction_doubleton_proportion = c(k15_contraction_doubleton_proportion, 
    read_unfolded_input_sfs(file_path)[2] / sum(read_unfolded_input_sfs(file_path)))  
}

k15_expansion_doubletons = c()
k15_expansion_doubleton_proportion = c()

for (i in 1:1000) {
  file_iter = paste0("k15_expansion_", i)
  file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
  k15_expansion_doubletons = c(k15_expansion_doubletons, read_unfolded_input_sfs(file_path)[2])
  k15_expansion_doubleton_proportion = c(k15_expansion_doubleton_proportion, 
    read_unfolded_input_sfs(file_path)[2] / sum(read_unfolded_input_sfs(file_path)))
}

k15_snm_doubletons = c()
k15_snm_doubleton_proportion = c()

for (i in 1:1000) {
  file_iter = paste0("k15_snm_", i)
  file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
  k15_snm_doubletons = c(k15_snm_doubletons, read_unfolded_input_sfs(file_path)[2])
  k15_snm_doubleton_proportion = c(k15_snm_doubleton_proportion, 
    read_unfolded_input_sfs(file_path)[2] / sum(read_unfolded_input_sfs(file_path)))
}

k15_doubleton_df = melt(data.frame(k15_bottleneck_doubletons,
  k15_contraction_doubletons,
  k15_expansion_doubletons,
  k15_snm_doubletons))

k20_bottleneck_singletons = c()
k20_bottleneck_singleton_proportion = c()

for (i in 1:1000) {
  file_iter = paste0("k20_bottleneck_", i)
  file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
  k20_bottleneck_singletons = c(k20_bottleneck_singletons, read_unfolded_input_sfs(file_path)[1])
  k20_bottleneck_singleton_proportion = c(k20_bottleneck_singleton_proportion, 
    read_unfolded_input_sfs(file_path)[1] / sum(read_unfolded_input_sfs(file_path)))
}

k20_contraction_singletons = c()
k20_contraction_singleton_proportion = c()

for (i in 1:1000) {
  file_iter = paste0("k20_contraction_", i)
  file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
  k20_contraction_singletons = c(k20_contraction_singletons, read_unfolded_input_sfs(file_path)[1])
  k20_contraction_singleton_proportion = c(k20_contraction_singleton_proportion, 
    read_unfolded_input_sfs(file_path)[1] / sum(read_unfolded_input_sfs(file_path)))  
}

k20_expansion_singletons = c()
k20_expansion_singleton_proportion = c()

for (i in 1:1000) {
  file_iter = paste0("k20_expansion_", i)
  file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
  k20_expansion_singletons = c(k20_expansion_singletons, read_unfolded_input_sfs(file_path)[1])
  k20_expansion_singleton_proportion = c(k20_expansion_singleton_proportion, 
    read_unfolded_input_sfs(file_path)[1] / sum(read_unfolded_input_sfs(file_path)))
}

k20_snm_singletons = c()
k20_snm_singleton_proportion = c()

for (i in 1:1000) {
  file_iter = paste0("k20_snm_", i)
  file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
  k20_snm_singletons = c(k20_snm_singletons, read_unfolded_input_sfs(file_path)[1])
  k20_snm_singleton_proportion = c(k20_snm_singleton_proportion, 
    read_unfolded_input_sfs(file_path)[1] / sum(read_unfolded_input_sfs(file_path)))
}

k20_singleton_df = melt(data.frame(k20_bottleneck_singletons,
  k20_contraction_singletons,
  k20_expansion_singletons,
  k20_snm_singletons))

k20_proportion_df = melt(data.frame(k20_bottleneck_singleton_proportion,
  k20_contraction_singleton_proportion,
  k20_expansion_singleton_proportion,
  k20_snm_singleton_proportion))


# ggplot(k20_singleton_df, aes(x=value, y=variable)) + geom_violin(aes(fill=variable)) + theme_bw() +
#   geom_boxplot(width=0.2) +
#   xlab('Number of singletons') +
#   ylab('Simulation') +
#   theme(legend.title=element_blank()) + 
#   guides(fill="none")
# 
# ggplot(k20_proportion_df, aes(x=value, y=variable)) + geom_violin(aes(fill=variable)) + theme_bw() +
#   geom_boxplot(width=0.2) +
#   xlab('Proportion of singletons') +
#   ylab('Simulation') +
#   theme(legend.title=element_blank()) + 
#   guides(fill="none")

# Doubletons

k20_bottleneck_doubletons = c()
k20_bottleneck_doubleton_proportion = c()

for (i in 1:1000) {
  file_iter = paste0("k20_bottleneck_", i)
  file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
  k20_bottleneck_doubletons = c(k20_bottleneck_doubletons, read_unfolded_input_sfs(file_path)[2])
  k20_bottleneck_doubleton_proportion = c(k20_bottleneck_doubleton_proportion, 
    read_unfolded_input_sfs(file_path)[2] / sum(read_unfolded_input_sfs(file_path)))
}

k20_contraction_doubletons = c()
k20_contraction_doubleton_proportion = c()

for (i in 1:1000) {
  file_iter = paste0("k20_contraction_", i)
  file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
  k20_contraction_doubletons = c(k20_contraction_doubletons, read_unfolded_input_sfs(file_path)[2])
  k20_contraction_doubleton_proportion = c(k20_contraction_doubleton_proportion, 
    read_unfolded_input_sfs(file_path)[2] / sum(read_unfolded_input_sfs(file_path)))  
}

k20_expansion_doubletons = c()
k20_expansion_doubleton_proportion = c()

for (i in 1:1000) {
  file_iter = paste0("k20_expansion_", i)
  file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
  k20_expansion_doubletons = c(k20_expansion_doubletons, read_unfolded_input_sfs(file_path)[2])
  k20_expansion_doubleton_proportion = c(k20_expansion_doubleton_proportion, 
    read_unfolded_input_sfs(file_path)[2] / sum(read_unfolded_input_sfs(file_path)))
}

k20_snm_doubletons = c()
k20_snm_doubleton_proportion = c()

for (i in 1:1000) {
  file_iter = paste0("k20_snm_", i)
  file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
  k20_snm_doubletons = c(k20_snm_doubletons, read_unfolded_input_sfs(file_path)[2])
  k20_snm_doubleton_proportion = c(k20_snm_doubleton_proportion, 
    read_unfolded_input_sfs(file_path)[2] / sum(read_unfolded_input_sfs(file_path)))
}

k20_doubleton_df = melt(data.frame(k20_bottleneck_doubletons,
  k20_contraction_doubletons,
  k20_expansion_doubletons,
  k20_snm_doubletons))

k5_singleton_df$sample_size = 'k=5'
k10_singleton_df$sample_size = 'k=10'
k15_singleton_df$sample_size = 'k=15'
k20_singleton_df$sample_size = 'k=20'

all_msprime_df = rbind(k5_singleton_df,
  k10_singleton_df,
  k15_singleton_df,
  k20_singleton_df)

all_msprime_df <- all_msprime_df %>%
  mutate(variable = str_replace(variable, "_bottleneck_singletons$", " bottleneck"))
  
all_msprime_df <- all_msprime_df %>%
  mutate(variable = str_replace(variable, "_contraction_singletons$", " contraction"))
  
all_msprime_df <- all_msprime_df %>%
  mutate(variable = str_replace(variable, "_expansion_singletons$", " expansion"))
  
all_msprime_df <- all_msprime_df %>%
  mutate(variable = str_replace(variable, "_snm_singletons$", " snm"))

desired_order <- c("k5 bottleneck", "k10 bottleneck", "k15 bottleneck", "k20 bottleneck",
  "k5 contraction", "k10 contraction", "k15 contraction", "k20 contraction", 
  "k5 expansion", "k10 expansion", "k15 expansion", "k20 expansion", 
  "k5 snm", "k10 snm", "k15 snm", "k20 snm")

all_msprime_df <- all_msprime_df %>%
  mutate(variable = factor(variable, levels = desired_order))

all_msprime_df$variable = fct_rev(all_msprime_df$variable)

ggplot(all_msprime_df, aes(x=value, y=variable, fill=sample_size)) + geom_violin(aes(fill=sample_size)) + theme_bw() +
  geom_boxplot(width=0.1, fill='white') +
  xlab('Number of singletons') +
  ylab('Simulation') +
  theme(legend.title=element_blank()) +
  ggtitle('Number of singletons by simulation and sample size')

k5_proportion_df$sample_size = 'k=5'
k10_proportion_df$sample_size = 'k=10'
k15_proportion_df$sample_size = 'k=15'
k20_proportion_df$sample_size = 'k=20'

all_msprime_proportion_df = rbind(k5_proportion_df,
  k10_proportion_df,
  k15_proportion_df,
  k20_proportion_df)

all_msprime_proportion_df <- all_msprime_proportion_df %>%
  mutate(variable = str_replace(variable, "_bottleneck_singleton_proportion$", " bottleneck"))
  
all_msprime_proportion_df <- all_msprime_proportion_df %>%
  mutate(variable = str_replace(variable, "_contraction_singleton_proportion$", " contraction"))
  
all_msprime_proportion_df <- all_msprime_proportion_df %>%
  mutate(variable = str_replace(variable, "_expansion_singleton_proportion$", " expansion"))
  
all_msprime_proportion_df <- all_msprime_proportion_df %>%
  mutate(variable = str_replace(variable, "_snm_singleton_proportion$", " snm"))

all_msprime_proportion_df <- all_msprime_proportion_df %>%
  mutate(variable = factor(variable, levels = desired_order))

all_msprime_proportion_df$variable = fct_rev(all_msprime_proportion_df$variable)

ggplot(all_msprime_proportion_df, aes(x=value, y=variable, fill=sample_size)) + geom_violin(aes(fill=sample_size)) + theme_bw() +
  geom_boxplot(width=0.1, fill='white') +
  xlab('Proportion of singletons') +
  ylab('Simulation') +
  theme(legend.title=element_blank()) +
  ggtitle('Proportion of singletons by simulation and sample size')

ggplot(k5_doubleton_df, aes(x=value, y=variable)) + geom_violin(aes(fill=variable)) + theme_bw() +
  geom_boxplot(width=0.1) +
  xlab('Number of doubletons') +
  ylab('Simulation') +
  theme(legend.title=element_blank()) +
  guides(fill="none")

## Compute_optimal_sample size vs. msprime

one_epoch_10_SFS = sfs_from_demography('../Analysis/TwoEpochContraction_10/one_epoch_demography.txt')
one_epoch_20_SFS = sfs_from_demography('../Analysis/TwoEpochContraction_20/one_epoch_demography.txt')
one_epoch_30_SFS = sfs_from_demography('../Analysis/TwoEpochContraction_30/one_epoch_demography.txt')

TwoEpochC_10_msprime_SFS = read_input_sfs('../Analysis/TwoEpochContraction_10/syn_downsampled_sfs.txt')
TwoEpochE_10_msprime_SFS = read_input_sfs('../Analysis/TwoEpochExpansion_10/syn_downsampled_sfs.txt')
ThreeEpochC_10_msprime_SFS = read_input_sfs('../Analysis/ThreeEpochContraction_10/syn_downsampled_sfs.txt')
ThreeEpochE_10_msprime_SFS = read_input_sfs('../Analysis/ThreeEpochExpansion_10/syn_downsampled_sfs.txt')
ThreeEpochB_10_msprime_SFS = read_input_sfs('../Analysis/ThreeEpochBottleneck_10/syn_downsampled_sfs.txt')

TwoEpochC_20_msprime_SFS = read_input_sfs('../Analysis/TwoEpochContraction_20/syn_downsampled_sfs.txt')
TwoEpochE_20_msprime_SFS = read_input_sfs('../Analysis/TwoEpochExpansion_20/syn_downsampled_sfs.txt')
ThreeEpochC_20_msprime_SFS = read_input_sfs('../Analysis/ThreeEpochContraction_20/syn_downsampled_sfs.txt')
ThreeEpochE_20_msprime_SFS = read_input_sfs('../Analysis/ThreeEpochExpansion_20/syn_downsampled_sfs.txt')
ThreeEpochB_20_msprime_SFS = read_input_sfs('../Analysis/ThreeEpochBottleneck_20/syn_downsampled_sfs.txt')

TwoEpochC_30_msprime_SFS = read_input_sfs('../Analysis/TwoEpochContraction_30/syn_downsampled_sfs.txt')
TwoEpochE_30_msprime_SFS = read_input_sfs('../Analysis/TwoEpochExpansion_30/syn_downsampled_sfs.txt')
ThreeEpochC_30_msprime_SFS = read_input_sfs('../Analysis/ThreeEpochContraction_30/syn_downsampled_sfs.txt')
ThreeEpochE_30_msprime_SFS = read_input_sfs('../Analysis/ThreeEpochExpansion_30/syn_downsampled_sfs.txt')
ThreeEpochB_30_msprime_SFS = read_input_sfs('../Analysis/ThreeEpochBottleneck_30/syn_downsampled_sfs.txt')

TwoEpochC_10_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/2EpC_11_expected_sfs.txt')
TwoEpochE_10_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/2EpE_11_expected_sfs.txt')
ThreeEpochC_10_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpC_11_expected_sfs.txt')
ThreeEpochE_10_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpE_11_expected_sfs.txt')
ThreeEpochB_10_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpB_11_expected_sfs.txt')

TwoEpochC_20_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/2EpC_21_expected_sfs.txt')
TwoEpochE_20_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/2EpE_21_expected_sfs.txt')
ThreeEpochC_20_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpC_21_expected_sfs.txt')
ThreeEpochE_20_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpE_21_expected_sfs.txt')
ThreeEpochB_20_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpB_21_expected_sfs.txt')

TwoEpochC_30_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/2EpC_31_expected_sfs.txt')
TwoEpochE_30_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/2EpE_31_expected_sfs.txt')
ThreeEpochC_30_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpC_31_expected_sfs.txt')
ThreeEpochE_30_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpE_31_expected_sfs.txt')
ThreeEpochB_30_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpB_31_expected_sfs.txt')

compare_msprime_lynch_proportional_sfs(one_epoch_10_SFS, TwoEpochC_10_msprime_SFS, TwoEpochC_10_lynch_SFS) + 
  ggtitle('Two Epoch Contraction, k=10') +
  compare_msprime_lynch_proportional_sfs(one_epoch_10_SFS, TwoEpochE_10_msprime_SFS, TwoEpochE_10_lynch_SFS) + 
  ggtitle('Two Epoch Expansion, k=10') +
  compare_msprime_lynch_proportional_sfs(one_epoch_10_SFS, ThreeEpochC_10_msprime_SFS, ThreeEpochC_10_lynch_SFS) + 
  ggtitle('Three Epoch Contraction, k=10') +
  compare_msprime_lynch_proportional_sfs(one_epoch_10_SFS, ThreeEpochE_10_msprime_SFS, ThreeEpochE_10_lynch_SFS) + 
  ggtitle('Three Epoch Expansion, k=10') +
  compare_msprime_lynch_proportional_sfs(one_epoch_10_SFS, ThreeEpochB_10_msprime_SFS, ThreeEpochB_10_lynch_SFS) + 
  ggtitle('Three Epoch Bottleneck, k=10') +
  plot_layout(nrow=2)

compare_msprime_lynch_proportional_sfs(one_epoch_20_SFS, TwoEpochC_20_msprime_SFS, TwoEpochC_20_lynch_SFS) + 
  ggtitle('Two Epoch Contraction, k=20') +
  compare_msprime_lynch_proportional_sfs(one_epoch_20_SFS, TwoEpochE_20_msprime_SFS, TwoEpochE_20_lynch_SFS) + 
  ggtitle('Two Epoch Expansion, k=20') +
  compare_msprime_lynch_proportional_sfs(one_epoch_20_SFS, ThreeEpochC_20_msprime_SFS, ThreeEpochC_20_lynch_SFS) + 
  ggtitle('Three Epoch Contraction, k=20') +
  compare_msprime_lynch_proportional_sfs(one_epoch_20_SFS, ThreeEpochE_20_msprime_SFS, ThreeEpochE_20_lynch_SFS) + 
  ggtitle('Three Epoch Expansion, k=20') +
  compare_msprime_lynch_proportional_sfs(one_epoch_20_SFS, ThreeEpochB_20_msprime_SFS, ThreeEpochB_20_lynch_SFS) + 
  ggtitle('Three Epoch Bottleneck, k=20') +
  plot_layout(nrow=2)

compare_msprime_lynch_proportional_sfs(one_epoch_30_SFS, TwoEpochC_30_msprime_SFS, TwoEpochC_30_lynch_SFS) + 
  ggtitle('Two Epoch Contraction, k=30') +
  compare_msprime_lynch_proportional_sfs(one_epoch_30_SFS, TwoEpochE_30_msprime_SFS, TwoEpochE_30_lynch_SFS) + 
  ggtitle('Two Epoch Expansion, k=30') +
  compare_msprime_lynch_proportional_sfs(one_epoch_30_SFS, ThreeEpochC_30_msprime_SFS, ThreeEpochC_30_lynch_SFS) + 
  ggtitle('Three Epoch Contraction, k=30') +
  compare_msprime_lynch_proportional_sfs(one_epoch_30_SFS, ThreeEpochE_30_msprime_SFS, ThreeEpochE_30_lynch_SFS) + 
  ggtitle('Three Epoch Expansion, k=30') +
  compare_msprime_lynch_proportional_sfs(one_epoch_30_SFS, ThreeEpochB_30_msprime_SFS, ThreeEpochB_30_lynch_SFS) + 
  ggtitle('Three Epoch Bottleneck, k=30') +
  plot_layout(nrow=3)

compare_msprime_lynch_proportional_sfs(one_epoch_20_SFS, TwoEpochC_20_msprime_SFS, TwoEpochC_20_lynch_SFS) + 
  ggtitle('Two Epoch Contraction, k=20')
compare_msprime_lynch_proportional_sfs(one_epoch_20_SFS, TwoEpochE_20_msprime_SFS, TwoEpochE_20_lynch_SFS) + 
  ggtitle('Two Epoch Expansion, k=20')
compare_msprime_lynch_proportional_sfs(one_epoch_20_SFS, ThreeEpochC_20_msprime_SFS, ThreeEpochC_20_lynch_SFS) + 
  ggtitle('Three Epoch Contraction, k=20')
compare_msprime_lynch_proportional_sfs(one_epoch_20_SFS, ThreeEpochE_20_msprime_SFS, ThreeEpochE_20_lynch_SFS) + 
  ggtitle('Three Epoch Expansion, k=20')
compare_msprime_lynch_proportional_sfs(one_epoch_20_SFS, ThreeEpochB_20_msprime_SFS, ThreeEpochB_20_lynch_SFS) + 
  ggtitle('Three Epoch Bottleneck, k=20')

compare_msprime_lynch_proportional_sfs(one_epoch_30_SFS, TwoEpochC_30_msprime_SFS, TwoEpochC_30_lynch_SFS) + 
  ggtitle('Two Epoch Contraction, k=30')
compare_msprime_lynch_proportional_sfs(one_epoch_30_SFS, TwoEpochE_30_msprime_SFS, TwoEpochE_30_lynch_SFS) + 
  ggtitle('Two Epoch Expansion, k=30')
compare_msprime_lynch_proportional_sfs(one_epoch_30_SFS, ThreeEpochC_30_msprime_SFS, ThreeEpochC_30_lynch_SFS) + 
  ggtitle('Three Epoch Contraction, k=30')
compare_msprime_lynch_proportional_sfs(one_epoch_30_SFS, ThreeEpochE_30_msprime_SFS, ThreeEpochE_30_lynch_SFS) + 
  ggtitle('Three Epoch Expansion, k=30')
compare_msprime_lynch_proportional_sfs(one_epoch_30_SFS, ThreeEpochB_30_msprime_SFS, ThreeEpochB_30_lynch_SFS) + 
  ggtitle('Three Epoch Bottleneck, k=30')
