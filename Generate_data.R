###############################################################################
# Specify linenums IN BOOTSTRAP FILE (use NULL to find this out originally)
###############################################################################
Index_Bootstrap_Linenums = 82:100
MarginalAgeComp_Bootstrap_Linenums = 230:279

###############################################################################
# Generate new replicated data set for each replicate
###############################################################################
for(mat in 1:NROW(inflationmatrix)) {
  inflation <- inflationmatrix[mat, ]
  inflationname <- paste(inflation, collapse = "-")

  for(RepI in replicates) {
    DateFileOrig <- DateFile
    DateFile <- paste0(gsub("/$", "", DateFile), "_", inflationname, "/")
    RepFile = paste0(DateFile,"Rep=",RepI,"/")
    dir.create(RepFile, recursive = TRUE)

    # Multinomial settings
    MargAgeComp_Settings = list(
      "Type"="Multinomial",
      "InflationFactor"=c("Fleet_1"=inflation[1], "Fleet_2"=inflation[2]))
    inputlist = bundlelist(c(
      "SigmaR",
      "Index_Bootstrap_Linenums",
      "MarginalAgeComp_Bootstrap_Linenums",
      "Framp",
      "MargAgeComp_Settings"))

    # Generate bootstrap replicate
    Bootstrap_Sim_Fn( inputlist )
    setwd(RootFile)
    DateFile <- DateFileOrig
  } #end replicate loop
} #end of inflation matrix loop
