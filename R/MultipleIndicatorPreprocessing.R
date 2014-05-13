################################################################
## Preprocess the MultipleIndicatorDilution Data ##
################################################################
# Read the timecourse data and creates reduced data structures
# for simplified query and visualization.
# Necessary to select the column indices (i.e. model components)
# which should be part of the reduced model structure.
# Run from terminal via -> Rscript MultipleIndicatorPreprocessing.R
#
# author: Matthias Koenig
# date: 2014-05-13
# install.packages('data.table')

rm(list=ls())   # Clear all objects
library(data.table)
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)
#------------------------------------------------------------------------------#
sname <- '2014-05-13_MultipleIndicator'
version <- 'v17'
ma.settings$dir.simdata <- file.path(ma.settings$dir.results, sname, 'data')
task.offset <- 27
task.seq <- seq(0,2)
tasks <- paste('T', task.offset+task.seq, sep='')
peaks <- paste('P0', task.seq, sep='')
#------------------------------------------------------------------------------#
for (kt in seq(length(tasks))){
  task <- tasks[kt]
  peak <- peaks[kt]
  modelId <- paste('MultipleIndicator_', peak, '_', version, '_Nc20_Nf1', sep='')
  parsfile <- file.path(ma.settings$dir.results, sname, 
                        paste(task, '_', modelId, '_parameters.csv', sep=""))

  # preprocessing
  preprocessPPPV(parsfile, ma.settings$dir.simdata)
}
