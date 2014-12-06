################################################################
# GAMLSS helper functions
################################################################
# Reusable functions for working with GAMLSS models.
# 
# author: Matthias Koenig
# date: 2014-11-27
################################################################

library('gamlss')

#' Save the models
#' 
#'@export
saveFitModels <- function(models, xname, yname){
  dir <- file.path(ma.settings$dir.base, "results", "gamlss")
  r_fname <- file.path(dir, sprintf('%s_%s_models.Rdata', yname, xname))
  print( sprintf('%s ~ %s -> %s', yname, xname, r_fname) )
  save('models', file=r_fname)
}

#' Load the models
#' 
#'@export
loadFitModels <- function(xname, yname){
  dir <- file.path(ma.settings$dir.base, "results", "gamlss")
  r_fname <- file.path(dir, sprintf('%s_%s_models.Rdata', yname, xname))
  print( sprintf('%s ~ %s -> %s', yname, xname, r_fname) )
  load(file=r_fname)
  return(models)
}