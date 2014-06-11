#' Get integration timecourse file for simulation id.
#' 
#' TODO: this is not working any more with the multiple simulations
#'@param simId simulation identifier
#'@return filename for the integration file
#'@export
getSimulationFileFromSimulationId <- function(dir, simId){
  if (ma.settings$simulator == 'COPASI'){
    fname <- paste(dir, '/', modelId, "_", simId, "_copasi.csv", sep="")  
  } else if (ma.settings$simulator == 'ROADRUNNER'){
    fname <- paste(dir, '/', modelId, "_", simId, "_roadrunner.csv", sep="")  
  }
  fname
}

#' Get the data storage filename from the parameter file name.
#'
#' @param parsfile Parameter file
#' @return storage filename
#' @export
outfileFromParsFile <- function(parsfile){
  out.file <- paste(parsfile, '.rdata', sep="")
}

#' Function to get the PPPV column indices from the data.
#' @param data CSV data frame
#' @param withTime the time vector is part of the columns
#' @return the column indices which should be used
#' @export
getColumnIndicesPPPV <- function(data){
  col.indices <- which(grepl("time", colnames(data))  | 
                       grepl("^PP__", colnames(data)) | 
                       grepl("^PV__", colnames(data)) )
}

#' Do the PPPV preprocessing, i.e. only the PPPV data.
#' @param parsfile Parameter file
#' @param sim.dir directory with simulation data
#' @param outFile filename to store Rdata
#' @param sim.indices which simulations to take
#' @return the preprocessed data
#' @export 
preprocessPPPV <- function(parsfile, sim.dir, outFile=NULL, sim.indices=NULL){
  f <- getColumnIndicesPPPV
  preprocess(parsfile, sim.dir, outFile=outFile, sim.indices=sim.indices, col.indices_f=f)
}
  

#' Preprocess the CSV simulation data for given parameter file.
#' 
#' @param parsfile Parameter file
#' @param sim.dir directory with simulation data
#' @param sim.indices which simulations to take
#' @param col.indices_f function to get column indices to take
#' @return outFile file with the saved data
#' @export
preprocess <- function(pars, sim.dir, outFile=NULL, sim.indices=NULL, col.indices_f=NULL, time=NULL){
  print('sim.indices:')
  print(sim.indices)
  print('col.indices_f:')
  print(col.indices_f)
    
  # Reduce pars to the simulations which should be taken
  if (is.null(sim.indices)){
     pars.sim <- pars
  } else {
     pars.sim <- pars[sim.indices, ] 
  }
  
  # Reduce to 'DONE' status
  if (any(pars.sim$status != 'DONE')){
    pars.sim <- pars.sim[pars.sim$status=="DONE", ]  
    warning("Not all simulations have status: DONE")
  }  
  
  # Read simulations
  missing <- findMissingTimecourses(pars=pars, dir=sim.dir)
  if (length(missing) > 0){
    for (name in names(missing)){
      warning(name)
    }
    stop()
  }
  
  print('Create preprocess list')
  preprocess.list = readColumnData(pars=pars.sim, dir=sim.dir, col.indices_f)
  print('Create preprocess matrix')
  print(ma.settings$simulator)
  if (ma.settings$simulator == 'COPASI' || ma.settings$simulator == 'ROADRUNNER_STEPS'){
    # Fixed step size in the timecourse => easy to put in matrix
    preprocess.mat <- createDataMatrices(dir=sim.dir, datalist=preprocess.list)  
  }else if (ma.settings$simulator == 'ROADRUNNER'){
    # Variable stepsize with different step size for every integration
    # necessary to unify the timesteps
    # preprocess.mat <- createVariableStepDataMatrices(dir=sim.dir, datalist=preprocess.list)
    preprocess.mat <- createDataMatricesVarSteps(dir=sim.dir, datalist=preprocess.list, time) 
  }
  
  # Store
  if (is.null(outFile)){
    outFile <- outfileFromParsFile(parsfile)
  }
  save(list=c('pars', 'preprocess.list', 'preprocess.mat'), file=outFile)
  outFile
}

