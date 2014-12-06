################################################################
# Preprocess Data
################################################################
# Read the timecourse data (CSV) and creates reduced data
# structures consisting of some components of the full
# sinusoidal system.
# All simulation csv have been collected in a common folder.
# Main challenge is the combination of the timecourses based
# the varying timesteps used for simulation.
# Important part is also dimension reduction of the data
# structure.
#
# author: Matthias Koenig
# date: 2014-11-11
################################################################
library(data.table)
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)

###############################################################
# Create necessary variables
###############################################################
# The collection of data files to be preprocessed is defined via
# the folder variable which encodes the Task

# folder <- '2014-11-17_T5'
print(folder)
if (!exists('folder')){
  stop('no folder for preprocessing set')
}
tmp <- strsplit(folder, '_')
date <- tmp[[1]][1]
task <- tmp[[1]][2]

modelXML <- list.files(path=file.path(ma.settings$dir.results, folder), pattern='.xml')
modelId <- substr(modelXML,1,nchar(modelXML)-4)

# ma.settings$dir.simdata <- file.path(ma.settings$dir.results, folder, task)               # copied files
ma.settings$dir.simdata <- file.path(ma.settings$dir.results, 'django', 'timecourse', task) # direct from django

parsfile <- file.path(ma.settings$dir.results, folder, 
                      paste(task, '_', modelId, '_parameters.csv', sep=""))
rm(tmp, modelXML)

# make results folder
dir.create(file.path(folder, 'results'), showWarnings = FALSE)

# read parameter file & extend with SBML information
print(parsfile)
pars <- loadParameterFile(file=parsfile)

ps <- getParameterTypes(pars=pars)
f.sbml <- file.path(ma.settings$dir.results, folder, paste(modelId, '.xml', sep=''))
model <- loadSBMLModel(f.sbml)
pars <- extendParameterStructure(pars=pars, fixed_ps=ps$fixed, model=model)
head(pars)

simIds = rownames(pars)

###############################################################
# Preprocess timecourses as Rdata
###############################################################
# Dictionary of the available names. The availble names can be
# checked in the SBML, the CSV or via
#   fname <- getSimulationFileFromSimulationId(ma.settings$dir.simdata, simIds[1])
#   ids.dict <- names(data)
# Here only the periportal and perivenious ids are used
ids <- c("PP__alb", "PP__gal", "PP__galM", "PP__h2oM", "PP__rbcM", "PP__suc",
         "PV__alb", "PV__gal", "PV__galM", "PV__h2oM", "PV__rbcM", "PV__suc")
x.fname <- paste(folder, '/results/x.Rdata', sep='')
cat('Creating Data matrix ...\n')
if (file.exists(x.fname)){
     load(file=x.fname)
     cat('Preprocessed data exists and is loaded.\n')
} else {
  x <- createPreprocessDataMatrices(ids=ids, out.fname=x.fname, simIds=simIds, modelId=modelId, dir=ma.settings$dir.simdata)
}
