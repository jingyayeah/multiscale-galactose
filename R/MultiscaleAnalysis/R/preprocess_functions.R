################################################################
# Preprocess Functions
################################################################
# These are the actual data manipulation functions for the 
# preprocessing of the csv files. 
# The helper functions handling the file parts are in 
# PreprocessFileFunctions.R
#
# author: Matthias Koenig
# date: 2014-12-07
################################################################

#' Process folder information.
#' 
#' From the folder information all the additional information can be created.
#' @export
process_folder_info <- function(folder){
  dir <- file.path(ma.settings$dir.results, folder)
  tmp <- strsplit(folder, '_')
  date <- tmp[[1]][1]
  task <- tmp[[1]][2]
  modelXML <- list.files(path=file.path(ma.settings$dir.results, folder), pattern='.xml')
  modelId <- substr(modelXML,1,nchar(modelXML)-4)
  f.sbml <- file.path(dir, sprintf('%s.xml', modelId))
  parsfile <- file.path(dir, sprintf('%s_%s_parameters.csv', task, modelId))
  dir.simdata <- file.path(ma.settings$dir.results, 'django', 'timecourse', task)
  return (list(folder=folder, dir=dir, date=date, task=task, parsfile=parsfile, 
               modelId=modelId, f.sbml=f.sbml,
               dir.simdata=dir.simdata) )  
}


#' Preprocess the results for given folder.
#' 
#' Generates the combined Rdata file for the selected ids.
#' The collection of data files to be preprocessed is defined via
#  the folder variable which encodes the task.
#' Read the timecourse data (CSV) and creates reduced data
#' structures consisting of some components of the full
#' sinusoidal system.
#' All simulation csv have been collected in a common folder.
#' Main challenge is the combination of the timecourses based
#' the varying timesteps used for simulation.
#' Important part is also dimension reduction of the data
#' structure.
#' Folder format follows '2014-11-17_T5'.
#' @export
preprocess_task <- function(folder, ids=preprocess.ids, force=FALSE, out_name='x'){
  if (missing(folder))
    stop('Need to specify folder for preprocessing.')
  # get all the information from the folder
  info <- process_folder_info(folder)
  
  # create results folder
  dir.create(file.path(info$dir, 'results'), showWarnings = FALSE)
  
  # read parameter file & extend with SBML information
  cat(info$parsfile, '\n')
  pars <- loadParameterFile(file=info$parsfile)
  
  # extend the parameter information with info from SBML file
  ps <- getParameterTypes(pars=pars)
  model <- loadSBMLModel(info$f.sbml)
  pars <- extendParameterStructure(pars=pars, fixed_ps=ps$fixed, model=model)
  
  # Preprocess timecourses as Rdata
  simIds = rownames(pars)
  fname <- file.path(info$dir, 'results', sprintf('%s.Rdata', out_name))
  
  cat('Creating data matrix ...\n')
  if (file.exists(fname) & force==FALSE){
    load(file=fname)
    cat('Preprocessed data exists and is loaded.\n')
  } else {
    x <- createPreprocessDataMatrices(ids=ids, out.fname=fname, simIds=simIds, 
                                      modelId=info$modelId, dir=info$dir.simdata)
  }
  return(list(pars=pars, ids=ids, x=x, info=info))
}

#' Dimension reduction of timecourse data frames.
#' 
#' The main idea is to reduce the amount of information necessary
#' to encode the non-changing components in the solution.
#' I.e. elements of one component of the integration solution are
#' reduced to the changing time points.
#' The first and last element are kept as well as all inner elements, which
#' are not identical to the previous ones, within a certain tolerance. The 
#' tolerance is here selected in accordance with the absolute tolerances
#' of the integration (which is 1E-6).
#' @export
reduceDimension <- function(df, eps=1E-8){
  Nr = nrow(df)
  unique_indices <- abs(df[2:(Nr-1),2]-df[1:(Nr-2),2])>eps
  indices <- c(TRUE, unique_indices, TRUE)
  res <- df[indices, ]
}

#' Handle Event timepoints.
#' 
#' Timepoints with corresponding data points are added for the events.
#' This is mainly for plotting the solution, which would not represent correctly
#' the fast change in components at the events without these datapoints.
#' @export
addEventPoints <- function(df){
  Nr = nrow(df)
  event_indices <- 1 + which(abs(df[2:Nr,2]-df[1:(Nr-1),2])>0.1)
  # add rows to the dataframe at the end
  rnew <- data.frame( (df[event_indices, 1]-1E-8), df[(event_indices-1),2] )
  names(rnew) <- names(df) # ? needed ?
  df <- rbind(df, rnew)  
  df <- df[with(df, order(time)),] # sort the data frame
}

