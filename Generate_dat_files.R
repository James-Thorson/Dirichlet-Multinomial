

# Load packages
#devtools::install_github("james-thorson/utilities")
library(ThorsonUtilities)
library(r4ss)

RootFile = "C:/Users/James.Thorson/Desktop/Project_git/Dirichlet-Multinomial/"
SourceFile = paste0(RootFile,"R/")
for(i in 1:length(list.files(SourceFile))) source( paste0(SourceFile,list.files(SourceFile)[i]) )

Species = "hake_V3.3_explicitF_V2"
SpeciesFile = paste0(RootFile,Species,"/")

Date = Sys.Date()
DateFile = paste0(RootFile,Date,"/")
  dir.create(DateFile)

# directory
RepI = 1
RepFile = paste0(DateFile,"Rep=",RepI,"/")
  dir.create(RepFile)

######################
# Generate new replicated data set
######################

# Settings
SigmaR = 0.9
# Specify linenums IN BOOTSTRAP FILE (specify as NULL to find this out originally)
Index_Bootstrap_Linenums = 82:100
MarginalAgeComp_Bootstrap_Linenums = 230:279
# new F ramp
Framp = c("min"=0.01, "max"=0.3)
# Multinomial settings
MargAgeComp_Settings = list("Type"="Multinomial", "InflationFactor"=c("Fleet_1"=10, "Fleet_2"=1))
# bundle into list
inputlist = bundlelist( c("SigmaR", "Index_Bootstrap_Linenums", "MarginalAgeComp_Bootstrap_Linenums", "Framp", "MargAgeComp_Settings") )

# Generate bootstrap replicate
Record = Bootstrap_Sim_Fn( inputlist )  

######################
# Run new estimation model
######################

Type = c("DM","normal")[1]
DM_data_Linenums = 225:226
DM_data_matrix = matrix( c(-1,0.001,0,0,1,1, -1,0.001,0,0,0,0), byrow=TRUE, nrow=2)
DM_control_Linenums = 209
# bundle into list
inputlist = bundlelist( c("Type","DM_data_Linenums","DM_data_matrix","DM_control_Linenums") )

# Modify dat file as necessary to generate EM
Build_EM_Fn( inputlist )

# Run first time
shell( "ss3.exe")
