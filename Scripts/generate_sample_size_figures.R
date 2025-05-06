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

T500_bottleneck_1 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/bottleneck_1/dadi/pop1.sfs')
T500_bottleneck_2 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/bottleneck_2/dadi/pop1.sfs')
T500_bottleneck_3 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/bottleneck_3/dadi/pop1.sfs')
T500_bottleneck_4 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/bottleneck_4/dadi/pop1.sfs')
T500_bottleneck_5 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/bottleneck_5/dadi/pop1.sfs')
T500_bottleneck_6 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/bottleneck_6/dadi/pop1.sfs')
T500_bottleneck_7 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/bottleneck_7/dadi/pop1.sfs')
T500_bottleneck_8 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/bottleneck_8/dadi/pop1.sfs')
T500_bottleneck_9 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/bottleneck_9/dadi/pop1.sfs')
T500_bottleneck_10 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/bottleneck_10/dadi/pop1.sfs')
T500_bottleneck_11 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/bottleneck_11/dadi/pop1.sfs')
T500_bottleneck_12 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/bottleneck_12/dadi/pop1.sfs')
T500_bottleneck_13 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/bottleneck_13/dadi/pop1.sfs')
T500_bottleneck_14 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/bottleneck_14/dadi/pop1.sfs')
T500_bottleneck_15 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/bottleneck_15/dadi/pop1.sfs')
T500_bottleneck_16 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/bottleneck_16/dadi/pop1.sfs')
T500_bottleneck_17 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/bottleneck_17/dadi/pop1.sfs')
T500_bottleneck_18 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/bottleneck_18/dadi/pop1.sfs')
T500_bottleneck_19 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/bottleneck_19/dadi/pop1.sfs')
T500_bottleneck_20 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/bottleneck_20/dadi/pop1.sfs')

T500_contraction_1 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/contraction_1/dadi/pop1.sfs')
T500_contraction_2 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/contraction_2/dadi/pop1.sfs')
T500_contraction_3 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/contraction_3/dadi/pop1.sfs')
T500_contraction_4 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/contraction_4/dadi/pop1.sfs')
T500_contraction_5 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/contraction_5/dadi/pop1.sfs')
T500_contraction_6 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/contraction_6/dadi/pop1.sfs')
T500_contraction_7 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/contraction_7/dadi/pop1.sfs')
T500_contraction_8 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/contraction_8/dadi/pop1.sfs')
T500_contraction_9 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/contraction_9/dadi/pop1.sfs')
T500_contraction_10 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/contraction_10/dadi/pop1.sfs')
T500_contraction_11 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/contraction_11/dadi/pop1.sfs')
T500_contraction_12 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/contraction_12/dadi/pop1.sfs')
T500_contraction_13 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/contraction_13/dadi/pop1.sfs')
T500_contraction_14 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/contraction_14/dadi/pop1.sfs')
T500_contraction_15 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/contraction_15/dadi/pop1.sfs')
T500_contraction_16 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/contraction_16/dadi/pop1.sfs')
T500_contraction_17 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/contraction_17/dadi/pop1.sfs')
T500_contraction_18 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/contraction_18/dadi/pop1.sfs')
T500_contraction_19 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/contraction_19/dadi/pop1.sfs')
T500_contraction_20 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/contraction_20/dadi/pop1.sfs')

T500_expansion_1 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/expansion_1/dadi/pop1.sfs')
T500_expansion_2 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/expansion_2/dadi/pop1.sfs')
T500_expansion_3 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/expansion_3/dadi/pop1.sfs')
T500_expansion_4 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/expansion_4/dadi/pop1.sfs')
T500_expansion_5 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/expansion_5/dadi/pop1.sfs')
T500_expansion_6 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/expansion_6/dadi/pop1.sfs')
T500_expansion_7 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/expansion_7/dadi/pop1.sfs')
T500_expansion_8 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/expansion_8/dadi/pop1.sfs')
T500_expansion_9 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/expansion_9/dadi/pop1.sfs')
T500_expansion_10 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/expansion_10/dadi/pop1.sfs')
T500_expansion_11 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/expansion_11/dadi/pop1.sfs')
T500_expansion_12 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/expansion_12/dadi/pop1.sfs')
T500_expansion_13 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/expansion_13/dadi/pop1.sfs')
T500_expansion_14 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/expansion_14/dadi/pop1.sfs')
T500_expansion_15 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/expansion_15/dadi/pop1.sfs')
T500_expansion_16 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/expansion_16/dadi/pop1.sfs')
T500_expansion_17 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/expansion_17/dadi/pop1.sfs')
T500_expansion_18 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/expansion_18/dadi/pop1.sfs')
T500_expansion_19 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/expansion_19/dadi/pop1.sfs')
T500_expansion_20 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T500/expansion_20/dadi/pop1.sfs')

