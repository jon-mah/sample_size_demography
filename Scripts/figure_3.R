# figure_3.R

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

sample_size = seq(from=10, to=800, by=10)
mean_list = c()
growth_coal_proportion = c()
bottleneck_coal_proportion = c()
ancestral_coal_proportion = c()
msprime_time = c()
msprime_nu_shape = c()

# Iterate through sample size and replicate
for (i in sample_size) {
  this_sample_size_distribution = c() # Initialize
  msprime_demography = paste0(
    "../Analysis/msprime_3EpB_", i, '/two_epoch_demography.txt')
  msprime_nu = nu_from_demography(msprime_demography)
  msprime_time = c(msprime_time, time_from_demography(msprime_demography))
  if (is.na(msprime_nu)) {
    msprime_nu_shape = c(msprime_nu_shape, NA)
  } else if (msprime_nu > 1) {
    msprime_nu_shape = c(msprime_nu_shape, 'msprime_expand')
  } else {
    msprime_nu_shape = c(msprime_nu_shape, 'msprime_contract')
  }  
  for (j in seq(from=1, to=20, by=1)) {
    this_replicate_distribution = paste0(
      "../Simulations/simple_simulations/ThreeEpochBottleneck_",
      i, '_coal_dist_',
      j, '.csv')
    # Read in the appropriate file
    this_csv = read.csv(this_replicate_distribution, header=TRUE)
    this_sample_size_distribution = c(this_sample_size_distribution, this_csv$generations)
  }
  # Lastly find the proportion of coalescent events in each epoch
  growth_coal_proportion = c(growth_coal_proportion, 
    mean(this_sample_size_distribution <= 200))
  bottleneck_coal_proportion = c(bottleneck_coal_proportion, 
    mean(this_sample_size_distribution <= 2000) - mean(this_sample_size_distribution < 200))
  ancestral_coal_proportion = c(ancestral_coal_proportion, 
    mean(this_sample_size_distribution > 2000))
}

# figure_3A_dataframe$sample_size = sample_size

figure_3A_dataframe = melt(data.frame(
  growth_coal_proportion,
  bottleneck_coal_proportion,
  ancestral_coal_proportion
))

figure_3A_dataframe$msprime_time = msprime_time
figure_3A_dataframe$msprime_shape = msprime_nu_shape
figure_3A_dataframe$sample_size = sample_size

plot_3A = ggplot(data=figure_3A_dataframe, aes(x=sample_size, y=value, color=variable, shape=msprime_shape)) +
  geom_point(size=1.5) +
  theme_bw() +
  # xlab('Sample size') +
  ylab('Proportion of coalescent events') +
  # ggtitle('Coalescent events per epoch, [Anc., 2000 g.a., 200 g.a.]') +
  ggtitle('Coalescent events per epoch') +
  scale_color_manual(name='Epoch',
                     breaks=c('growth_coal_proportion',
                       'bottleneck_coal_proportion',
                       'ancestral_coal_proportion'),
                     values=c('growth_coal_proportion'='#1b9e77',
                       'bottleneck_coal_proportion'='#d95f02',
                       'ancestral_coal_proportion'='#7570b3'),
                     labels=c('Current [200 g.a.]', 
                       'Bottleneck [2000 g.a.]', 
                       'Ancestral [>2000 g.a.]')) +
  scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion'))

sample_size = seq(10, 800, by=10)

# Mean of proportions
mean_prop_growth = c()
mean_prop_bottleneck = c()
mean_prop_ancestral = c()

# Ratio of sums
prop_sum_growth = c()
prop_sum_bottleneck = c()
prop_sum_ancestral = c()

