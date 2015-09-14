#' Obtain sample size information from a \code{Report.sso} file after
#' running an estimation method. The function works with the newest version
#' of Stock Synthesis.

tune_info <- function(file = "Report.sso", dir = dir.run) {
  # r4ss::matchfun2
  matchfun2 <- function(string1, adjust1, string2, adjust2, cols = 1:10, 
  	matchcol1 = 1, matchcol2 = 1, objmatch = rawrep, objsubset = rawrep,
  	substr1 = TRUE, substr2 = TRUE, header = TRUE)
  {
    # return a subset of values from the report file (or other file)
    # subset is defined by character strings at the start and end, with integer
    # adjustments of the number of lines to above/below the two strings
    line1 <- match(string1,if(substr1){substring(objmatch[,matchcol1],1,nchar(string1))}else{objmatch[,matchcol1]})
    line2 <- match(string2,if(substr2){substring(objmatch[,matchcol2],1,nchar(string2))}else{objmatch[,matchcol2]})
    if (is.na(line1) | is.na(line2)) return("absent")

    if (is.numeric(cols)) {
      out <- objsubset[(line1+adjust1):(line2+adjust2), cols]
    }
    if (cols[1] == "all") {
      out <- objsubset[(line1+adjust1):(line2+adjust2), ]
    }
    if (cols[1] == "nonblank") {
      # returns only columns that contain at least one non-empty value
      out <- objsubset[(line1+adjust1):(line2+adjust2), ]
      out <- out[, apply(out, 2, emptytest) < 1]
    }
    if (header && nrow(out) > 0) {
      out[1, out[1, ] == ""] <- "NoName"
      names(out) <- out[1, ]
      out <- out[-1, ]
    }
    return(out)
  }
  # r4ss:emptytest
  emptytest <- function(x) {
  	sum(!is.na(x) & x == "") / length(x)
  }
  
  # Get information from the report file
  dir <- gsub("/$", "", dir)
  repfile <- file.path(dir, file)
  if(!file.exists(repfile)) stop(paste(refile), "does not exist")
  rawrep <- read.table(file = repfile, col.names = 1:600, fill = TRUE,
  	quote = "", colClasses = "character", nrows = -1, comment.char = "")
  rawdefs <- matchfun2("DEFINITIONS",1,"LIKELIHOOD",-1)
  defs <- rawdefs[-(1:3),apply(rawdefs[-(1:3),],2,emptytest)<1]
  defs[defs == ""] <- NA
  FleetNames <- as.character(defs[grep("fleet_names",defs[1,]),-1])
  FleetNames <- FleetNames[!is.na(FleetNames)]
  nfleets <- length(FleetNames)
  # Age comp effective N tuning check
  agentune <- matchfun2("FIT_SIZE_COMPS", -(nfleets+1), "FIT_SIZE_COMPS", -1)
  names(agentune)[10] <- "FleetName"
  agentune <- agentune[agentune$N > 0, c(10, 1, 4:9)]
  # avoid NA warnings by removing #IND values
  agentune$"MeaneffN/MeaninputN"[agentune$"MeaneffN/MeaninputN" == "-1.#IND"] <- NA
  for(i in 2:ncol(agentune)) agentune[, i] <- as.numeric(agentune[, i])
  agentune$"HarEffN/MeanInputN" <- agentune$"HarMean(effN)" / agentune$"mean(inputN*Adj)"
  return(agentune)
}
