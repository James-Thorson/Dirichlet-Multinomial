
############
# NOTES:
# Report file has "FIT_AGE_COMPS" section
############

if(!"ThorsonUtilities" %in% installed.packages()[, 1]) {
  devtools::install_github("james-thorson/utilities")
}
library(ThorsonUtilities)
library( r4ss )
dir <- 'C:/Users/James.Thorson/Desktop/Project_git/Dirichlet-Multinomial/hake_case_study_results/'
source(file.path(dir,'SSplotComps_Dirichlet-Multinomial.R'))

# Pearson residuals for Jim Thorson's request on 2/25/16
for(i in 1:4){
  if(i==1) model_dir <- file.path(dir,'hake_V3.3_explicitF_V4/with D-M/')
  if(i==2) model_dir <- file.path(dir,'hake_V3.3_explicitF_V4/without D-M/')
  if(i==3) model_dir <- file.path(dir,'hake_V3.3_explicitF_V4/without D-M unweighted/')
  if(i==4) model_dir <- file.path(dir,'hake_V3.3_explicitF_V4/with D-M (ad hoc lambdas)/')
  dm4 <- SS_output(model_dir)

  # Log-param
  if(i==1 | i==4){
    DM_param = exp( dm4$parameter['ln(EffN_mult)_1','Value'] )
    # Var_adjust = (1 + DM_param*N_input) / (1 + DM_param)
    # Line 1526 from SSplotComps

    # Linear
    #dm4$agedbase[,'effective_sample_size'] = (1 + DM_param * dm4$agedbase[,'N']) / (1 + DM_param)
    dm4$agedbase[,'effective_sample_size'] = (1 + DM_param * dm4$agedbase[,'N']) / (1 + DM_param)
    # Saturating
    #dm4$agedbase[,'effective_sample_size'] = (dm4$agedbase[,'N'] + DM_param*dm4$agedbase[,'N']) / (dm4$agedbase[,'N'] + DM_param)
    # Ratio
    dm4$agedbase[,'sample_size_ratio'] = dm4$agedbase[,'effective_sample_size'] / dm4$agedbase[,'N']

    # Calculation
    dm4$agedbase[,'sd'] = sqrt( dm4$agedbase[,'Exp']*(1-dm4$agedbase[,'Exp']) / dm4$agedbase[,'effective_sample_size'] )
    dm4$agedbase[,'Pearson'] = (dm4$agedbase[,'Obs'] - dm4$agedbase[,'Exp']) / dm4$agedbase[,'sd']
  }

  ## Pearson residuals
  doPNG <- T
  ht <- 7; wd<- 6
  save_fig( file=file.path(model_dir,"Pearson_Residuals"), width=6.5, height=6.5, res=c(200,600), type=c("png","tif"), FUN=function(){
    #par( oma=c(4,4,0,0) )
    SSplotComps(dm4,kind="AGE",subplot=24,printmkt=FALSE,printsex=FALSE, fleetnames=c("Fishery","Survey"), axis1=seq(1975,2015,5))
    mtext("Year",side=1,line=3,cex=par()$cex,outer=TRUE)
    #mtext("Age",side=1,line=3,cex=par()$cex,outer=TRUE)
  })
}