T500_bottleneck_singletons = c(T500_bottleneck_1[1],
  T500_bottleneck_2[1],
  T500_bottleneck_3[1],
  T500_bottleneck_4[1],
  T500_bottleneck_5[1],
  T500_bottleneck_6[1],
  T500_bottleneck_7[1],
  T500_bottleneck_8[1],
  T500_bottleneck_9[1],
  T500_bottleneck_10[1],
  T500_bottleneck_11[1],
  T500_bottleneck_12[1],
  T500_bottleneck_13[1],
  T500_bottleneck_14[1],
  T500_bottleneck_15[1],
  T500_bottleneck_16[1],
  T500_bottleneck_17[1],
  T500_bottleneck_18[1],
  T500_bottleneck_19[1],
  T500_bottleneck_20[1])

T500_contraction_singletons = c(T500_contraction_1[1],
  T500_contraction_2[1],
  T500_contraction_3[1],
  T500_contraction_4[1],
  T500_contraction_5[1],
  T500_contraction_6[1],
  T500_contraction_7[1],
  T500_contraction_8[1],
  T500_contraction_9[1],
  T500_contraction_10[1],
  T500_contraction_11[1],
  T500_contraction_12[1],
  T500_contraction_13[1],
  T500_contraction_14[1],
  T500_contraction_15[1],
  T500_contraction_16[1],
  T500_contraction_17[1],
  T500_contraction_18[1],
  T500_contraction_19[1],
  T500_contraction_20[1])

T500_expansion_singletons = c(T500_expansion_1[1],
  T500_expansion_2[1],
  T500_expansion_3[1],
  T500_expansion_4[1],
  T500_expansion_5[1],
  T500_expansion_6[1],
  T500_expansion_7[1],
  T500_expansion_8[1],
  T500_expansion_9[1],
  T500_expansion_10[1],
  T500_expansion_11[1],
  T500_expansion_12[1],
  T500_expansion_13[1],
  T500_expansion_14[1],
  T500_expansion_15[1],
  T500_expansion_16[1],
  T500_expansion_17[1],
  T500_expansion_18[1],
  T500_expansion_19[1],
  T500_expansion_20[1])

T50_bottleneck_1 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/bottleneck_1/dadi/pop1.sfs')
T50_bottleneck_2 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/bottleneck_2/dadi/pop1.sfs')
T50_bottleneck_3 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/bottleneck_3/dadi/pop1.sfs')
T50_bottleneck_4 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/bottleneck_4/dadi/pop1.sfs')
T50_bottleneck_5 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/bottleneck_5/dadi/pop1.sfs')
T50_bottleneck_6 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/bottleneck_6/dadi/pop1.sfs')
T50_bottleneck_7 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/bottleneck_7/dadi/pop1.sfs')
T50_bottleneck_8 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/bottleneck_8/dadi/pop1.sfs')
T50_bottleneck_9 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/bottleneck_9/dadi/pop1.sfs')
T50_bottleneck_10 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/bottleneck_10/dadi/pop1.sfs')
T50_bottleneck_11 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/bottleneck_11/dadi/pop1.sfs')
T50_bottleneck_12 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/bottleneck_12/dadi/pop1.sfs')
T50_bottleneck_13 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/bottleneck_13/dadi/pop1.sfs')
T50_bottleneck_14 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/bottleneck_14/dadi/pop1.sfs')
T50_bottleneck_15 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/bottleneck_15/dadi/pop1.sfs')
T50_bottleneck_16 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/bottleneck_16/dadi/pop1.sfs')
T50_bottleneck_17 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/bottleneck_17/dadi/pop1.sfs')
T50_bottleneck_18 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/bottleneck_18/dadi/pop1.sfs')
T50_bottleneck_19 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/bottleneck_19/dadi/pop1.sfs')
T50_bottleneck_20 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/bottleneck_20/dadi/pop1.sfs')

