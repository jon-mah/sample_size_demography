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

# Loop through subdirectories and get relevant files
for (i in seq(from=10, to=800, by=10)) {
  subdirectory_2epC <- paste0("../Analysis/TwoEpochContraction_", i)
  subdirectory_2epE <- paste0("../Analysis/TwoEpochExpansion_", i)
  subdirectory_3epB <- paste0("../Analysis/ThreeEpochContraction_", i)
  subdirectory_3epC <- paste0("../Analysis/ThreeEpochExpansion_", i)
  subdirectory_3epE <- paste0("../Analysis/ThreeEpochBottleneck_", i)
  TwoEpochC_log_file_path <- file.path(subdirectory_2epC, "syn_downsampled.log")
  TwoEpochE_log_file_path <- file.path(subdirectory_2epE, "syn_downsampled.log")
  ThreeEpochB_log_file_path <- file.path(subdirectory_3epB, "syn_downsampled.log")
  ThreeEpochC_log_file_path <- file.path(subdirectory_3epC, "syn_downsampled.log")
  ThreeEpochE_log_file_path <- file.path(subdirectory_3epE, "syn_downsampled.log")
  TwoEpochC_sfs_file_path <- file.path(subdirectory_2epC, "syn_downsampled_sfs.txt")
  TwoEpochE_sfs_file_path <- file.path(subdirectory_2epE, "syn_downsampled_sfs.txt")
  ThreeEpochB_sfs_file_path <- file.path(subdirectory_3epB, "syn_downsampled_sfs.txt")
  ThreeEpochC_sfs_file_path <- file.path(subdirectory_3epC, "syn_downsampled_sfs.txt")
  ThreeEpochE_sfs_file_path <- file.path(subdirectory_3epE, "syn_downsampled_sfs.txt")

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
}

watterson_df = data.frame(TwoEpochC_watterson_theta,
  TwoEpochE_watterson_theta,
  ThreeEpochB_watterson_theta,
  ThreeEpochC_watterson_theta,
  ThreeEpochE_watterson_theta)

watterson_df$sample_size = seq(from=10, to=800, by=10)

# watterson_df = melt(watterson_df, id=c('TwoEpochC_watterson_theta',
#   'TwoEpochE_watterson_theta',
#   'ThreeEpochB_watterson_theta',
#   'ThreeEpochC_watterson_theta',
#   'ThreeEpochE_watterson_theta'))

ggplot(data=watterson_df, aes(x=sample_size, y=TwoEpochC_watterson_theta, color='Two Epoch Contraction')) + geom_line(linewidth=2) +
  geom_line(aes(x=sample_size, y=TwoEpochE_watterson_theta, color='Two Epoch Expansion'), linewidth=2) +
  geom_line(aes(x=sample_size, y=ThreeEpochB_watterson_theta, color='Three Epoch Bottleneck'), linewidth=2) +
  geom_line(aes(x=sample_size, y=ThreeEpochC_watterson_theta, color='Three Epoch Contraction'), linewidth=2) +
  geom_line(aes(x=sample_size, y=ThreeEpochE_watterson_theta, color='Three Epoch Expansion'), linewidth=2) +
  scale_color_manual(name='Simulated Demographic Scenario',
                     breaks=c('Two Epoch Contraction',
                       'Two Epoch Expansion',
                       'Three Epoch Bottleneck',
                       'Three Epoch Contraction',
                       'Three Epoch Expansion'),
                     values=c('Two Epoch Contraction'='#a50026',
                       'Two Epoch Expansion'='#f46d43',
                       'Three Epoch Bottleneck'='#fee090',
                       'Three Epoch Contraction'='#74add1',
                       'Three Epoch Expansion'='#313695')) +
  theme_bw() +
  ylab("Watterson's Theta") +
  xlab('Sample Size') +
  ggtitle("Watterson's Theta over sample size for simulated demographic histories")

zeng_E_df = data.frame(TwoEpochC_tajima_d,
  TwoEpochE_tajima_d,
  ThreeEpochB_tajima_d,
  ThreeEpochC_tajima_d,
  ThreeEpochE_tajima_d)

zeng_E_df$sample_size = seq(from=10, to=800, by=10)

