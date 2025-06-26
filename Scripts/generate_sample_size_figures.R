# generate_sample_size_figures.R

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

# global_allele_sum = 20 * 1000000
# 
# TwoEpochC_watterson_theta = c()
# # TwoEpochC_heterozygosity = c()
# TwoEpochC_tajima_d = c()
# TwoEpochC_singetons = c()
# TwoEpochC_pi = c()
# TwoEpochC_zeng_E = c()
# TwoEpochC_zeng_theta_L = c()
# TwoEpochC_proportion_singletons = c()
# TwoEpochC_rare_variant_proportion = c()
# 
# TwoEpochE_watterson_theta = c()
# # TwoEpochE_heterozygosity = c()
# TwoEpochE_tajima_d = c()
# TwoEpochE_singletons = c()
# TwoEpochE_pi = c()
# TwoEpochE_zeng_E = c()
# TwoEpochE_zeng_theta_L = c()
# TwoEpochE_proportion_singletons = c()
# TwoEpochE_rare_variant_proportion = c()
# 
# ThreeEpochB_watterson_theta = c()
# # ThreeEpochB_heterozygosity = c()
# ThreeEpochB_tajima_d = c()
# ThreeEpochB_singletons = c()
# ThreeEpochB_pi = c()
# ThreeEpochB_zeng_E = c()
# ThreeEpochB_zeng_theta_L = c()
# ThreeEpochB_proportion_singletons = c()
# ThreeEpochB_rare_variant_proportion = c()
# 
# ThreeEpochC_watterson_theta = c()
# # ThreeEpochC_heterozygosity = c()
# ThreeEpochC_tajima_d = c()
# ThreeEpochC_singletons = c()
# ThreeEpochC_pi = c()
# ThreeEpochC_zeng_E = c()
# ThreeEpochC_zeng_theta_L = c()
# ThreeEpochC_proportion_singletons = c()
# ThreeEpochC_rare_variant_proportion = c()
# 
# ThreeEpochE_watterson_theta = c()
# # ThreeEpochE_heterozygosity = c()
# ThreeEpochE_tajima_d = c()
# ThreeEpochE_singletons = c()
# ThreeEpochE_pi = c()
# ThreeEpochE_zeng_E = c()
# ThreeEpochE_zeng_theta_L = c()
# ThreeEpochE_proportion_singletons = c()
# ThreeEpochE_rare_variant_proportion = c()
# 
# snm_watterson_theta = c()
# # snm_heterozygosity = c()
# snm_tajima_d = c()
# snm_singletons = c()
# snm_pi = c()
# snm_zeng_E = c()
# snm_zeng_theta_L = c()
# snm_proportion_singletons = c()
# snm_rare_variant_proportion = c()
# 
# # Loop through subdirectories and get relevant files
# for (i in seq(from=10, to=800, by=10)) {
#   subdirectory_2epC <- paste0("../Analysis/TwoEpochContraction_", i)
#   subdirectory_2epE <- paste0("../Analysis/TwoEpochExpansion_", i)
#   subdirectory_3epB <- paste0("../Analysis/ThreeEpochBottleneck_", i)
#   subdirectory_3epC <- paste0("../Analysis/ThreeEpochContraction_", i)
#   subdirectory_3epE <- paste0("../Analysis/ThreeEpochExpansion_", i)
#   subdirectory_snm <- paste0("../Analysis/snm_", i)
#   TwoEpochC_log_file_path <- file.path(subdirectory_2epC, "syn_downsampled.log")
#   TwoEpochE_log_file_path <- file.path(subdirectory_2epE, "syn_downsampled.log")
#   ThreeEpochB_log_file_path <- file.path(subdirectory_3epB, "syn_downsampled.log")
#   ThreeEpochC_log_file_path <- file.path(subdirectory_3epC, "syn_downsampled.log")
#   ThreeEpochE_log_file_path <- file.path(subdirectory_3epE, "syn_downsampled.log")
#   snm_log_file_path <- file.path(subdirectory_snm, "snm_downsampled.log")
#   TwoEpochC_sfs_file_path <- file.path(subdirectory_2epC, "syn_downsampled_sfs.txt")
#   TwoEpochE_sfs_file_path <- file.path(subdirectory_2epE, "syn_downsampled_sfs.txt")
#   ThreeEpochB_sfs_file_path <- file.path(subdirectory_3epB, "syn_downsampled_sfs.txt")
#   ThreeEpochC_sfs_file_path <- file.path(subdirectory_3epC, "syn_downsampled_sfs.txt")
#   ThreeEpochE_sfs_file_path <- file.path(subdirectory_3epE, "syn_downsampled_sfs.txt")
#   snm_sfs_file_path <- file.path(subdirectory_snm, "snm_downsampled_sfs.txt")
# 
#   # Check if the file exists before attempting to read and print its contents
#   if (file.exists(TwoEpochC_log_file_path)) {
#     TwoEpochC_watterson_theta = c(TwoEpochC_watterson_theta, watterson_theta_from_sfs(TwoEpochC_log_file_path))
#     # TwoEpochC_heterozygosity = c(TwoEpochC_heterozygosity, heterozygosity_from_sfs(TwoEpochC_log_file_path))
#     TwoEpochC_tajima_d = c(TwoEpochC_tajima_d, tajima_D_from_sfs(TwoEpochC_log_file_path))
#     TwoEpochC_pi = c(TwoEpochC_pi, pi_from_sfs_array(read_input_sfs(TwoEpochC_sfs_file_path)))
#     TwoEpochC_zeng_E = c(TwoEpochC_zeng_E, zeng_E_from_sfs(TwoEpochC_log_file_path))
#     TwoEpochC_zeng_theta_L = c(TwoEpochC_zeng_theta_L, zeng_theta_L_from_sfs(TwoEpochC_log_file_path))
#     TwoEpochC_proportion_singletons = c(TwoEpochC_proportion_singletons, 
#       read_input_sfs(TwoEpochC_sfs_file_path)[1] / sum(read_input_sfs(TwoEpochC_sfs_file_path)))
#     TwoEpochC_rare_variant_proportion = c(TwoEpochC_rare_variant_proportion, calculate_rare_variant_proportion(read_input_sfs(TwoEpochC_sfs_file_path)))
#   }
#   if (file.exists(TwoEpochE_log_file_path)) {
#     TwoEpochE_watterson_theta = c(TwoEpochE_watterson_theta, watterson_theta_from_sfs(TwoEpochE_log_file_path))
#     # TwoEpochE_heterozygosity = c(TwoEpochE_heterozygosity, heterozygosity_from_sfs(TwoEpochE_log_file_path))
#     TwoEpochE_tajima_d = c(TwoEpochE_tajima_d, tajima_D_from_sfs(TwoEpochE_log_file_path))
#     TwoEpochE_pi = c(TwoEpochE_pi, pi_from_sfs_array(read_input_sfs(TwoEpochE_sfs_file_path)))
#     TwoEpochE_zeng_E = c(TwoEpochE_zeng_E, zeng_E_from_sfs(TwoEpochE_log_file_path))
#     TwoEpochE_zeng_theta_L = c(TwoEpochE_zeng_theta_L, zeng_theta_L_from_sfs(TwoEpochE_log_file_path))
#     TwoEpochE_proportion_singletons = c(TwoEpochE_proportion_singletons, 
#       read_input_sfs(TwoEpochE_sfs_file_path)[1] / sum(read_input_sfs(TwoEpochE_sfs_file_path)))
#     TwoEpochE_rare_variant_proportion = c(TwoEpochE_rare_variant_proportion, calculate_rare_variant_proportion(read_input_sfs(TwoEpochE_sfs_file_path)))
#   }
#   if (file.exists(ThreeEpochB_log_file_path)) {
#     ThreeEpochB_watterson_theta = c(ThreeEpochB_watterson_theta, watterson_theta_from_sfs(ThreeEpochB_log_file_path))
#     # ThreeEpochB_heterozygosity = c(ThreeEpochB_heterozygosity, heterozygosity_from_sfs(ThreeEpochB_log_file_path))
#     ThreeEpochB_tajima_d = c(ThreeEpochB_tajima_d, tajima_D_from_sfs(ThreeEpochB_log_file_path))
#     ThreeEpochB_pi = c(ThreeEpochB_pi, pi_from_sfs_array(read_input_sfs(ThreeEpochB_sfs_file_path)))
#     ThreeEpochB_zeng_E = c(ThreeEpochB_zeng_E, zeng_E_from_sfs(ThreeEpochB_log_file_path))
#     ThreeEpochB_zeng_theta_L = c(ThreeEpochB_zeng_theta_L, zeng_theta_L_from_sfs(ThreeEpochB_log_file_path))
#     ThreeEpochB_proportion_singletons = c(ThreeEpochB_proportion_singletons, 
#       read_input_sfs(ThreeEpochB_sfs_file_path)[1] / sum(read_input_sfs(ThreeEpochB_sfs_file_path)))
#     ThreeEpochB_rare_variant_proportion = c(ThreeEpochB_rare_variant_proportion, calculate_rare_variant_proportion(read_input_sfs(ThreeEpochB_sfs_file_path)))
#   }
#   if (file.exists(ThreeEpochC_log_file_path)) {
#     ThreeEpochC_watterson_theta = c(ThreeEpochC_watterson_theta, watterson_theta_from_sfs(ThreeEpochC_log_file_path))
#     # ThreeEpochC_heterozygosity = c(ThreeEpochC_heterozygosity, heterozygosity_from_sfs(ThreeEpochC_log_file_path))
#     ThreeEpochC_tajima_d = c(ThreeEpochC_tajima_d, tajima_D_from_sfs(ThreeEpochC_log_file_path))
#     ThreeEpochC_pi = c(ThreeEpochC_pi, pi_from_sfs_array(read_input_sfs(ThreeEpochC_sfs_file_path)))
#     ThreeEpochC_zeng_E = c(ThreeEpochC_zeng_E, zeng_E_from_sfs(ThreeEpochC_log_file_path))
#     ThreeEpochC_zeng_theta_L = c(ThreeEpochC_zeng_theta_L, zeng_theta_L_from_sfs(ThreeEpochC_log_file_path))
#     ThreeEpochC_proportion_singletons = c(ThreeEpochC_proportion_singletons, 
#       read_input_sfs(ThreeEpochC_sfs_file_path)[1] / sum(read_input_sfs(ThreeEpochC_sfs_file_path)))
#     ThreeEpochC_rare_variant_proportion = c(ThreeEpochC_rare_variant_proportion, calculate_rare_variant_proportion(read_input_sfs(ThreeEpochC_sfs_file_path)))
#   }
#   if (file.exists(ThreeEpochE_log_file_path)) {
#     ThreeEpochE_watterson_theta = c(ThreeEpochE_watterson_theta, watterson_theta_from_sfs(ThreeEpochE_log_file_path))
#     # ThreeEpochE_heterozygosity = c(ThreeEpochE_heterozygosity, heterozygosity_from_sfs(ThreeEpochE_log_file_path))
#     ThreeEpochE_tajima_d = c(ThreeEpochE_tajima_d, tajima_D_from_sfs(ThreeEpochE_log_file_path))
#     ThreeEpochE_pi = c(ThreeEpochE_pi, pi_from_sfs_array(read_input_sfs(ThreeEpochE_sfs_file_path)))
#     ThreeEpochE_zeng_E = c(ThreeEpochE_zeng_E, zeng_E_from_sfs(ThreeEpochE_log_file_path))
#     ThreeEpochE_zeng_theta_L = c(ThreeEpochE_zeng_theta_L, zeng_theta_L_from_sfs(ThreeEpochE_log_file_path))
#     ThreeEpochE_proportion_singletons = c(ThreeEpochE_proportion_singletons, 
#       read_input_sfs(ThreeEpochE_sfs_file_path)[1] / sum(read_input_sfs(ThreeEpochE_sfs_file_path)))
#     ThreeEpochE_rare_variant_proportion = c(ThreeEpochE_rare_variant_proportion, calculate_rare_variant_proportion(read_input_sfs(ThreeEpochE_sfs_file_path)))
#   }
#   if (file.exists(snm_log_file_path)) {
#     snm_watterson_theta = c(snm_watterson_theta, watterson_theta_from_sfs(snm_log_file_path))
#     # snm_heterozygosity = c(snm_heterozygosity, heterozygosity_from_sfs(snm_log_file_path))
#     snm_tajima_d = c(snm_tajima_d, tajima_D_from_sfs(snm_log_file_path))
#     snm_pi = c(snm_pi, pi_from_sfs_array(read_input_sfs(snm_sfs_file_path)))
#     snm_zeng_E = c(snm_zeng_E, zeng_E_from_sfs(snm_log_file_path))
#     snm_zeng_theta_L = c(snm_zeng_theta_L, zeng_theta_L_from_sfs(snm_log_file_path))
#     snm_proportion_singletons = c(snm_proportion_singletons, 
#       read_input_sfs(snm_sfs_file_path)[1] / sum(read_input_sfs(snm_sfs_file_path)))
#     snm_rare_variant_proportion = c(snm_rare_variant_proportion, calculate_rare_variant_proportion(read_input_sfs(snm_sfs_file_path)))
#   }
# }
# 
# watterson_df = data.frame(TwoEpochC_watterson_theta,
#   TwoEpochE_watterson_theta,
#   ThreeEpochB_watterson_theta,
#   ThreeEpochC_watterson_theta,
#   ThreeEpochE_watterson_theta,
#   snm_watterson_theta)
# 
# watterson_df$sample_size = seq(from=10, to=800, by=10)
# 
# ggplot(data=watterson_df, aes(x=sample_size, y=TwoEpochC_watterson_theta, color='Two Epoch Contraction')) + geom_line(linewidth=2) +
#   geom_line(aes(x=sample_size, y=TwoEpochE_watterson_theta, color='Two Epoch Expansion'), linewidth=2) +
#   geom_line(aes(x=sample_size, y=ThreeEpochB_watterson_theta, color='Three Epoch Bottleneck'), linewidth=2) +
#   geom_line(aes(x=sample_size, y=ThreeEpochC_watterson_theta, color='Three Epoch Contraction'), linewidth=2) +
#   geom_line(aes(x=sample_size, y=ThreeEpochE_watterson_theta, color='Three Epoch Expansion'), linewidth=2) +
#   geom_line(aes(x=sample_size, y=snm_watterson_theta, color='Standard Neutral Model'), linewidth=2) +
#   scale_color_manual(name='Simulated Demographic Scenario',
#                      breaks=c('Two Epoch Contraction',
#                        'Two Epoch Expansion',
#                        'Three Epoch Bottleneck',
#                        'Three Epoch Contraction',
#                        'Three Epoch Expansion',
#                        'Standard Neutral Model'),
#                      values=c('Two Epoch Contraction'='#a50026',
#                        'Two Epoch Expansion'='#f46d43',
#                        'Three Epoch Bottleneck'='#fee090',
#                        'Three Epoch Contraction'='#74add1',
#                        'Three Epoch Expansion'='#313695',
#                        'Standard Neutral Model'='black')) +
#   theme_bw() +
#   ylab("Watterson's Theta") +
#   xlab('Sample Size') +
#   # scale_x_log10() +
#   ggtitle("Watterson's Theta over sample size for simulated demographic histories")
# 
# tajima_d_df = data.frame(TwoEpochC_tajima_d,
#   TwoEpochE_tajima_d,
#   ThreeEpochB_tajima_d,
#   ThreeEpochC_tajima_d,
#   ThreeEpochE_tajima_d,
#   snm_tajima_d)
# 
# tajima_d_df$sample_size = seq(from=10, to=800, by=10)
# 
# ggplot(data=tajima_d_df, aes(x=sample_size, y=TwoEpochC_tajima_d, color='Two Epoch Contraction')) + geom_line(linewidth=2) +
#   geom_line(aes(x=sample_size, y=TwoEpochE_tajima_d, color='Two Epoch Expansion'), linewidth=2) +
#   geom_line(aes(x=sample_size, y=ThreeEpochB_tajima_d, color='Three Epoch Bottleneck'), linewidth=2) +
#   geom_line(aes(x=sample_size, y=ThreeEpochC_tajima_d, color='Three Epoch Contraction'), linewidth=2) +
#   geom_line(aes(x=sample_size, y=ThreeEpochE_tajima_d, color='Three Epoch Expansion'), linewidth=2) +
#   geom_line(aes(x=sample_size, y=snm_tajima_d, color='Standard Neutral Model'), linewidth=2) +
#   scale_color_manual(name='Simulated Demographic Scenario',
#                      breaks=c('Two Epoch Contraction',
#                        'Two Epoch Expansion',
#                        'Three Epoch Bottleneck',
#                        'Three Epoch Contraction',
#                        'Three Epoch Expansion',
#                        'Standard Neutral Model'),
#                      values=c('Two Epoch Contraction'='#a50026',
#                        'Two Epoch Expansion'='#f46d43',
#                        'Three Epoch Bottleneck'='#fee090',
#                        'Three Epoch Contraction'='#74add1',
#                        'Three Epoch Expansion'='#313695',
#                        'Standard Neutral Model'='black')) +
#   geom_hline(yintercept = 0, linetype='dashed') +
#   theme_bw() +
#   ylab("Tajima's D") +
#   xlab('Sample Size') +
#   ggtitle("Tajima's D over sample size for simulated demographic histories")
# 
# # pi_df = data.frame(TwoEpochC_pi,
# #   TwoEpochE_pi,
# #   ThreeEpochB_pi,
# #   ThreeEpochC_pi,
# #   ThreeEpochE_pi)
# # 
# # pi_df$sample_size = seq(from=10, to=800, by=10)
# # 
# # ggplot(data=pi_df, aes(x=sample_size, y=TwoEpochC_pi, color='Two Epoch Contraction')) + geom_line(linewidth=2) +
# #   geom_line(aes(x=sample_size, y=TwoEpochE_pi, color='Two Epoch Expansion'), linewidth=2) +
# #   geom_line(aes(x=sample_size, y=ThreeEpochB_pi, color='Three Epoch Bottleneck'), linewidth=2) +
# #   geom_line(aes(x=sample_size, y=ThreeEpochC_pi, color='Three Epoch Contraction'), linewidth=2) +
# #   geom_line(aes(x=sample_size, y=ThreeEpochE_pi, color='Three Epoch Expansion'), linewidth=2) +
# #   scale_color_manual(name='Simulated Demographic Scenario',
# #                      breaks=c('Two Epoch Contraction',
# #                        'Two Epoch Expansion',
# #                        'Three Epoch Bottleneck',
# #                        'Three Epoch Contraction',
# #                        'Three Epoch Expansion'),
# #                      values=c('Two Epoch Contraction'='#a50026',
# #                        'Two Epoch Expansion'='#f46d43',
# #                        'Three Epoch Bottleneck'='#fee090',
# #                        'Three Epoch Contraction'='#74add1',
# #                        'Three Epoch Expansion'='#313695')) +
# #   geom_hline(yintercept = 0, linetype='dashed') +
# #   theme_bw() +
# #   ylab("Tajima's D") +
# #   xlab('Sample Size') +
# #   ggtitle("Tajima's D over sample size for simulated demographic histories")
# 
# zeng_E_df = data.frame(TwoEpochC_zeng_E,
#   TwoEpochE_zeng_E,
#   ThreeEpochB_zeng_E,
#   ThreeEpochC_zeng_E,
#   ThreeEpochE_zeng_E,
#   snm_zeng_E)
# 
# zeng_E_df$sample_size = seq(from=10, to=800, by=10)
# 
# ggplot(data=zeng_E_df, aes(x=sample_size, y=TwoEpochC_zeng_E, color='Two Epoch Contraction')) + geom_line(linewidth=2) +
#   geom_line(aes(x=sample_size, y=TwoEpochE_zeng_E, color='Two Epoch Expansion'), linewidth=2) +
#   geom_line(aes(x=sample_size, y=ThreeEpochB_zeng_E, color='Three Epoch Bottleneck'), linewidth=2) +
#   geom_line(aes(x=sample_size, y=ThreeEpochC_zeng_E, color='Three Epoch Contraction'), linewidth=2) +
#   geom_line(aes(x=sample_size, y=ThreeEpochE_zeng_E, color='Three Epoch Expansion'), linewidth=2) +
#   geom_line(aes(x=sample_size, y=snm_zeng_E, color='Standard Neutral Model'), linewidth=2) +
#   scale_color_manual(name='Simulated Demographic Scenario',
#                      breaks=c('Two Epoch Contraction',
#                        'Two Epoch Expansion',
#                        'Three Epoch Bottleneck',
#                        'Three Epoch Contraction',
#                        'Three Epoch Expansion',
#                        'Standard Neutral Model'),
#                      values=c('Two Epoch Contraction'='#a50026',
#                        'Two Epoch Expansion'='#f46d43',
#                        'Three Epoch Bottleneck'='#fee090',
#                        'Three Epoch Contraction'='#74add1',
#                        'Three Epoch Expansion'='#313695',
#                        'Standard Neutral Model'='black')) +
#   geom_hline(yintercept = 0, linetype='dashed') +
#   theme_bw() +
#   ylab("Zeng's E") +
#   xlab('Sample Size') +
#   ggtitle("Zeng's E over sample size for simulated demographic histories")
# 
# zeng_theta_L_df = data.frame(TwoEpochC_zeng_theta_L,
#   TwoEpochE_zeng_theta_L,
#   ThreeEpochB_zeng_theta_L,
#   ThreeEpochC_zeng_theta_L,
#   ThreeEpochE_zeng_theta_L,
#   snm_zeng_theta_L)
# 
# zeng_theta_L_df$sample_size = seq(from=10, to=800, by=10)
# 
# ggplot(data=zeng_theta_L_df, aes(x=sample_size, y=TwoEpochC_zeng_theta_L, color='Two Epoch Contraction')) + geom_line(linewidth=2) +
#   geom_line(aes(x=sample_size, y=TwoEpochE_zeng_theta_L, color='Two Epoch Expansion'), linewidth=2) +
#   geom_line(aes(x=sample_size, y=ThreeEpochB_zeng_theta_L, color='Three Epoch Bottleneck'), linewidth=2) +
#   geom_line(aes(x=sample_size, y=ThreeEpochC_zeng_theta_L, color='Three Epoch Contraction'), linewidth=2) +
#   geom_line(aes(x=sample_size, y=ThreeEpochE_zeng_theta_L, color='Three Epoch Expansion'), linewidth=2) +
#   geom_line(aes(x=sample_size, y=snm_zeng_theta_L, color='Standard Neutral Model'), linewidth=2) +
#   scale_color_manual(name='Simulated Demographic Scenario',
#                      breaks=c('Two Epoch Contraction',
#                        'Two Epoch Expansion',
#                        'Three Epoch Bottleneck',
#                        'Three Epoch Contraction',
#                        'Three Epoch Expansion',
#                        'Standard Neutral Model'),
#                      values=c('Two Epoch Contraction'='#a50026',
#                        'Two Epoch Expansion'='#f46d43',
#                        'Three Epoch Bottleneck'='#fee090',
#                        'Three Epoch Contraction'='#74add1',
#                        'Three Epoch Expansion'='#313695',
#                        'Standard Neutral Model'='black')) +
#   theme_bw() +
#   ylab("Zeng's ThetaL") +
#   xlab('Sample Size') +
#   ggtitle("Zeng's ThetaL over sample size for simulated demographic histories")
# 
# proportion_singletons_df = data.frame(TwoEpochC_proportion_singletons,
#   TwoEpochE_proportion_singletons,
#   ThreeEpochB_proportion_singletons,
#   ThreeEpochC_proportion_singletons,
#   ThreeEpochE_proportion_singletons,
#   snm_proportion_singletons)
# 
# proportion_singletons_df$sample_size = seq(from=10, to=800, by=10)
# 
# ggplot(data=proportion_singletons_df, aes(x=sample_size, y=TwoEpochC_proportion_singletons, color='Two Epoch Contraction')) + geom_line(linewidth=2) +
#   geom_line(aes(x=sample_size, y=TwoEpochE_proportion_singletons, color='Two Epoch Expansion'), linewidth=2) +
#   geom_line(aes(x=sample_size, y=ThreeEpochB_proportion_singletons, color='Three Epoch Bottleneck'), linewidth=2) +
#   geom_line(aes(x=sample_size, y=ThreeEpochC_proportion_singletons, color='Three Epoch Contraction'), linewidth=2) +
#   geom_line(aes(x=sample_size, y=ThreeEpochE_proportion_singletons, color='Three Epoch Expansion'), linewidth=2) +
#   geom_line(aes(x=sample_size, y=snm_proportion_singletons, color='Standard Neutral Model'), linewidth=2) +
#   scale_color_manual(name='Simulated Demographic Scenario',
#                      breaks=c('Two Epoch Contraction',
#                        'Two Epoch Expansion',
#                        'Three Epoch Bottleneck',
#                        'Three Epoch Contraction',
#                        'Three Epoch Expansion',
#                        'Standard Neutral Model'),
#                      values=c('Two Epoch Contraction'='#a50026',
#                        'Two Epoch Expansion'='#f46d43',
#                        'Three Epoch Bottleneck'='#fee090',
#                        'Three Epoch Contraction'='#74add1',
#                        'Three Epoch Expansion'='#313695',
#                        'Standard Neutral Model'='black')) +
#   theme_bw() +
#   ylab("Proportion of singletons") +
#   xlab('Sample Size') +
#   scale_x_log10() +
#   ggtitle("Proportion of singletons over sample size for simulated demographic histories")
# 
# rare_variant_proportion_df = data.frame(TwoEpochC_rare_variant_proportion,
#   TwoEpochE_rare_variant_proportion,
#   ThreeEpochB_rare_variant_proportion,
#   ThreeEpochC_rare_variant_proportion,
#   ThreeEpochE_rare_variant_proportion,
#   snm_rare_variant_proportion)
# 
# rare_variant_proportion_df$sample_size = seq(from=10, to=800, by=10)
# 
# ggplot(data=rare_variant_proportion_df, aes(x=sample_size, y=TwoEpochC_rare_variant_proportion, color='Two Epoch Contraction')) + geom_line(linewidth=2) +
#   geom_line(aes(x=sample_size, y=TwoEpochE_rare_variant_proportion, color='Two Epoch Expansion'), linewidth=2) +
#   geom_line(aes(x=sample_size, y=ThreeEpochB_rare_variant_proportion, color='Three Epoch Bottleneck'), linewidth=2) +
#   geom_line(aes(x=sample_size, y=ThreeEpochC_rare_variant_proportion, color='Three Epoch Contraction'), linewidth=2) +
#   geom_line(aes(x=sample_size, y=ThreeEpochE_rare_variant_proportion, color='Three Epoch Expansion'), linewidth=2) +
#   geom_line(aes(x=sample_size, y=snm_rare_variant_proportion, color='Standard Neutral Model'), linewidth=2) +
#   scale_color_manual(name='Simulated Demographic Scenario',
#                      breaks=c('Two Epoch Contraction',
#                        'Two Epoch Expansion',
#                        'Three Epoch Bottleneck',
#                        'Three Epoch Contraction',
#                        'Three Epoch Expansion',
#                        'Standard Neutral Model'),
#                      values=c('Two Epoch Contraction'='#a50026',
#                        'Two Epoch Expansion'='#f46d43',
#                        'Three Epoch Bottleneck'='#fee090',
#                        'Three Epoch Contraction'='#74add1',
#                        'Three Epoch Expansion'='#313695',
#                        'Standard Neutral Model'='black')) +
#   theme_bw() +
#   ylab("Proportion of singletons") +
#   xlab('Sample Size') +
#   scale_x_log10() +
#   ggtitle("Proportion of SFS comprised of rare variants over sample size for simulated demographic histories")
# 
# ## Compute statistics for lynch simulations
# 
# k5_bottleneck_singletons = c()
# k5_bottleneck_singleton_proportion = c()
# 
# for (i in 1:1000) {
#   file_iter = paste0("k5_bottleneck_", i)
#   file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
#   k5_bottleneck_singletons = c(k5_bottleneck_singletons, read_unfolded_input_sfs(file_path)[1])
#   k5_bottleneck_singleton_proportion = c(k5_bottleneck_singleton_proportion, 
#     read_unfolded_input_sfs(file_path)[1] / sum(read_unfolded_input_sfs(file_path)))
# }
# 
# k5_contraction_singletons = c()
# k5_contraction_singleton_proportion = c()
# 
# for (i in 1:1000) {
#   file_iter = paste0("k5_contraction_", i)
#   file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
#   k5_contraction_singletons = c(k5_contraction_singletons, read_unfolded_input_sfs(file_path)[1])
#   k5_contraction_singleton_proportion = c(k5_contraction_singleton_proportion, 
#     read_unfolded_input_sfs(file_path)[1] / sum(read_unfolded_input_sfs(file_path)))  
# }
# 
# k5_expansion_singletons = c()
# k5_expansion_singleton_proportion = c()
# 
# for (i in 1:1000) {
#   file_iter = paste0("k5_expansion_", i)
#   file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
#   k5_expansion_singletons = c(k5_expansion_singletons, read_unfolded_input_sfs(file_path)[1])
#   k5_expansion_singleton_proportion = c(k5_expansion_singleton_proportion, 
#     read_unfolded_input_sfs(file_path)[1] / sum(read_unfolded_input_sfs(file_path)))
# }
# 
# k5_snm_singletons = c()
# k5_snm_singleton_proportion = c()
# 
# for (i in 1:1000) {
#   file_iter = paste0("k5_snm_", i)
#   file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
#   k5_snm_singletons = c(k5_snm_singletons, read_unfolded_input_sfs(file_path)[1])
#   k5_snm_singleton_proportion = c(k5_snm_singleton_proportion, 
#     read_unfolded_input_sfs(file_path)[1] / sum(read_unfolded_input_sfs(file_path)))
# }
# 
# k5_singleton_df = melt(data.frame(k5_bottleneck_singletons,
#   k5_contraction_singletons,
#   k5_expansion_singletons,
#   k5_snm_singletons))
# 
# k5_proportion_df = melt(data.frame(k5_bottleneck_singleton_proportion,
#   k5_contraction_singleton_proportion,
#   k5_expansion_singleton_proportion,
#   k5_snm_singleton_proportion))
# 
# 
# # ggplot(k5_singleton_df, aes(x=value, y=variable)) + geom_violin(aes(fill=variable)) + theme_bw() +
# #   geom_boxplot(width=0.2) +
# #   xlab('Number of singletons') +
# #   ylab('Simulation') +
# #   theme(legend.title=element_blank()) + 
# #   guides(fill="none")
# # 
# # ggplot(k5_proportion_df, aes(x=value, y=variable)) + geom_violin(aes(fill=variable)) + theme_bw() +
# #   geom_boxplot(width=0.2) +
# #   xlab('Proportion of singletons') +
# #   ylab('Simulation') +
# #   theme(legend.title=element_blank()) + 
# #   guides(fill="none")
# 
# # Doubletons
# 
# k5_bottleneck_doubletons = c()
# k5_bottleneck_doubleton_proportion = c()
# 
# for (i in 1:1000) {
#   file_iter = paste0("k5_bottleneck_", i)
#   file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
#   k5_bottleneck_doubletons = c(k5_bottleneck_doubletons, read_unfolded_input_sfs(file_path)[2])
#   k5_bottleneck_doubleton_proportion = c(k5_bottleneck_doubleton_proportion, 
#     read_unfolded_input_sfs(file_path)[2] / sum(read_unfolded_input_sfs(file_path)))
# }
# 
# k5_contraction_doubletons = c()
# k5_contraction_doubleton_proportion = c()
# 
# for (i in 1:1000) {
#   file_iter = paste0("k5_contraction_", i)
#   file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
#   k5_contraction_doubletons = c(k5_contraction_doubletons, read_unfolded_input_sfs(file_path)[2])
#   k5_contraction_doubleton_proportion = c(k5_contraction_doubleton_proportion, 
#     read_unfolded_input_sfs(file_path)[2] / sum(read_unfolded_input_sfs(file_path)))  
# }
# 
# k5_expansion_doubletons = c()
# k5_expansion_doubleton_proportion = c()
# 
# for (i in 1:1000) {
#   file_iter = paste0("k5_expansion_", i)
#   file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
#   k5_expansion_doubletons = c(k5_expansion_doubletons, read_unfolded_input_sfs(file_path)[2])
#   k5_expansion_doubleton_proportion = c(k5_expansion_doubleton_proportion, 
#     read_unfolded_input_sfs(file_path)[2] / sum(read_unfolded_input_sfs(file_path)))
# }
# 
# k5_snm_doubletons = c()
# k5_snm_doubleton_proportion = c()
# 
# for (i in 1:1000) {
#   file_iter = paste0("k5_snm_", i)
#   file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
#   k5_snm_doubletons = c(k5_snm_doubletons, read_unfolded_input_sfs(file_path)[2])
#   k5_snm_doubleton_proportion = c(k5_snm_doubleton_proportion, 
#     read_unfolded_input_sfs(file_path)[2] / sum(read_unfolded_input_sfs(file_path)))
# }
# 
# k5_doubleton_df = melt(data.frame(k5_bottleneck_doubletons,
#   k5_contraction_doubletons,
#   k5_expansion_doubletons,
#   k5_snm_doubletons))
# 
# k10_bottleneck_singletons = c()
# k10_bottleneck_singleton_proportion = c()
# 
# for (i in 1:1000) {
#   file_iter = paste0("k10_bottleneck_", i)
#   file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
#   k10_bottleneck_singletons = c(k10_bottleneck_singletons, read_unfolded_input_sfs(file_path)[1])
#   k10_bottleneck_singleton_proportion = c(k10_bottleneck_singleton_proportion, 
#     read_unfolded_input_sfs(file_path)[1] / sum(read_unfolded_input_sfs(file_path)))
# }
# 
# k10_contraction_singletons = c()
# k10_contraction_singleton_proportion = c()
# 
# for (i in 1:1000) {
#   file_iter = paste0("k10_contraction_", i)
#   file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
#   k10_contraction_singletons = c(k10_contraction_singletons, read_unfolded_input_sfs(file_path)[1])
#   k10_contraction_singleton_proportion = c(k10_contraction_singleton_proportion, 
#     read_unfolded_input_sfs(file_path)[1] / sum(read_unfolded_input_sfs(file_path)))  
# }
# 
# k10_expansion_singletons = c()
# k10_expansion_singleton_proportion = c()
# 
# for (i in 1:1000) {
#   file_iter = paste0("k10_expansion_", i)
#   file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
#   k10_expansion_singletons = c(k10_expansion_singletons, read_unfolded_input_sfs(file_path)[1])
#   k10_expansion_singleton_proportion = c(k10_expansion_singleton_proportion, 
#     read_unfolded_input_sfs(file_path)[1] / sum(read_unfolded_input_sfs(file_path)))
# }
# 
# k10_snm_singletons = c()
# k10_snm_singleton_proportion = c()
# 
# for (i in 1:1000) {
#   file_iter = paste0("k10_snm_", i)
#   file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
#   k10_snm_singletons = c(k10_snm_singletons, read_unfolded_input_sfs(file_path)[1])
#   k10_snm_singleton_proportion = c(k10_snm_singleton_proportion, 
#     read_unfolded_input_sfs(file_path)[1] / sum(read_unfolded_input_sfs(file_path)))
# }
# 
# k10_singleton_df = melt(data.frame(k10_bottleneck_singletons,
#   k10_contraction_singletons,
#   k10_expansion_singletons,
#   k10_snm_singletons))
# 
# k10_proportion_df = melt(data.frame(k10_bottleneck_singleton_proportion,
#   k10_contraction_singleton_proportion,
#   k10_expansion_singleton_proportion,
#   k10_snm_singleton_proportion))
# 
# 
# # ggplot(k10_singleton_df, aes(x=value, y=variable)) + geom_violin(aes(fill=variable)) + theme_bw() +
# #   geom_boxplot(width=0.2) +
# #   xlab('Number of singletons') +
# #   ylab('Simulation') +
# #   theme(legend.title=element_blank()) + 
# #   guides(fill="none")
# # 
# # ggplot(k10_proportion_df, aes(x=value, y=variable)) + geom_violin(aes(fill=variable)) + theme_bw() +
# #   geom_boxplot(width=0.2) +
# #   xlab('Proportion of singletons') +
# #   ylab('Simulation') +
# #   theme(legend.title=element_blank()) + 
# #   guides(fill="none")
# 
# # Doubletons
# 
# k10_bottleneck_doubletons = c()
# k10_bottleneck_doubleton_proportion = c()
# 
# for (i in 1:1000) {
#   file_iter = paste0("k10_bottleneck_", i)
#   file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
#   k10_bottleneck_doubletons = c(k10_bottleneck_doubletons, read_unfolded_input_sfs(file_path)[2])
#   k10_bottleneck_doubleton_proportion = c(k10_bottleneck_doubleton_proportion, 
#     read_unfolded_input_sfs(file_path)[2] / sum(read_unfolded_input_sfs(file_path)))
# }
# 
# k10_contraction_doubletons = c()
# k10_contraction_doubleton_proportion = c()
# 
# for (i in 1:1000) {
#   file_iter = paste0("k10_contraction_", i)
#   file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
#   k10_contraction_doubletons = c(k10_contraction_doubletons, read_unfolded_input_sfs(file_path)[2])
#   k10_contraction_doubleton_proportion = c(k10_contraction_doubleton_proportion, 
#     read_unfolded_input_sfs(file_path)[2] / sum(read_unfolded_input_sfs(file_path)))  
# }
# 
# k10_expansion_doubletons = c()
# k10_expansion_doubleton_proportion = c()
# 
# for (i in 1:1000) {
#   file_iter = paste0("k10_expansion_", i)
#   file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
#   k10_expansion_doubletons = c(k10_expansion_doubletons, read_unfolded_input_sfs(file_path)[2])
#   k10_expansion_doubleton_proportion = c(k10_expansion_doubleton_proportion, 
#     read_unfolded_input_sfs(file_path)[2] / sum(read_unfolded_input_sfs(file_path)))
# }
# 
# k10_snm_doubletons = c()
# k10_snm_doubleton_proportion = c()
# 
# for (i in 1:1000) {
#   file_iter = paste0("k10_snm_", i)
#   file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
#   k10_snm_doubletons = c(k10_snm_doubletons, read_unfolded_input_sfs(file_path)[2])
#   k10_snm_doubleton_proportion = c(k10_snm_doubleton_proportion, 
#     read_unfolded_input_sfs(file_path)[2] / sum(read_unfolded_input_sfs(file_path)))
# }
# 
# k10_doubleton_df = melt(data.frame(k10_bottleneck_doubletons,
#   k10_contraction_doubletons,
#   k10_expansion_doubletons,
#   k10_snm_doubletons))
# 
# k15_bottleneck_singletons = c()
# k15_bottleneck_singleton_proportion = c()
# 
# for (i in 1:1000) {
#   file_iter = paste0("k15_bottleneck_", i)
#   file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
#   k15_bottleneck_singletons = c(k15_bottleneck_singletons, read_unfolded_input_sfs(file_path)[1])
#   k15_bottleneck_singleton_proportion = c(k15_bottleneck_singleton_proportion, 
#     read_unfolded_input_sfs(file_path)[1] / sum(read_unfolded_input_sfs(file_path)))
# }
# 
# k15_contraction_singletons = c()
# k15_contraction_singleton_proportion = c()
# 
# for (i in 1:1000) {
#   file_iter = paste0("k15_contraction_", i)
#   file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
#   k15_contraction_singletons = c(k15_contraction_singletons, read_unfolded_input_sfs(file_path)[1])
#   k15_contraction_singleton_proportion = c(k15_contraction_singleton_proportion, 
#     read_unfolded_input_sfs(file_path)[1] / sum(read_unfolded_input_sfs(file_path)))  
# }
# 
# k15_expansion_singletons = c()
# k15_expansion_singleton_proportion = c()
# 
# for (i in 1:1000) {
#   file_iter = paste0("k15_expansion_", i)
#   file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
#   k15_expansion_singletons = c(k15_expansion_singletons, read_unfolded_input_sfs(file_path)[1])
#   k15_expansion_singleton_proportion = c(k15_expansion_singleton_proportion, 
#     read_unfolded_input_sfs(file_path)[1] / sum(read_unfolded_input_sfs(file_path)))
# }
# 
# k15_snm_singletons = c()
# k15_snm_singleton_proportion = c()
# 
# for (i in 1:1000) {
#   file_iter = paste0("k15_snm_", i)
#   file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
#   k15_snm_singletons = c(k15_snm_singletons, read_unfolded_input_sfs(file_path)[1])
#   k15_snm_singleton_proportion = c(k15_snm_singleton_proportion, 
#     read_unfolded_input_sfs(file_path)[1] / sum(read_unfolded_input_sfs(file_path)))
# }
# 
# k15_singleton_df = melt(data.frame(k15_bottleneck_singletons,
#   k15_contraction_singletons,
#   k15_expansion_singletons,
#   k15_snm_singletons))
# 
# k15_proportion_df = melt(data.frame(k15_bottleneck_singleton_proportion,
#   k15_contraction_singleton_proportion,
#   k15_expansion_singleton_proportion,
#   k15_snm_singleton_proportion))
# 
# 
# # ggplot(k15_singleton_df, aes(x=value, y=variable)) + geom_violin(aes(fill=variable)) + theme_bw() +
# #   geom_boxplot(width=0.2) +
# #   xlab('Number of singletons') +
# #   ylab('Simulation') +
# #   theme(legend.title=element_blank()) + 
# #   guides(fill="none")
# # 
# # ggplot(k15_proportion_df, aes(x=value, y=variable)) + geom_violin(aes(fill=variable)) + theme_bw() +
# #   geom_boxplot(width=0.2) +
# #   xlab('Proportion of singletons') +
# #   ylab('Simulation') +
# #   theme(legend.title=element_blank()) + 
# #   guides(fill="none")
# 
# # Doubletons
# 
# k15_bottleneck_doubletons = c()
# k15_bottleneck_doubleton_proportion = c()
# 
# for (i in 1:1000) {
#   file_iter = paste0("k15_bottleneck_", i)
#   file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
#   k15_bottleneck_doubletons = c(k15_bottleneck_doubletons, read_unfolded_input_sfs(file_path)[2])
#   k15_bottleneck_doubleton_proportion = c(k15_bottleneck_doubleton_proportion, 
#     read_unfolded_input_sfs(file_path)[2] / sum(read_unfolded_input_sfs(file_path)))
# }
# 
# k15_contraction_doubletons = c()
# k15_contraction_doubleton_proportion = c()
# 
# for (i in 1:1000) {
#   file_iter = paste0("k15_contraction_", i)
#   file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
#   k15_contraction_doubletons = c(k15_contraction_doubletons, read_unfolded_input_sfs(file_path)[2])
#   k15_contraction_doubleton_proportion = c(k15_contraction_doubleton_proportion, 
#     read_unfolded_input_sfs(file_path)[2] / sum(read_unfolded_input_sfs(file_path)))  
# }
# 
# k15_expansion_doubletons = c()
# k15_expansion_doubleton_proportion = c()
# 
# for (i in 1:1000) {
#   file_iter = paste0("k15_expansion_", i)
#   file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
#   k15_expansion_doubletons = c(k15_expansion_doubletons, read_unfolded_input_sfs(file_path)[2])
#   k15_expansion_doubleton_proportion = c(k15_expansion_doubleton_proportion, 
#     read_unfolded_input_sfs(file_path)[2] / sum(read_unfolded_input_sfs(file_path)))
# }
# 
# k15_snm_doubletons = c()
# k15_snm_doubleton_proportion = c()
# 
# for (i in 1:1000) {
#   file_iter = paste0("k15_snm_", i)
#   file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
#   k15_snm_doubletons = c(k15_snm_doubletons, read_unfolded_input_sfs(file_path)[2])
#   k15_snm_doubleton_proportion = c(k15_snm_doubleton_proportion, 
#     read_unfolded_input_sfs(file_path)[2] / sum(read_unfolded_input_sfs(file_path)))
# }
# 
# k15_doubleton_df = melt(data.frame(k15_bottleneck_doubletons,
#   k15_contraction_doubletons,
#   k15_expansion_doubletons,
#   k15_snm_doubletons))
# 
# k20_bottleneck_singletons = c()
# k20_bottleneck_singleton_proportion = c()
# 
# for (i in 1:1000) {
#   file_iter = paste0("k20_bottleneck_", i)
#   file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
#   k20_bottleneck_singletons = c(k20_bottleneck_singletons, read_unfolded_input_sfs(file_path)[1])
#   k20_bottleneck_singleton_proportion = c(k20_bottleneck_singleton_proportion, 
#     read_unfolded_input_sfs(file_path)[1] / sum(read_unfolded_input_sfs(file_path)))
# }
# 
# k20_contraction_singletons = c()
# k20_contraction_singleton_proportion = c()
# 
# for (i in 1:1000) {
#   file_iter = paste0("k20_contraction_", i)
#   file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
#   k20_contraction_singletons = c(k20_contraction_singletons, read_unfolded_input_sfs(file_path)[1])
#   k20_contraction_singleton_proportion = c(k20_contraction_singleton_proportion, 
#     read_unfolded_input_sfs(file_path)[1] / sum(read_unfolded_input_sfs(file_path)))  
# }
# 
# k20_expansion_singletons = c()
# k20_expansion_singleton_proportion = c()
# 
# for (i in 1:1000) {
#   file_iter = paste0("k20_expansion_", i)
#   file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
#   k20_expansion_singletons = c(k20_expansion_singletons, read_unfolded_input_sfs(file_path)[1])
#   k20_expansion_singleton_proportion = c(k20_expansion_singleton_proportion, 
#     read_unfolded_input_sfs(file_path)[1] / sum(read_unfolded_input_sfs(file_path)))
# }
# 
# k20_snm_singletons = c()
# k20_snm_singleton_proportion = c()
# 
# for (i in 1:1000) {
#   file_iter = paste0("k20_snm_", i)
#   file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
#   k20_snm_singletons = c(k20_snm_singletons, read_unfolded_input_sfs(file_path)[1])
#   k20_snm_singleton_proportion = c(k20_snm_singleton_proportion, 
#     read_unfolded_input_sfs(file_path)[1] / sum(read_unfolded_input_sfs(file_path)))
# }
# 
# k20_singleton_df = melt(data.frame(k20_bottleneck_singletons,
#   k20_contraction_singletons,
#   k20_expansion_singletons,
#   k20_snm_singletons))
# 
# k20_proportion_df = melt(data.frame(k20_bottleneck_singleton_proportion,
#   k20_contraction_singleton_proportion,
#   k20_expansion_singleton_proportion,
#   k20_snm_singleton_proportion))
# 
# 
# # ggplot(k20_singleton_df, aes(x=value, y=variable)) + geom_violin(aes(fill=variable)) + theme_bw() +
# #   geom_boxplot(width=0.2) +
# #   xlab('Number of singletons') +
# #   ylab('Simulation') +
# #   theme(legend.title=element_blank()) + 
# #   guides(fill="none")
# # 
# # ggplot(k20_proportion_df, aes(x=value, y=variable)) + geom_violin(aes(fill=variable)) + theme_bw() +
# #   geom_boxplot(width=0.2) +
# #   xlab('Proportion of singletons') +
# #   ylab('Simulation') +
# #   theme(legend.title=element_blank()) + 
# #   guides(fill="none")
# 
# # Doubletons
# 
# k20_bottleneck_doubletons = c()
# k20_bottleneck_doubleton_proportion = c()
# 
# for (i in 1:1000) {
#   file_iter = paste0("k20_bottleneck_", i)
#   file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
#   k20_bottleneck_doubletons = c(k20_bottleneck_doubletons, read_unfolded_input_sfs(file_path)[2])
#   k20_bottleneck_doubleton_proportion = c(k20_bottleneck_doubleton_proportion, 
#     read_unfolded_input_sfs(file_path)[2] / sum(read_unfolded_input_sfs(file_path)))
# }
# 
# k20_contraction_doubletons = c()
# k20_contraction_doubleton_proportion = c()
# 
# for (i in 1:1000) {
#   file_iter = paste0("k20_contraction_", i)
#   file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
#   k20_contraction_doubletons = c(k20_contraction_doubletons, read_unfolded_input_sfs(file_path)[2])
#   k20_contraction_doubleton_proportion = c(k20_contraction_doubleton_proportion, 
#     read_unfolded_input_sfs(file_path)[2] / sum(read_unfolded_input_sfs(file_path)))  
# }
# 
# k20_expansion_doubletons = c()
# k20_expansion_doubleton_proportion = c()
# 
# for (i in 1:1000) {
#   file_iter = paste0("k20_expansion_", i)
#   file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
#   k20_expansion_doubletons = c(k20_expansion_doubletons, read_unfolded_input_sfs(file_path)[2])
#   k20_expansion_doubleton_proportion = c(k20_expansion_doubleton_proportion, 
#     read_unfolded_input_sfs(file_path)[2] / sum(read_unfolded_input_sfs(file_path)))
# }
# 
# k20_snm_doubletons = c()
# k20_snm_doubleton_proportion = c()
# 
# for (i in 1:1000) {
#   file_iter = paste0("k20_snm_", i)
#   file_path = paste0('../Simulations/lynch_singletons/msprime_simulations/', file_iter, '/dadi/pop1.sfs')
#   k20_snm_doubletons = c(k20_snm_doubletons, read_unfolded_input_sfs(file_path)[2])
#   k20_snm_doubleton_proportion = c(k20_snm_doubleton_proportion, 
#     read_unfolded_input_sfs(file_path)[2] / sum(read_unfolded_input_sfs(file_path)))
# }
# 
# k20_doubleton_df = melt(data.frame(k20_bottleneck_doubletons,
#   k20_contraction_doubletons,
#   k20_expansion_doubletons,
#   k20_snm_doubletons))
# 
# k5_singleton_df$sample_size = 'k=5'
# k10_singleton_df$sample_size = 'k=10'
# k15_singleton_df$sample_size = 'k=15'
# k20_singleton_df$sample_size = 'k=20'
# 
# all_msprime_df = rbind(k5_singleton_df,
#   k10_singleton_df,
#   k15_singleton_df,
#   k20_singleton_df)
# 
# all_msprime_df <- all_msprime_df %>%
#   mutate(variable = str_replace(variable, "_bottleneck_singletons$", " bottleneck"))
#   
# all_msprime_df <- all_msprime_df %>%
#   mutate(variable = str_replace(variable, "_contraction_singletons$", " contraction"))
#   
# all_msprime_df <- all_msprime_df %>%
#   mutate(variable = str_replace(variable, "_expansion_singletons$", " expansion"))
#   
# all_msprime_df <- all_msprime_df %>%
#   mutate(variable = str_replace(variable, "_snm_singletons$", " snm"))
# 
# desired_order <- c("k5 bottleneck", "k10 bottleneck", "k15 bottleneck", "k20 bottleneck",
#   "k5 contraction", "k10 contraction", "k15 contraction", "k20 contraction", 
#   "k5 expansion", "k10 expansion", "k15 expansion", "k20 expansion", 
#   "k5 snm", "k10 snm", "k15 snm", "k20 snm")
# 
# all_msprime_df <- all_msprime_df %>%
#   mutate(variable = factor(variable, levels = desired_order))
# 
# all_msprime_df$variable = fct_rev(all_msprime_df$variable)
# 
# ggplot(all_msprime_df, aes(x=value, y=variable, fill=sample_size)) + geom_violin(aes(fill=sample_size)) + theme_bw() +
#   geom_boxplot(width=0.1, fill='white') +
#   xlab('Number of singletons') +
#   ylab('Simulation') +
#   theme(legend.title=element_blank()) +
#   ggtitle('Number of singletons by simulation and sample size')
# 
# k5_proportion_df$sample_size = 'k=5'
# k10_proportion_df$sample_size = 'k=10'
# k15_proportion_df$sample_size = 'k=15'
# k20_proportion_df$sample_size = 'k=20'
# 
# all_msprime_proportion_df = rbind(k5_proportion_df,
#   k10_proportion_df,
#   k15_proportion_df,
#   k20_proportion_df)
# 
# all_msprime_proportion_df <- all_msprime_proportion_df %>%
#   mutate(variable = str_replace(variable, "_bottleneck_singleton_proportion$", " bottleneck"))
#   
# all_msprime_proportion_df <- all_msprime_proportion_df %>%
#   mutate(variable = str_replace(variable, "_contraction_singleton_proportion$", " contraction"))
#   
# all_msprime_proportion_df <- all_msprime_proportion_df %>%
#   mutate(variable = str_replace(variable, "_expansion_singleton_proportion$", " expansion"))
#   
# all_msprime_proportion_df <- all_msprime_proportion_df %>%
#   mutate(variable = str_replace(variable, "_snm_singleton_proportion$", " snm"))
# 
# all_msprime_proportion_df <- all_msprime_proportion_df %>%
#   mutate(variable = factor(variable, levels = desired_order))
# 
# all_msprime_proportion_df$variable = fct_rev(all_msprime_proportion_df$variable)
# 
# ggplot(all_msprime_proportion_df, aes(x=value, y=variable, fill=sample_size)) + geom_violin(aes(fill=sample_size)) + theme_bw() +
#   geom_boxplot(width=0.1, fill='white') +
#   xlab('Proportion of singletons') +
#   ylab('Simulation') +
#   theme(legend.title=element_blank()) +
#   ggtitle('Proportion of singletons by simulation and sample size')
# 
# ggplot(k5_doubleton_df, aes(x=value, y=variable)) + geom_violin(aes(fill=variable)) + theme_bw() +
#   geom_boxplot(width=0.1) +
#   xlab('Number of doubletons') +
#   ylab('Simulation') +
#   theme(legend.title=element_blank()) +
#   guides(fill="none")

