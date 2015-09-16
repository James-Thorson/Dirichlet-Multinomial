###############################################################################
# Plot results
###############################################################################
resolution <- 150
width <- 700
height <- 700

###############################################################################
# Estimates of DM parameter 1
###############################################################################
png(filename = paste0(ResultsFD, "/DM1_inflation.png"), res = resolution,
  width = width, height = height)
boxplot(1/exp(lnEffN_mult_1) ~ Nfishery, data = resdf, las = 1,
  xlab = "OM inflation factor", ylab = expression(beta))
dev.off()

###############################################################################
# Estimates of ESS
###############################################################################
resdf$ESS1 <- with(resdf, ((1/as.numeric(as.character(Nfishery))) + (1/(exp(lnEffN_mult_1) + 1)))^(-1))
resdf$ESS2 <- with(resdf, ((1/as.numeric(as.character(Nfishery))) + (1/(exp(lnEffN_mult_1) * as.numeric(as.character(Nfishery)) + 1)))^(-1))
png(filename = paste0(ResultsFD, "/ESS_inflation.png"), res = resolution,
    width = width, height = height)
boxplot(ESS2 ~ Nfishery, data = resdf, las = 1,
  xlab = "OM inflation factor", ylab = expression(N[eff]))
dev.off()

###############################################################################
# Correlated error in R_0 and M
###############################################################################
png(filename = paste0(ResultsFD, "/R0andM_inflation.png"), res = resolution,
    width = width, height = height)
ggplot(resdf, aes(SR_LNR0_RE, NatM_p_1_Fem_GP_1_RE)) +
  geom_point(aes(SR_LNR0_RE, NatM_p_1_Fem_GP_1_RE, color = gradient)) +
  facet_grid(model ~ Nfishery) +
  scale_color_gradient(low='blue', high='red') +
  xlab(expression(paste(italic(ln), "(", italic(R_0), ")", sep = ""))) +
  ylab(expression(paste(italic("M")))) +
  theme_bw() +
  theme(plot.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        strip.background = element_blank(),
        panel.border = element_rect(colour = "black"),
        legend.position = c(0.145, 0.20)
  )
dev.off()


