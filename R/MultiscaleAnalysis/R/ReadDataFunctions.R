##########################################################
# Helper functions to read Timecourse Data from CSV            '
##########################################################

#' Get integration timecourse file for simulation id.
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
readPPPVData <- function(pars, dir, max_index=-1){
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
    data[[k]] = readPPPVDataForSimulation(dir=dir, simId=simId)
  }
  data
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

#' Load the PP and PV data for single simulation by sim name
#' The timecourse for the data should exists. This can be checked with
#' via the simulation status in the parameter files.
#' @param sim simulation identifier
#' @param withTime keeps the time column
#' @return PPPV data
#' @export
readPPPVDataForSimulation <- function(dir, simId, withTime=F){
  # load simulation data
  fname <- getSimulationFileFromSimulationId(dir, simId)
  # much faster solution than read.csv
  # data <- read.csv(file=fname)
  # ! careful data is not striped with fread
  data <- fread(fname, header=T, sep=',')
  # necessary to trim
  setnames(data, trim(colnames(data)))
  # somehow craziness for the class is happening
  # fix this strange behavior via
  data <- as.data.frame(data)
  
  # reduce data to PP__ and PV__ data
  pppv.index <- which(grepl("^PP__", colnames(data)) | grepl("^PV__", colnames(data)) )
  if (withTime==T){
     pppv.index <- which(grepl("^PP__", colnames(data)) | grepl("^PV__", colnames(data)) |  grepl("^time", colnames(data)))
  } 
  data <- data[, pppv.index]
}

#' Reads the time vector from simulation identifier
#' @param sim simulation identifier
#' @return time vector
#' @export
readTimeForSimulation <- function(dir, simId){
  tmp <- readPPPVDataForSimulation(dir, simId, withTime=T)
  time <- tmp$time
}
