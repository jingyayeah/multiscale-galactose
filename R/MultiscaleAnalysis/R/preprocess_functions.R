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
preprocess_task <- function(folder, ids=preprocess.ids, force=FALSE){
  
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
  x.fname <- file.path(info$dir, 'results', 'x.Rdata')
  cat('Creating data matrix ...\n')
  if (file.exists(x.fname) & force==FALSE){
    load(file=x.fname)
    cat('Preprocessed data exists and is loaded.\n')
  } else {
    x <- createPreprocessDataMatrices(ids=ids, out.fname=x.fname, simIds=simIds, 
                                      modelId=info$modelId, dir=info$dir.simdata)
  }
  return(list(task=task, pars=pars, ids=ids, x=x, info=info))
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