T50_contraction_1 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/contraction_1/dadi/pop1.sfs')
T50_contraction_2 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/contraction_2/dadi/pop1.sfs')
T50_contraction_3 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/contraction_3/dadi/pop1.sfs')
T50_contraction_4 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/contraction_4/dadi/pop1.sfs')
T50_contraction_5 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/contraction_5/dadi/pop1.sfs')
T50_contraction_6 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/contraction_6/dadi/pop1.sfs')
T50_contraction_7 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/contraction_7/dadi/pop1.sfs')
T50_contraction_8 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/contraction_8/dadi/pop1.sfs')
T50_contraction_9 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/contraction_9/dadi/pop1.sfs')
T50_contraction_10 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/contraction_10/dadi/pop1.sfs')
T50_contraction_11 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/contraction_11/dadi/pop1.sfs')
T50_contraction_12 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/contraction_12/dadi/pop1.sfs')
T50_contraction_13 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/contraction_13/dadi/pop1.sfs')
T50_contraction_14 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/contraction_14/dadi/pop1.sfs')
T50_contraction_15 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/contraction_15/dadi/pop1.sfs')
T50_contraction_16 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/contraction_16/dadi/pop1.sfs')
T50_contraction_17 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/contraction_17/dadi/pop1.sfs')
T50_contraction_18 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/contraction_18/dadi/pop1.sfs')
T50_contraction_19 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/contraction_19/dadi/pop1.sfs')
T50_contraction_20 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/contraction_20/dadi/pop1.sfs')

T50_expansion_1 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/expansion_1/dadi/pop1.sfs')
T50_expansion_2 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/expansion_2/dadi/pop1.sfs')
T50_expansion_3 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/expansion_3/dadi/pop1.sfs')
T50_expansion_4 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/expansion_4/dadi/pop1.sfs')
T50_expansion_5 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/expansion_5/dadi/pop1.sfs')
T50_expansion_6 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/expansion_6/dadi/pop1.sfs')
T50_expansion_7 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/expansion_7/dadi/pop1.sfs')
T50_expansion_8 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/expansion_8/dadi/pop1.sfs')
T50_expansion_9 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/expansion_9/dadi/pop1.sfs')
T50_expansion_10 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/expansion_10/dadi/pop1.sfs')
T50_expansion_11 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/expansion_11/dadi/pop1.sfs')
T50_expansion_12 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/expansion_12/dadi/pop1.sfs')
T50_expansion_13 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/expansion_13/dadi/pop1.sfs')
T50_expansion_14 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/expansion_14/dadi/pop1.sfs')
T50_expansion_15 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/expansion_15/dadi/pop1.sfs')
T50_expansion_16 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/expansion_16/dadi/pop1.sfs')
T50_expansion_17 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/expansion_17/dadi/pop1.sfs')
T50_expansion_18 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/expansion_18/dadi/pop1.sfs')
T50_expansion_19 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/expansion_19/dadi/pop1.sfs')
T50_expansion_20 = read_unfolded_input_sfs('../Simulations/lynch_singletons/T50/expansion_20/dadi/pop1.sfs')

T50_bottleneck_singletons = c(T50_bottleneck_1[1],
  T50_bottleneck_2[1],
  T50_bottleneck_3[1],
  T50_bottleneck_4[1],
  T50_bottleneck_5[1],
  T50_bottleneck_6[1],
  T50_bottleneck_7[1],
  T50_bottleneck_8[1],
  T50_bottleneck_9[1],
  T50_bottleneck_10[1],
  T50_bottleneck_11[1],
  T50_bottleneck_12[1],
  T50_bottleneck_13[1],
  T50_bottleneck_14[1],
  T50_bottleneck_15[1],
  T50_bottleneck_16[1],
  T50_bottleneck_17[1],
  T50_bottleneck_18[1],
  T50_bottleneck_19[1],
  T50_bottleneck_20[1])

T50_contraction_singletons = c(T50_contraction_1[1],
  T50_contraction_2[1],
  T50_contraction_3[1],
  T50_contraction_4[1],
  T50_contraction_5[1],
  T50_contraction_6[1],
  T50_contraction_7[1],
  T50_contraction_8[1],
  T50_contraction_9[1],
  T50_contraction_10[1],
  T50_contraction_11[1],
  T50_contraction_12[1],
  T50_contraction_13[1],
  T50_contraction_14[1],
  T50_contraction_15[1],
  T50_contraction_16[1],
  T50_contraction_17[1],
  T50_contraction_18[1],
  T50_contraction_19[1],
  T50_contraction_20[1])

T50_expansion_singletons = c(T50_expansion_1[1],
  T50_expansion_2[1],
  T50_expansion_3[1],
  T50_expansion_4[1],
  T50_expansion_5[1],
  T50_expansion_6[1],
  T50_expansion_7[1],
  T50_expansion_8[1],
  T50_expansion_9[1],
  T50_expansion_10[1],
  T50_expansion_11[1],
  T50_expansion_12[1],
  T50_expansion_13[1],
  T50_expansion_14[1],
  T50_expansion_15[1],
  T50_expansion_16[1],
  T50_expansion_17[1],
  T50_expansion_18[1],
  T50_expansion_19[1],
  T50_expansion_20[1])

