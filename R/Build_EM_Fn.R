Build_EM_Fn = function( inputlist, folder = RepFile ){
  # inputs
  if(!exists("verbose")) verbose <- FALSE
  attach( inputlist, warn.conflicts = verbose )
  on.exit( detach(inputlist) )

  # Change starter file
  Starter = SS_readstarter( file=paste0(folder,"starter.ss"), verbose = verbose)
  Starter[['init_values_src']] = 0
  Starter[['N_bootstraps']] = 0
  SS_writestarter( mylist=Starter, dir=folder, overwrite=TRUE, verbose=verbose, warn = verbose)

  # Modify if necessary
  if(Type=="DM"){
    # Modify DAT file
    Lines = readLines( paste0(folder,"hake_330.dat") )
    findageline <- grep("#_N_age_bins", Lines)
    dmdatlines <- grep("#_fleet:", Lines)
    dmdatlines <- dmdatlines[dmdatlines > findageline]
    Lines[dmdatlines] = apply(DM_data_matrix, MARGIN=1, FUN=paste, collapse=" ")
    writeLines(text=Lines, con=paste0(folder,"hake_330.dat"))
    # Modify CTL file
    Lines = readLines( paste0(folder,"hake_330.ctl") )
    dmctllines <- grep("ln\\(EffN_mult\\)_1", Lines)[1]
    NewLine = strsplit(Lines[dmctllines],"")[[1]]
    Lines[dmctllines] = paste0( NewLine[-grep("#",NewLine)[1]], collapse="")
    writeLines(text=Lines, con=paste0(folder,"hake_330.ctl"))
  }

}