for (i in sample_size) {

  # Proportions for each replicate
  prop_growth = numeric(20)
  prop_bottleneck = numeric(20)
  prop_ancestral = numeric(20)

  # Sum across replicates
  sum_growth = numeric(20)
  sum_bottleneck = numeric(20)
  sum_ancestral = numeric(20)
  sum_total = numeric(20)

  for (g in seq_len(20)) {
    this_branch_distribution = paste0(
      "../Simulations/simple_simulations/ThreeEpochBottleneck_",
      i, '_branch_length_dist_',
      g, '.csv')

    this_b_len_csv = read.csv(this_branch_distribution, header = TRUE)

    start <- this_b_len_csv$node_generations
    end   <- start + this_b_len_csv$branch_length

    # Overlap

    growth_overlap <- pmax(0, pmin(end, 200) - start)
    bottleneck_overlap <- pmax(0, pmin(end, 2000) - pmax(start, 200))
    ancestral_overlap <- pmax(0, end - pmax(start, 2000))

    # Raw sums
    sum_growth[g]      <- sum(growth_overlap)
    sum_bottleneck[g]  <- sum(bottleneck_overlap)
    sum_ancestral[g]   <- sum(ancestral_overlap)
    sum_total[g]       <- sum(this_b_len_csv$branch_length)

    # Per-replicate proportions
    prop_growth[g]     <- sum_growth[g]     / sum_total[g]
    prop_bottleneck[g] <- sum_bottleneck[g] / sum_total[g]
    prop_ancestral[g]  <- sum_ancestral[g]  / sum_total[g]
  }

  # Mean of proportions, calculation
  mean_prop_growth      <- c(mean_prop_growth, mean(prop_growth))
  mean_prop_bottleneck  <- c(mean_prop_bottleneck, mean(prop_bottleneck))
  mean_prop_ancestral   <- c(mean_prop_ancestral, mean(prop_ancestral))

  # Ratio of sums, calculation
  prop_sum_growth      <- c(prop_sum_growth, sum(sum_growth)     / sum(sum_total))
  prop_sum_bottleneck  <- c(prop_sum_bottleneck, sum(sum_bottleneck) / sum(sum_total))
  prop_sum_ancestral   <- c(prop_sum_ancestral, sum(sum_ancestral)  / sum(sum_total))
}

branch_proportion_df = data.frame(
  prop_sum_ancestral,
  prop_sum_bottleneck,
  prop_sum_growth
)

names(branch_proportion_df) = c('Proportion of sums, Anc.', 
  'Proportion of sums, Bot.',
  'Proportion of sums, Cur.')
branch_proportion_df = melt(branch_proportion_df)
branch_proportion_df$sample_size = sample_size
branch_proportion_df$shape = msprime_nu_shape

branch_proportion_df$epoch =
  ifelse(grepl("Anc", branch_proportion_df$variable), "Ancestral",
  ifelse(grepl("Bot", branch_proportion_df$variable), "Bottleneck", "Current"))

figure_3B = ggplot(branch_proportion_df,
                     aes(x = sample_size,
                         y = value,
                         color = epoch,
                       shape=shape)) +
  geom_point(size = 1.5) +
  theme_bw() +
  scale_color_manual(values = c(
    "Ancestral" = '#7570b3',
    "Bottleneck" = '#d95f02',
    "Current" = '#1b9e77'
  )) +
    scale_shape_manual(name='Inferred two-epoch model',
                     breaks=c('msprime_contract',
                       'msprime_expand'),
                     values=c('msprime_contract'=15,
                       'msprime_expand'=22),
                     labels=c('Contraction',
                       'Expansion')) +
  xlab('Sample size') +
  ylab('Proportion of branch length') +
  ggtitle('Distribution of branch lengths acoss epochs') +
  guides(shape='none', color='none')
figure_3B

# 700x600
figure_3 = plot_3A + figure_3B + plot_layout(nrow=2)

ggsave('../Summary/figure_3_output.svg', figure_3, width=7, height=6, units='in', dpi=100)


