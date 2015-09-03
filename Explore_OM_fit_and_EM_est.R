

#devtools::install_github('r4ss/r4ss')#, ref='v1.23.0')  #
library( r4ss )
#setwd( "C:/Users/James.Thorson/Desktop/Project_git/Dirichlet-Multinomial/" )

# OM fits
RunFile = "hake_V3.3_explicitF_V2"
  SsOutput = Covar = TRUE
  SsOutput = SS_output(RunFile, covar=Covar, forecast=FALSE, printstats=TRUE)
  #Plots = SS_plots(SsOutput, png=TRUE, printfolder="Plots_Default", uncertainty=Covar, aalresids=TRUE, datplot=TRUE, areanames=c("CA","OR","WA"), multifig_colpolygon=c( rgb(1,0,0,0.5), rgb(0,0,1,0.5), rgb(0,1,0,0.5)), multifig_oma=c(5,5,1,2)+.1, linescol=c("green", "red", "blue"), andre_oma=c(3,0,0.5,0) ) #aalyear, aalbin
  Plots = SS_plots(SsOutput, plot=c(2), png=TRUE, printfolder="Plots_selex", uncertainty=Covar) #aalyear, aalbin

# EM fits
RunFile = "2015-09-02/Rep=1"
  SsOutput = Covar = TRUE
  SsOutput = SS_output(RunFile, covar=Covar, forecast=FALSE, printstats=TRUE)
  #Plots = SS_plots(SsOutput, png=TRUE, printfolder="Plots_Default", uncertainty=Covar, aalresids=TRUE, datplot=TRUE, areanames=c("CA","OR","WA"), multifig_colpolygon=c( rgb(1,0,0,0.5), rgb(0,0,1,0.5), rgb(0,1,0,0.5)), multifig_oma=c(5,5,1,2)+.1, linescol=c("green", "red", "blue"), andre_oma=c(3,0,0.5,0) ) #aalyear, aalbin
  Plots = SS_plots(SsOutput, plot=c(2), png=TRUE, printfolder="Plots_selex", uncertainty=Covar) #aalyear, aalbin