no_r_bottleneck_1 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/bottleneck_1/dadi/pop1.sfs')
no_r_bottleneck_2 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/bottleneck_2/dadi/pop1.sfs')
no_r_bottleneck_3 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/bottleneck_3/dadi/pop1.sfs')
no_r_bottleneck_4 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/bottleneck_4/dadi/pop1.sfs')
no_r_bottleneck_5 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/bottleneck_5/dadi/pop1.sfs')
no_r_bottleneck_6 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/bottleneck_6/dadi/pop1.sfs')
no_r_bottleneck_7 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/bottleneck_7/dadi/pop1.sfs')
no_r_bottleneck_8 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/bottleneck_8/dadi/pop1.sfs')
no_r_bottleneck_9 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/bottleneck_9/dadi/pop1.sfs')
no_r_bottleneck_10 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/bottleneck_10/dadi/pop1.sfs')
no_r_bottleneck_11 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/bottleneck_11/dadi/pop1.sfs')
no_r_bottleneck_12 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/bottleneck_12/dadi/pop1.sfs')
no_r_bottleneck_13 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/bottleneck_13/dadi/pop1.sfs')
no_r_bottleneck_14 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/bottleneck_14/dadi/pop1.sfs')
no_r_bottleneck_15 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/bottleneck_15/dadi/pop1.sfs')
no_r_bottleneck_16 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/bottleneck_16/dadi/pop1.sfs')
no_r_bottleneck_17 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/bottleneck_17/dadi/pop1.sfs')
no_r_bottleneck_18 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/bottleneck_18/dadi/pop1.sfs')
no_r_bottleneck_19 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/bottleneck_19/dadi/pop1.sfs')
no_r_bottleneck_20 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/bottleneck_20/dadi/pop1.sfs')

no_r_contraction_1 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/contraction_1/dadi/pop1.sfs')
no_r_contraction_2 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/contraction_2/dadi/pop1.sfs')
no_r_contraction_3 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/contraction_3/dadi/pop1.sfs')
no_r_contraction_4 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/contraction_4/dadi/pop1.sfs')
no_r_contraction_5 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/contraction_5/dadi/pop1.sfs')
no_r_contraction_6 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/contraction_6/dadi/pop1.sfs')
no_r_contraction_7 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/contraction_7/dadi/pop1.sfs')
no_r_contraction_8 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/contraction_8/dadi/pop1.sfs')
no_r_contraction_9 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/contraction_9/dadi/pop1.sfs')
no_r_contraction_10 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/contraction_10/dadi/pop1.sfs')
no_r_contraction_11 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/contraction_11/dadi/pop1.sfs')
no_r_contraction_12 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/contraction_12/dadi/pop1.sfs')
no_r_contraction_13 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/contraction_13/dadi/pop1.sfs')
no_r_contraction_14 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/contraction_14/dadi/pop1.sfs')
no_r_contraction_15 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/contraction_15/dadi/pop1.sfs')
no_r_contraction_16 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/contraction_16/dadi/pop1.sfs')
no_r_contraction_17 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/contraction_17/dadi/pop1.sfs')
no_r_contraction_18 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/contraction_18/dadi/pop1.sfs')
no_r_contraction_19 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/contraction_19/dadi/pop1.sfs')
no_r_contraction_20 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/contraction_20/dadi/pop1.sfs')

no_r_expansion_1 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/expansion_1/dadi/pop1.sfs')
no_r_expansion_2 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/expansion_2/dadi/pop1.sfs')
no_r_expansion_3 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/expansion_3/dadi/pop1.sfs')
no_r_expansion_4 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/expansion_4/dadi/pop1.sfs')
no_r_expansion_5 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/expansion_5/dadi/pop1.sfs')
no_r_expansion_6 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/expansion_6/dadi/pop1.sfs')
no_r_expansion_7 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/expansion_7/dadi/pop1.sfs')
no_r_expansion_8 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/expansion_8/dadi/pop1.sfs')
no_r_expansion_9 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/expansion_9/dadi/pop1.sfs')
no_r_expansion_10 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/expansion_10/dadi/pop1.sfs')
no_r_expansion_11 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/expansion_11/dadi/pop1.sfs')
no_r_expansion_12 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/expansion_12/dadi/pop1.sfs')
no_r_expansion_13 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/expansion_13/dadi/pop1.sfs')
no_r_expansion_14 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/expansion_14/dadi/pop1.sfs')
no_r_expansion_15 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/expansion_15/dadi/pop1.sfs')
no_r_expansion_16 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/expansion_16/dadi/pop1.sfs')
no_r_expansion_17 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/expansion_17/dadi/pop1.sfs')
no_r_expansion_18 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/expansion_18/dadi/pop1.sfs')
no_r_expansion_19 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/expansion_19/dadi/pop1.sfs')
no_r_expansion_20 = read_unfolded_input_sfs('../Simulations/lynch_singletons/no_r/expansion_20/dadi/pop1.sfs')

