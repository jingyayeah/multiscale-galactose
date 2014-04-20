
#' Get the data storage filename from the parameter file name.
#' @param parsfile Parameter file
#' @return storage filename
#' @export
outfileFromParsfile <- function(parsfile){
  out.file <- paste(parsfile, '.rdata', sep="")
}

#' Get the data storage filename from the parameter file name.
#' @param parsfile Parameter file
#' @param sim.dir directory with simulation data
#' @return storage filename
#' @export
preprocess <- function(parsfile, sim.dir, outFile=NULL, max_index=-1){
  # File for storing the preprocess data
  if (is.null(outFile)){
    outFile <- outfileFromParsFile(parsfile)
  }
  
  # Read pars file
  pars <- loadParsFile(parsfile)
  if (any(pars$status != 'DONE')){
    pars <- pars[pars$status=="DONE", ]  
    warning("Not all simulations have status: DONE")
  }
  
  # Read simulations
  MI.list = readPPPVData(pars=pars, dir=sim.dir, max_index=max_index)
  MI.mat <- createDataMatrices(dir=sim.dir, datalist=MI.list)
  save(list=c('pars', 'MI.list', 'MI.mat'), file=outFile)
  rm('pars', 'MI.list', 'MI.mat')
}