# 
# # Expectation (code from Kirk)
# 
# # =============================================================================
# # Coalescent Branch Length Calculator: Three-Epoch Model (v2)
# # =============================================================================
# # Computes expected branch length in each of three epochs under Kingman's
# # coalescent with piecewise-constant population sizes.
# #
# # Epoch 1: [0, t)        - population size N0 (reference)
# # Epoch 2: [t, t+i)      - population size N1, rate scaled by rho1 = N0/N1
# # Epoch 3: [t+i, t+i+j)  - population size N2, rate scaled by rho2 = N0/N2
# #
# # Time is in coalescent units scaled to N0 generations.
# #
# # APPROACH: Numerically integrate E[K(s)] over each epoch, where E[K(s)] is
# # the expected number of lineages at time s. This satisfies the hard bound:
# #   branch length in epoch <= (lineages entering epoch) * (epoch duration)
# #
# # E[K(s)] is obtained by solving the Kolmogorov forward ODE for P(K(s)=k)
# # using RK4 with adaptive step sizes chosen to ensure numerical stability
# # for any combination of n and epoch duration.
# #
# # Results are validated against the bound n * duration and can be checked
# # against Monte Carlo simulation using the included verify_mc() function.
# # =============================================================================
# 
# 
# # -----------------------------------------------------------------------------
# # RK4 step for the Kolmogorov forward ODE of the Kingman coalescent
# #
# # State: P = (P_1, ..., P_m) where P_k = P(K(t) = k), m = current max lineages
# # ODE:  dP_k/dt = lam_{k+1}*P_{k+1} - lam_k*P_k   (k < m)
# #       dP_m/dt = -lam_m * P_m
# # where lam_k = rho * k*(k-1)/2
# #
# # Arguments:
# #   P        : current probability vector (length m)
# #   duration : time interval to integrate over
# #   rho      : coalescent rate scaling factor for this epoch
# #
# # Returns: probability vector at time t + duration
# # -----------------------------------------------------------------------------
# rk4_coalescent <- function(P, duration, rho = 1) {
#   
#   m   <- length(P)
#   lam <- rho * sapply(1:m, function(k) k * (k - 1) / 2)
#   
#   # Adaptive step size: ensure dt << 1 / lambda_max for stability
#   lam_max <- lam[m]
#   n_steps <- if (lam_max > 0) max(10L, ceiling(duration * lam_max * 20)) else 10L
#   dt      <- duration / n_steps
#   
#   f <- function(P) {
#     dP        <- -lam * P
#     dP[1:m-1] <- dP[1:m-1] + lam[2:m] * P[2:m]
#     return(dP)
#   }
#   
#   for (step in seq_len(n_steps)) {
#     k1 <- f(P)
#     k2 <- f(P + 0.5 * dt * k1)
#     k3 <- f(P + 0.5 * dt * k2)
#     k4 <- f(P +       dt * k3)
#     P  <- pmax(0, P + (dt / 6) * (k1 + 2*k2 + 2*k3 + k4))
#   }
#   
#   return(P)
# }
# 
# 
# # -----------------------------------------------------------------------------
# # Compute E[K(s)] on a grid and return the final lineage distribution
# #
# # Integrates the ODE forward across n_points grid points spanning [0, duration],
# # recording E[K(s)] at each point. Also returns the final P vector so it can
# # be passed directly as the initial distribution for the next epoch.
# #
# # Arguments:
# #   P_init   : initial probability vector
# #   duration : epoch duration
# #   rho      : rate scaling factor for this epoch
# #   n_points : number of grid points (odd recommended for Simpson's rule)
# #
# # Returns: list with
# #   $Eks     : vector of E[K(s)] values at each grid point
# #   $P_final : probability vector at end of epoch
# # -----------------------------------------------------------------------------
# ek_grid <- function(P_init, duration, rho = 1, n_points = 501) {
#   
#   m    <- length(P_init)
#   ks   <- 1:m
#   P    <- P_init
#   Eks  <- numeric(n_points)
#   Eks[1] <- sum(ks * P)
#   
#   dt_interval <- duration / (n_points - 1)
#   
#   for (g in 2:n_points) {
#     P    <- rk4_coalescent(P, dt_interval, rho)
#     Eks[g] <- sum(ks * P)
#   }
#   
#   return(list(Eks = Eks, P_final = P))
# }
# 
# 
# # -----------------------------------------------------------------------------
# # Trim negligible probability mass from the tail of a lineage distribution
# #
# # After a period of coalescence, high-k states become negligible. Trimming
# # the state vector speeds up subsequent ODE solves considerably.
# #
# # Arguments:
# #   P      : probability vector
# #   tol    : threshold below which tail probabilities are dropped
# #
# # Returns: trimmed probability vector
# # -----------------------------------------------------------------------------
# trim_distribution <- function(P, tol = 1e-10) {
#   last <- max(which(P > tol), 1)
#   return(P[1:last])
# }
# 
# 
# # -----------------------------------------------------------------------------
# # Simpson's rule numerical integration
# # -----------------------------------------------------------------------------
# simpsons_rule <- function(y, duration) {
#   m <- length(y)
#   if (m < 2) return(0)
#   h <- duration / (m - 1)
#   if (m %% 2 == 0) {
#     return(h * (y[1]/2 + sum(y[2:(m-1)]) + y[m]/2))
#   }
#   return((h/3) * (y[1] +
#                   4 * sum(y[seq(2, m-1, 2)]) +
#                   2 * sum(y[seq(3, m-2, 2)]) +
#                   y[m]))
# }
# 
# 
# 
# 
# # -----------------------------------------------------------------------------
# # Monte Carlo verification (optional — for checking results)
# #
# # Simulates the coalescent process directly and estimates branch lengths
# # by averaging over n_sim independent realizations.
# #
# # Arguments:
# #   n, t, i, j, rho1, rho2 : same as coalescent_epochs()
# #   n_sim                  : number of simulations (default 50000)
# #
# # Returns: named list with A, B, C, total, p1, p2, p3 (MC estimates)
# # -----------------------------------------------------------------------------
# verify_mc <- function(n, t, i, j, rho1, rho2, n_sim = 50000) {
#   
#   cat(sprintf("Running Monte Carlo verification (n_sim = %d)...\n", n_sim))
#   
#   A_tot <- B_tot <- C_tot <- 0
#   
#   for (sim in seq_len(n_sim)) {
#     
#     k <- n
#     
#     # Epoch 1
#     s <- 0; A <- 0
#     while (k > 1) {
#       rate <- k * (k - 1) / 2
#       dt   <- rexp(1, rate)
#       if (s + dt > t) { A <- A + k * (t - s); s <- t;   break }
#       A <- A + k * dt;  s <- s + dt;  k <- k - 1
#     }
#     if (s < t) A <- A + k * (t - s)
#     
#     # Epoch 2
#     s <- 0; B <- 0
#     while (k > 1) {
#       rate <- rho1 * k * (k - 1) / 2
#       dt   <- rexp(1, rate)
#       if (s + dt > i) { B <- B + k * (i - s); s <- i;   break }
#       B <- B + k * dt;  s <- s + dt;  k <- k - 1
#     }
#     if (s < i) B <- B + k * (i - s)
#     
#     # Epoch 3
#     s <- 0; C <- 0
#     while (k > 1) {
#       rate <- rho2 * k * (k - 1) / 2
#       dt   <- rexp(1, rate)
#       if (s + dt > j) { C <- C + k * (j - s); s <- j;   break }
#       C <- C + k * dt;  s <- s + dt;  k <- k - 1
#     }
#     if (s < j) C <- C + k * (j - s)
#     
#     A_tot <- A_tot + A
#     B_tot <- B_tot + B
#     C_tot <- C_tot + C
#   }
#   
#   tot <- A_tot + B_tot + C_tot
#   list(
#     A = A_tot/n_sim,  B = B_tot/n_sim,  C = C_tot/n_sim,
#     total = tot/n_sim,
#     p1 = A_tot/tot,   p2 = B_tot/tot,   p3 = C_tot/tot
#   )
# }
# 
# 
# 
# # -----------------------------------------------------------------------------
# # Epoch 3 (infinite duration): analytical expected branch length
# #
# # When the population remains at size rho2 indefinitely, all remaining
# # lineages eventually coalesce and the total expected branch length
# # has an exact closed form.
# #
# # C_inf = sum_{k=1}^{n} P2(k) * (2/rho2) * sum_{m=2}^{k} 1/(m-1)
# #
# # Arguments:
# #   P_at_ti : lineage probability vector entering Epoch 3 (from epoch 2)
# #   rho2    : rate scaling factor for Epoch 3 (N0/N2)
# #
# # Returns: scalar expected branch length in Epoch 3
# # -----------------------------------------------------------------------------
# epoch3_infinite <- function(P_at_ti, rho2) {
#   
#   if (rho2 <= 0) stop("rho2 must be positive")
#   
#   n <- length(P_at_ti)
#   
#   # Precompute the complete-coalescent branch length for each entry state k:
#   # bl(k) = (2/rho2) * sum_{m=2}^{k} 1/(m-1)
#   # bl(1) = 0 (single lineage, nothing left to coalesce)
#   bl <- numeric(n)
#   for (k in 2:n) {
#     bl[k] <- (2 / rho2) * sum(1 / (1:(k-1)))
#   }
#   
#   # Weight by entry distribution
#   C_inf <- sum(P_at_ti * bl)
#   
#   return(C_inf)
# }
# 
# 
# # -----------------------------------------------------------------------------
# # Updated wrapper with optional infinite Epoch 3
# #
# # Set j = Inf to use the analytical formula for the most ancient epoch.
# # -----------------------------------------------------------------------------
# coalescent_epochs <- function(n, t, i, j = Inf, rho1, rho2,
#                               n_points = 501, verbose = TRUE) {
#   
#   if (n < 2)     stop("Sample size n must be at least 2")
#   if (any(c(t, i) < 0)) stop("Epoch durations must be non-negative")
#   if (!is.infinite(j) && j < 0) stop("j must be non-negative or Inf")
#   if (rho1 <= 0) stop("rho1 must be positive")
#   if (rho2 <= 0) stop("rho2 must be positive")
#   
#   if (verbose) cat("Computing Epoch 1 (A)...\n")
#   P0  <- numeric(n); P0[n] <- 1.0
#   ep1 <- ek_grid(P0, t, rho = 1, n_points)
#   A   <- simpsons_rule(ep1$Eks, t)
#   
#   if (verbose) cat("Computing Epoch 2 (B)...\n")
#   P1  <- trim_distribution(ep1$P_final)
#   ep2 <- ek_grid(P1, i, rho = rho1, n_points)
#   B   <- simpsons_rule(ep2$Eks, i)
#   
#   if (verbose) cat("Computing Epoch 3 (C)...\n")
#   P2  <- trim_distribution(ep2$P_final)
#   
#   if (is.infinite(j)) {
#     C     <- epoch3_infinite(P2, rho2)   # exact analytical result
#     C_max <- Inf
#   } else {
#     ep3   <- ek_grid(P2, j, rho = rho2, n_points)
#     C     <- simpsons_rule(ep3$Eks, j)
#     C_max <- n * j
#   }
#   
#   total <- A + B + C
#   
#   list(
#     A     = A,      B     = B,      C     = C,
#     total = total,
#     p1    = A / total,
#     p2    = B / total,
#     p3    = C / total,
#     A_max = n * t,
#     B_max = n * i,
#     C_max = C_max
#   )
# }
# 
# 
# 
# # =============================================================================
# # Example: Bottleneck from Jon's paper
# # =============================================================================
# 
# cat("=== Three-Epoch Coalescent Branch Length Calculator (v2) ===\n\n")
# 
# N0<-50000*2 #this is the current popualtion size, in haploids
# n    <- 800 #sample size in haploids
# t    <- 200/(N0)   # length of growth epoch, in units of N0
# rho1 <- N0/(2*1000) #size change in bottleneck
# rho2 <- N0/(2*10000) #size change in ancestral
# 
# i<-1800/(N0) #length of bottleneck epoch, in units of N0
# j<-Inf #set to Inf to use analytical calculation for infinite length of ancestral epoch
# 
# 
# cat(sprintf("Parameters: n=%d, t=%.3f, i=%.2f, j=%.2f, rho1=%.2f, rho2=%.2f\n\n",
#             n, t, i, j, rho1, rho2))
# 
# result <- coalescent_epochs(n, t, i, j, rho1, rho2)
# 
# cat("\n--- ODE Results ---\n")
# cat(sprintf("Epoch 1 (A): %.4f  [upper bound n*t = %.4f  |  OK: %s]\n",
#             result$A, result$A_max, result$A <= result$A_max))
# cat(sprintf("Epoch 2 (B): %.4f  [upper bound n*i = %.4f  |  OK: %s]\n",
#             result$B, result$B_max, result$B <= result$B_max))
# cat(sprintf("Epoch 3 (C): %.4f  [upper bound n*j = %.4f  |  OK: %s]\n",
#             result$C, result$C_max, result$C <= result$C_max))
# cat(sprintf("Total:       %.4f\n\n", result$total))
# cat(sprintf("p1 = %.4f,  p2 = %.4f,  p3 = %.4f  (sum = %.4f)\n\n",
#             result$p1, result$p2, result$p3,
#             result$p1 + result$p2 + result$p3))
# 
# ######################
# #end here!
# 
# 
# # Monte Carlo check
# mc <- verify_mc(n, t, i, j, rho1, rho2, n_sim = 50000)
# 
# cat("\n--- Comparison: ODE vs Monte Carlo ---\n")
# cat(sprintf("%-6s  %-10s  %-10s\n", "", "ODE", "MC"))
# cat(strrep("-", 30), "\n")
# cat(sprintf("%-6s  %-10.4f  %-10.4f\n", "A",  result$A,  mc$A))
# cat(sprintf("%-6s  %-10.4f  %-10.4f\n", "B",  result$B,  mc$B))
# cat(sprintf("%-6s  %-10.4f  %-10.4f\n", "C",  result$C,  mc$C))
# cat(sprintf("%-6s  %-10.4f  %-10.4f\n", "p1", result$p1, mc$p1))
# cat(sprintf("%-6s  %-10.4f  %-10.4f\n", "p2", result$p2, mc$p2))
# cat(sprintf("%-6s  %-10.4f  %-10.4f\n", "p3", result$p3, mc$p3))
# 
# 
# # =============================================================================
# # Sensitivity analysis 1: vary sample size n
# # =============================================================================
# 
# cat("\n\n=== Sensitivity to Sample Size n ===\n\n")
# 
# # n_values <- c(2, 5, 10, 20, 50, 100)
# n_values = seq(10, 800, by=10)
# 
# sensitivity_n <- matrix(
#   NA,
#   nrow     = length(n_values),
#   ncol     = 7,
#   dimnames = list(paste0("n=", n_values),
#                   c("A", "B", "C", "Total", "p1", "p2", "p3"))
# )
# 
# for (idx in seq_along(n_values)) {
#   cat(sprintf("  n = %d\n", n_values[idx]))
#   r <- coalescent_epochs(n_values[idx], t, i, j, rho1, rho2, verbose = FALSE)
#   sensitivity_n[idx, ] <- c(r$A, r$B, r$C, r$total, r$p1, r$p2, r$p3)
# }
# 
# cat("\n")
# print(round(sensitivity_n, 4))
# 
# 
# # =============================================================================
# # Sensitivity analysis 2: vary rho1 (Epoch 2 bottleneck strength)
# # =============================================================================
# 
# cat("\n=== Sensitivity to Epoch 2 Bottleneck Strength (rho1) ===\n\n")
# 
# rho1_values <- c(0.5, 1.0, 2.0, 5.0, 10.0)
# 
# sensitivity_rho1 <- matrix(
#   NA,
#   nrow     = length(rho1_values),
#   ncol     = 7,
#   dimnames = list(paste0("rho1=", rho1_values),
#                   c("A", "B", "C", "Total", "p1", "p2", "p3"))
# )
# 
# for (idx in seq_along(rho1_values)) {
#   cat(sprintf("  rho1 = %.1f\n", rho1_values[idx]))
#   r <- coalescent_epochs(n, t, i, j, rho1_values[idx], rho2, verbose = FALSE)
#   sensitivity_rho1[idx, ] <- c(r$A, r$B, r$C, r$total, r$p1, r$p2, r$p3)
# }
# 
# cat("\n")
# print(round(sensitivity_rho1, 4))



