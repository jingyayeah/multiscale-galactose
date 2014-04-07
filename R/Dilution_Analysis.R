
rm(list=ls())   # Clear all objects
setwd("/home/mkoenig/multiscale-galactose-results/dataR_dilution")

################################################################
## Evaluate Galactose Dilution Curves ##
################################################################
# author: Matthias Koenig
# date: 2014-03-24

### Load the parameter file ###
modelId <- "Dilution_Curves_v4_Nc20_Nf1"
task <- "T1"

parsfile <- paste(task, '_parameters.csv', sep="")
pars <- read.csv(parsfile, header=TRUE)
names(pars)
# set row names
row.names(pars) <- paste("Sim", pars$sim, sep="")
pars$sim <- NULL
# number of parameters
Np = length(names(pars))

# plot parameter histogram
plotParameterHist <- function(name, breaks=20){
  x <- pars[,name] 
  print(x)
  hist(x, breaks=breaks, xlab=name, main=paste("Histogram", name))
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

# Load data for single simulation by sim name
readDataForSim <- function(sim, withTime=F){
  tmp <- read.csv(paste("data/", modelId, "_", sim, "_copasi.csv", sep=""))
  # set time as row names and remove the time vector
  row.names(tmp) <- tmp$time

  # reduce data to PP__ and PV__ data
  pppv.index <- which(grepl("^PP__", names(tmp)) | grepl("^PV__", names(tmp)) )
  if (withTime==T){
    pppv.index <- which(grepl("^PP__", names(tmp)) | grepl("^PV__", names(tmp)) |  grepl("^time", names(tmp)))
  }
  tmp <- tmp[, pppv.index]
}

# Read the data in a list structure
# Every element of the list v[[sim]] is the data.frame for the respective simulation sim


dilution <- list()
for (sim in row.names(pars) ){
  print(paste("Read CSV for:", sim))
  v[[sim]] = readDataForSim(sim)
}
save(v, file="T2_Dilution_Data.rdata")

load(file="T2_Dilution_Data.rdata")


# List of matrixes
# A better data structure is a matrix for the different components
# Matrix size [Ntime x Nsim] for every component
prefixes = c('PV__')
compounds = c('rbcM', 'alb', 'suc', 'h2oM', 'gal')
ccolors = c('darkred', 'darkgreen', 'darkorange', 'darkblue', 'black')
#          red,  green, orange, blue,  black

# read one compound matrix
tmp <- readDataForSim(row.names(pars)[1], withTime=T)
time <- tmp$time
rm(tmp)

Ntime = length(time)
Nsim = length(names(v))
createDataMatrices <- function(){
  mat = list()
  for (prefix in prefixes){
    for (compound in compounds){
      name = paste(prefix, compound, sep="")
      print(name)
      mat[[name]] <- matrix(, nrow = Ntime, ncol = Nsim)
      # copy all the columns
      for(k in seq(1,Nsim)){
        sim <- names(v)[k]
        mat[[name]][, k] <- v[[sim]][, name]
      }
    }
  }
  mat
}
rm(mat)
mat <- createDataMatrices()

####################################################################
## plotting the data ##
# Sys.setenv(http_proxy="http://proxy.charite.de:888")
# install packages from command line via proxy
# install.packages('matrixStats')

# Plot all data curves and mean curve #
library('matrixStats')
png(filename=paste(task, "_Dilution_Curves.png", sep=""),
    width = 4000, height = 1000, units = "px", bg = "white",  res = 200)

par(mfrow=c(1,length(compounds)))
for (kc in seq(1, length(compounds)) ){
  # name = "PV__rbcM"
  name = paste("PV__", compounds[kc], sep="")
  print(name)
  # plot one compound
  tmp <- mat[[name]]
  for (ks in seq(1,Nsim)){
    if (ks == 1){
      plot(time, tmp[,ks], col="gray", 'l', main=name, xlab="time [s]", ylab="c [mM]", ylim=c(0.0, 0.2) )
    } else {
      lines(time, tmp[,ks], col="gray")
    }
  }
  # plot the mean and variance for time courses
  rmean <- rowMeans(tmp)
  rstd <- rowSds(tmp)
  lines(time, rmean, col=ccolors[kc], lwd=2)
  lines(time, rmean+rstd, col=ccolors[kc], lwd=2, lty=2)
  lines(time, rmean-rstd, col=ccolors[kc], lwd=2, lty=2)
}
par(mfrow=c(1,1))
dev.off()

## Combined Dilution Curves in one plot ##
png(filename=paste(task, "_Dilution_Curves_Combined.png", sep=""),
    width = 1000, height = 1000, units = "px", bg = "white",  res = 150)
par(mfrow=c(1,1))
for (kc in seq(1, length(compounds)) ){
  
  # name = "PV__rbcM"
  name = paste("PV__", compounds[kc], sep="")
  print(name)
  # plot one compound
  tmp <- mat[[name]]
  # plot the mean and variance for time courses
  rmean <- rowMeans(tmp)
  rstd <- rowSds(tmp)
  if (kc==1){
    plot(time, rmean, col=ccolors[kc], lwd=3, 'l', main="Dilution Curves", xlab="time [s]", ylab="c [mM]", ylim=c(0.0, 0.08), xlim=c(0.0, 100) )
  }else {
    lines(time, rmean, col=ccolors[kc], lwd=3)
  }
  lines(time, rmean+rstd, col=ccolors[kc], lwd=1, lty=2)
  lines(time, rmean-rstd, col=ccolors[kc], lwd=1, lty=2)
}
par(mfrow=c(1,1))
dev.off()


# calculate the maximum values
maxtime <- data.frame(tmp=numeric(Nsim))

for (kc in seq(1, length(compounds)) ){
  name = paste("PV__", compounds[kc], sep="")
  print(name)
  maxtime[[name]] <- numeric(Nsim)    
  # find the max values for all simulations
  for (k in seq(1, Nsim)){
    maxtime[[name]][k] = time[ which.max(mat[[name]][,k]) ]
  }
}
maxtime$tmp <- NULL

png(filename=paste(task, "_Boxplot_MaxTimes", sep=""),
    width = 1000, height = 1000, units = "px", bg = "white",  res = 150)
boxplot(maxtime, col=ccolors, horizontal=T, xlab="time [s]")
dev.off()

## Scatterplots of the parameters ##
library("lattice")


sortind <- unlist(as.matrix(sort.int(maxtime[["PV__rbcM"]], index.return=TRUE))[2])

maxtime[["PV__rbcM"]][sortind]
my.colors = colorRampPalette(c("light green", "yellow", "orange", "red"))
sort.colors <- my.colors(Nsim)[sortind]
png(filename=paste(task, "_Scatter_Parameters", sep=""),
    width = 1000, height = 1000, units = "px", bg = "white",  res = 150)
plot(pars, col=sort.colors)
dev.off()

