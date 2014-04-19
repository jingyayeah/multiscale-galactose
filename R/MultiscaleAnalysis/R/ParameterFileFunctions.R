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

#'  Takes folder, task and modelID
#'  @param file parameter file to load
#'  @return parameter data.frame
#'  @export  
loadParsFile <- function(file){
  print(parsfile)
  pars <- read.csv(parsfile, header=TRUE)
  # set row names
  row.names(pars) <- paste("Sim", pars$sim, sep="")
  pars
}

#' Get parameter names, i.e columns which are not keywords
#' @return vector of parameter names
#' @export
getParsNames <- function(pars){
  pnames <- setdiff(names(pars), pars.keywords) 
}

#' Plot parameter histogram
#' @param pars Parameter data frame
#' @param name of parameter
#' @return hist information
#' @export
plotParameterHist <- function(pars, name, breaks=40){
  x <- pars[,name] 
  h <- hist(x, breaks=breaks, xlab=name, main=paste("Histogram", name))
}


#' Histogramm for all parameters
#' @param pars Parameter data frame
#' @param file File where to save the histogramm
plotFullParameterHist <- function(pars, file){
  pnames <- getParsNames(pars)
  Np <- length(pnames)
  
  png(filename=file,
      width = 1800, height = 500, units = "px", bg = "white",  res = 150)
  par(mfrow=c(1,Np))
  for (k in seq(Np)){
    plotParameterHist(pnames[k])
  }
  par(mfrow=c(1,1))
  dev.off()  
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