## Compute_optimal_sample size vs. msprime

one_epoch_10_SFS = sfs_from_demography('../Analysis/TwoEpochContraction_10/one_epoch_demography.txt')
one_epoch_20_SFS = sfs_from_demography('../Analysis/TwoEpochContraction_20/one_epoch_demography.txt')
one_epoch_30_SFS = sfs_from_demography('../Analysis/TwoEpochContraction_30/one_epoch_demography.txt')
one_epoch_40_SFS = sfs_from_demography('../Analysis/TwoEpochContraction_40/one_epoch_demography.txt')
one_epoch_50_SFS = sfs_from_demography('../Analysis/TwoEpochContraction_50/one_epoch_demography.txt')
one_epoch_60_SFS = sfs_from_demography('../Analysis/TwoEpochContraction_60/one_epoch_demography.txt')
one_epoch_70_SFS = sfs_from_demography('../Analysis/TwoEpochContraction_70/one_epoch_demography.txt')
one_epoch_80_SFS = sfs_from_demography('../Analysis/TwoEpochContraction_80/one_epoch_demography.txt')
one_epoch_90_SFS = sfs_from_demography('../Analysis/TwoEpochContraction_90/one_epoch_demography.txt')
one_epoch_100_SFS = sfs_from_demography('../Analysis/TwoEpochContraction_100/one_epoch_demography.txt')

