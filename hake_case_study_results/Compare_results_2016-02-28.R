
if(!"ThorsonUtilities" %in% installed.packages()[, 1]) {
  devtools::install_github("james-thorson/utilities")
}
library(ThorsonUtilities)
library( r4ss )

RootFile = "C:/Users/James.Thorson/Desktop/Project_git/Dirichlet-Multinomial/hake_case_study_results/hake_V3.3_explicitF_V4/"
  #SsOutput = Covar = TRUE
  #SsOutput = SS_output(RunFile, covar=Covar, forecast=TRUE, printstats=TRUE, ncols=210)
  # All
  #Plots = SS_plots(SsOutput, png=TRUE, printfolder="Plots_Default", uncertainty=Covar, aalresids=TRUE, datplot=TRUE, areanames=c("CA","OR","WA"), multifig_colpolygon=c( rgb(1,0,0,0.5), rgb(0,0,1,0.5), rgb(0,1,0,0.5)), multifig_oma=c(5,5,1,2)+.1, linescol=c("green", "red", "blue"), andre_oma=c(3,0,0.5,0) ) #aalyear, aalbin

RunFile = paste0(RootFile,"without fishery/")
  #STD_3 = read.table( paste0(RunFile,"ss3.std"), header=TRUE )
  Output_0old = SS_output(RunFile, covar=TRUE, forecast=TRUE, printstats=TRUE)
  STD_0old = Output_0old$derived_quants
RunFile = paste0(RootFile,"without fishery (fixed)/")
  #STD_3 = read.table( paste0(RunFile,"ss3.std"), header=TRUE )
  Output_0 = SS_output(RunFile, covar=TRUE, forecast=TRUE, printstats=TRUE)
  STD_0 = Output_0$derived_quants
RunFile = paste0(RootFile,"without D-M unweighted/")
  #STD_0 = read.table( paste0(RunFile,"ss3.std"), header=TRUE )
  Output_1 = SS_output(RunFile, covar=TRUE, forecast=TRUE, printstats=TRUE)
  STD_1 = Output_1$derived_quants
RunFile = paste0(RootFile,"without D-M/")
  #STD_1 = read.table( paste0(RunFile,"ss3.std"), header=TRUE )
  Output_2 = SS_output(RunFile, covar=TRUE, forecast=TRUE, printstats=TRUE)
  STD_2 = Output_2$derived_quants
RunFile = paste0(RootFile,"with D-M/")
  #STD_2 = read.table( paste0(RunFile,"ss3.std"), header=TRUE )
  Output_3 = SS_output(RunFile, covar=TRUE, forecast=TRUE, printstats=TRUE)
  STD_3 = Output_3$derived_quants

YearSet = 1967:2013
save_fig( file=paste0(RootFile,"Comparison_with_hake"), width=6.5, height=6.5, res=c(200,600), type=c("png","tif"), FUN=function(){
  par( mfrow=c(2,2), mar=c(0,2,2,0), mgp=c(1.75,0.25,0), xaxs="i", yaxs="i", oma=c(3,1,0,0))
  for(j in 1:4){
    #Name = c("depletion", "SPB_std", "F_std")[j]
    Name = paste0( c("Bratio_", "SPB_", "F_", "Recr_")[j], YearSet)
    Label = c("Relative spawning output", "Spawning output", "Fishing intensity", "Recruitment")[j]
    Est = cbind( STD_0[Name,c('Value','StdDev')], STD_1[Name,c('Value','StdDev')], STD_2[Name,c('Value','StdDev')], STD_3[Name,c('Value','StdDev')] )
    Ylim = c(0,1.3*max(Est[,c(1,3,5,7)]))
    if( j==3 ) Ylim[2] = Ylim[2] * 1.3
    matplot( y=Est[,c(1,3,5,7)], x=YearSet, type="l", col=c("red","green","black","blue"), lty="solid", lwd=3, ylim=Ylim, xlab="", main=Label, ylab="", xaxt="n", yaxt="n" )
    for(i in 1:4){
      polygon( y=c(Est[,1+2*(i-1)]-1.0*Est[,2+2*(i-1)],rev(Est[,1+2*(i-1)]+1.0*Est[,2+2*(i-1)])), x=c(YearSet,rev(YearSet)), col=list(rgb(1,0,0,0.2),rgb(0,1,0,0.2),rgb(0,0,0,0.2),rgb(0,0,1,0.2))[[i]], border=NA )
    }
    if(j==3) legend("topleft", legend=c("No fishery ages","Unweighted","Tuned","D-M"), fill=c("red","green","black","blue"), ncol=2, bty="n")
    if(j>=3) axis(1)
    axis(2, at=rev(rev(axTicks(2))[-1]), labels=rev(rev(axTicks(2))[-1]) )
  }
  mtext(side=1, text="Year", outer=TRUE, line=2)
  mtext(side=2, text="Derived quantity", outer=TRUE, line=0)
})

# Comparison of likelihood components
Output_0$likelihoods_raw_by_fleet
Output_0$timeseries

Output_0$parameters[,1:9]
Output_0old$parameters[,1:9]
