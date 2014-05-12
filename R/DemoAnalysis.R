################################################################
## Evaluation of demo network curves
################################################################
# The workflow for analysis is:
# preprocessing of timecourse data

# author: Matthias Koenig
# date: 2014-05-11
################################################################

rm(list=ls())
library(data.table)
library(libSBML)
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)

###########################################################################
# Load parameters for samples
###########################################################################
# definition of changing parameters, with a single sample 
# corresponding to a sinusoidal unit configuration
# samples are based on random sampling of multidimensional parameter space

sname <- '2014-05-11_Demo'
modelVersion <- 'v14_Nc20_Nf1'
ma.settings$dir.simdata <- file.path(ma.settings$dir.results, sname, 'data')
load_with_sims = FALSE;
task = 'T12'
modelId <- 'Koenig2014_demo_kinetic_v7'
parsfile <- file.path(ma.settings$dir.results, sname, 
                        paste(task, '_', modelId, '_parameters.csv', sep=""))
# Load the data
if (load_with_sims == FALSE){
  # only load the parameters:
  pars <- loadParameterFile(parsfile)
} else {
  # preprocessing necessary for loading the data with the parameters
  load(file=outfileFromParsFile(parsfile))
}
print(summary(pars))
names(pars)

# plot the histogramm
plotParameterHistogramFull(pars)

################################################################
## Preprocess the Demo data
################################################################
# Read the timecourse data and create optimized data structures
# for query.
# Selection of the values is necessary.
# author: Matthias Koenig
# date: 2014-05-11
# install.packages('data.table')

rm(list=ls())   # Clear all objects
library(data.table)
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)


# Do the preprocessing
# preprocess(parsfile=parsfile, sim.dir=ma.settings$dir.simdata, 
#            outFile='test.out', max_index=2)
preprocess(parsfile, ma.settings$dir.simdata)

###########################################################################
# Do the pars plots
# Settings for plots
create_plot_files = TRUE
plot.width = 800 
plot.height = 800
plot.units= "px"
plot.bg = "white"
plot.res = 150
