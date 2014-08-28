###########################################################################################
# Function set handling parameter files
###########################################################################################
# Parameter files are created directly from the database for the tasks. 
# They contain additional columns providing information about the 
# simulations, i.e. certain keyword columns are not parameters.

# Trick:
# a good way is to pack output in a list
#list(coefficients=coef, vcov=vcov, ...)


#' Reserved keywords which are not parameters
#' @export
pars.keywords <- c('status', 'duration', 'core', 'sim')

#'  Read theparameter file into a data.frame.
#'  
#'  This function reads the parameter file in CSV format into a data.frame.
#'  @param file parameter csv file for loading
#'  @return data.frame of parameters
#'  @export  
loadParameterFile <- function(file){
  print(file)
  pars <- read.csv(file, header=TRUE)
  row.names(pars) <- paste("Sim", pars$sim, sep="")
  
  # replace 'X..' if header given via '# '
  names(pars) <- gsub('X..', '', names(pars))
  return(pars)
}

#' Get parameter names, i.e columns which are not keywords.
#' 
#' Uses the defined pars.keywords to see which names are parameters and
#' which are keywords.
#' @return vector of parameter names
#' @export
getParameterNames <- function(pars){
  pnames <- setdiff(names(pars), pars.keywords) 
}

#' Creates histogram for all parameters.
#' 
#' This function generates all the histograms for the parameters in the
#' given parameter structure.
#' @param pars parameter data structure.
#' @export
plotParameterHistogramFull <- function(pars, all_pars=FALSE){
  if (all_pars == TRUE){
    pnames = names(pars)
  }else{
    pnames <- getParameterNames(pars)
  }
  Np <- length(pnames)
  par(mfrow=c(1,Np))
  for (k in seq(Np)){
    plotParameterHistogram(pars, name=pnames[k])
  }
  par(mfrow=c(1,1))
} 

#' Plot parameter histogram
#' @param pars Parameter data frame
#' @param name of parameter
#' @return hist information
#' @export
plotParameterHistogram <- function(pars, name, breaks=40){
  x <- pars[,name] 
  h <- hist(x, breaks=breaks, xlab=name, main=paste("Histogram", name))
}


###########################################################################################
# Usage
###########################################################################################
test <- FALSE
if (test == TRUE){
 print('TESTING ParameterFile')
 folder.results <- 
 folder.simdata <- paste(folder.results, '/', '2014-04-13_Dilution_Curves', sep="")
 task <- 'T3'
 modelId <- 'Dilution_Test'
 pars <- loadParsFile(folder.simdata, task, modelId)
 pars.histfile <-paste(folder.results, '/', task, "_parameter_histograms.png", sep="") 
 plotFullParameterHist(pars, pars.histfile)
 
}
rm(test)