TwoEpochC_10_dadi_projection_SFS = read_input_sfs('../Analysis/TwoEpochContraction_10/syn_downsampled_sfs.txt')
TwoEpochE_10_dadi_projection_SFS = read_input_sfs('../Analysis/TwoEpochExpansion_10/syn_downsampled_sfs.txt')
ThreeEpochC_10_dadi_projection_SFS = read_input_sfs('../Analysis/ThreeEpochContraction_10/syn_downsampled_sfs.txt')
ThreeEpochE_10_dadi_projection_SFS = read_input_sfs('../Analysis/ThreeEpochExpansion_10/syn_downsampled_sfs.txt')
ThreeEpochB_10_dadi_projection_SFS = read_input_sfs('../Analysis/ThreeEpochBottleneck_10/syn_downsampled_sfs.txt')

TwoEpochC_20_dadi_projection_SFS = read_input_sfs('../Analysis/TwoEpochContraction_20/syn_downsampled_sfs.txt')
TwoEpochE_20_dadi_projection_SFS = read_input_sfs('../Analysis/TwoEpochExpansion_20/syn_downsampled_sfs.txt')
ThreeEpochC_20_dadi_projection_SFS = read_input_sfs('../Analysis/ThreeEpochContraction_20/syn_downsampled_sfs.txt')
ThreeEpochE_20_dadi_projection_SFS = read_input_sfs('../Analysis/ThreeEpochExpansion_20/syn_downsampled_sfs.txt')
ThreeEpochB_20_dadi_projection_SFS = read_input_sfs('../Analysis/ThreeEpochBottleneck_20/syn_downsampled_sfs.txt')

