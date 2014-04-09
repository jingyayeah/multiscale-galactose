################################################################
## Evaluate Galactose Dilution Curves ##
################################################################
# author: Matthias Koenig
# date: 2014-03-24
# TODO: create plots on console and copy to images 
# TODO: correct image names


rm(list=ls())   # Clear all objects
setwd("/home/mkoenig/multiscale-galactose-results/")

###############################################################
task <- "T2"
modelId <- "Dilution_Curves_v8_Nc20_Nf1"
# here the parameter files are stored
info.folder <- '2014-04-08'
# here the ini & csv of the integrations are stored
data.folder <- 'django/timecourse/2014-04-08'
###############################################################

### Load the parameter file ###
parsfile <- paste(info.folder, '/', task, '_', modelId, '_parameters.csv', sep="")
pars <- read.csv(parsfile, header=TRUE)
names(pars)

# set row names
row.names(pars) <- paste("Sim", pars$sim, sep="")

# reserved keyworkds which are not parameters
keywords <- c('status', 'duration', 'core', 'sim')
# find the parameters not in keywords
pnames <- setdiff(names(pars), keywords) 
Np = length(pnames)

# plot parameter histogram
plotParameterHist <- function(name, breaks=40){
  x <- pars[,name] 
  print(x)
  hist(x, breaks=breaks, xlab=name, main=paste("Histogram", name))
}

# create the plot
par(mfrow=c(1,Np))
for (k in seq(1,Np)){
  plotParameterHist(pnames[k])
}
rm(k)
par(mfrow=c(1,1))
png(filename=paste(info.folder, '/', task, "_parameter_histograms.png", sep=""),
    width = 1800, height = 500, units = "px", bg = "white",  res = 150)
dev.off()

# Overview of the distribution parameters
summary(pars)

########################################################################
### Create simulation data structure ###
# Now working with the resulting ODE integration results, i.e. load the 
# timecourse data for the individual simulations and do the analysis with
# the data.
dataset1.file <- paste(info.folder, '/', modelId, '_dataset1','.rdata', sep="")

# Load the PP and PV data for single simulation by sim name
# The timecourse for the data should exists. This can be checked with
# via the simulation status in the parameter files.
readPPPVDataForSim <- function(sim, withTime=F){
  tmp <- read.csv(paste(data.folder, '/', modelId, "_", sim, "_copasi.csv", sep=""))
  
  # set time as row names and remove the time vector
  row.names(tmp) <- tmp$time

  # reduce data to PP__ and PV__ data
  pppv.index <- which(grepl("^PP__", names(tmp)) | grepl("^PV__", names(tmp)) )
  if (withTime==T){
    pppv.index <- which(grepl("^PP__", names(tmp)) | grepl("^PV__", names(tmp)) |  grepl("^time", names(tmp)))
  }
  # here most of the timecourses are droped
  # if different data is needed use similar reading function
  tmp <- tmp[, pppv.index]
}

# Read the data in a list structure
# Every element of the list v[[sim]] is the data.frame for the respective simulation sim
tmp <- readPPPVDataForSim(row.names(pars)[1], withTime=T)
time <- tmp$time
rm(tmp)

dil <- list()
for (sim in row.names(pars)[1:10] ){
  print(paste("Read CSV for:", sim))
  status = pars[sim,]$status
  if (status != 'DONE'){
    print(paste('simulation -> ', status))
  } else {
    dil[[sim]] = readPPPVDataForSim(sim)
  }
}
rm(sim, status)
save.image(file=dataset1.file)


### Load the simulation data  structure ###
load(file=dataset1.file)

# List of matrixes
# A better data structure is a matrix for the different components
# Matrix size [Ntime x Nsim] for every component
prefixes = c('PV__')
compounds = c('rbcM', 'alb', 'suc', 'h2oM', 'gal')
ccolors = c('darkred', 'darkgreen', 'darkorange', 'darkblue', 'black')
#          red,  green, orange, blue,  black

# read one compound matrix
Ntime = length(time)
Nsim = length(names(dil))
createDataMatrices <- function(){
  mat = list()
  for (prefix in prefixes){
    for (compound in compounds){
      name = paste(prefix, compound, sep="")
      print(name)
      mat[[name]] <- matrix(, nrow = Ntime, ncol = Nsim)
      # copy all the columns
      for(k in seq(1,Nsim)){
        sim <- names(dil)[k]
        mat[[name]][, k] <- dil[[sim]][, name]
      }
    }
  }
  mat
}
dilmat <- createDataMatrices()

####################################################################
## plotting the data ##
# Sys.setenv(http_proxy="http://proxy.charite.de:888")
# install packages from command line via proxy
# install.packages('matrixStats')

# Plot all data curves and mean curve #
library('matrixStats')

#png(filename=paste(task, "_Dilution_Curves.png", sep=""),
#    width = 4000, height = 1000, units = "px", bg = "white",  res = 200)

par(mfrow=c(1,length(compounds)))
for (kc in seq(1, length(compounds)) ){
  # name = "PV__rbcM"
  name = paste("PV__", compounds[kc], sep="")
  print(name)
  # plot one compound
  tmp <- dilmat[[name]]
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
# dev.off()

## Combined Dilution Curves in one plot ##
#png(filename=paste(task, "_Dilution_Curves_Combined.png", sep=""),
#    width = 1000, height = 1000, units = "px", bg = "white",  res = 150)
par(mfrow=c(1,1))
for (kc in seq(1, length(compounds)) ){
  
  # name = "PV__rbcM"
  name = paste("PV__", compounds[kc], sep="")
  print(name)
  # plot one compound
  tmp <- dilmat[[name]]
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
# dev.off()


# calculate the maximum values
maxtime <- data.frame(tmp=numeric(Nsim))
for (kc in seq(1, length(compounds)) ){
  name = paste("PV__", compounds[kc], sep="")
  print(name)
  maxtime[[name]] <- numeric(Nsim)    
  # find the max values for all simulations
  for (k in seq(1, Nsim)){
    maxtime[[name]][k] = time[ which.max(dilmat[[name]][,k]) ]
  }
}
maxtime$tmp <- NULL

#png(filename=paste(task, "_Boxplot_MaxTimes", sep=""),
#    width = 1000, height = 1000, units = "px", bg = "white",  res = 150)
boxplot(maxtime, col=ccolors, horizontal=T, xlab="time [s]")
#dev.off()

## Scatterplots of the parameters ##
library("lattice")

sortind <- unlist(as.matrix(sort.int(maxtime[["PV__rbcM"]], index.return=TRUE))[2])

maxtime[["PV__rbcM"]][sortind]
my.colors = colorRampPalette(c("light green", "yellow", "orange", "red"))
sort.colors <- my.colors(Nsim)[sortind]
#png(filename=paste(task, "_Scatter_Parameters", sep=""),
#    width = 1000, height = 1000, units = "px", bg = "white",  res = 150)
plot(pars[,pnames], col=sort.colors)
#dev.off()


