# Clear all objects
rm(list=ls())

################################################################
## Evaluate Galactose Dilution Curves ##
################################################################
# author: Matthias Koenig
# date: 2014-03-23

### Load the parameter file ###
modelId <- "Dilution_Curves_v4_Nc20_Nf1"
task <- "T1"

setwd("/home/mkoenig/multiscale-galactose-results/dataR_dilution")
parsfile <- paste(task, '_parameters.csv', sep="")
pars <- read.csv(parsfile, header=TRUE)
names(pars)
# set row names
row.names(pars) <- paste("Sim", pars$sim, sep="")
pars$sim <- NULL
# number of parameters
Np = length(names(pars))

# Create a function that plots the value of "z" against the "y" value
plotParameterHist <- function(name){
  x <- pars[,name] 
  print(x)
  hist(x, breaks=20, xlab=name, main=paste("Histogram", name))
}

# create the plot
png(filename=paste(task, "_parameter_histograms.png", sep=""),
    width = 1800, height = 500, units = "px", bg = "white",  res = 150)
par(mfrow=c(1,Np))
for (k in seq(1,Np)){
  name <- names(pars)[k]
  plotParameterHist(name)
}
par(mfrow=c(1,1))
dev.off()

# Overview of the distribution parameters
summary(pars)

########################################################################
### Load the simulation data ###

row.names(pars)
for (sim in row.names(pars) ){
  print(sim)
}

# Store as list, only read the time once,
# reduce data to PP__ and PV__ data
sim <- "Sim1"
tmp <- read.csv(paste("data/", modelId, "_", sim, "_copasi.csv", sep=""))


names(data1)
plot(data1$time, data1$PV__rbcM)
plot(data1$time, data1$PP__rbcM)