TwoEpochC_30_dadi_projection_SFS = read_input_sfs('../Analysis/TwoEpochContraction_30/syn_downsampled_sfs.txt')
TwoEpochE_30_dadi_projection_SFS = read_input_sfs('../Analysis/TwoEpochExpansion_30/syn_downsampled_sfs.txt')
ThreeEpochC_30_dadi_projection_SFS = read_input_sfs('../Analysis/ThreeEpochContraction_30/syn_downsampled_sfs.txt')
ThreeEpochE_30_dadi_projection_SFS = read_input_sfs('../Analysis/ThreeEpochExpansion_30/syn_downsampled_sfs.txt')
ThreeEpochB_30_dadi_projection_SFS = read_input_sfs('../Analysis/ThreeEpochBottleneck_30/syn_downsampled_sfs.txt')

TwoEpochC_40_dadi_projection_SFS = read_input_sfs('../Analysis/TwoEpochContraction_40/syn_downsampled_sfs.txt')
TwoEpochE_40_dadi_projection_SFS = read_input_sfs('../Analysis/TwoEpochExpansion_40/syn_downsampled_sfs.txt')
ThreeEpochC_40_dadi_projection_SFS = read_input_sfs('../Analysis/ThreeEpochContraction_40/syn_downsampled_sfs.txt')
ThreeEpochE_40_dadi_projection_SFS = read_input_sfs('../Analysis/ThreeEpochExpansion_40/syn_downsampled_sfs.txt')
ThreeEpochB_40_dadi_projection_SFS = read_input_sfs('../Analysis/ThreeEpochBottleneck_40/syn_downsampled_sfs.txt')

