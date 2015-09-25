###############################################################################
# Plot results
###############################################################################
resolution <- 150
width <- 700
height <- 700
colors <- gray.colors(3, start = 0.3, end = 0.9, gamma = 2.2, alpha = NULL)

###############################################################################
# Estimates of DM parameter 1
###############################################################################
png(filename = paste0(ResultsFD, "/DM1_inflation.png"), res = resolution,
  width = width, height = height)
boxplot(1/exp(lnEffN_mult_1) ~ Nfishery + ntrue,
  data = droplevels(subset(resdf, Nfishery != 1)), las = 1,
  xlab = "OM yearly sample size", ylab = expression(theta),
  col = colors, xaxt = "n")
axis(1, at = c(2, 5, 8), labels = yearlyn)
legend("topright", legend = levels(resdf$Nfishery)[-1], fill = colors,
  bty = "n", title = "Inflation factor")
dev.off()

###############################################################################
# Estimates of ESS
###############################################################################
resdf$ESS1 <- with(resdf, ((1/nsamp) + (1/(exp(lnEffN_mult_1) + 1)))^(-1))
resdf$ESS2 <- with(resdf, ((1/nsamp) + (1/(exp(lnEffN_mult_1) * as.numeric(as.character(nsamp)) + 1)))^(-1))
png(filename = paste0(ResultsFD, "/ESS_inflation.png"), res = resolution,
    width = width, height = height)
boxplot(ESS2 ~ Nfishery + ntrue,
        data = droplevels(subset(resdf, Nfishery != 1)), las = 1,
  xlab = "OM yearly sample size", ylab = expression(N[eff]),
  col = colors, xaxt = "n")
axis(1, at = c(2, 5, 8), labels = yearlyn)
legend("topleft", legend = sort(unique(resdf$Nfishery))[-1], fill = colors,
  bty = "n", title = "True sample size")
dev.off()

###############################################################################
# Correlated error in R_0 and M
###############################################################################
gradientfilter <- 0.1
png(filename = paste0(ResultsFD, "/R0andM_inflation.png"), res = resolution,
    width = width, height = height)
means <- aggregate(gradient ~ model + Nfishery, data = resdf, mean)
means$gradient <- round(means$gradient, 4)
lengths <- aggregate(gradient ~ model + Nfishery,
  data = subset(resdf, gradient < gradientfilter), length)
letterlab <- means
letterlab$gradient <- paste0("(", letters[1:11], ")")
ggplot(subset(resdf, gradient < gradientfilter),
       aes(SR_LNR0_RE, NatM_p_1_Fem_GP_1_RE)) +
  geom_point(aes(SR_LNR0_RE, NatM_p_1_Fem_GP_1_RE, color = factor(ntrue))) +
  facet_grid(model ~ Nfishery) +
  # scale_color_gradient(low='blue', high='red') +
  xlab(expression(paste(italic(ln), "(", italic(R_0), ")", sep = ""))) +
  ylab(expression(paste(italic("M")))) +
  theme_bw() +
  theme(plot.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        strip.background = element_blank(),
        panel.border = element_rect(colour = "black"),
        legend.position = c(0.145, 0.16),
        legend.key = element_rect(colour = "white"),
        legend.title = element_text(size = 7, face = "bold"),
        legend.text = element_text(size = 7, face = "bold")
  ) +
  labs(color = "OM yearly n") +
  geom_hline(yintercept = 0, lty = 2) +
  geom_vline(xintercept = 0, lty = 2) +
  # geom_text(data = means, aes(label = gradient, x = -0.05, y = 0.65), size = 2.5) +
  geom_text(data = lengths, aes(label = gradient, x = -0.05, y = 0.85), size = 2.5) +
  geom_text(data = letterlab, aes(label = gradient, x = -0.1, y = 0.85), size = 2.5)
dev.off()
