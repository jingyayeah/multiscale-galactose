################################################################
# Preprocess Data
################################################################
# Read the timecourse data and creates reduced data structures
# for simplified query and visualization.
#
# Run with: Rscript
# author: Matthias Koenig
# date: 2014-08-11
################################################################
library(data.table)
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)

## Functions
# now all the Rdata files exist: 
# putting things together from the different calculations to calculate
# statistical values
# The variable timesteps have to be accounted for.

## Dimension Reduction ## 
# Alternative dimension reduction based on the RDP algorithm
# http://en.wikipedia.org/wiki/Ramer%E2%80%93Douglas%E2%80%93Peucker_algorithm
# Ramer–Douglas–Peucker algorithm
reduceDimension <- function(df){
  # Reduction of dimensionality for given dataframe consisting
  # of time, data
  # The first and last element are kept as well as all inner elements, which
  # are not identical to the previous one in respect to the data
  Nr = nrow(df)
  unique_indices <- abs(df[2:(Nr-1),2]-df[1:(Nr-2),2])>1E-8  
  indices <- c(TRUE, unique_indices, TRUE)
  res <- df[indices, ]
}

## Add Event timepoints ##
# necessary to add event points for plotting purposes.
# Otherwise there are large jumps in the values during plotting
addEventPoints <- function(df){
  Nr = nrow(df)
  event_indices <- 1 + which(abs(df[2:Nr,2]-df[1:(Nr-1),2])>0.1)
  # add rows to the dataframe at the end
  rnew <- data.frame( (df[event_indices, 1]-1E-8), df[(event_indices-1),2] )
  names(rnew) <- names(df)
  # print(sprintf("%.10f",rnew[1]))
  df <- rbind(df, rnew)  
  # sort the data frame
  df <- df[with(df, order(time)),]
}

# Creates list of lists for the given ids from the timeseries data.
# Perfoms Dimensionality reduction and adds interpolated timepoints 
# for the events
createDataMatrices <- function(ids, out.fname, simIds){
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
    fname <- getSimulationFileFromSimulationId(ma.settings$dir.simdata, simIds[ks])
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

## Calculation of statistical values for the timecourses.
# Necessary to create a compatible data structure which has values
# for all timepoints.
# Use t-approx to create timecourse matrix
# than calculate values on the matrix
# 1. calculate the matrix 5000 x 200/0.05 (4000)
#                              x 50/0.01 (5000)   

# Creates the approximation of the time, data vector.
# if reverse=FALSE => fit time vector
# if reverse=TRUE => fit data vector
createApproximationMatrix <- function(ids, simIds, points, reverse=FALSE){
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
    
    # fill the matrix with interpolated data
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




###############################################################
# preprocess  - create necessary variables
###############################################################
# data to preprocess (folder <- '2014-07-30_T26')
print(folder)
if (!exists('folder')){   
  stop('no folder for preprocessing set')
}
tmp <- strsplit(folder, '_')
date <- tmp[[1]][1]
task <- tmp[[1]][2]

modelXML <- list.files(path=file.path(ma.settings$dir.results, folder), pattern='.xml')
modelId <- substr(modelXML,1,nchar(modelXML)-4)

ma.settings$dir.simdata <- file.path(ma.settings$dir.results, folder, task)
parsfile <- file.path(ma.settings$dir.results, folder, 
                      paste(task, '_', modelId, '_parameters.csv', sep=""))
rm(tmp, modelXML)

# make results folder
dir.create(file.path(folder, 'results'), showWarnings = FALSE)

# read parameter file
print(parsfile)
pars <- loadParameterFile(file=parsfile)
simIds = rownames(pars)
head(pars)
# plotParameterHistogramFull(pars)   

###############################################################
# preprocess - all timecourses as R data
###############################################################
# dictionary of the available names
# fname <- getSimulationFileFromSimulationId(ma.settings$dir.simdata, simIds[1])
# ids.dict <- names(data)
ids <- c("PP__alb", "PP__gal", "PP__galM", "PP__h2oM", "PP__rbcM", "PP__suc",
         "PV__alb", "PV__gal", "PV__galM", "PV__h2oM", "PV__rbcM", "PV__suc")
x.fname <- paste(folder, '/results/x.Rdata', sep='')

if (file.exists(x.fname)){
  load(file=x.fname)
} else {
  # convert the CSV to R data structures  
  print('# Reading CSV -> Rdata #')
  library(parallel)
  workerFunc <- function(simId){
    print(simId)
    fname <- getSimulationFileFromSimulationId(ma.settings$dir.simdata, simId)
    data <- readDataForSimulationFile(fname)
    save(data, file=paste(fname, '.Rdata', sep=''))
  }
  Ncores <- 10
  res <- mclapply(simIds, workerFunc, mc.cores=Ncores)
  rm(Ncores)

  # make the preprocessing
  x <- createDataMatrices(ids=ids, out.fname=x.fname, simIds=simIds)
}