TwoEpochC_50_dadi_projection_SFS = read_input_sfs('../Analysis/TwoEpochContraction_50/syn_downsampled_sfs.txt')
TwoEpochE_50_dadi_projection_SFS = read_input_sfs('../Analysis/TwoEpochExpansion_50/syn_downsampled_sfs.txt')
ThreeEpochC_50_dadi_projection_SFS = read_input_sfs('../Analysis/ThreeEpochContraction_50/syn_downsampled_sfs.txt')
ThreeEpochE_50_dadi_projection_SFS = read_input_sfs('../Analysis/ThreeEpochExpansion_50/syn_downsampled_sfs.txt')
ThreeEpochB_50_dadi_projection_SFS = read_input_sfs('../Analysis/ThreeEpochBottleneck_50/syn_downsampled_sfs.txt')

TwoEpochC_60_dadi_projection_SFS = read_input_sfs('../Analysis/TwoEpochContraction_60/syn_downsampled_sfs.txt')
TwoEpochE_60_dadi_projection_SFS = read_input_sfs('../Analysis/TwoEpochExpansion_60/syn_downsampled_sfs.txt')
ThreeEpochC_60_dadi_projection_SFS = read_input_sfs('../Analysis/ThreeEpochContraction_60/syn_downsampled_sfs.txt')
ThreeEpochE_60_dadi_projection_SFS = read_input_sfs('../Analysis/ThreeEpochExpansion_60/syn_downsampled_sfs.txt')
ThreeEpochB_60_dadi_projection_SFS = read_input_sfs('../Analysis/ThreeEpochBottleneck_60/syn_downsampled_sfs.txt')

TwoEpochC_70_dadi_projection_SFS = read_input_sfs('../Analysis/TwoEpochContraction_70/syn_downsampled_sfs.txt')
TwoEpochE_70_dadi_projection_SFS = read_input_sfs('../Analysis/TwoEpochExpansion_70/syn_downsampled_sfs.txt')
ThreeEpochC_70_dadi_projection_SFS = read_input_sfs('../Analysis/ThreeEpochContraction_70/syn_downsampled_sfs.txt')
ThreeEpochE_70_dadi_projection_SFS = read_input_sfs('../Analysis/ThreeEpochExpansion_70/syn_downsampled_sfs.txt')
ThreeEpochB_70_dadi_projection_SFS = read_input_sfs('../Analysis/ThreeEpochBottleneck_70/syn_downsampled_sfs.txt')

TwoEpochC_80_dadi_projection_SFS = read_input_sfs('../Analysis/TwoEpochContraction_80/syn_downsampled_sfs.txt')
TwoEpochE_80_dadi_projection_SFS = read_input_sfs('../Analysis/TwoEpochExpansion_80/syn_downsampled_sfs.txt')
ThreeEpochC_80_dadi_projection_SFS = read_input_sfs('../Analysis/ThreeEpochContraction_80/syn_downsampled_sfs.txt')
ThreeEpochE_80_dadi_projection_SFS = read_input_sfs('../Analysis/ThreeEpochExpansion_80/syn_downsampled_sfs.txt')
ThreeEpochB_80_dadi_projection_SFS = read_input_sfs('../Analysis/ThreeEpochBottleneck_80/syn_downsampled_sfs.txt')

TwoEpochC_90_dadi_projection_SFS = read_input_sfs('../Analysis/TwoEpochContraction_90/syn_downsampled_sfs.txt')
TwoEpochE_90_dadi_projection_SFS = read_input_sfs('../Analysis/TwoEpochExpansion_90/syn_downsampled_sfs.txt')
ThreeEpochC_90_dadi_projection_SFS = read_input_sfs('../Analysis/ThreeEpochContraction_90/syn_downsampled_sfs.txt')
ThreeEpochE_90_dadi_projection_SFS = read_input_sfs('../Analysis/ThreeEpochExpansion_90/syn_downsampled_sfs.txt')
ThreeEpochB_90_dadi_projection_SFS = read_input_sfs('../Analysis/ThreeEpochBottleneck_90/syn_downsampled_sfs.txt')

TwoEpochC_100_dadi_projection_SFS = read_input_sfs('../Analysis/TwoEpochContraction_100/syn_downsampled_sfs.txt')
TwoEpochE_100_dadi_projection_SFS = read_input_sfs('../Analysis/TwoEpochExpansion_100/syn_downsampled_sfs.txt')
ThreeEpochC_100_dadi_projection_SFS = read_input_sfs('../Analysis/ThreeEpochContraction_100/syn_downsampled_sfs.txt')
ThreeEpochE_100_dadi_projection_SFS = read_input_sfs('../Analysis/ThreeEpochExpansion_100/syn_downsampled_sfs.txt')
ThreeEpochB_100_dadi_projection_SFS = read_input_sfs('../Analysis/ThreeEpochBottleneck_100/syn_downsampled_sfs.txt')

TwoEpochC_10_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/TwoEpochContraction_10_concat.sfs')
TwoEpochE_10_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/TwoEpochExpansion_10_concat.sfs')
ThreeEpochC_10_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/ThreeEpochContraction_10_concat.sfs')
ThreeEpochE_10_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/ThreeEpochExpansion_10_concat.sfs')
ThreeEpochB_10_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/ThreeEpochBottleneck_10_concat.sfs')

TwoEpochC_20_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/TwoEpochContraction_20_concat.sfs')
TwoEpochE_20_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/TwoEpochExpansion_20_concat.sfs')
ThreeEpochC_20_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/ThreeEpochContraction_20_concat.sfs')
ThreeEpochE_20_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/ThreeEpochExpansion_20_concat.sfs')
ThreeEpochB_20_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/ThreeEpochBottleneck_20_concat.sfs')

TwoEpochC_30_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/TwoEpochContraction_30_concat.sfs')
TwoEpochE_30_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/TwoEpochExpansion_30_concat.sfs')
ThreeEpochC_30_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/ThreeEpochContraction_30_concat.sfs')
ThreeEpochE_30_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/ThreeEpochExpansion_30_concat.sfs')
ThreeEpochB_30_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/ThreeEpochBottleneck_30_concat.sfs')

