###############################################################################
# Specify linenums IN BOOTSTRAP FILE (use NULL to find this out originally)
###############################################################################
DM_data_Linenums = 225:226
DM_control_Linenums = 209

###############################################################################
# Generate folders with files for each type of EM
###############################################################################
currwd <- getwd()

for(mat in dir(currwd, pattern = basename(DateFile), full.names = TRUE)) {
  DateFileOrig <- DateFile
  DateFile <- paste0(mat, "/")
for(RepI in replicates) {
  RepFile = paste0(DateFile, "Rep=", RepI, "/")
  mapply(dir.create, paste0(RepFile, Estimations))
  filenames <- c("starter.ss", "forecast.ss", "wtatage.ss",
    list.files(path = RepFile, pattern = "ctl$|exe|dat$"))
  for(Type in Estimations) {
    # If inflation factor is 1 and Type == "DM" move on to next
    if (grepl("_1-1/$", DateFile) & Type == "DM") next

    # Ensure all files exist and copy over to EM folder
    get <- paste0(RepFile, filenames)
    if(!any(file.exists(get))) {
      cat("The following files do not exist\n")
      paste(get[!file.exists(get)], collapse = " ")
      stop("stopping Generate_em.R")
    }
    file.copy(from = get, to = paste0(RepFile, Type, "/", filenames))

    #Create each specific EM
    if (Type == "DM") {
      inputlist = bundlelist(c("Type","DM_data_Linenums","DM_data_matrix","DM_control_Linenums"))
    } # End DM switch
    if (Type == "MN") {
      inputlist = bundlelist(c("Type"))
    } # End MN switch
    if (Type == "ES") {
      inputlist = bundlelist(c("Type"))
    } # End ES switch

    # Run the model
    Build_EM_Fn(inputlist, folder = paste0(RepFile, Type, "/"))
    setwd(paste0(RepFile, Type))
    shellout <- shell( "ss3.exe", intern = !verbose )

    # Run EM again after tuned
    if (Type == "ES") {
      tunewrite <- list()
      for (iter in 1:numtune) {
        # If the initial run failed to produce ss_new files
        if (!file.exists("control.ss_new")) {
          use <- "hake_330\\.ctl"
        } else {use <- "control"}
        tuneval <- tune_info(file = "Report.sso", dir = getwd())
        names <- tuneval[, "FleetName"]
        tuneval <- tuneval[, "HarEffN/MeanInputN"] * tuneval[, "Var_Adj"]
        tunewrite[length(tunewrite) + 1] <- tune_ctl(replace = tuneval, pattern = use)
        if (iter == numtune) {
          tunewrite[[length(tunewrite) + 1]] <- ifelse(tuneval > 1, 1, tuneval)
        }
        shellout <- shell( "ss3.exe", intern = !verbose )
      }
      tunewrite <- do.call("rbind", tunewrite)
      colnames(tunewrite) <- names
      write.csv(tunewrite, "tune.csv", row.names = FALSE)
    } # End ES switch

    setwd(currwd)
  } #end of estimation methods loop
} #end of replicate loop
  DateFile <- DateFileOrig
} #end of inflation matrix loop
