################################################################
## Preprocess the Galactose Single Cell data
################################################################
# Read the timecourse data and create optimized data structures
# for query.
# The optimized structures are generated with a selection of columns.
# The timecourses for the different simulations have varying timepoints
# due to the variable step integration.
#
# author: Matthias Koenig
# date: 2014-06-04
# install.packages('data.table')

rm(list=ls())
library(data.table)
library('matrixStats')
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)

sname <- '2014-06-04_GalactoseCell'
modelId <- paste('Galactose_v20_Nc1_Nf1')
task <- 'T1'
t.approx <- seq(from=0, to=5000, by=10)

ma.settings$dir.simdata <- file.path(ma.settings$dir.results, sname, task)
parsfile <- file.path(ma.settings$dir.results, sname, 
                        paste(task, '_', modelId, '_parameters.csv', sep=""))
pars <- loadParameterFile(file=parsfile)
pnames <- getParameterNames(pars)
pnames
head(pars)
plotParameterHistogramFull(pars)

# do the preprocessing (here all columns)
# time series consists of non-equidistant time points => provided
# time vector is used for interpolation of the data
# ! the time vector has to be consistent with the fastest dynamics of interest

# data.approx <- approx(tmp$time, tmp$A_in, xout=t.approx, method="linear")

outfileForDeficiency <- function(deficiency){
  file <- paste(parsfile, '_EDEF', deficiency, '.rdata', sep="")
}
parsForDeficiency <- function(deficiency){
  pars_def <- pars[pars$deficiency==deficiency,]
}


# Do the preprocessing individually for all deficiencies
for (deficiency in seq(0,23)){
  print(paste('Deficiency', deficiency))
  pars_def = parsForDeficiency(deficiency) 
  preprocess(pars_def, ma.settings$dir.simdata, time=t.approx, 
             outFile=outfileForDeficiency(deficiency) )
}

################################################################
# do the plots
# TODO: problems with the units
create_plot_files = T

# Plot all the single curves with mean and std
# They have to be weighted with the actual probability assicociated with the samples.
plotCurve <- function(preprocess.mat, name, sim.indices=NULL){
  time <- preprocess.mat[['time']][,1]
  data <- preprocess.mat[[name]]
  if (!is.null(sim.indices)){
    data <- as.matrix(data[,sim.indices])
  }  
  xlim=c(0,5000)
  ylim=c(min(data), max(data))
  plotCompound(time, data, name=name, xlim=xlim, ylim=ylim, weights=NULL, col="black")
  plotCompoundMean(time, data, weights=NULL, col="red")
}

plotSteadyState <- function(pars_def, preprocess.mat, name){
  # TODO
  data <- preprocess.mat[[name]]
  if (!is.null(sim.indices)){
    data <- as.matrix(data[,sim.indices])
  }  
  ylim=c(min(data), max(data))
  plotCompound(time, data, name=name, xlim=xlim, ylim=ylim, weights=NULL, col="black")
  plotCompoundMean(time, data, weights=NULL, col="red")
}

# Varied parameters
# deficiency = 23
for (deficiency in seq(0,23)){
load(outfileForDeficiency(deficiency))
pars_def = parsForDeficiency(deficiency) 
pnames <- getParameterNames(pars=pars_def)
filename <- paste(ma.settings$dir.simdata, '/', 'DEF', deficiency , ".png", sep="")
print(filename)
# Available columns
cnames <- names(preprocess.mat)
print(cnames)
cnames <- c('PP__gal', 'H01__gal', 'PV__gal', 'H01__GALK', 'H01__GALT', 'H01__GALE') 
cnames

# Create the plot
if (create_plot_files == TRUE){
  png(filename=filename,
      width = 1200, height = 1200, units = "px", bg = "white",  res = 100)
}
Np = ceiling(sqrt(length(cnames)))
par(mfrow=c(Np,Np))
for (name in cnames){
  print(name)
  if (name != 'time'){
    plotCurve(preprocess.mat, name, sim.indices=NULL)
  }
}
par(mfrow=c(1,1))
if (create_plot_files == TRUE){
  dev.off()
}
}
plotCurve(preprocess.mat, "PV__gal")

