################################################################
# Preprocess Functions
################################################################
# These are the actual data manipulation functions for the 
# preprocessing of the csv files. 
# The helper functions handling the file parts are in 
# PreprocessFileFunctions.R
#
# author: Matthias Koenig
# date: 2014-11-11
################################################################

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