no_r_bottleneck_singletons = c(no_r_bottleneck_1[1],
  no_r_bottleneck_2[1],
  no_r_bottleneck_3[1],
  no_r_bottleneck_4[1],
  no_r_bottleneck_5[1],
  no_r_bottleneck_6[1],
  no_r_bottleneck_7[1],
  no_r_bottleneck_8[1],
  no_r_bottleneck_9[1],
  no_r_bottleneck_10[1],
  no_r_bottleneck_11[1],
  no_r_bottleneck_12[1],
  no_r_bottleneck_13[1],
  no_r_bottleneck_14[1],
  no_r_bottleneck_15[1],
  no_r_bottleneck_16[1],
  no_r_bottleneck_17[1],
  no_r_bottleneck_18[1],
  no_r_bottleneck_19[1],
  no_r_bottleneck_20[1])

no_r_contraction_singletons = c(no_r_contraction_1[1],
  no_r_contraction_2[1],
  no_r_contraction_3[1],
  no_r_contraction_4[1],
  no_r_contraction_5[1],
  no_r_contraction_6[1],
  no_r_contraction_7[1],
  no_r_contraction_8[1],
  no_r_contraction_9[1],
  no_r_contraction_10[1],
  no_r_contraction_11[1],
  no_r_contraction_12[1],
  no_r_contraction_13[1],
  no_r_contraction_14[1],
  no_r_contraction_15[1],
  no_r_contraction_16[1],
  no_r_contraction_17[1],
  no_r_contraction_18[1],
  no_r_contraction_19[1],
  no_r_contraction_20[1])

no_r_expansion_singletons = c(no_r_expansion_1[1],
  no_r_expansion_2[1],
  no_r_expansion_3[1],
  no_r_expansion_4[1],
  no_r_expansion_5[1],
  no_r_expansion_6[1],
  no_r_expansion_7[1],
  no_r_expansion_8[1],
  no_r_expansion_9[1],
  no_r_expansion_10[1],
  no_r_expansion_11[1],
  no_r_expansion_12[1],
  no_r_expansion_13[1],
  no_r_expansion_14[1],
  no_r_expansion_15[1],
  no_r_expansion_16[1],
  no_r_expansion_17[1],
  no_r_expansion_18[1],
  no_r_expansion_19[1],
  no_r_expansion_20[1])

small_nu_bottleneck_1 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/bottleneck_1/dadi/pop1.sfs')
small_nu_bottleneck_2 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/bottleneck_2/dadi/pop1.sfs')
small_nu_bottleneck_3 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/bottleneck_3/dadi/pop1.sfs')
small_nu_bottleneck_4 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/bottleneck_4/dadi/pop1.sfs')
small_nu_bottleneck_5 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/bottleneck_5/dadi/pop1.sfs')
small_nu_bottleneck_6 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/bottleneck_6/dadi/pop1.sfs')
small_nu_bottleneck_7 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/bottleneck_7/dadi/pop1.sfs')
small_nu_bottleneck_8 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/bottleneck_8/dadi/pop1.sfs')
small_nu_bottleneck_9 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/bottleneck_9/dadi/pop1.sfs')
small_nu_bottleneck_10 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/bottleneck_10/dadi/pop1.sfs')
small_nu_bottleneck_11 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/bottleneck_11/dadi/pop1.sfs')
small_nu_bottleneck_12 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/bottleneck_12/dadi/pop1.sfs')
small_nu_bottleneck_13 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/bottleneck_13/dadi/pop1.sfs')
small_nu_bottleneck_14 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/bottleneck_14/dadi/pop1.sfs')
small_nu_bottleneck_15 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/bottleneck_15/dadi/pop1.sfs')
small_nu_bottleneck_16 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/bottleneck_16/dadi/pop1.sfs')
small_nu_bottleneck_17 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/bottleneck_17/dadi/pop1.sfs')
small_nu_bottleneck_18 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/bottleneck_18/dadi/pop1.sfs')
small_nu_bottleneck_19 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/bottleneck_19/dadi/pop1.sfs')
small_nu_bottleneck_20 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/bottleneck_20/dadi/pop1.sfs')