ggplot(data=zeng_E_df, aes(x=sample_size, y=TwoEpochC_tajima_d, color='Two Epoch Contraction')) + geom_line(linewidth=2) +
  geom_line(aes(x=sample_size, y=TwoEpochE_tajima_d, color='Two Epoch Expansion'), linewidth=2) +
  geom_line(aes(x=sample_size, y=ThreeEpochB_tajima_d, color='Three Epoch Bottleneck'), linewidth=2) +
  geom_line(aes(x=sample_size, y=ThreeEpochC_tajima_d, color='Three Epoch Contraction'), linewidth=2) +
  geom_line(aes(x=sample_size, y=ThreeEpochE_tajima_d, color='Three Epoch Expansion'), linewidth=2) +
  scale_color_manual(name='Simulated Demographic Scenario',
                     breaks=c('Two Epoch Contraction',
                       'Two Epoch Expansion',
                       'Three Epoch Bottleneck',
                       'Three Epoch Contraction',
                       'Three Epoch Expansion'),
                     values=c('Two Epoch Contraction'='#a50026',
                       'Two Epoch Expansion'='#f46d43',
                       'Three Epoch Bottleneck'='#fee090',
                       'Three Epoch Contraction'='#74add1',
                       'Three Epoch Expansion'='#313695')) +
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
  ThreeEpochE_zeng_E)

zeng_E_df$sample_size = seq(from=10, to=800, by=10)

ggplot(data=zeng_E_df, aes(x=sample_size, y=TwoEpochC_zeng_E, color='Two Epoch Contraction')) + geom_line(linewidth=2) +
  geom_line(aes(x=sample_size, y=TwoEpochE_zeng_E, color='Two Epoch Expansion'), linewidth=2) +
  geom_line(aes(x=sample_size, y=ThreeEpochB_zeng_E, color='Three Epoch Bottleneck'), linewidth=2) +
  geom_line(aes(x=sample_size, y=ThreeEpochC_zeng_E, color='Three Epoch Contraction'), linewidth=2) +
  geom_line(aes(x=sample_size, y=ThreeEpochE_zeng_E, color='Three Epoch Expansion'), linewidth=2) +
  scale_color_manual(name='Simulated Demographic Scenario',
                     breaks=c('Two Epoch Contraction',
                       'Two Epoch Expansion',
                       'Three Epoch Bottleneck',
                       'Three Epoch Contraction',
                       'Three Epoch Expansion'),
                     values=c('Two Epoch Contraction'='#a50026',
                       'Two Epoch Expansion'='#f46d43',
                       'Three Epoch Bottleneck'='#fee090',
                       'Three Epoch Contraction'='#74add1',
                       'Three Epoch Expansion'='#313695')) +
  geom_hline(yintercept = 0, linetype='dashed') +
  theme_bw() +
  ylab("Zeng's E") +
  xlab('Sample Size') +
  ggtitle("Zeng's E over sample size for simulated demographic histories")

zeng_theta_L_df = data.frame(TwoEpochC_zeng_theta_L,
  TwoEpochE_zeng_theta_L,
  ThreeEpochB_zeng_theta_L,
  ThreeEpochC_zeng_theta_L,
  ThreeEpochE_zeng_theta_L)

zeng_theta_L_df$sample_size = seq(from=10, to=800, by=10)

ggplot(data=zeng_theta_L_df, aes(x=sample_size, y=TwoEpochC_zeng_theta_L, color='Two Epoch Contraction')) + geom_line(linewidth=2) +
  geom_line(aes(x=sample_size, y=TwoEpochE_zeng_theta_L, color='Two Epoch Expansion'), linewidth=2) +
  geom_line(aes(x=sample_size, y=ThreeEpochB_zeng_theta_L, color='Three Epoch Bottleneck'), linewidth=2) +
  geom_line(aes(x=sample_size, y=ThreeEpochC_zeng_theta_L, color='Three Epoch Contraction'), linewidth=2) +
  geom_line(aes(x=sample_size, y=ThreeEpochE_zeng_theta_L, color='Three Epoch Expansion'), linewidth=2) +
  scale_color_manual(name='Simulated Demographic Scenario',
                     breaks=c('Two Epoch Contraction',
                       'Two Epoch Expansion',
                       'Three Epoch Bottleneck',
                       'Three Epoch Contraction',
                       'Three Epoch Expansion'),
                     values=c('Two Epoch Contraction'='#a50026',
                       'Two Epoch Expansion'='#f46d43',
                       'Three Epoch Bottleneck'='#fee090',
                       'Three Epoch Contraction'='#74add1',
                       'Three Epoch Expansion'='#313695')) +
  theme_bw() +
  ylab("Zeng's ThetaL") +
  xlab('Sample Size') +
  ggtitle("Zeng's ThetaL over sample size for simulated demographic histories")

