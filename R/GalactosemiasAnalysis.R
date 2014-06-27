################################################################
## Galactosemias
################################################################
# Analysis of the galactose elimination simulations with varying
# galactose and varying blood flow
#
# author: Matthias Koenig
# date: 2014-06-11
################################################################
rm(list=ls())
library(data.table)
library(libSBML)
library(matrixStats)
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)

ma.settings$simulator <- 'ROADRUNNER'
tasks = seq(5,6)
date = '2014-06-23'
modelId <- paste('GalactoseComplete_v21_Nc20_Nf1')
t.approx <- seq(from=0, to=10000, by=10)

###############################################################
# preprocess data
###############################################################
for (k in tasks){
  task <- paste('T', k, sep='')
  sname <- paste(date, '_', task, sep='')
  print(sname)
  ma.settings$dir.simdata <- file.path(ma.settings$dir.results, sname, task)
  parsfile <- file.path(ma.settings$dir.results, sname, 
                      paste(task, '_', modelId, '_parameters.csv', sep=""))
  print(parsfile)
  pars <- loadParameterFile(file=parsfile)
  head(pars)
  names(pars)
  plotParameterHistogramFull(pars)     
  
  outFile <- preprocess(pars, ma.settings$dir.simdata, time=t.approx)
}
###############################################################
# create figures
###############################################################

for (k in seq(1,2)){
  task <- paste('T', k, sep='')
  sname <- paste(date, '_', task, sep='')
  print(sname)
  ma.settings$dir.simdata <- file.path(ma.settings$dir.results, sname, task)
  parsfile <- file.path(ma.settings$dir.results, sname, 
                        paste(task, '_', modelId, '_parameters.csv', sep=""))
  outfile <- outfileFromParsFile(parsfile)
  load(outfile)

}