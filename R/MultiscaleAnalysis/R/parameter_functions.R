################################################################
# Parameter functions
################################################################
# Parameter files are created via the database for the tasks. 
# They contain additional columns providing information about the 
# simulations like the simulation status or the time necessary
# for integration of the sinusoidal unit.
# Consequently, certain columns are not parameters.
#
# author: Matthias Koenig
# date: 2014-11-11
################################################################


#' Reserved keywords which are not parameters.
#' @export
pars.keywords <- c('status', 'duration', 'core', 'sim')

#'  Read parameter file into data.frame.
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
  cat('Parameters: ', pnames, '\n')
  Np <- length(pnames)
  Ndim <- ceiling(sqrt(Np))
  par(mfrow=c(Ndim,Ndim))
  for (k in seq(Np)){
    plotParameterHistogram(pars, name=pnames[k])
  }
  par(mfrow=c(1,1))
} 

#' Plot parameter histogram
#' 
#' @export
plotParameterHistogram <- function(pars, name, breaks=40){
  x <- pars[,name] 
  h <- hist(x, breaks=breaks, xlab=name, main=paste("Histogram", name))
}

###########################################################################
# Parameter file processing 
###########################################################################
# Get calculated values & simulation results for samples
#
# For every sample results are calculated, consisting of 
# derived geometrical parameters, and simulation results like timecourse 
# simulations.
# To get the distributions of these derived values from the sample, the 
# weighted means and sds based on the probabilities for the respective 
# samples have to be calculated.
# IMPORTANT: The calculated distributions, can be be compared 
#            to the experimental values

#' Get the different parameter types (fixed and variable)
#' @export
getParameterTypes <- function(pars){
  # Get parameters from SBML or parameter structure and calculate the derived
  # variables.
  ps <- list()
  ps$all = c('Nc', 'L', 'y_sin', 'y_end', 'y_dis', 'y_cell', 'flow_sin', 'N_fen', 'r_fen', 'f_fen', 
             'rho_liv', 'f_tissue', 'scale_f')
  ps$fixed <- getFixedParameters(pars=pars, all_ps=ps$all)
  ps$var <- getVariableParameters(pars=pars, all_ps=ps$all)
  
  ps
}

#' Loads the standard distributions for normal case.
#' @export
loadStandardDistributions <- function(){
  fname <- file.path(ma.settings$dir.results, 'distribution_fit_data.csv')
  p.gen <- read.csv(file=fname)
  rownames(p.gen) <- p.gen$name
  p.gen
}

#' Calculated ECDFs for standard distributions.
#' @export
createListOfStandardECDF <- function (p.gen, ps.var, Npoints=25000) {
  # Create the ECDFs via random sampling from log-normal distribution
  ecdf.list <- list()
  for (name in ps.var){
    # create ecdf by random sampling
    y <- rlnorm(Npoints, meanlog=p.gen[name, 'meanlog'], sdlog=p.gen[name, 'sdlog'])
    y <- y/p.gen[name, 'scale_fac']
    f.ecdf <- ecdf(y)
    ecdf.list[[name]] <- f.ecdf 
  }
  ecdf.list
}

#' Calculate the single variable probabilies based on ECDF
#' @export
calculateProbabilitiesForVariables <- function (pars, ecdf.list) {
  var.ps <- names(ecdf.list)
  for (name in var.ps){
    f.ecdf <- ecdf.list[[name]]
    x <- pars[[name]];
    p_sample <- getProbabilitiesForData(x, f.ecdf)
    p_name <- paste('p_', name, sep='')
    pars[[p_name]] <- p_sample$p
  }
  pars
}

#' Plot probabilities with associated midpoints as horizontal lines
#' @export
plotProbabilitiesForVariable <- function (x, f.ecdf, xlab) {
  ptmp <- getProbabilitiesForData(x, f.ecdf)
  ord <- order(x)
  par(mfrow=c(2,1))
  # probability
  plot(x, ptmp$p, xlab=xlab, main="probability")
  points(x[ord], ptmp$p[ord], type="l", lwd=2)
  for (mp in ptmp$midpoints){
    abline(v=mp, col=rgb(0,0,1,0.5))
  }
  abline(h=0.0, col='black')
  # ecdf
  plot(x[ord], f.ecdf(x[ord]), type="l", lwd=2, xlab=xlab, main="ECDF")
  for (mp in ptmp$midpoints){
    abline(v=mp, col=rgb(0,0,1,0.5))
  }
  abline(h=0.0, col='black')
  abline(h=1.0, col='black')
  par(mfrow=c(1,1))
}


#' Calculate the overall probability of the sample under the assumption
#' of statistical independence.
#' 
#' TODO: make sure it is valid
#' @export
calculateSampleProbability <- function (pars, ps.var) {
  Nsim <- nrow(pars)
  p_sample <- rep(1, Nsim)
  for (name in ps.var){
    p_name <- paste('p_', name, sep='')
    p_sample = p_sample * pars[[p_name]]
  }
  # Normalize p_sample
  pars$p_sample <- p_sample/sum(p_sample)
  pars
}
