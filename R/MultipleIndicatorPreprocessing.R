################################################################
## Preprocess the MultipleIndicatorDilution Data ##
################################################################
# Read the timecourse data and create optimized data structures
# for query.
# Change the necessary settings for the respective SBML networks,
# parameter files.
# Run from terminal via -> Rscript MultipleIndicatorPreprocessing.R
#
# author: Matthias Koenig
# date: 2014-04-19

rm(list=ls())   # Clear all objects
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)

sname <- '2014-04-20_MultipleIndicator'
ma.settings$dir.simdata <- file.path(ma.settings$dir.results, sname, 'data')

tasks <- paste('T', seq(6,10), sep='')
peaks <- c('P00', 'P01', 'P02', 'P03', 'P04')

for (kt in seq(length(tasks))){
  task <- tasks[kt]
  peak <- peaks[kt]
  modelId <- paste('MultipleIndicator_', peak, '_v11_Nc20_Nf1', sep='')
  parsfile <- file.path(ma.settings$dir.results, sname, 
                        paste(task, '_', modelId, '_parameters.csv', sep=""))

  # Do the preprocessing
  # preprocess(parsfile=parsfile, sim.dir=ma.settings$dir.simdata, 
  #            outFile='test.out', max_index=2)
  preprocess(parsfile, ma.settings$dir.simdata)
}