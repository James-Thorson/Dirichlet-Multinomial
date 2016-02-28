
library( r4ss )
# Pearson residuals for Jim Thorson's request on 2/25/16
#dir <- 'C:/github/Dirichlet-Multinomial'
dir <- 'C:/Users/James.Thorson/Desktop/Project_git/Dirichlet-Multinomial/hake_case_study_results/'
if(!exists('dm4')) dm4 <- SS_output(file.path(dir, 'hake_V3.3_explicitF_V4/with D-M/hake_V3.3_explicitF_V4'))
source(file.path(dir,'SSplotComps_Dirichlet-Multinomial.R'))

## Pearson residuals
doPNG <- T
ht <- 7; wd<- 6
if(doPNG) {png(file.path(dir,"ageCompPearsons.png"),height=ht,width=wd,
               pointsize=10,units="in",res=300)}
if(!doPNG) {windows(width=wd,height=ht)}
SSplotComps(dm4,kind="AGE",subplot=24,printmkt=FALSE,printsex=FALSE,
            fleetnames=c("Fishery","Survey"), axis1=seq(1975,2015,5))
mtext("Year",side=1,line=3,cex=par()$cex)
if(doPNG){dev.off()}

