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

task <- 'T1'
modelId <- 'MultipleIndicator_P00_v10_Nc20_Nf1'
ma.settings$dir.simdata <- file.path(ma.settings$dir.results, 
                                     '2014-04-19_MultipleIndicator', 'data')
parsfile <- file.path(ma.settings$dir.results, '2014-04-19_MultipleIndicator', 
                paste(task, '_', modelId, '_parameters.csv', sep=""))
pars <- loadParsFile(parsfile)
head(pars)
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
out.file <- paste(parsfile, '.rdata', sep="")
dil_list = readPPPVData(ma.settings$dir.simdata)

# A better data structure is a matrix for the different components
# Matrix size [Ntime x Nsim] for every component
dilmat <- createDataMatrices(ma.settings$dir.simdata, dil_list, compounds=compounds)
save.image(file=out.file)