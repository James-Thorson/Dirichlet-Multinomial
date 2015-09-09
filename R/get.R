###############################################################################
# Get results from an folder with EM or OM data
###############################################################################
get_results <- function(dir, type = "EM", verbose = FALSE) {
  nanumber <- -999
  reportname <- paste0(dir, "/Report.sso")
  if(!file.exists(reportname)) {
    if (verbose) warning(paste(reportname, "does not exist"))
    return()
  }
  data <- readLines(reportname)
  # Find terminal year statistics
  yeart <- unlist(strsplit(tail(grep("TIME 1", data, value = TRUE), 1), "[[:space:]]+"))[2]
  derived <- data.frame(MSY = get_derived(find = "TotYield_MSY", data),
                        depletion = get_derived(find = paste0("Bratio_", yeart), data),
                        F = get_derived(find = paste0("F_", yeart), data),
                        SSB = get_derived(find = paste0("SPB_", yeart), data))
  controlname <- paste0(dir, "/control.ss_new")
  if(!file.exists(controlname)) {
    if (verbose) warning(paste(controlname, "does not exist"))
    return()
  }
  pars <- SS_parlines(ctlfile = controlname, active = TRUE)$INIT
  names(pars) <- gsub("\\(|\\)", "",
    SS_parlines(ctlfile = controlname, active = TRUE)$Label)
  pars <- data.frame(t(pars))
  # Calculate the logistic selectivity values from the age-based selectivity pars
  pars <- get_selectivity(pars)

  # if EM
  if (type == "EM") {
    # obtain dirichlet parameter if it exists else leave as NA
    if (any(grepl("lnEffN_mult_1", colnames(pars)))) {
        temp <- grep("ln\\(EffN_mult\\)_1", data, value = TRUE)
        pars$"lnEffN_mult_1_SD" <- as.numeric(unlist(strsplit(temp, "[[:space:]]+"))[10])
    } else {
        pars$"lnEffN_mult_1" <- nanumber
        pars$"lnEffN_mult_1_SD" <- nanumber
    }
    if (any(grepl("lnEffN_mult_2", colnames(pars)))) {
        temp <- grep("ln\\(EffN_mult\\)_2", data, value = TRUE)
        pars$"lnEffN_mult_2_SD" <- as.numeric(unlist(strsplit(temp, "[[:space:]]+"))[10])
    } else {
        pars$"lnEffN_mult_2" <- nanumber
        pars$"lnEffN_mult_2_SD" <- nanumber
    }
    range <- grep("Lambda Lambda|Surv_like", data) + 2
    likes <- gsub(" 1$", "", data[range[1]:range[2]][c(1, 3, 5:8, 17)])
    agecomponent <- strsplit(likes[7], "[[:space:]]+")[[1]]
    likes[7] <- paste("Age_catch", agecomponent[3])
    likes[8] <- paste("Age_survey", agecomponent[4])
    likes <- c(grep("TOTAL ", data, value = TRUE), likes)
    names(likes) <- paste0("Like_", sapply(strsplit(likes, "[[:space:]]+"), "[", 1))
    likes <- t(sapply(strsplit(likes, " "), "[", 2))
    mode(likes) <- "numeric"
    gradient <- grep("is_final_gradient", data, value = TRUE)
    gradient <- as.numeric(strsplit(gradient, "[[:space:]]")[[1]][2])
    model <- basename(dir)
    report <- data.frame(pars, likes, gradient, model)
  }
  # if OM
  if (type == "OM") {
    colnames(pars) <- paste0(colnames(pars), "_", type)
    colnames(derived) <- paste0(colnames(derived), "_", type)
    report <- data.frame(pars)
  }
  report <- data.frame(report, derived)
  report[report == nanumber] <- NA
  invisible(report)
}

###############################################################################
# Get all information from a replicate folder
###############################################################################
get_replicate <- function(dirreplicate, verbose = FALSE) {
  # OM
  om <- get_results(dir = dirreplicate, type = "OM", verbose = verbose)
  # EMs
  fdem <- list.dirs(dirreplicate, recursive = FALSE, full.names = TRUE)
  em <- list()
  for (i in seq_along(fdem)) {
    em[[length(em) + 1]] <- get_results(dir = fdem[i], type = "EM")
  }
  em <- do.call("rbind", em)
  if(is.null(em)) return()
  om <- as.data.frame(lapply(om, rep, NROW(em)))
  # Iteration number
  iteration <- as.numeric(strsplit(dirreplicate, "=")[[1]][2])
  # Iteration information
  info <- readLines(paste0(dirreplicate, "/info_data.txt"))
  mult <- as.data.frame(lapply(setNames(strsplit(info[3],
    "[[:space:]]+")[[1]], c("Nfishery", "Nsurvey")), rep, NROW(em)))
  omtype <- info[2]

  # Calculate relative error
  omnames <- gsub("_OM", "", colnames(om))
  keep <- em[, colnames(em) %in% omnames]
  keep <- keep[, omnames]
  re <- (keep - om) / om
  colnames(re) <- gsub("OM", "RE", colnames(om))
  # Combine all the results into a single data.frame
  results <- data.frame(om, em, re, iteration, omtype, mult)
  invisible(results)
}

###############################################################################
# Get all replicates within a folder
###############################################################################
get_dir <- function(dirdir, verbose = FALSE) {
  directories <- dir(dirdir, pattern = "Rep", full.names = TRUE)
  results <- list()
  for(i in directories) {
    temp <- get_replicate(i, verbose = verbose)
    if(is.null(temp)) next
    results[[length(results) + 1]] <- temp
  } # end of loop through replicate directories
  results <- do.call("rbind", results)
  invisible(results)
}

###############################################################################
# Get all folders containing replicates
###############################################################################
get_all <- function(dirroot, pattern = basename(DateFile), verbose = FALSE) {
  scenarios <- dir(dirroot, pattern = pattern)
  temp <- do.call("rbind", lapply(scenarios, get_dir, verbose = verbose))
  results <- calc_factororder(temp)
  invisible(temp)
}


###############################################################################
# Obtain selectivity parameters from SS estimates for age-based selectivity
###############################################################################
get_selectivity <- function(pars) {
  whichkeep <- grep("AgeSel", names(pars))
  keep <- unlist(c(pars[whichkeep]))
  fishorsurv <- gsub("AgeSel_P[[:alnum:]]_|\\.[[:alnum:]]\\.", "", names(keep))
  vals <- unlist(tapply(keep, fishorsurv, calc_selectivity))
  pars[whichkeep] <- vals
  return(pars)
}

calc_selectivity <- function(x) {
  exp(cumsum(x) - sum(x))
}

###############################################################################
# Order factors as needed
###############################################################################
calc_factororder <- function(x) {
  factorcols <- sapply(x, is.factor)
  factorcols <- which(factorcols == TRUE)
  if (length(factorcols) < 1) return(x)
  for (fact in factorcols) {
    isnumber <- any(grepl("^[[:alpha:]]+", x[, fact]))
    if (isnumber) next
    neworder <- order(as.numeric(levels(x[, fact])))
    x[, fact] <- factor(x[, fact], levels(x[, fact])[neworder])
  } #end loop through factor columns
  invisible(x)
}

###############################################################################
# Find derived quantities
###############################################################################
get_derived <- function(find, x) {
  value <- unlist(strsplit(grep(find, x, value = TRUE), "[[:space:]]+"))
  value <- suppressWarnings(as.numeric(value))
  value <- value[!is.na(value)][1]
  return(value)
}
