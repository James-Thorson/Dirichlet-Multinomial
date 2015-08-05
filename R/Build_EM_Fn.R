Build_EM_Fn = function( inputlist ){
  # inputs
  attach( inputlist )
  on.exit( detach(inputlist) )

  # Stop if running for first time
  if( is.null(Index_Bootstrap_Linenums) | is.null(MarginalAgeComp_Bootstrap_Linenums) ){
    print("Stop and inspect datfile for linenums")
    return()
  }

  # Change starter file
  Starter = SS_readstarter( file=paste0(RepFile,"starter.ss"))
  Starter[['init_values_src']] = 0
  Starter[['N_bootstraps']] = 0
  SS_writestarter( mylist=Starter, dir=RepFile, overwrite=TRUE, verbose=FALSE)

  # Modify if necessary
  if(Type=="DM"){
    # Modify DAT file
    Lines = readLines( paste0(RepFile,"hake_330.dat") )
    Lines[DM_data_Linenums] = apply(DM_data_matrix, MARGIN=1, FUN=paste, collapse=" ")
    writeLines(text=Lines, con=paste0(RepFile,"hake_330.dat"))
    # Modify CTL file
    Lines = readLines( paste0(RepFile,"hake_330.ctl") )
    NewLine = strsplit(Lines[DM_control_Linenums],"")[[1]]
    Lines[DM_control_Linenums] = paste0( NewLine[-grep("#",NewLine)[1]], collapse="")
    writeLines(text=Lines, con=paste0(RepFile,"hake_330.ctl"))
  }

}

