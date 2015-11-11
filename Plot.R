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
DF = droplevels(subset(resdf, !(Nfishery%in%c(1,1000)) & gradient<gradientfilter) )

png(filename=paste0(ResultsFD,"/Combined_simulation_results.png"), res=resolution, width=6.5, height=2.5*2, units="in")
  par(mfcol=c(2,3), mar=c(0,0,0.25,0.5), mgp=c(1.75,0.5,0), tck=-0.02, oma=c(3,3.5,3,0))
  for(j in 1:3){
    Which = which(DF$ntrue==sort(unique(DF$ntrue))[j])
    boxplot( 1/exp(lnEffN_mult_1) ~ Nfishery, data=DF[Which,], ylim=c(0.1,2000), log="y", xaxt="n", yaxt="n" )
    mtext(side=3, text=sort(unique(DF$ntrue))[j])
    if(j==1){
      axis(2)
      mtext(side=2, text=expression(theta), line=1.75)
    }
    boxplot( ESS3 ~ Nfishery, data=DF[Which,], ylim=c(15,500), log="y", yaxt="n" )
    abline( h=sort(unique(DF$ntrue))[j], lty="dotted", lwd=3)
    if(j==1){
      axis(2)
      mtext(side=2, text=expression(N[eff]), line=1.75)
    }
  }
  mtext(side=3, outer=TRUE, line=1.75, text="True annual sample size")
  mtext(side=1, outer=TRUE, line=1.75, text="Inflation factor")
dev.off()

###############################################################################
# Correlated error in R_0 and M
###############################################################################
library(ggplot2)
levels(resdf$model) = c("tuned","unweighted","DM")
png(filename = paste0(ResultsFD, "/R0andM_inflation.png"), res = resolution,
    width = 1.9*5, height = 1.9*3, units="in")
par( mar=c(3,3,0.5,0.5), mgp=c(1.75,0.5,0), tck=-0.02, oma=c(0,0,0,0))
means <- aggregate(gradient ~ model + Nfishery, data = droplevels(subset(resdf,!(Nfishery%in%c(1000)))), mean)
means$gradient <- round(means$gradient, 4)
lengths <- aggregate(gradient ~ model + Nfishery,
  data = subset(resdf, gradient < gradientfilter & !(Nfishery%in%c(1000))), length)
lengths$label <- paste0("     (", letters[1:NROW(means)], ") ", lengths$gradient)
letterlab <- means
ggplot(subset(resdf, gradient < gradientfilter & !(Nfishery%in%c(1000))),
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
