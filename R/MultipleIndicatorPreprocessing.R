################################################################
## Preprocess the MultipleIndicatorDilution Data ##
################################################################
# TODO: faster opening of files and directly writing into matrix
#       currently very slow.
# Only read all the data and put into the right data structure for visualization.
# author: Matthias Koenig
# date: 2014-04-19

rm(list=ls())   # Clear all objects
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)

###############################################################
results.folder <- "/home/mkoenig/multiscale-galactose-results"
code.folder    <- "/home/mkoenig/multiscale-galactose/R" 

tasks <- c('T1', 'T2', 'T3', 'T4', 'T5')
modelIds <- "Dilution_Curves_v9_Nc20_Nf1"

ma.settings$dir.simdata <- file.path(ma.settings$dir.results, 'django/timecourse/2014-04-15')
ma.settings$dir.simdata

pars <- loadParsFile(ma.settings$dir.results, task=task, modelId=modelId)
pars <- pars[pars$status=="DONE", ]
summary(pars)

compounds = c('gal', 'rbcM', 'alb', 'suc', 'h2oM')
ccolors = c('black', 'red', 'darkgreen', 'darkorange', 'darkblue' )
#            red,  green, orange, blue,  black


########################################################################
### Create simulation data structure ###
# Now working with the resulting ODE integration results, i.e. load the 
# timecourse data for the individual simulations and do the analysis with
# the data.

# File for storage
dataset1.file <- paste(ma.settings$dir.results, '/', modelId, '_dataset1','.rdata', sep="")
dil_list = readPPPVData(ma.settings$dir.simdata)

# A better data structure is a matrix for the different components
# Matrix size [Ntime x Nsim] for every component
dilmat <- createDataMatrices(ma.settings$dir.simdata, dil_list, compounds=compounds)
save.image(file=dataset1.file)