#' Find a specific line in a \code{control.ss_new} file and then replace
#' the numeric values in the \code{.ctl} file at that specific 
#' line with the information provided in \code{replace}.
#' A new file will be written to \code{hake_330.ctl} file in the same
#' directory that the \code{control.ss_new} file was found. 
#' If \code{is.null(folder)} is \code{TRUE} then \code{folder} will be set
#' to the current \code{getwd()}.

tune_ctl <- function(word = "#_mult_by_agecomp_N", folder = NULL, replace = new) {
  # get directory and filename
  if(is.null(folder)) folder <- getwd()
  folder <- gsub("/$", "", folder)
  ctlname <- list.files(folder, pattern = "ctl", full.names = TRUE)
  # read the ctl
  ctl <- readLines(ctlname)

  line <- grep(word, ctl, value = FALSE)
  x <- ctl[line]
  x <- strsplit(x, " ")
  keep <- sapply(x, "[[", 1)
  keep <- !grepl("#", keep)
  x <- x[keep]
  x <- lapply(x, function(w) {
  	w <- w[!w == ""]
  	remove <- grepl("[[:space:]]+|#|[[:alpha:]]+", w)
  	w <- w[!remove]
    return(as.numeric(w))
  })

  replace <- ifelse(replace > 1, 1, replace)
  if(NCOL(replace) > 1) {
  	newword <- paste(apply(replace, 2, paste, collapse = " "), word)
  } else {
  	newword <- paste(paste(replace, collapse = " "), word)
  }
  
  ctl[line[keep]] <- newword
  writeLines(ctl, file.path(folder, "hake_330.ctl"))

  return(x)
}
