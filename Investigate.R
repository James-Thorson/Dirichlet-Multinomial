###############################################################################
# Investigate results
###############################################################################
table(resdf$ntrue)
bad <- subset(resdf, gradient > 0.1 & model == "DM" & ntrue == 400)[1, ]
setwd(paste0(bad$ntrue, "_2015-10-04_", bad$Nfishery, "-1/Rep=", bad$iteration, "/DM"))

dir.create(paste0(RootFile, "test"))
file.copy(list.files(), file.path(paste0(RootFile, "test"), list.files()))
setwd(paste0(RootFile, "test"))
reports <- list()
reports[[1]] <- SS_output(getwd())
file.rename("control.ss_new", "hake_330.ctl")
file.rename("Report.sso", "Report_1.sso")
system("ss3")
reports[[2]] <- SS_output(getwd())

sapply(reports, "[", "maximum_gradient_component")
temp <- sapply(sapply(reports, "[", "parameters"), "[", "Value")
reports[[1]]$parameters$Label[which(abs(temp[[1]] - temp[[2]]) > 0.00001)]

aggregate(lnEffN_mult_1 ~ Nfishery + model + ntrue, data = subset(resdf, gradient < gradientfilter), mean)
aggregate(lnEffN_mult_1_SD ~ Nfishery + model + ntrue, data = subset(resdf, gradient < gradientfilter), mean)

temp <- subset(resdf, gradient < gradientfilter & model == "DM")
temp$high <- 1/exp(with(temp, lnEffN_mult_1 - 1.96 * lnEffN_mult_1_SD))
temp$low <- 1/exp(with(temp, lnEffN_mult_1 + 1.96 * lnEffN_mult_1_SD))
temp$cilow <- temp$low < as.numeric(as.character(temp$Nfishery))
temp$cihigh <- temp$high > as.numeric(as.character(temp$Nfishery))
aggregate(cilow ~ Nfishery + ntrue, temp, sum)
aggregate(cihigh ~ Nfishery + ntrue, temp, sum)