TwoEpochC_40_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/TwoEpochContraction_40_concat.sfs')
TwoEpochE_40_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/TwoEpochExpansion_40_concat.sfs')
ThreeEpochC_40_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/ThreeEpochContraction_40_concat.sfs')
ThreeEpochE_40_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/ThreeEpochExpansion_40_concat.sfs')
ThreeEpochB_40_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/ThreeEpochBottleneck_40_concat.sfs')

TwoEpochC_50_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/TwoEpochContraction_50_concat.sfs')
TwoEpochE_50_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/TwoEpochExpansion_50_concat.sfs')
ThreeEpochC_50_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/ThreeEpochContraction_50_concat.sfs')
ThreeEpochE_50_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/ThreeEpochExpansion_50_concat.sfs')
ThreeEpochB_50_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/ThreeEpochBottleneck_50_concat.sfs')

TwoEpochC_60_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/TwoEpochContraction_60_concat.sfs')
TwoEpochE_60_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/TwoEpochExpansion_60_concat.sfs')
ThreeEpochC_60_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/ThreeEpochContraction_60_concat.sfs')
ThreeEpochE_60_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/ThreeEpochExpansion_60_concat.sfs')
ThreeEpochB_60_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/ThreeEpochBottleneck_60_concat.sfs')

TwoEpochC_70_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/TwoEpochContraction_70_concat.sfs')
TwoEpochE_70_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/TwoEpochExpansion_70_concat.sfs')
ThreeEpochC_70_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/ThreeEpochContraction_70_concat.sfs')
ThreeEpochE_70_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/ThreeEpochExpansion_70_concat.sfs')
ThreeEpochB_70_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/ThreeEpochBottleneck_70_concat.sfs')

TwoEpochC_80_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/TwoEpochContraction_80_concat.sfs')
TwoEpochE_80_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/TwoEpochExpansion_80_concat.sfs')
ThreeEpochC_80_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/ThreeEpochContraction_80_concat.sfs')
ThreeEpochE_80_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/ThreeEpochExpansion_80_concat.sfs')
ThreeEpochB_80_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/ThreeEpochBottleneck_80_concat.sfs')

TwoEpochC_90_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/TwoEpochContraction_90_concat.sfs')
TwoEpochE_90_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/TwoEpochExpansion_90_concat.sfs')
ThreeEpochC_90_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/ThreeEpochContraction_90_concat.sfs')
ThreeEpochE_90_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/ThreeEpochExpansion_90_concat.sfs')
ThreeEpochB_90_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/ThreeEpochBottleneck_90_concat.sfs')

TwoEpochC_100_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/TwoEpochContraction_100_concat.sfs')
TwoEpochE_100_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/TwoEpochExpansion_100_concat.sfs')
ThreeEpochC_100_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/ThreeEpochContraction_100_concat.sfs')
ThreeEpochE_100_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/ThreeEpochExpansion_100_concat.sfs')
ThreeEpochB_100_msprime_SFS = read_input_sfs('../Simulations/simple_simulations/ThreeEpochBottleneck_100_concat.sfs')

TwoEpochC_10_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/2EpC_11_expected_sfs.txt')
TwoEpochE_10_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/2EpE_11_expected_sfs.txt')
ThreeEpochC_10_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpC_11_expected_sfs.txt')
ThreeEpochE_10_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpE_11_expected_sfs.txt')
ThreeEpochB_10_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpB_11_expected_sfs.txt')
lynch_1000_1000_10_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/1000_1000_bottleneck_11_expected_sfs.txt')
lynch_2000_2000_10_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/2000_2000_bottleneck_11_expected_sfs.txt')

TwoEpochC_20_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/2EpC_21_expected_sfs.txt')
TwoEpochE_20_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/2EpE_21_expected_sfs.txt')
ThreeEpochC_20_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpC_21_expected_sfs.txt')
ThreeEpochE_20_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpE_21_expected_sfs.txt')
ThreeEpochB_20_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpB_21_expected_sfs.txt')
lynch_1000_1000_20_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/1000_1000_bottleneck_21_expected_sfs.txt')
lynch_2000_2000_20_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/2000_2000_bottleneck_21_expected_sfs.txt')

TwoEpochC_30_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/2EpC_31_expected_sfs.txt')
TwoEpochE_30_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/2EpE_31_expected_sfs.txt')
ThreeEpochC_30_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpC_31_expected_sfs.txt')
ThreeEpochE_30_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpE_31_expected_sfs.txt')
ThreeEpochB_30_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpB_31_expected_sfs.txt')
lynch_1000_1000_30_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/1000_1000_bottleneck_31_expected_sfs.txt')
lynch_2000_2000_30_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/2000_2000_bottleneck_31_expected_sfs.txt')

TwoEpochC_40_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/2EpC_41_expected_sfs.txt')
TwoEpochE_40_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/2EpE_41_expected_sfs.txt')
ThreeEpochC_40_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpC_41_expected_sfs.txt')
ThreeEpochE_40_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpE_41_expected_sfs.txt')
ThreeEpochB_40_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpB_41_expected_sfs.txt')
lynch_1000_1000_40_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/1000_1000_bottleneck_41_expected_sfs.txt')
lynch_2000_2000_40_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/2000_2000_bottleneck_41_expected_sfs.txt')

TwoEpochC_50_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/2EpC_51_expected_sfs.txt')
TwoEpochE_50_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/2EpE_51_expected_sfs.txt')
ThreeEpochC_50_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpC_51_expected_sfs.txt')
ThreeEpochE_50_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpE_51_expected_sfs.txt')
ThreeEpochB_50_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpB_51_expected_sfs.txt')
lynch_1000_1000_50_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/1000_1000_bottleneck_51_expected_sfs.txt')
lynch_2000_2000_50_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/2000_2000_bottleneck_51_expected_sfs.txt')

TwoEpochC_60_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/2EpC_61_expected_sfs.txt')
TwoEpochE_60_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/2EpE_61_expected_sfs.txt')
ThreeEpochC_60_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpC_61_expected_sfs.txt')
ThreeEpochE_60_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpE_61_expected_sfs.txt')
ThreeEpochB_60_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpB_61_expected_sfs.txt')
lynch_1000_1000_60_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/1000_1000_bottleneck_61_expected_sfs.txt')
lynch_2000_2000_60_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/2000_2000_bottleneck_61_expected_sfs.txt')

TwoEpochC_70_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/2EpC_71_expected_sfs.txt')
TwoEpochE_70_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/2EpE_71_expected_sfs.txt')
ThreeEpochC_70_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpC_71_expected_sfs.txt')
ThreeEpochE_70_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpE_71_expected_sfs.txt')
ThreeEpochB_70_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpB_71_expected_sfs.txt')
lynch_1000_1000_70_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/1000_1000_bottleneck_71_expected_sfs.txt')
lynch_2000_2000_70_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/2000_2000_bottleneck_71_expected_sfs.txt')

TwoEpochC_80_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/2EpC_81_expected_sfs.txt')
TwoEpochE_80_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/2EpE_81_expected_sfs.txt')
ThreeEpochC_80_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpC_81_expected_sfs.txt')
ThreeEpochE_80_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpE_81_expected_sfs.txt')
ThreeEpochB_80_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpB_81_expected_sfs.txt')
lynch_1000_1000_80_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/1000_1000_bottleneck_81_expected_sfs.txt')
lynch_2000_2000_80_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/2000_2000_bottleneck_81_expected_sfs.txt')

TwoEpochC_90_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/2EpC_91_expected_sfs.txt')
TwoEpochE_90_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/2EpE_91_expected_sfs.txt')
ThreeEpochC_90_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpC_91_expected_sfs.txt')
ThreeEpochE_90_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpE_91_expected_sfs.txt')
ThreeEpochB_90_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpB_91_expected_sfs.txt')
lynch_1000_1000_90_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/1000_1000_bottleneck_91_expected_sfs.txt')
lynch_2000_2000_90_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/2000_2000_bottleneck_91_expected_sfs.txt')

TwoEpochC_100_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/2EpC_101_expected_sfs.txt')
TwoEpochE_100_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/2EpE_101_expected_sfs.txt')
ThreeEpochC_100_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpC_101_expected_sfs.txt')
ThreeEpochE_100_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpE_101_expected_sfs.txt')
ThreeEpochB_100_lynch_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/3EpB_101_expected_sfs.txt')
lynch_1000_1000_100_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/1000_1000_bottleneck_101_expected_sfs.txt')
lynch_2000_2000_100_SFS = read_input_sfs('../Analysis/optimal_sample_size_test/2000_2000_bottleneck_101_expected_sfs.txt')

compare_msprime_dadi_lynch_proportional_sfs(one_epoch_10_SFS, TwoEpochC_10_msprime_SFS, 
    TwoEpochC_10_dadi_projection_SFS, TwoEpochC_10_lynch_SFS) + 
  ggtitle('Two Epoch Contraction, k=10') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_10_SFS, TwoEpochE_10_msprime_SFS,
    TwoEpochE_10_dadi_projection_SFS, TwoEpochE_10_lynch_SFS) + 
  ggtitle('Two Epoch Expansion, k=10') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_10_SFS, ThreeEpochC_10_msprime_SFS,
    ThreeEpochC_10_dadi_projection_SFS, ThreeEpochC_10_lynch_SFS) + 
  ggtitle('Three Epoch Contraction, k=10') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_10_SFS, ThreeEpochE_10_msprime_SFS,
    ThreeEpochE_10_dadi_projection_SFS, ThreeEpochE_10_lynch_SFS) + 
  ggtitle('Three Epoch Expansion, k=10') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_10_SFS, ThreeEpochB_10_msprime_SFS,
    ThreeEpochB_10_dadi_projection_SFS, ThreeEpochB_10_lynch_SFS) + 
  ggtitle('Three Epoch Bottleneck, k=10') +
  plot_layout(nrow=3)

compare_msprime_dadi_lynch_proportional_sfs(one_epoch_20_SFS, TwoEpochC_20_msprime_SFS, 
    TwoEpochC_20_dadi_projection_SFS, TwoEpochC_20_lynch_SFS) + 
  ggtitle('Two Epoch Contraction, k=20') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_20_SFS, TwoEpochE_20_msprime_SFS,
    TwoEpochE_20_dadi_projection_SFS, TwoEpochE_20_lynch_SFS) + 
  ggtitle('Two Epoch Expansion, k=20') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_20_SFS, ThreeEpochC_20_msprime_SFS,
    ThreeEpochC_20_dadi_projection_SFS, ThreeEpochC_20_lynch_SFS) + 
  ggtitle('Three Epoch Contraction, k=20') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_20_SFS, ThreeEpochE_20_msprime_SFS,
    ThreeEpochE_20_dadi_projection_SFS, ThreeEpochE_20_lynch_SFS) + 
  ggtitle('Three Epoch Expansion, k=20') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_20_SFS, ThreeEpochB_20_msprime_SFS,
    ThreeEpochB_20_dadi_projection_SFS, ThreeEpochB_20_lynch_SFS) + 
  ggtitle('Three Epoch Bottleneck, k=20') +
  plot_layout(nrow=3)

compare_msprime_dadi_lynch_proportional_sfs(one_epoch_30_SFS, TwoEpochC_30_msprime_SFS, 
    TwoEpochC_30_dadi_projection_SFS, TwoEpochC_30_lynch_SFS) + 
  ggtitle('Two Epoch Contraction, k=30') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_30_SFS, TwoEpochE_30_msprime_SFS,
    TwoEpochE_30_dadi_projection_SFS, TwoEpochE_30_lynch_SFS) + 
  ggtitle('Two Epoch Expansion, k=30') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_30_SFS, ThreeEpochC_30_msprime_SFS,
    ThreeEpochC_30_dadi_projection_SFS, ThreeEpochC_30_lynch_SFS) + 
  ggtitle('Three Epoch Contraction, k=30') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_30_SFS, ThreeEpochE_30_msprime_SFS,
    ThreeEpochE_30_dadi_projection_SFS, ThreeEpochE_30_lynch_SFS) + 
  ggtitle('Three Epoch Expansion, k=30') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_30_SFS, ThreeEpochB_30_msprime_SFS,
    ThreeEpochB_30_dadi_projection_SFS, ThreeEpochB_30_lynch_SFS) + 
  ggtitle('Three Epoch Bottleneck, k=30') +
  plot_layout(nrow=3)

