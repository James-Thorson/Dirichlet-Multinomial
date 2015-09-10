###############################################################################
# Plot results
###############################################################################

###############################################################################
# Estimates of DM parameter 1
###############################################################################
 png(filename = paste0(ResultsFD, "/DM1_inflation.png"), res = 100)
 boxplot(lnEffN_mult_1 ~ Nfishery, data = resdf, las = 1,
   xlab = "OM inflation factor", ylab = "EM estimate of DM parameter 1")
dev.off()

###############################################################################
# Correlated error in R_0 and M
###############################################################################
png(filename = paste0(ResultsFD, "/R0andM_inflation.png"), res = 100)
ggplot(resdf, aes(SR_LNR0_RE, NatM_p_1_Fem_GP_1_RE)) + geom_point(color="chartreuse4") +
    facet_grid(model ~ Nfishery)
dev.off()