#' Create data matrices.
#' 
#' Main function of preprocessing the csv data from integration.
#' Creates list of lists for the given ids from the timeseries data.
#' Perfoms Dimensionality reduction and adds interpolated timepoints 
#' for the events
#' Creates data matrices for the given ids and selected simulations.
#' Most of the time if the simulation number is not (>10000) no 
#' restriction of the simulations via simIds is necessary.
#' @export
createPreprocessDataMatrices <- function(ids, out.fname, simIds, modelId, dir){
  # Create the list for storage of the matrices
  x <- vector('list', length(ids))
  names(x) <- ids
  
  # Create list of lists
  Nsim = length(simIds)
  for (id in ids){  
    x[[id]] <- vector('list', Nsim)
    names(x[[id]]) <- simIds
  }
  
  # Fill the lists
  for (ks in seq(Nsim)){
    cat(ks/Nsim*100, '\n')  
    # load data as 'data' and put in list
    fname <- getSimulationFileFromSimulationId(dir, simIds[ks], modelId)
    load(paste(fname, '.Rdata', sep=''))
    for (id in ids){
      df <- data[, c('time', id)];
      df <- reduceDimension(df)
      df <- addEventPoints(df)
      x[[id]][[ks]] <- df
    }
  }
  save(x, ids, file=out.fname)
  return(x)
}

#' Creates approximation data matrix for time and data vectors.
#' 
#' Necessary to create a compatible data structure which has values
#' for all timepoints. Filling the gaps in the variable timestep solutions
#' from different integrations via linear interpolation of the available
#' datapoints for the given components.
#'
#' if reverse=FALSE => fit time vector
#' if reverse=TRUE => fit data vector
#' @export
createApproximationMatrix <- function(x, ids, simIds, points, reverse=FALSE){
  Npoints <- length(points)
  Nsim <- length(simIds)
  
  # setup the results list
  mlist <- vector('list', length(ids))
  names(mlist) <- ids
  for (id in ids){
    # setup the empty matrix
    mlist[[id]] <- matrix(data=NA, nrow=Npoints, ncol=Nsim)
    colnames(mlist[[id]]) <- simIds
    rownames(mlist[[id]]) <- points
    
    # fill the matrix with linear interpolated data between data points
    for(ks in seq(Nsim)){
      datalist <- x[[id]]
      if (reverse == FALSE){
        # fit the time
        data.interp <- approx(datalist[[ks]][, 1], datalist[[ks]][, 2], xout=points, method="linear")
      } else if (reverse == TRUE){
        # fit the points
        data.interp <- approx(datalist[[ks]][, 2], datalist[[ks]][, 1], xout=points, method="linear")
      }
      mlist[[id]][, ks] <- data.interp[[2]]
    }
  }
  return(mlist)
}

###########################################
# Parameter & Simulation files
###########################################

#' Get integration timecourse file for simulation id.
#' 
#' TODO: this is not working any more with the multiple simulations
#'@param simId simulation identifier
#'@return filename for the integration file
#'@export
getSimulationFileFromSimulationId <- function(dir, simId, modelId){
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
  
  # For the preprocess list all the single simulation files are read
  # and stored in a list. This takes a lot of space and is very inefficient.
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

#' Read all col.indices components and store R data structures.
#' For all simulations the csv files are loaded and the 
#' respective columns extracted.
#' @param max_index maximal index until which data is read
#' @return list of matrices
#' @export
createColumnDataFiles <- function(pars, dir, col.indices_f=NULL){
  simulations <- row.names(pars)
  Nsim <- length(simulations)
  for (k in seq(1,Nsim)){
    simId <- simulations[[k]]
    print(paste(simId, ' [', k/Nsim*100, ']'))
    
    # read data and save
    fname <- getSimulationFileFromSimulationId(dir, simId)
    data <- readDataForSimulationFile(fname, col.indices_f)
    save(data, file=paste(fname, '.Rdata', sep=''))
  }
}


#' Load the column data for simulation file.
#' 
#' @param fname CSV file to load
#' @return column data
#' @export
readDataForSimulationFile <- function(fname, col.indices_f=NULL){
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
#' TODO: fix the performance (select only subset of interest)
#' 
#' @param datalist list of data matrices
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
#' @param time for interpolation
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
