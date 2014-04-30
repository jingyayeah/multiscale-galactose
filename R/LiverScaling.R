################################################################
## Scaling to whole-liver
################################################################
# This is a crucial part of the model. The results for the 
# specific condition & person have to be generated based on the
# set of simulations for a broad range of conditions.
#
# Use the person/condition specific simulation parameters to scale
# the sample of simulation to the actual result.

# Given: 
# - sample of parameters
# - sample results for the given parameter samples
# - distribution of parameters for the given condition/person 
#   - these can result from whole liver data, i.e. different flow distribution from total 
#     liver flow
# - whole liver volume/mass for scaling. 

# author: Matthias Koenig
# date: 2014-04-29

# Load the parameter samples (here the parameters which are changing are defined)
rm(list=ls())   # Clear all objects
library(data.table)
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)

sname <- '2014-04-30_MultipleIndicator'
tasks <- paste('T', seq(11,15), sep='')
peaks <- c('P00', 'P01', 'P02', 'P03', 'P04')
ma.settings$dir.simdata <- file.path(ma.settings$dir.results, sname, 'data')

# for (kt in seq(length(tasks))){
for (kt in seq(1)){
  task <- tasks[kt]
  peak <- peaks[kt]
  modelId <- paste('MultipleIndicator_', peak, '_', 'v13_Nc20_Nf1', sep='')
  parsfile <- file.path(ma.settings$dir.results, sname, 
                        paste(task, '_', modelId, '_parameters.csv', sep=""))
  # Load the data
  print(parsfile)
  load(file=outfileFromParsFile(parsfile))
  print(summary(pars))
}
hist(pars$y_cell)

# Get the additional parameters from the SBML file directly necessary for scaling, i.e 
# calculate from the formulas
# i.e. evalutate the AST nodes
# What is needed ?
# The Volumes ?


# Load the corresponding simulation results of interest


# Define distributions of parameters which should be used for the calculation



# Calculate the mean/std results based on the integration over the parameter distribution

# Scale to whole liver function