small_nu_contraction_1 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/contraction_1/dadi/pop1.sfs')
small_nu_contraction_2 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/contraction_2/dadi/pop1.sfs')
small_nu_contraction_3 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/contraction_3/dadi/pop1.sfs')
small_nu_contraction_4 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/contraction_4/dadi/pop1.sfs')
small_nu_contraction_5 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/contraction_5/dadi/pop1.sfs')
small_nu_contraction_6 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/contraction_6/dadi/pop1.sfs')
small_nu_contraction_7 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/contraction_7/dadi/pop1.sfs')
small_nu_contraction_8 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/contraction_8/dadi/pop1.sfs')
small_nu_contraction_9 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/contraction_9/dadi/pop1.sfs')
small_nu_contraction_10 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/contraction_10/dadi/pop1.sfs')
small_nu_contraction_11 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/contraction_11/dadi/pop1.sfs')
small_nu_contraction_12 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/contraction_12/dadi/pop1.sfs')
small_nu_contraction_13 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/contraction_13/dadi/pop1.sfs')
small_nu_contraction_14 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/contraction_14/dadi/pop1.sfs')
small_nu_contraction_15 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/contraction_15/dadi/pop1.sfs')
small_nu_contraction_16 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/contraction_16/dadi/pop1.sfs')
small_nu_contraction_17 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/contraction_17/dadi/pop1.sfs')
small_nu_contraction_18 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/contraction_18/dadi/pop1.sfs')
small_nu_contraction_19 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/contraction_19/dadi/pop1.sfs')
small_nu_contraction_20 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/contraction_20/dadi/pop1.sfs')

small_nu_expansion_1 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/expansion_1/dadi/pop1.sfs')
small_nu_expansion_2 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/expansion_2/dadi/pop1.sfs')
small_nu_expansion_3 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/expansion_3/dadi/pop1.sfs')
small_nu_expansion_4 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/expansion_4/dadi/pop1.sfs')
small_nu_expansion_5 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/expansion_5/dadi/pop1.sfs')
small_nu_expansion_6 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/expansion_6/dadi/pop1.sfs')
small_nu_expansion_7 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/expansion_7/dadi/pop1.sfs')
small_nu_expansion_8 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/expansion_8/dadi/pop1.sfs')
small_nu_expansion_9 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/expansion_9/dadi/pop1.sfs')
small_nu_expansion_10 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/expansion_10/dadi/pop1.sfs')
small_nu_expansion_11 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/expansion_11/dadi/pop1.sfs')
small_nu_expansion_12 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/expansion_12/dadi/pop1.sfs')
small_nu_expansion_13 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/expansion_13/dadi/pop1.sfs')
small_nu_expansion_14 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/expansion_14/dadi/pop1.sfs')
small_nu_expansion_15 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/expansion_15/dadi/pop1.sfs')
small_nu_expansion_16 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/expansion_16/dadi/pop1.sfs')
small_nu_expansion_17 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/expansion_17/dadi/pop1.sfs')
small_nu_expansion_18 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/expansion_18/dadi/pop1.sfs')
small_nu_expansion_19 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/expansion_19/dadi/pop1.sfs')
small_nu_expansion_20 = read_unfolded_input_sfs('../Simulations/lynch_singletons/small_nu/expansion_20/dadi/pop1.sfs')

small_nu_bottleneck_singletons = c(small_nu_bottleneck_1[1],
  small_nu_bottleneck_2[1],
  small_nu_bottleneck_3[1],
  small_nu_bottleneck_4[1],
  small_nu_bottleneck_5[1],
  small_nu_bottleneck_6[1],
  small_nu_bottleneck_7[1],
  small_nu_bottleneck_8[1],
  small_nu_bottleneck_9[1],
  small_nu_bottleneck_10[1],
  small_nu_bottleneck_11[1],
  small_nu_bottleneck_12[1],
  small_nu_bottleneck_13[1],
  small_nu_bottleneck_14[1],
  small_nu_bottleneck_15[1],
  small_nu_bottleneck_16[1],
  small_nu_bottleneck_17[1],
  small_nu_bottleneck_18[1],
  small_nu_bottleneck_19[1],
  small_nu_bottleneck_20[1])

small_nu_contraction_singletons = c(small_nu_contraction_1[1],
  small_nu_contraction_2[1],
  small_nu_contraction_3[1],
  small_nu_contraction_4[1],
  small_nu_contraction_5[1],
  small_nu_contraction_6[1],
  small_nu_contraction_7[1],
  small_nu_contraction_8[1],
  small_nu_contraction_9[1],
  small_nu_contraction_10[1],
  small_nu_contraction_11[1],
  small_nu_contraction_12[1],
  small_nu_contraction_13[1],
  small_nu_contraction_14[1],
  small_nu_contraction_15[1],
  small_nu_contraction_16[1],
  small_nu_contraction_17[1],
  small_nu_contraction_18[1],
  small_nu_contraction_19[1],
  small_nu_contraction_20[1])

