#' Change the samples sizes for age composition data.
#' Either a single value is supplied, where all years for all fleets are changed
#' to have the same sample size, or a vector the same length \code{#_N_Agecomp_obs}
#' is passed to \code{n}.

Build_Samplesize_Fn <- function(folder, n, fleet = 1) {
  folder <- gsub("/$", "", folder)
  dat <- readLines(file.path(folder, "hake_330.dat"))
  line.start <- grep("#_N_Agecomp_obs", dat) + 2
  line.end <- grep("#_N_MeanSize-at-Age_obs", dat) - 1
  if (grepl("#", dat[line.end])) line.end <- line.end - 1

  frame <- strsplit(dat[line.start:line.end], "[[:space:]]+")
  frame <- do.call("rbind", frame)
  frame <- t(apply(frame, 1, function(x) {
    temp <- x[!x == ""]
    as.numeric(temp)
    }))
  frame[frame[, 3] %in% fleet, 9] <- n

  lines <- apply(frame, 1, paste, collapse = " ")
  dat[line.start:line.end] <- lines

  writeLines(dat, file.path(folder, "hake_330.dat"))
  invisible(dat)
}
