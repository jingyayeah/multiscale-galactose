################################################################
# Preprocess Multiple Indicator Dilution data
################################################################
# Read the timecourse data and creates reduced data structures
# for simplified query and visualization.
#
# author: Matthias Koenig
# date: 2014-07-30
rm(list=ls())

# - data folder & how to interpolate the information
folder <- '2014-07-30_T25'
t.approx <- seq(from=0, to=100, by=0.1)
plot(seq(1,length(t.approx)), t.approx )

##

library(data.table)
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)
ma.settings$simulator <- 'ROADRUNNER'

# read the file information from the folder
tmp <- strsplit(folder, '_')
date <- tmp[[1]][1]
task <- tmp[[1]][2]
rm(tmp)
modelXML <- list.files(path=file.path(ma.settings$dir.results, folder), pattern='.xml')
# remove the '.xml'
modelId <- substr(modelXML,1,nchar(modelXML)-4)
ma.settings$dir.simdata <- file.path(ma.settings$dir.results, folder, task)
parsfile <- file.path(ma.settings$dir.results, folder, 
                      paste(task, '_', modelId, '_parameters.csv', sep=""))

###############################################################
# preprocess data
###############################################################
pars <- loadParameterFile(file=parsfile)
head(pars)
names(pars)
plotParameterHistogramFull(pars)   


# more efficient preprocessing ?
# read all the information in Rdata files
createColumnDataFiles(pars, dir=ma.settings$dir.simdata)


outFile <- preprocess(pars, ma.settings$dir.simdata, time=t.approx)

