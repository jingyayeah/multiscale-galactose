################################################################
## Preprocess the Demo data
################################################################
# Read the timecourse data and create optimized data structures
# for query.
# The optimized structures are generated with a selection of columns.
#
# author: Matthias Koenig
# date: 2014-05-11
# install.packages('data.table')

rm(list=ls())   # Clear all objects
library(data.table)
library('matrixStats')
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)

sname <- '2014-05-12_Demo'
ma.settings$dir.simdata <- file.path(ma.settings$dir.results, sname, 'data')
task <- 'T12'
modelId <- paste('Koenig2014_demo_kinetic_v7')
parsfile <- file.path(ma.settings$dir.results, sname, 
                        paste(task, '_', modelId, '_parameters.csv', sep=""))
pars <- loadParameterFile(file=parsfile)
plotParameterHistogramFull(pars)

# do the preprocessing (here all columns)
# what is written in the CSV?
outFile <- preprocess(parsfile, ma.settings$dir.simdata)

# load the preprocessed data
load(outFile)

################################################################
# do the plots
# TODO: problems with the units

create_plot_files = FALSE

# Plot all the single curves with mean and std
# They have to be weighted with the actual probability assicociated with the samples.
plotCurve <- function(preprocess.mat, name){
  Nsim <- nrow(data) 
  time <- preprocess.mat[['time']][,1]
  print(time)
  data <- preprocess.mat[[name]]
  xlim=c(0,100)
  ylim=c(min(data), max(data))
  print(ylim)
  plotCompound(time, data, name=name, xlim=xlim, ylim=ylim, weights=NULL, col=rgb(1,1,1, 0.2))
  plotCompoundMean(time, data, weights=NULL, col="red")
}

# Varied parameters
pnames <- getParameterNames(pars=pars)

# Available columns
cnames <- names(preprocess.mat)
print(cnames)

# Create the plot
if (create_plot_files == TRUE){
  png(filename=paste(ma.settings$dir.results, '/', 'Demo_' , name, ".png", sep=""),
      width = 800, height = 800, units = "px", bg = "white",  res = 200)
}
Np = ceiling(sqrt(length(cnames)))
par(mfrow=c(Np,Np))
for (name in cnames){
  print(name)
  if (name != 'time'){
    plotCurve(preprocess.mat, name)
  }
}
par(mfrow=c(1,1))
if (create_plot_files == TRUE){
  dev.off()
}

plotCurve(preprocess.mat, "A_in")