compare_msprime_dadi_lynch_proportional_sfs(one_epoch_40_SFS, TwoEpochC_40_msprime_SFS, 
    TwoEpochC_40_dadi_projection_SFS, TwoEpochC_40_lynch_SFS) + 
  ggtitle('Two Epoch Contraction, k=40') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_40_SFS, TwoEpochE_40_msprime_SFS,
    TwoEpochE_40_dadi_projection_SFS, TwoEpochE_40_lynch_SFS) + 
  ggtitle('Two Epoch Expansion, k=40') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_40_SFS, ThreeEpochC_40_msprime_SFS,
    ThreeEpochC_40_dadi_projection_SFS, ThreeEpochC_40_lynch_SFS) + 
  ggtitle('Three Epoch Contraction, k=40') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_40_SFS, ThreeEpochE_40_msprime_SFS,
    ThreeEpochE_40_dadi_projection_SFS, ThreeEpochE_40_lynch_SFS) + 
  ggtitle('Three Epoch Expansion, k=40') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_40_SFS, ThreeEpochB_40_msprime_SFS,
    ThreeEpochB_40_dadi_projection_SFS, ThreeEpochB_40_lynch_SFS) + 
  ggtitle('Three Epoch Bottleneck, k=40') +
  plot_layout(nrow=3)

compare_msprime_dadi_lynch_proportional_sfs(one_epoch_50_SFS, TwoEpochC_50_msprime_SFS, 
    TwoEpochC_50_dadi_projection_SFS, TwoEpochC_50_lynch_SFS) + 
  ggtitle('Two Epoch Contraction, k=50') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_50_SFS, TwoEpochE_50_msprime_SFS,
    TwoEpochE_50_dadi_projection_SFS, TwoEpochE_50_lynch_SFS) + 
  ggtitle('Two Epoch Expansion, k=50') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_50_SFS, ThreeEpochC_50_msprime_SFS,
    ThreeEpochC_50_dadi_projection_SFS, ThreeEpochC_50_lynch_SFS) + 
  ggtitle('Three Epoch Contraction, k=50') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_50_SFS, ThreeEpochE_50_msprime_SFS,
    ThreeEpochE_50_dadi_projection_SFS, ThreeEpochE_50_lynch_SFS) + 
  ggtitle('Three Epoch Expansion, k=50') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_50_SFS, ThreeEpochB_50_msprime_SFS,
    ThreeEpochB_50_dadi_projection_SFS, ThreeEpochB_50_lynch_SFS) + 
  ggtitle('Three Epoch Bottleneck, k=50') +
  plot_layout(nrow=3)

compare_msprime_dadi_lynch_proportional_sfs(one_epoch_60_SFS, TwoEpochC_60_msprime_SFS, 
    TwoEpochC_60_dadi_projection_SFS, TwoEpochC_60_lynch_SFS) + 
  ggtitle('Two Epoch Contraction, k=60') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_60_SFS, TwoEpochE_60_msprime_SFS,
    TwoEpochE_60_dadi_projection_SFS, TwoEpochE_60_lynch_SFS) + 
  ggtitle('Two Epoch Expansion, k=60') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_60_SFS, ThreeEpochC_60_msprime_SFS,
    ThreeEpochC_60_dadi_projection_SFS, ThreeEpochC_60_lynch_SFS) + 
  ggtitle('Three Epoch Contraction, k=60') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_60_SFS, ThreeEpochE_60_msprime_SFS,
    ThreeEpochE_60_dadi_projection_SFS, ThreeEpochE_60_lynch_SFS) + 
  ggtitle('Three Epoch Expansion, k=60') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_60_SFS, ThreeEpochB_60_msprime_SFS,
    ThreeEpochB_60_dadi_projection_SFS, ThreeEpochB_60_lynch_SFS) + 
  ggtitle('Three Epoch Bottleneck, k=60') +
  plot_layout(nrow=3)

compare_msprime_dadi_lynch_proportional_sfs(one_epoch_70_SFS, TwoEpochC_70_msprime_SFS, 
    TwoEpochC_70_dadi_projection_SFS, TwoEpochC_70_lynch_SFS) + 
  ggtitle('Two Epoch Contraction, k=70') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_70_SFS, TwoEpochE_70_msprime_SFS,
    TwoEpochE_70_dadi_projection_SFS, TwoEpochE_70_lynch_SFS) + 
  ggtitle('Two Epoch Expansion, k=70') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_70_SFS, ThreeEpochC_70_msprime_SFS,
    ThreeEpochC_70_dadi_projection_SFS, ThreeEpochC_70_lynch_SFS) + 
  ggtitle('Three Epoch Contraction, k=70') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_70_SFS, ThreeEpochE_70_msprime_SFS,
    ThreeEpochE_70_dadi_projection_SFS, ThreeEpochE_70_lynch_SFS) + 
  ggtitle('Three Epoch Expansion, k=70') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_70_SFS, ThreeEpochB_70_msprime_SFS,
    ThreeEpochB_70_dadi_projection_SFS, ThreeEpochB_70_lynch_SFS) + 
  ggtitle('Three Epoch Bottleneck, k=70') +
  plot_layout(nrow=3)

compare_msprime_dadi_lynch_proportional_sfs(one_epoch_80_SFS, TwoEpochC_80_msprime_SFS, 
    TwoEpochC_80_dadi_projection_SFS, TwoEpochC_80_lynch_SFS) + 
  ggtitle('Two Epoch Contraction, k=80') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_80_SFS, TwoEpochE_80_msprime_SFS,
    TwoEpochE_80_dadi_projection_SFS, TwoEpochE_80_lynch_SFS) + 
  ggtitle('Two Epoch Expansion, k=80') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_80_SFS, ThreeEpochC_80_msprime_SFS,
    ThreeEpochC_80_dadi_projection_SFS, ThreeEpochC_80_lynch_SFS) + 
  ggtitle('Three Epoch Contraction, k=80') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_80_SFS, ThreeEpochE_80_msprime_SFS,
    ThreeEpochE_80_dadi_projection_SFS, ThreeEpochE_80_lynch_SFS) + 
  ggtitle('Three Epoch Expansion, k=80') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_80_SFS, ThreeEpochB_80_msprime_SFS,
    ThreeEpochB_80_dadi_projection_SFS, ThreeEpochB_80_lynch_SFS) + 
  ggtitle('Three Epoch Bottleneck, k=80') +
  plot_layout(nrow=3)

compare_msprime_dadi_lynch_proportional_sfs(one_epoch_90_SFS, TwoEpochC_90_msprime_SFS, 
    TwoEpochC_90_dadi_projection_SFS, TwoEpochC_90_lynch_SFS) + 
  ggtitle('Two Epoch Contraction, k=90') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_90_SFS, TwoEpochE_90_msprime_SFS,
    TwoEpochE_90_dadi_projection_SFS, TwoEpochE_90_lynch_SFS) + 
  ggtitle('Two Epoch Expansion, k=90') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_90_SFS, ThreeEpochC_90_msprime_SFS,
    ThreeEpochC_90_dadi_projection_SFS, ThreeEpochC_90_lynch_SFS) + 
  ggtitle('Three Epoch Contraction, k=90') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_90_SFS, ThreeEpochE_90_msprime_SFS,
    ThreeEpochE_90_dadi_projection_SFS, ThreeEpochE_90_lynch_SFS) + 
  ggtitle('Three Epoch Expansion, k=90') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_90_SFS, ThreeEpochB_90_msprime_SFS,
    ThreeEpochB_90_dadi_projection_SFS, ThreeEpochB_90_lynch_SFS) + 
  ggtitle('Three Epoch Bottleneck, k=90') +
  plot_layout(nrow=3)

compare_msprime_dadi_lynch_proportional_sfs(one_epoch_100_SFS, TwoEpochC_100_msprime_SFS, 
    TwoEpochC_100_dadi_projection_SFS, TwoEpochC_100_lynch_SFS) + 
  ggtitle('Two Epoch Contraction, k=100') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_100_SFS, TwoEpochE_100_msprime_SFS,
    TwoEpochE_100_dadi_projection_SFS, TwoEpochE_100_lynch_SFS) + 
  ggtitle('Two Epoch Expansion, k=100') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_100_SFS, ThreeEpochC_100_msprime_SFS,
    ThreeEpochC_100_dadi_projection_SFS, ThreeEpochC_100_lynch_SFS) + 
  ggtitle('Three Epoch Contraction, k=100') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_100_SFS, ThreeEpochE_100_msprime_SFS,
    ThreeEpochE_100_dadi_projection_SFS, ThreeEpochE_100_lynch_SFS) + 
  ggtitle('Three Epoch Expansion, k=100') +
  compare_msprime_dadi_lynch_proportional_sfs(one_epoch_100_SFS, ThreeEpochB_100_msprime_SFS,
    ThreeEpochB_100_dadi_projection_SFS, ThreeEpochB_100_lynch_SFS) + 
  ggtitle('Three Epoch Bottleneck, k=100') +
  plot_layout(nrow=3)

# compare_msprime_dadi_lynch_proportional_sfs_bottleneck(one_epoch_10_SFS, 
#   ThreeEpochB_10_msprime_SFS, ThreeEpochB_10_dadi_projection_SFS, 
#   ThreeEpochB_10_lynch_SFS, lynch_1000_1000_10_SFS, lynch_2000_2000_10_SFS) + 
#   ggtitle('Three Epoch Bottleneck, k=10') +
#   compare_msprime_dadi_lynch_proportional_sfs_bottleneck(one_epoch_20_SFS, 
#   ThreeEpochB_20_msprime_SFS, ThreeEpochB_20_dadi_projection_SFS, 
#   ThreeEpochB_20_lynch_SFS, lynch_1000_1000_20_SFS, lynch_2000_2000_20_SFS) + 
#   ggtitle('Three Epoch Bottleneck, k=20') +
#   compare_msprime_dadi_lynch_proportional_sfs_bottleneck(one_epoch_30_SFS, 
#   ThreeEpochB_30_msprime_SFS, ThreeEpochB_30_dadi_projection_SFS, 
#   ThreeEpochB_30_lynch_SFS, lynch_1000_1000_30_SFS, lynch_2000_2000_30_SFS) + 
#   ggtitle('Three Epoch Bottleneck, k=30') +
#   compare_msprime_dadi_lynch_proportional_sfs_bottleneck(one_epoch_40_SFS, 
#   ThreeEpochB_40_msprime_SFS, ThreeEpochB_40_dadi_projection_SFS, 
#   ThreeEpochB_40_lynch_SFS, lynch_1000_1000_40_SFS, lynch_2000_2000_40_SFS) + 
#   ggtitle('Three Epoch Bottleneck, k=40') +
#   compare_msprime_dadi_lynch_proportional_sfs_bottleneck(one_epoch_50_SFS, 
#   ThreeEpochB_50_msprime_SFS, ThreeEpochB_50_dadi_projection_SFS, 
#   ThreeEpochB_50_lynch_SFS, lynch_1000_1000_50_SFS, lynch_2000_2000_50_SFS) + 
#   ggtitle('Three Epoch Bottleneck, k=50') +
#   compare_msprime_dadi_lynch_proportional_sfs_bottleneck(one_epoch_60_SFS, 
#   ThreeEpochB_60_msprime_SFS, ThreeEpochB_60_dadi_projection_SFS, 
#   ThreeEpochB_60_lynch_SFS, lynch_1000_1000_60_SFS, lynch_2000_2000_60_SFS) + 
#   ggtitle('Three Epoch Bottleneck, k=60') +
#   compare_msprime_dadi_lynch_proportional_sfs_bottleneck(one_epoch_70_SFS, 
#   ThreeEpochB_70_msprime_SFS, ThreeEpochB_70_dadi_projection_SFS, 
#   ThreeEpochB_70_lynch_SFS, lynch_1000_1000_70_SFS, lynch_2000_2000_70_SFS) + 
#   ggtitle('Three Epoch Bottleneck, k=70') +
#   compare_msprime_dadi_lynch_proportional_sfs_bottleneck(one_epoch_80_SFS, 
#   ThreeEpochB_80_msprime_SFS, ThreeEpochB_80_dadi_projection_SFS, 
#   ThreeEpochB_80_lynch_SFS, lynch_1000_1000_80_SFS, lynch_2000_2000_80_SFS) + 
#   ggtitle('Three Epoch Bottleneck, k=80') +
#   compare_msprime_dadi_lynch_proportional_sfs_bottleneck(one_epoch_90_SFS, 
#   ThreeEpochB_90_msprime_SFS, ThreeEpochB_90_dadi_projection_SFS, 
#   ThreeEpochB_90_lynch_SFS, lynch_1000_1000_90_SFS, lynch_2000_2000_90_SFS) + 
#   ggtitle('Three Epoch Bottleneck, k=90') +
#   compare_msprime_dadi_lynch_proportional_sfs_bottleneck(one_epoch_100_SFS, 
#   ThreeEpochB_100_msprime_SFS, ThreeEpochB_100_dadi_projection_SFS, 
#   ThreeEpochB_100_lynch_SFS, lynch_1000_1000_100_SFS, lynch_2000_2000_100_SFS) + 
#   ggtitle('Three Epoch Bottleneck, k=100') +
#   plot_layout(nrow=5)

## Compare Tajima's D

TwoEpochC_dadi_tajima_d = c()
TwoEpochE_dadi_tajima_d = c()
ThreeEpochC_dadi_tajima_d = c()
ThreeEpochE_dadi_tajima_d = c()
ThreeEpochB_dadi_tajima_d = c()

