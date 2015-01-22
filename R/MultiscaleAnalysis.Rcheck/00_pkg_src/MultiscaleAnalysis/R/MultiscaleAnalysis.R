#' MultiscaleAnalysis: Supporting package for multiscale-galactose model.
#'
#' The MultiscaleAnalysis package is a set of tools that implement the
#' necessary R analysis functions for the SBML model and simulations of a
#' liver multiscale model developed in the Virtual Liver Network (VLN).
#'
#' @section Introduction:
#'
#' Main parts of the model are the visualization and integration of sets of simulations,
#' and the prediction of Galactose Elimination Capacity (GEC) for individuals based on 
#' their anthropomorhpic information.
#'
#' @docType package
#' @name MultiscaleAnalysis


#' Create the settings structure.
#' 
#' Encodes the main dirs and settings necessary.
#' Simulator can be either ROADRUNNER or COPASI.
#' @export
create.settings <- function(dir="/home/mkoenig", simulator="ROADRUNNER"){
  dir.base    = file.path(dir, 'multiscale-galactose')
  dir.code    = file.path(dir.base, 'R')
  dir.expdata = file.path(dir.base, 'experimental_data')
  
  dir.results = file.path(dir, 'multiscale-galactose-results')
  dir.simdata = file.path(dir, 'multiscale-galactose-results')
  
  # Shiny model directory 
  dir.shiny = file.path(dir.code, "shiny", 'gec_app', 'data', 'gamlss')
  
  # GAMLSS model directory
  dir.gamlss = file.path(dir.base, "results", 'gamlss')
  
  list(dir.base=dir.base,
       dir.code=dir.code,
       dir.expdata=dir.expdata,
       dir.simdata=dir.simdata,
       dir.results=dir.results,
       dir.gamlss=dir.gamlss,
       dir.shiny=dir.shiny,
       simulator=simulator)
}

#' Settings structure with available directories.
#' 
#' @export
ma.settings <- create.settings()
  

.onUnload <- function (libpath) {
  library.dynam.unload("MultiscaleAnalysis", libpath)
}