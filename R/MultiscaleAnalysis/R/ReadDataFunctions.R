##########################################################
# Helper functions to read Data from the CSV            '
##########################################################

#' Get integration timecourse file for simulation id.
#'@param simId simulation identifier
#'@return filename for the integration file
#'@export
getSimulationFileFromSimulationId <- function(simId){
  # TODO with cat
  fname <- paste(ma.settings$dir.simdata, '/', modelId, "_", sim, "_copasi.csv", sep="")
}

#' Load the PP and PV data for single simulation by sim name
#' The timecourse for the data should exists. This can be checked with
#' via the simulation status in the parameter files.
#' @param sim simulation identifier
#' @param withTime keeps the time column
#' @return PPPV data
#' @export
readPPPVDataForSimulation <- function(simId, withTime=F){
  # load simulation data
  fname <- getSimulationFileFromSimulationId(simId)
  data <- read.csv()
  
  # set time as row names and remove the time vector
  row.names(data) <- data$time
  
  # reduce data to PP__ and PV__ data
  pppv.index <- which(grepl("^PP__", names(data)) | grepl("^PV__", names(data)) )
  if (withTime==T){
    pppv.index <- which(grepl("^PP__", names(data)) | grepl("^PV__", names(data)) |  grepl("^time", names(data)))
  }
  data <- data[, pppv.index]
}

#' Reads the time vector from simulation identifier
#' @param sim simulation identifier
#' @return time vector
#' @export
readTimeForSimulation <- function(simId){
  tmp <- readPPPVDataForSimulation(simId, withTime=T)
  time <- tmp$time
}

#' Read the data in a list structure
#' Parameter data pars has to be available in environment.
#' @param max_index maximal index until which data is read
#' @return list of PPPV data matrices
#' @export
readPPPVData <- function(max_index=-1){
  data <- list()
  if (max_index<1){
    simulations <- row.names(pars)  
  } else {
    simulations <- row.names(pars)[1:max_index]
  }
  Nsim <- length(simulations)
  for (k in seq(1,Nsim)){
    simId <- simulations[[k]]
    print(paste(sim, ' [', k/Nsim*100, ']'))
    status = pars[simId,]$status
    
    if (length(status)==0 || status == 'DONE'){
      data[[simId]] = readPPPVDataForSimulation(simId)
    } else {
      print(paste('simulation -> ', status))
    }
  }
  data
}

#' Convert list structure into data matrix
#' @param datalist list of data matrices
#' @param compounds which compounds to take
#' @prefixes which prefixes to take
#' @return matrix of pppv data
#' @export
createDataMatrices <- function(datalist, compounds, prefixes=c('PV__')){
  time <- readTimeForSimulation(names(pars)[1])
  Ntime = length(time)
  Nsim = length(names(datalist))
  
  mat = list()
  for (prefix in prefixes){
    for (compound in compounds){
      name = paste(prefix, compound, sep="")  
      mat[[name]] <- matrix(, nrow = Ntime, ncol = Nsim)
    
      # copy all the columns
      for(k in seq(1,Nsim)){
        sim <- names(datalist)[k]
        mat[[name]][, k] <- datalist[[sim]][, name]
      }
    }
  }
  mat
}

