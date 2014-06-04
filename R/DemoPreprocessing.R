################################################################
## Preprocess the Demo data
################################################################
# Read the timecourse data and create optimized data structures
# for query.
# The optimized structures are generated with a selection of columns.
# The timecourses for the different simulations have varying timepoints
# due to the variable step integration.
#
# author: Matthias Koenig
# date: 2014-05-11
# install.packages('data.table')

rm(list=ls())
library(data.table)
library('matrixStats')
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)

sname <- '2014-05-27_Demo'
modelId <- paste('Koenig2014_demo_kinetic_v7')
task <- 'T1'
ma.settings$dir.simdata <- file.path(ma.settings$dir.results, sname, task)


parsfile <- file.path(ma.settings$dir.results, sname, 
                        paste(task, '_', modelId, '_parameters.csv', sep=""))
pars <- loadParameterFile(file=parsfile)
head(pars)
plotParameterHistogramFull(pars)

# do the preprocessing (here all columns)
# time series consists of non-equidistant time points
outFile <- preprocess(parsfile, ma.settings$dir.simdata)
# TODO: only the preprocess list generated so far
tmp <- preprocess.list[[1]]
head(tmp)
# TODO: interpolate for equidistant steps
plot(tmp$time, tmp$A_in)

t.new <- seq(from=0, to=100, by=0.1)
A_in.new <- approx(t.new)


approx   (x, y = NULL, xout, method = "linear", n = 50,
          yleft, yright, rule = 1, f = 0, ties = mean)


# load the preprocessed data
load(outFile)
tmp <- head(preprocess.list[[1]])
plot(tmp$time, tmp$A_in)

################################################################
# do the plots
# TODO: problems with the units

create_plot_files = T

# Plot all the single curves with mean and std
# They have to be weighted with the actual probability assicociated with the samples.
plotCurve <- function(preprocess.mat, name, sim.indices=NULL){
  Nsim <- nrow(data) 
  time <- preprocess.mat[['time']][,1]
  print(time)
  data <- preprocess.mat[[name]]
  if (!is.null(sim.indices)){
    data <- as.matrix(data[,sim.indices])
  }
  
  xlim=c(0,25)
  ylim=c(min(data), max(data))
  plotCompound(time, data, name=name, xlim=xlim, ylim=ylim, weights=NULL, col="black")
  plotCompoundMean(time, data, weights=NULL, col="red")
}

# Varied parameters
pnames <- getParameterNames(pars=pars)

# Available columns
cnames <- names(preprocess.mat)
print(cnames)

# plot single simulation
# sim.indices = seq(1, nrow(pars))
# sim.indices = which(rownames(pars)=="Sim568")
# sim.indices

# Create the plot
if (create_plot_files == TRUE){
  png(filename=paste(ma.settings$dir.results, '/', 'Demo_results' , ".png", sep=""),
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

plotCurve(preprocess.mat, "A_in")

