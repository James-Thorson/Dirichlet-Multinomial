###############################################################################
# Plot results
###############################################################################
resolution <- 125
width <- 700
height <- 700
colors <- gray.colors(3, start = 0.3, end = 0.9, gamma = 2.2, alpha = NULL)
gradientfilter <- 0.1

###############################################################################
# Estimates of DM parameter 1
###############################################################################
png(filename = paste0(ResultsFD, "/Combined_simulation_results.png"), res = resolution,
  width = 6, height = 3*2, units="in")
par( mfrow=c(2,1), mar=c(1,3,0.25,0.5), mgp=c(1.75,0.5,0), tck=-0.02,
  oma = c(2, 0, 2.75, 0))
# Panel 1 -- estimates of parameter
boxplot(1/exp(lnEffN_mult_1) ~ Nfishery + ntrue,
  data = droplevels(subset(resdf, Nfishery != 1 & gradient < gradientfilter)),
  xlab = "", ylab = expression(theta),
  # col = colors,
  xaxt = "n")
area <- par("usr")
axisbot <- axis(1, at = seq(area[1] + area[2]/6, area[2] - area[2]/6,
  length.out = length(yearlyn)), labels = rep("", length(yearlyn)))
axistop <- axis(side = 3, at = 1:((NROW(inflationmatrix)-1)*length(yearlyn)),
  labels = rep(inflationmatrix[-1, 1], length(yearlyn)), cex.axis = .6)
# Panel 2 --
boxplot(ESS2 ~ Nfishery + ntrue,
        data = droplevels(subset(resdf, Nfishery != 1 & gradient < gradientfilter)),
  xlab = "", ylab = expression(N[eff]),
  # col = colors,
  xaxt = "n")
axis(1, at = axisbot, labels = yearlyn)
axis(3, at = axistop, labels = rep("", length(axistop)))
# legend("topleft", legend = levels(resdf$Nfishery)[-1], fill = colors,
#   bty = "n", title = "Inflation factor", pch = letters[1:3])
mtext( side=1, outer=FALSE, line=1.75, text="True annual sample size")
mtext( side=3, outer=TRUE, line=1.75, text="Inflation factor")
dev.off()

###############################################################################
# Correlated error in R_0 and M
###############################################################################
library(ggplot2)
levels(resdf$model) = c("tuned","unweighted","DM")
png(filename = paste0(ResultsFD, "/R0andM_inflation.png"), res = resolution,
    width = 1.9*4, height = 1.9*3, units="in")
par( mar=c(3,3,0.5,0.5), mgp=c(1.75,0.5,0), tck=-0.02, oma=c(0,0,0,0))
means <- aggregate(gradient ~ model + Nfishery, data = resdf, mean)
means$gradient <- round(means$gradient, 4)
lengths <- aggregate(gradient ~ model + Nfishery,
  data = subset(resdf, gradient < gradientfilter), length)
lengths$label <- paste0("(", letters[1:NROW(means)], ") ", lengths$gradient)
letterlab <- means
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
        legend.position = c(1/((NROW(inflationmatrix) + 4)), 1/((NROW(inflationmatrix)))),
        legend.key = element_rect(colour = "white"),
        legend.title = element_text(size = 7, face = "bold"),
        legend.text = element_text(size = 7, face = "bold")
  ) +
  labs(color = "True annual\nsample size") +
  geom_hline(yintercept = 0, lty = 2) +
  geom_vline(xintercept = 0, lty = 2) +
  # geom_text(data = means, aes(label = gradient, x = -0.05, y = 0.65), size = 2.5) +
  geom_text(data = lengths, aes(label = label, x = -0.05, y = 0.85), size = 2.5)
dev.off()