small_nu_expansion_singletons = c(small_nu_expansion_1[1],
  small_nu_expansion_2[1],
  small_nu_expansion_3[1],
  small_nu_expansion_4[1],
  small_nu_expansion_5[1],
  small_nu_expansion_6[1],
  small_nu_expansion_7[1],
  small_nu_expansion_8[1],
  small_nu_expansion_9[1],
  small_nu_expansion_10[1],
  small_nu_expansion_11[1],
  small_nu_expansion_12[1],
  small_nu_expansion_13[1],
  small_nu_expansion_14[1],
  small_nu_expansion_15[1],
  small_nu_expansion_16[1],
  small_nu_expansion_17[1],
  small_nu_expansion_18[1],
  small_nu_expansion_19[1],
  small_nu_expansion_20[1])

large_nu_bottleneck_1 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/bottleneck_1/dadi/pop1.sfs')
large_nu_bottleneck_2 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/bottleneck_2/dadi/pop1.sfs')
large_nu_bottleneck_3 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/bottleneck_3/dadi/pop1.sfs')
large_nu_bottleneck_4 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/bottleneck_4/dadi/pop1.sfs')
large_nu_bottleneck_5 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/bottleneck_5/dadi/pop1.sfs')
large_nu_bottleneck_6 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/bottleneck_6/dadi/pop1.sfs')
large_nu_bottleneck_7 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/bottleneck_7/dadi/pop1.sfs')
large_nu_bottleneck_8 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/bottleneck_8/dadi/pop1.sfs')
large_nu_bottleneck_9 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/bottleneck_9/dadi/pop1.sfs')
large_nu_bottleneck_10 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/bottleneck_10/dadi/pop1.sfs')
large_nu_bottleneck_11 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/bottleneck_11/dadi/pop1.sfs')
large_nu_bottleneck_12 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/bottleneck_12/dadi/pop1.sfs')
large_nu_bottleneck_13 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/bottleneck_13/dadi/pop1.sfs')
large_nu_bottleneck_14 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/bottleneck_14/dadi/pop1.sfs')
large_nu_bottleneck_15 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/bottleneck_15/dadi/pop1.sfs')
large_nu_bottleneck_16 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/bottleneck_16/dadi/pop1.sfs')
large_nu_bottleneck_17 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/bottleneck_17/dadi/pop1.sfs')
large_nu_bottleneck_18 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/bottleneck_18/dadi/pop1.sfs')
large_nu_bottleneck_19 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/bottleneck_19/dadi/pop1.sfs')
large_nu_bottleneck_20 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/bottleneck_20/dadi/pop1.sfs')

large_nu_contraction_1 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/contraction_1/dadi/pop1.sfs')
large_nu_contraction_2 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/contraction_2/dadi/pop1.sfs')
large_nu_contraction_3 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/contraction_3/dadi/pop1.sfs')
large_nu_contraction_4 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/contraction_4/dadi/pop1.sfs')
large_nu_contraction_5 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/contraction_5/dadi/pop1.sfs')
large_nu_contraction_6 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/contraction_6/dadi/pop1.sfs')
large_nu_contraction_7 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/contraction_7/dadi/pop1.sfs')
large_nu_contraction_8 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/contraction_8/dadi/pop1.sfs')
large_nu_contraction_9 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/contraction_9/dadi/pop1.sfs')
large_nu_contraction_10 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/contraction_10/dadi/pop1.sfs')
large_nu_contraction_11 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/contraction_11/dadi/pop1.sfs')
large_nu_contraction_12 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/contraction_12/dadi/pop1.sfs')
large_nu_contraction_13 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/contraction_13/dadi/pop1.sfs')
large_nu_contraction_14 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/contraction_14/dadi/pop1.sfs')
large_nu_contraction_15 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/contraction_15/dadi/pop1.sfs')
large_nu_contraction_16 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/contraction_16/dadi/pop1.sfs')
large_nu_contraction_17 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/contraction_17/dadi/pop1.sfs')
large_nu_contraction_18 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/contraction_18/dadi/pop1.sfs')
large_nu_contraction_19 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/contraction_19/dadi/pop1.sfs')
large_nu_contraction_20 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/contraction_20/dadi/pop1.sfs')

