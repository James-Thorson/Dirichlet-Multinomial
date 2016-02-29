
if(!"ThorsonUtilities" %in% installed.packages()[, 1]) {
  devtools::install_github("james-thorson/utilities")
}
library(ThorsonUtilities)
library( r4ss )
# Pearson residuals for Jim Thorson's request on 2/25/16
#dir <- 'C:/github/Dirichlet-Multinomial'
dir <- 'C:/Users/James.Thorson/Desktop/Project_git/Dirichlet-Multinomial/hake_case_study_results/'
dm4 <- SS_output(file.path(dir, 'hake_V3.3_explicitF_V4/with D-M/'))
source(file.path(dir,'SSplotComps_Dirichlet-Multinomial.R'))

# Log-param
DM_param = exp( dm4$parameter['ln(EffN_mult)_1','Value'] )
# Var_adjust = (1 + DM_param*N_input) / (1 + DM_param)
# Line 1526 from SSplotComps
dm4$agedbase[,'Pearson'] = dm4$agedbase[,'Pearson'] / sqrt((1 + DM_param*dm4$agedbase[,'N']) / (1 + DM_param))

## Pearson residuals
doPNG <- T
ht <- 7; wd<- 6
save_fig( file=paste0(RootFile,"Pearson_Residuals"), width=6.5, height=6.5, res=c(200,600), type=c("png","tif"), FUN=function(){
  #par( oma=c(4,4,0,0) )
  SSplotComps(dm4,kind="AGE",subplot=24,printmkt=FALSE,printsex=FALSE, fleetnames=c("Fishery","Survey"), axis1=seq(1975,2015,5))
  mtext("Year",side=1,line=3,cex=par()$cex,outer=TRUE)
  #mtext("Age",side=1,line=3,cex=par()$cex,outer=TRUE)
})