TwoEpochC_msprime_tajima_d = c()
TwoEpochE_msprime_tajima_d = c()
ThreeEpochC_msprime_tajima_d = c()
ThreeEpochE_msprime_tajima_d = c()
ThreeEpochB_msprime_tajima_d = c()

TwoEpochC_lynch_tajima_d = c()
TwoEpochE_lynch_tajima_d = c()
ThreeEpochC_lynch_tajima_d = c()
ThreeEpochE_lynch_tajima_d = c()
ThreeEpochB_lynch_tajima_d = c()


# Loop through subdirectories and get relevant files
for (i in seq(from=10, to=800, by=10)) {
  # Dadi
  subdirectory_dadi_2epC <- paste0("../Analysis/TwoEpochContraction_", i)
  subdirectory_dadi_2epE <- paste0("../Analysis/TwoEpochExpansion_", i)
  subdirectory_dadi_3epB <- paste0("../Analysis/ThreeEpochBottleneck_", i)
  subdirectory_dadi_3epC <- paste0("../Analysis/ThreeEpochContraction_", i)
  subdirectory_dadi_3epE <- paste0("../Analysis/ThreeEpochExpansion_", i)

  TwoEpochC_dadi_summary <- paste0(subdirectory_dadi_2epC, "/summary.txt")
  TwoEpochE_dadi_summary <- paste0(subdirectory_dadi_2epE, "/summary.txt")
  ThreeEpochB_dadi_summary <- paste0(subdirectory_dadi_3epB, "/summary.txt")
  ThreeEpochC_dadi_summary <- paste0(subdirectory_dadi_3epC, "/summary.txt")
  ThreeEpochE_dadi_summary <- paste0(subdirectory_dadi_3epE, "/summary.txt")

  TwoEpochC_dadi_tajima_d = c(TwoEpochC_dadi_tajima_d, read_summary_statistics(TwoEpochC_dadi_summary)[3])
  TwoEpochE_dadi_tajima_d = c(TwoEpochE_dadi_tajima_d, read_summary_statistics(TwoEpochE_dadi_summary)[3])
  ThreeEpochB_dadi_tajima_d = c(ThreeEpochB_dadi_tajima_d, read_summary_statistics(ThreeEpochB_dadi_summary)[3])
  ThreeEpochC_dadi_tajima_d = c(ThreeEpochC_dadi_tajima_d, read_summary_statistics(ThreeEpochC_dadi_summary)[3])
  ThreeEpochE_dadi_tajima_d = c(ThreeEpochE_dadi_tajima_d, read_summary_statistics(ThreeEpochE_dadi_summary)[3])

  # Lynch
  j = i + 1
  subdirectory_lynch_2epC <- paste0("../Analysis/optimal_sample_size_test/2epC_", j)
  subdirectory_lynch_2epE <- paste0("../Analysis/optimal_sample_size_test/2epE_", j)
  subdirectory_lynch_3epB <- paste0("../Analysis/optimal_sample_size_test/3epB_", j)
  subdirectory_lynch_3epC <- paste0("../Analysis/optimal_sample_size_test/3epC_", j)
  subdirectory_lynch_3epE <- paste0("../Analysis/optimal_sample_size_test/3epE_", j)

  TwoEpochC_lynch_summary <- paste0(subdirectory_lynch_2epC, "_summary.txt")
  TwoEpochE_lynch_summary <- paste0(subdirectory_lynch_2epE, "_summary.txt")
  ThreeEpochB_lynch_summary <- paste0(subdirectory_lynch_3epB, "_summary.txt")
  ThreeEpochC_lynch_summary <- paste0(subdirectory_lynch_3epC, "_summary.txt")
  ThreeEpochE_lynch_summary <- paste0(subdirectory_lynch_3epE, "_summary.txt")

  TwoEpochC_lynch_tajima_d = c(TwoEpochC_lynch_tajima_d, read_summary_statistics(TwoEpochC_lynch_summary)[3])
  TwoEpochE_lynch_tajima_d = c(TwoEpochE_lynch_tajima_d, read_summary_statistics(TwoEpochE_lynch_summary)[3])
  ThreeEpochB_lynch_tajima_d = c(ThreeEpochB_lynch_tajima_d, read_summary_statistics(ThreeEpochB_lynch_summary)[3])
  ThreeEpochC_lynch_tajima_d = c(ThreeEpochC_lynch_tajima_d, read_summary_statistics(ThreeEpochC_lynch_summary)[3])
  ThreeEpochE_lynch_tajima_d = c(ThreeEpochE_lynch_tajima_d, read_summary_statistics(ThreeEpochE_lynch_summary)[3])

  # MSPrime
  subdirectory_msprime_2epC <- paste0("../Simulations/simple_simulations/TwoEpochContraction_", i)
  subdirectory_msprime_2epE <- paste0("../Simulations/simple_simulations/TwoEpochExpansion_", i)
  subdirectory_msprime_3epB <- paste0("../Simulations/simple_simulations/ThreeEpochBottleneck_", i)
  subdirectory_msprime_3epC <- paste0("../Simulations/simple_simulations/ThreeEpochContraction_", i)
  subdirectory_msprime_3epE <- paste0("../Simulations/simple_simulations/ThreeEpochExpansion_", i)

  TwoEpochC_msprime_summary <- paste0(subdirectory_msprime_2epC, "_concat_summary.txt")
  TwoEpochE_msprime_summary <- paste0(subdirectory_msprime_2epE, "_concat_summary.txt")
  ThreeEpochB_msprime_summary <- paste0(subdirectory_msprime_3epB, "_concat_summary.txt")
  ThreeEpochC_msprime_summary <- paste0(subdirectory_msprime_3epC, "_concat_summary.txt")
  ThreeEpochE_msprime_summary <- paste0(subdirectory_msprime_3epE, "_concat_summary.txt")

  TwoEpochC_msprime_tajima_d = c(TwoEpochC_msprime_tajima_d, read_summary_statistics(TwoEpochC_msprime_summary)[3])
  TwoEpochE_msprime_tajima_d = c(TwoEpochE_msprime_tajima_d, read_summary_statistics(TwoEpochE_msprime_summary)[3])
  ThreeEpochB_msprime_tajima_d = c(ThreeEpochB_msprime_tajima_d, read_summary_statistics(ThreeEpochB_msprime_summary)[3])
  ThreeEpochC_msprime_tajima_d = c(ThreeEpochC_msprime_tajima_d, read_summary_statistics(ThreeEpochC_msprime_summary)[3])
  ThreeEpochE_msprime_tajima_d = c(ThreeEpochE_msprime_tajima_d, read_summary_statistics(ThreeEpochE_msprime_summary)[3])
}

sample_size_index = seq(10, 800, 10)

TwoEpochC_tajima_d_df = melt(data.frame(
  TwoEpochC_dadi_tajima_d,
  TwoEpochC_msprime_tajima_d,
  TwoEpochC_lynch_tajima_d
))
TwoEpochC_tajima_d_df$sample_size = sample_size_index

TwoEpochE_tajima_d_df = melt(data.frame(
  TwoEpochE_dadi_tajima_d,
  TwoEpochE_msprime_tajima_d,
  TwoEpochE_lynch_tajima_d
))
TwoEpochE_tajima_d_df$sample_size = sample_size_index

ThreeEpochC_tajima_d_df = melt(data.frame(
  ThreeEpochC_dadi_tajima_d,
  ThreeEpochC_msprime_tajima_d,
  ThreeEpochC_lynch_tajima_d
))
ThreeEpochC_tajima_d_df$sample_size = sample_size_index

ThreeEpochE_tajima_d_df = melt(data.frame(
  ThreeEpochE_dadi_tajima_d,
  ThreeEpochE_msprime_tajima_d,
  ThreeEpochE_lynch_tajima_d
))
ThreeEpochE_tajima_d_df$sample_size = sample_size_index

ThreeEpochB_tajima_d_df = melt(data.frame(
  ThreeEpochB_dadi_tajima_d,
  ThreeEpochB_msprime_tajima_d,
  ThreeEpochB_lynch_tajima_d
))
ThreeEpochB_tajima_d_df$sample_size = sample_size_index

ggplot(data=TwoEpochC_tajima_d_df, aes(x=sample_size, y=value, color=variable)) + geom_line(size=2) +
  theme_bw() + guides(color=guide_legend(title="Type of SFS")) +
  xlab('Sample size') +
  ylab("Tajima's D") +
  ggtitle("Tajima's D, Two Epoch Contraction") + 
  scale_colour_manual(
    values = c("TwoEpochC_dadi_tajima_d"='red', 
      "TwoEpochC_msprime_tajima_d"='blue', 
      "TwoEpochC_lynch_tajima_d"='green'),
    labels = c("Dadi", "MSPrime", "Lynch Theory")
  ) +
  geom_hline(yintercept = 0, size = 2, linetype = 'dashed')

ggplot(data=TwoEpochE_tajima_d_df, aes(x=sample_size, y=value, color=variable)) + geom_line(size=2) +
  theme_bw() + guides(color=guide_legend(title="Type of SFS")) +
  xlab('Sample size') +
  ylab("Tajima's D") +
  ggtitle("Tajima's D, Two Epoch Expansion") + 
  scale_colour_manual(
    values = c("TwoEpochE_dadi_tajima_d"='red', 
      "TwoEpochE_msprime_tajima_d"='blue', 
      "TwoEpochE_lynch_tajima_d"='green'),
    labels = c("Dadi", "MSPrime", "Lynch Theory")
  ) +
  geom_hline(yintercept = 0, size = 2, linetype = 'dashed')

ggplot(data=ThreeEpochC_tajima_d_df, aes(x=sample_size, y=value, color=variable)) + geom_line(size=2) +
  theme_bw() + guides(color=guide_legend(title="Type of SFS")) +
  xlab('Sample size') +
  ylab("Tajima's D") +
  ggtitle("Tajima's D, Three Epoch Contraction") + 
  scale_colour_manual(
    values = c("ThreeEpochC_dadi_tajima_d"='red', 
      "ThreeEpochC_msprime_tajima_d"='blue', 
      "ThreeEpochC_lynch_tajima_d"='green'),
    labels = c("Dadi", "MSPrime", "Lynch Theory")
  ) +
  geom_hline(yintercept = 0, size = 2, linetype = 'dashed')

ggplot(data=ThreeEpochE_tajima_d_df, aes(x=sample_size, y=value, color=variable)) + geom_line(size=2) +
  theme_bw() + guides(color=guide_legend(title="Type of SFS")) +
  xlab('Sample size') +
  ylab("Tajima's D") +
  ggtitle("Tajima's D, Three Epoch Expansion") + 
  scale_colour_manual(
    values = c("ThreeEpochE_dadi_tajima_d"='red', 
      "ThreeEpochE_msprime_tajima_d"='blue', 
      "ThreeEpochE_lynch_tajima_d"='green'),
    labels = c("Dadi", "MSPrime", "Lynch Theory")
  ) +
  geom_hline(yintercept = 0, size = 2, linetype = 'dashed')

ggplot(data=ThreeEpochB_tajima_d_df, aes(x=sample_size, y=value, color=variable)) + geom_line(size=2) +
  theme_bw() + guides(color=guide_legend(title="Type of SFS")) +
  xlab('Sample size') +
  ylab("Tajima's D") +
  ggtitle("Tajima's D, Three-epoch Bottleneck + Growth") + 
  scale_colour_manual(
    values = c("ThreeEpochB_dadi_tajima_d"='red', 
      "ThreeEpochB_msprime_tajima_d"='blue', 
      "ThreeEpochB_lynch_tajima_d"='green'),
    labels = c("Dadi", "MSPrime", "Lynch Theory")
  ) +
  geom_hline(yintercept = 0, size = 2, linetype = 'dashed')
  
tennessen_lynch_tajima_d = c()

# Loop through subdirectories and get relevant files
for (i in seq(from=10, to=800, by=10)) {
  # Lynch
  j = i + 1
  subdirectory_lynch_tennessen <- paste0("../Analysis/optimal_sample_size_test/tennessen_", j)
  tennessen_lynch_summary <- paste0(subdirectory_lynch_tennessen, "_summary.txt")

  tennessen_lynch_tajima_d = c(tennessen_lynch_tajima_d, read_summary_statistics(tennessen_lynch_summary)[3])
}

tennessen_tajima_d_df = melt(data.frame(tennessen_lynch_tajima_d))
tennessen_tajima_d_df$sample_size = sample_size_index

ggplot(data=tennessen_tajima_d_df, aes(x=sample_size, y=value, color=variable)) + geom_line(size=2) +
  theme_bw() + guides(color=guide_legend(title="Type of SFS")) +
  xlab('Sample size') +
  ylab("Tajima's D") +
  ggtitle("Tajima's D, Tennessen model") + 
  scale_colour_manual(
    values = c("tennessen_lynch_tajima_d"='green'),
    labels = c("Lynch Theory")
  ) +
  geom_hline(yintercept = 0, size = 2, linetype = 'dashed')
  