proportion_singletons_df = data.frame(TwoEpochC_proportion_singletons,
  TwoEpochE_proportion_singletons,
  ThreeEpochB_proportion_singletons,
  ThreeEpochC_proportion_singletons,
  ThreeEpochE_proportion_singletons)

proportion_singletons_df$sample_size = seq(from=10, to=800, by=10)

ggplot(data=proportion_singletons_df, aes(x=sample_size, y=TwoEpochC_proportion_singletons, color='Two Epoch Contraction')) + geom_line(linewidth=2) +
  geom_line(aes(x=sample_size, y=TwoEpochE_proportion_singletons, color='Two Epoch Expansion'), linewidth=2) +
  geom_line(aes(x=sample_size, y=ThreeEpochB_proportion_singletons, color='Three Epoch Bottleneck'), linewidth=2) +
  geom_line(aes(x=sample_size, y=ThreeEpochC_proportion_singletons, color='Three Epoch Contraction'), linewidth=2) +
  geom_line(aes(x=sample_size, y=ThreeEpochE_proportion_singletons, color='Three Epoch Expansion'), linewidth=2) +
  scale_color_manual(name='Simulated Demographic Scenario',
                     breaks=c('Two Epoch Contraction',
                       'Two Epoch Expansion',
                       'Three Epoch Bottleneck',
                       'Three Epoch Contraction',
                       'Three Epoch Expansion'),
                     values=c('Two Epoch Contraction'='#a50026',
                       'Two Epoch Expansion'='#f46d43',
                       'Three Epoch Bottleneck'='#fee090',
                       'Three Epoch Contraction'='#74add1',
                       'Three Epoch Expansion'='#313695')) +
  theme_bw() +
  ylab("Proportion of singletons") +
  xlab('Sample Size') +
  ggtitle("Proportion of singletons over sample size for simulated demographic histories")

rare_variant_proportion_df = data.frame(TwoEpochC_rare_variant_proportion,
  TwoEpochE_rare_variant_proportion,
  ThreeEpochB_rare_variant_proportion,
  ThreeEpochC_rare_variant_proportion,
  ThreeEpochE_rare_variant_proportion)

rare_variant_proportion_df$sample_size = seq(from=10, to=800, by=10)

ggplot(data=rare_variant_proportion_df, aes(x=sample_size, y=TwoEpochC_rare_variant_proportion, color='Two Epoch Contraction')) + geom_line(linewidth=2) +
  geom_line(aes(x=sample_size, y=TwoEpochE_rare_variant_proportion, color='Two Epoch Expansion'), linewidth=2) +
  geom_line(aes(x=sample_size, y=ThreeEpochB_rare_variant_proportion, color='Three Epoch Bottleneck'), linewidth=2) +
  geom_line(aes(x=sample_size, y=ThreeEpochC_rare_variant_proportion, color='Three Epoch Contraction'), linewidth=2) +
  geom_line(aes(x=sample_size, y=ThreeEpochE_rare_variant_proportion, color='Three Epoch Expansion'), linewidth=2) +
  scale_color_manual(name='Simulated Demographic Scenario',
                     breaks=c('Two Epoch Contraction',
                       'Two Epoch Expansion',
                       'Three Epoch Bottleneck',
                       'Three Epoch Contraction',
                       'Three Epoch Expansion'),
                     values=c('Two Epoch Contraction'='#a50026',
                       'Two Epoch Expansion'='#f46d43',
                       'Three Epoch Bottleneck'='#fee090',
                       'Three Epoch Contraction'='#74add1',
                       'Three Epoch Expansion'='#313695')) +
  theme_bw() +
  ylab("Proportion of singletons") +
  xlab('Sample Size') +
  ggtitle("Proportion of SFS comprised of rare variants over sample size for simulated demographic histories")
