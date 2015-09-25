
###############################################################################
# Estimates of DM parameter 1
###############################################################################
png(filename = paste0(ResultsFD, "/DM1_inflation.png"), res = resolution,
  width = width, height = height)
par( mar=c(3,3,0.5,0.5), mgp=c(1.75,0.5,0), tck=-0.02, oma=c(0,0,0,0))
boxplot(1/exp(lnEffN_mult_1) ~ Nfishery + ntrue,
  data = droplevels(subset(resdf, Nfishery != 1)),
  xlab = "True annual sample size", ylab = expression(theta),
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
par( mar=c(3,3,0.5,0.5), mgp=c(1.75,0.5,0), tck=-0.02, oma=c(0,0,0,0))
boxplot(ESS2 ~ Nfishery + ntrue,
        data = droplevels(subset(resdf, Nfishery != 1)),
  xlab = "True annual sample size", ylab = expression(N[eff]),
  col = colors, xaxt = "n")
axis(1, at = c(2, 5, 8), labels = yearlyn)
legend("topleft", legend = levels(resdf$Nfishery)[-1], fill = colors,
  bty = "n", title = "Observed sample size")
dev.off()
