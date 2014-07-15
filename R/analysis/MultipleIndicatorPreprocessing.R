################################################################
# Preprocess Multiple Indicator Dilution data
################################################################
# Read the timecourse data and creates reduced data structures
# for simplified query and visualization.
#
# author: Matthias Koenig
# date: 2014-07-07

rm(list=ls())
library(data.table)
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)

ma.settings$simulator <- 'ROADRUNNER'
date <- '2014-07-08'
task <- 'T1'
modelId <- paste('Galactose_v12_Nc20_dilution')
t.approx <- seq(from=0, to=100, by=0.1)

###############################################################
# preprocess data
###############################################################
sname <- paste(date, '_', task, sep='')
ma.settings$dir.simdata <- file.path(ma.settings$dir.results, sname, task)
parsfile <- file.path(ma.settings$dir.results, sname, 
                        paste(task, '_', modelId, '_parameters.csv', sep=""))
pars <- loadParameterFile(file=parsfile)
head(pars)
names(pars)
plotParameterHistogramFull(pars)     
outFile <- preprocess(pars, ma.settings$dir.simdata, time=t.approx)

