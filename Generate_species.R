###############################################################################
# Constants
###############################################################################
keep.DateFile <- DateFile
keep.Species <- Species
keep.SpeciesFile <- SpeciesFile
base <- paste0(RootFile, keep.Species, "/")

###############################################################################
# Generate new species for each level of sample size
###############################################################################
for(samps in yearlyn) {
  DateFile <- file.path(dirname(DateFile),
    paste0(samps, "_", basename(DateFile)))

  Species <- paste0(gsub("[[:digit:]]$", "", keep.Species), samps)
  SpeciesFile <- paste0(RootFile, Species,"/")
  dir.create(SpeciesFile, showWarnings = verbose)

  # Move files to new directory
  ignore <- file.copy(overwrite = TRUE,
    from = list.files(base, full.names = TRUE),
    to = paste0(SpeciesFile, list.files(base)))

  Build_Samplesize_Fn(folder = SpeciesFile, n = samps)

  set.seed(samps)
  source("Generate_data.R")
  source("Generate_em.R")

  DateFile <- keep.DateFile
  Species <- keep.Species
  SpeciesFile <- keep.SpeciesFile
} #end of sample size loop