large_nu_expansion_1 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/expansion_1/dadi/pop1.sfs')
large_nu_expansion_2 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/expansion_2/dadi/pop1.sfs')
large_nu_expansion_3 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/expansion_3/dadi/pop1.sfs')
large_nu_expansion_4 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/expansion_4/dadi/pop1.sfs')
large_nu_expansion_5 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/expansion_5/dadi/pop1.sfs')
large_nu_expansion_6 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/expansion_6/dadi/pop1.sfs')
large_nu_expansion_7 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/expansion_7/dadi/pop1.sfs')
large_nu_expansion_8 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/expansion_8/dadi/pop1.sfs')
large_nu_expansion_9 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/expansion_9/dadi/pop1.sfs')
large_nu_expansion_10 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/expansion_10/dadi/pop1.sfs')
large_nu_expansion_11 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/expansion_11/dadi/pop1.sfs')
large_nu_expansion_12 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/expansion_12/dadi/pop1.sfs')
large_nu_expansion_13 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/expansion_13/dadi/pop1.sfs')
large_nu_expansion_14 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/expansion_14/dadi/pop1.sfs')
large_nu_expansion_15 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/expansion_15/dadi/pop1.sfs')
large_nu_expansion_16 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/expansion_16/dadi/pop1.sfs')
large_nu_expansion_17 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/expansion_17/dadi/pop1.sfs')
large_nu_expansion_18 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/expansion_18/dadi/pop1.sfs')
large_nu_expansion_19 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/expansion_19/dadi/pop1.sfs')
large_nu_expansion_20 = read_unfolded_input_sfs('../Simulations/lynch_singletons/large_nu/expansion_20/dadi/pop1.sfs')

large_nu_bottleneck_singletons = c(large_nu_bottleneck_1[1],
  large_nu_bottleneck_2[1],
  large_nu_bottleneck_3[1],
  large_nu_bottleneck_4[1],
  large_nu_bottleneck_5[1],
  large_nu_bottleneck_6[1],
  large_nu_bottleneck_7[1],
  large_nu_bottleneck_8[1],
  large_nu_bottleneck_9[1],
  large_nu_bottleneck_10[1],
  large_nu_bottleneck_11[1],
  large_nu_bottleneck_12[1],
  large_nu_bottleneck_13[1],
  large_nu_bottleneck_14[1],
  large_nu_bottleneck_15[1],
  large_nu_bottleneck_16[1],
  large_nu_bottleneck_17[1],
  large_nu_bottleneck_18[1],
  large_nu_bottleneck_19[1],
  large_nu_bottleneck_20[1])

large_nu_contraction_singletons = c(large_nu_contraction_1[1],
  large_nu_contraction_2[1],
  large_nu_contraction_3[1],
  large_nu_contraction_4[1],
  large_nu_contraction_5[1],
  large_nu_contraction_6[1],
  large_nu_contraction_7[1],
  large_nu_contraction_8[1],
  large_nu_contraction_9[1],
  large_nu_contraction_10[1],
  large_nu_contraction_11[1],
  large_nu_contraction_12[1],
  large_nu_contraction_13[1],
  large_nu_contraction_14[1],
  large_nu_contraction_15[1],
  large_nu_contraction_16[1],
  large_nu_contraction_17[1],
  large_nu_contraction_18[1],
  large_nu_contraction_19[1],
  large_nu_contraction_20[1])

large_nu_expansion_singletons = c(large_nu_expansion_1[1],
  large_nu_expansion_2[1],
  large_nu_expansion_3[1],
  large_nu_expansion_4[1],
  large_nu_expansion_5[1],
  large_nu_expansion_6[1],
  large_nu_expansion_7[1],
  large_nu_expansion_8[1],
  large_nu_expansion_9[1],
  large_nu_expansion_10[1],
  large_nu_expansion_11[1],
  large_nu_expansion_12[1],
  large_nu_expansion_13[1],
  large_nu_expansion_14[1],
  large_nu_expansion_15[1],
  large_nu_expansion_16[1],
  large_nu_expansion_17[1],
  large_nu_expansion_18[1],
  large_nu_expansion_19[1],
  large_nu_expansion_20[1])

T500_df = melt(data.frame(T500_bottleneck_singletons,
  T500_contraction_singletons,
  T500_expansion_singletons))

T500_df$simulation="T500"

T50_df = melt(data.frame(T50_bottleneck_singletons,
  T50_contraction_singletons,
  T50_expansion_singletons))

T50_df$simulation="T50"

no_r_df = melt(data.frame(no_r_bottleneck_singletons,
  no_r_contraction_singletons,
  no_r_expansion_singletons))

no_r_df$simulation="no_r"

small_nu_df = melt(data.frame(small_nu_bottleneck_singletons,
  small_nu_contraction_singletons,
  small_nu_expansion_singletons))

small_nu_df$simulation="small_nu"

large_nu_df = melt(data.frame(large_nu_bottleneck_singletons,
  large_nu_contraction_singletons,
  large_nu_expansion_singletons))

large_nu_df$simulation="large_nu"

all_sims_df = rbind(T500_df, T50_df, no_r_df, small_nu_df, large_nu_df)

ggplot(all_sims_df, aes(x=value, y=variable, color=simulation)) + geom_boxplot() +
  theme_bw()
