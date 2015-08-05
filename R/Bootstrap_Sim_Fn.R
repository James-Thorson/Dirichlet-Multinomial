Bootstrap_Sim_Fn = function( inputlist ){
  # inputs
  attach( inputlist )
  on.exit( detach(inputlist) ) 
  
  # Move files to new directory
  file.copy( from=paste0(SpeciesFile,list.files(SpeciesFile)), to=paste0(RepFile,list.files(SpeciesFile)), overwrite=TRUE)

  # Modify par file
  Par = scan_admb_par( paste0(RepFile,"ss3.par"))
  # Generate and write rec-devs to par file
  if( "SigmaR" %in% names(inputlist)){
    Which = union( grep("recdev",names(Par)), grep("recruitment",names(Par)))
    Par[Which] = rnorm( length(Which), mean=-SigmaR^2/2, sd=SigmaR)
  }
  # Generate and write new F trajectory
  if( "Framp" %in% names(inputlist)){
    Which = grep("F_rate",names(Par))
    Par[Which] = seq( from=Framp['min'], to=Framp['max'], length=length(Which))
  }
  # Write par file
  write.table( Par, file=paste0(RepFile,"ss3.par"), row.names=FALSE, col.names=FALSE)

  # Change starter file
  Starter = SS_readstarter( file=paste0(RepFile,"starter.ss"))
  Starter[['init_values_src']] = 1
  Starter[['N_bootstraps']] = 2
  SS_writestarter( mylist=Starter, dir=RepFile, overwrite=TRUE, verbose=FALSE)

  # Run first time
  setwd( RepFile )
  shell( "ss3.exe -maxfn 0 -nohess")

  # Write bootstrap simulation to data file
  Lines = readLines( paste0(RepFile,"data.ss_new") )
  Lines = Lines[ (grep("#_expected values with no error added ",Lines)+1):grep("ENDDATA",Lines)]
  writeLines(text=Lines, con=paste0(RepFile,Starter[['datfile']]))

  # Stop if running for first time
  if( is.null(Index_Bootstrap_Linenums) | is.null(MarginalAgeComp_Bootstrap_Linenums) ){
    print("Stop and inspect bootstrap datfile for linenums")
    return()
  }

  # Simulate new indices
  Lines = readLines( paste0(RepFile,Starter[['datfile']]) )
  for(i in Index_Bootstrap_Linenums){
    NewLine = as.numeric(strsplit( Lines[i]," ")[[1]][1:5])
    NewLine[4] = rlnorm(1, meanlog=log(NewLine[4]), sdlog=NewLine[5])
    Lines[i] = paste(NewLine, collapse=" ")
  }
  writeLines( text=Lines, paste0(RepFile,Starter[['datfile']]) )

  # Simulate new age-comps
  Lines = readLines( paste0(RepFile,Starter[['datfile']]) )
  for(i in MarginalAgeComp_Bootstrap_Linenums){
    NewLine = na.omit(as.numeric(strsplit( Lines[i]," ")[[1]]))
    if( MargAgeComp_Settings[["Type"]]=="Multinomial"){
      NewLine[-c(1:9)] = rmultinom(n=1, size=NewLine[9], prob=NewLine[-c(1:9)])[,1]
      NewLine[9] = NewLine[9] * MargAgeComp_Settings[["InflationFactor"]][paste0("Fleet_",NewLine[3])]
    }
    Lines[i] = paste(NewLine, collapse=" ")
  }
  writeLines( text=Lines, paste0(RepFile,Starter[['datfile']]) )

  # Remove commenting if necessary
  Lines = readLines( paste0(RepFile,Starter[['datfile']]) )
  if( any(Lines=="#0 # N sizefreq methods to read ") ){
    Which = which(Lines=="#0 # N sizefreq methods to read ")
    Lines[Which] = "0 # N sizefreq methods to read" 
  }
  writeLines( text=Lines, paste0(RepFile,Starter[['datfile']]) )
  
  # Return stuff
  Return = list( "Success"=1, "TruePar"=Par )
  return(Return)
}
