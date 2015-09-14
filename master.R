# Title: Dirichlet-Multinomial simulation
# Author: James T. Thorson and Kelli Faye Johnson
# Email: james.thorson@noaa.gov and kellifayejohnson@gmail.com
# Date: 09/09/2015

###############################################################################
# Set variable inputs
###############################################################################
verbose <- FALSE
replicates <- 1:100
Species = "hake_V3.3_explicitF_V2"
SigmaR = 0.9
Framp = c("min"=0.01, "max"=0.3) # No burn in

# Levels of inflation for fishery and survey age composition samples
inflationmatrix <- matrix(ncol = 2, byrow = FALSE,
  c(1, 25, 100, 1000, rep(1, 4)))
# Estimation matrix for fishery and survey age composition samples
DM_data_matrix <- matrix(byrow = TRUE, nrow = 2,
  c(-1,0.001,0,0,1,1,
    -1,0.001,0,0,0,0))

# MN: Multinomial
# DM: Dirichlet parameter
# EF: effective sample size
Estimations <- c("MN", "DM", "EF")
numtune <- 3

###############################################################################
# Set working directory and folder structure
###############################################################################
if (Sys.info()["user"] == "kelli") {
  RootFile <- "c:/SS/Dirichlet-Multinomial/"
} else {
  RootFile = "C:/Users/James.Thorson/Desktop/Project_git/Dirichlet-Multinomial/"
}
setwd(RootFile)
DateFile = paste0(RootFile, Sys.Date(), "/")
SpeciesFile = paste0(RootFile,Species,"/")
ResultsFD <- paste0(RootFile, "results"); dir.create(ResultsFD, show = verbose)

###############################################################################
# load packages
###############################################################################
#' Load packages and R functions
if(!"ThorsonUtilities" %in% installed.packages()[, 1]) {
  devtools::install_github("james-thorson/utilities")
}
library(ThorsonUtilities)
suppressWarnings(suppressMessages(library(ggplot2)))
library(r4ss)
temp <- mapply(source, list.files(paste0(RootFile, "R/"), full.names = TRUE))

###############################################################################
# Run simulation
###############################################################################
source("Generate_data.R")
source("Generate_em.R")

###############################################################################
# Read results
###############################################################################
resdf <- get_all(dirroot = RootFile, pattern = basename(DateFile))

###############################################################################
# Plot results
###############################################################################
source("Plot.R")
