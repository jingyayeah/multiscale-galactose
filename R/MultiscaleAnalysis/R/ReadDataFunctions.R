##########################################################
# Helper functions to read Timecourse Data from CSV            '
##########################################################

#' Get integration timecourse file for simulation id.
#' 
#' TODO: this is not working any more with the multiple simulations
#'@param simId simulation identifier
#'@return filename for the integration file
#'@export
getSimulationFileFromSimulationId <- function(dir, simId){
  fname <- paste(dir, '/', modelId, "_", simId, "_copasi.csv", sep="")
}

#' Read all PP__ and PV__ components in a list structure.
#' Parameter data pars has to be available in environment. For all simulations
#' the csv ode solutions are loaded and the necessary components extracted.
#' @param max_index maximal index until which data is read
#' @return list of PPPV data matrices
#' @export
readPPPVData <- function(pars, dir, max_index=-1, withTime=F){
  col.indices <- which(grepl("^PP__", colnames(data)) | grepl("^PV__", colnames(data)) )
  
  if (withTime==T){
    pppv.index <- which(grepl("^PP__", colnames(data)) | grepl("^PV__", colnames(data)) |  grepl("^time", colnames(data)))
  
  readColumnData(pars, dir, col.indices, max_index)
} 


#' Read all col.indices components in a list structure.
#' Parameter data pars has to be available in environment. For all simulations
#' the csv ode solutions are loaded and the necessary components extracted.
#' @param max_index maximal index until which data is read
#' @return list of matrices
#' @export
readColumnData <- function(pars, dir, col.indices, max_index=-1){
  # Get the done simulations
  simulations <- row.names(pars)[pars$status == "DONE"]  
  Nsim <- length(simulations)
  # Handle subset
  if (max_index > 0 && max_index<=Nsim){
    simulations <- row.names(pars)[1:max_index]
    Nsim <- length(simulations)
  }
  # Read the data in list
  data <- vector('list', Nsim)
  names(data) <- simulations
  for (k in seq(1,Nsim)){
    simId <- simulations[[k]]
    print(paste(simId, ' [', k/Nsim*100, ']'))
    data[[k]] = readDataForSimulation(dir=dir, simId=simId, col.indices)
  }
  data
}

#' Load the column data for single simulation by sim name
#' 
#' @param sim simulation identifier
#' @param withTime keeps the time column
#' @return column data
#' @export
readDataForSimulation <- function(dir, simId, col.indices){
  fname <- getSimulationFileFromSimulationId(dir, simId)
  # much faster solution than read.csv
  # data <- read.csv(file=fname)
  # ! careful data is not striped with fread
  data <- fread(fname, header=T, sep=',')
  
  # necessary to trim
  setnames(data, trim(colnames(data)))
  
  # fix strange behavior via cast
  data <- as.data.frame(data)
  
  # reduce data col.indices
  data <- data[, col.indices]
}


#' Convert list structure into data matrix
#' @param datalist list of data matrices
#' @param compounds which compounds to take
#' @prefixes which prefixes to take
#' @return matrix of pppv data
#' @export
createDataMatrices <- function(dir, datalist){
  time <- readTimeForSimulation(dir, names(datalist)[1])
  Ntime = length(time)
  simulations <- names(datalist)
  Nsim = length(simulations)
  
  # compund names
  compounds <- colnames(datalist[[1]])
  Nc <- length(compounds)
  
  # create empty matrix first
  mat = vector('list', Nc)
  names(mat) <- compounds
  for (kc in seq(Nc)){
    tmp <- matrix(data=NA, nrow = Ntime, ncol = Nsim)
    colnames(tmp) <- simulations
    rownames(tmp) <- time
    
    for(ks in seq(Nsim)){
      tmp[, ks] <- datalist[[ks]][, kc]
    }
    mat[[kc]] <- tmp;
  }
  mat
}

#' Reads the time vector from simulation identifier
#' @param sim simulation identifier
#' @return time vector
#' @export
readTimeForSimulation <- function(dir, simId){
  tmp <- readPPPVDataForSimulation(dir, simId, withTime=T)
  time <- tmp$time
}

#' Reads the time vector from the simulation matrix list.
#' @param MI.mat List of simulation matrixes
#' @return time vector
#' @export
getTimeFromMIMAT <- function(MI.mat){
  names <- rownames(MI.mat[[1]])
  as.numeric(names) 
}
