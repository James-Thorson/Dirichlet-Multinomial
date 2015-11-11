
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
  xaxt = "n", log="y")
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
  xaxt = "n", log="y")
axis(1, at = axisbot, labels = yearlyn)
axis(3, at = axistop, labels = rep("", length(axistop)))
# legend("topleft", legend = levels(resdf$Nfishery)[-1], fill = colors,
#   bty = "n", title = "Inflation factor", pch = letters[1:3])
mtext( side=1, outer=FALSE, line=1.75, text="True annual sample size")
mtext( side=3, outer=TRUE, line=1.75, text="Inflation factor")
dev.off()