#' Find missing timecourse files.
#' @export
findMissingTimecourses <- function(pars, dir){
  # check if all the files are available
  simulations <- row.names(pars)
  missing <- list()
  for (simId in simulations){
    fname <- getSimulationFileFromSimulationId(dir, simId)
    if (!file.exists(fname)){
      missing[[fname]] <- fname
    }
  }
  missing
}

#' Read all col.indices components in a list structure.
#' Parameter data pars has to be available in environment. For all simulations
#' the csv ode solutions are loaded and the necessary components extracted.
#' @param max_index maximal index until which data is read
#' @return list of matrices
#' @export
readColumnData <- function(pars, dir, col.indices_f){
  simulations <- row.names(pars)
  Nsim <- length(simulations)
  
  # Read the data in list
  data <- vector('list', Nsim)
  names(data) <- simulations
  for (k in seq(1,Nsim)){
    simId <- simulations[[k]]
    print(paste(simId, ' [', k/Nsim*100, ']'))
    data[[k]] = readDataForSimulation(dir=dir, simId=simId, col.indices_f)
  }
  data
}

#' Load the column data for single simulation by sim name
#' 
#' @param sim simulation identifier
#' @param withTime keeps the time column
#' @return column data
#' @export
readDataForSimulation <- function(dir, simId, col.indices_f){
  fname <- getSimulationFileFromSimulationId(dir, simId)
  
  # much faster solution than read.csv
  # data <- read.csv(file=fname)
  # ! careful data is not striped with fread
  data <- fread(fname, header=T, sep=',')
  
  # replace 'X..' if header given via '# '
  names(data) <- gsub('X..', '', names(data))
  names(data) <- gsub('#', '', names(data))
  names(data) <- gsub('\\[', '', names(data))
  names(data) <- gsub('\\]', '', names(data))
  
  # necessary to trim
  setnames(data, trim(colnames(data)))
  
  # fix strange behavior via cast
  data <- as.data.frame(data)
  rownames(data) <- data[,'time']
  
  # reduce data col.indices given by the function
  if (!is.null(col.indices_f)){
    col.indices <- col.indices_f(data)
    data <- data[, col.indices]
  }
  data
}

#' Reads the time vector from the simulation matrix list.
#' @param MI.mat List of simulation matrixes
#' @return time vector
#' @export
getTimeFromPreprocessMatrix <- function(preprocess.mat){
  names <- rownames(preprocess.mat[[1]])
  as.numeric(names) 
}

#' Convert timecourse list structure into data matrix.
#' 
#' @param datalist list of data matrices
#' @param compounds which compounds to take
#' @prefixes which prefixes to take
#' @return matrix of pppv data
#' @export
createDataMatrices <- function(dir, datalist){
  simulations <- names(datalist)
  Nsim = length(simulations)
  
  # compund names
  compounds <- colnames(datalist[[1]])
  Nc <- length(compounds)
  
  # create empty matrix first
  mat = vector('list', Nc)
  names(mat) <- compounds
  
  time <- as.numeric(rownames(datalist[[1]]))
  Ntime = length(time)
  
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


#' Convert timecourse list structure into data matrix.
#' 
#' @param datalist list of data matrices
#' @param compounds which compounds to take
#' @time time for interpolation
#' @prefixes which prefixes to take
#' @return matrix of pppv data
#' @export
createDataMatricesVarSteps <- function(dir, datalist, time){
  simulations <- names(datalist)
  Nsim = length(simulations)
  
  # compund names
  compounds <- colnames(datalist[[1]])
  Nc <- length(compounds)
  
  # create empty matrix first
  mat = vector('list', Nc)
  names(mat) <- compounds
  
  Ntime = length(time)
  
  for (kc in seq(Nc)){
    tmp <- matrix(data=NA, nrow = Ntime, ncol = Nsim)
    colnames(tmp) <- simulations
    rownames(tmp) <- time
    
    for(ks in seq(Nsim)){
      data.approx <- approx(datalist[[ks]][, 'time'], datalist[[ks]][, kc], xout=time, method="linear")
      tmp[, ks] <- data.approx[[2]]
    }
    mat[[kc]] <- tmp;
  }
  mat
}


