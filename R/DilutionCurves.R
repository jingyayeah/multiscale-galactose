################################################################
## Evaluate Galactose Dilution Curves ##
################################################################
# author: Matthias Koenig
# date: 2014-04-13

# TODO: create plots on console and copy to images

rm(list=ls())   # Clear all objects
library(MultiscaleAnalysis)
library(MASS)
setwd(ma.settings$dir.results)

###############################################################
results.folder <- "/home/mkoenig/multiscale-galactose-results"
code.folder    <- "/home/mkoenig/multiscale-galactose/R" 

task <- "T4"
modelId <- "Dilution_Curves_v9_Nc20_Nf1"
ma.settings$dir.simdata <- file.path(ma.settings$dir.results, 'django/timecourse/2014-04-15')

pars <- loadParsFile(ma.settings$dir.results, task=task, modelId=modelId)
pars <- pars[pars$status=="DONE", ]
summary(pars)

########################################################################
### Create simulation data structure ###
# Now working with the resulting ODE integration results, i.e. load the 
# timecourse data for the individual simulations and do the analysis with
# the data.

# File for storage
dataset1.file <- paste(info.folder, '/', modelId, '_dataset1','.rdata', sep="")
dil_list = readPPPVData()

compounds = c('rbcM', 'alb', 'suc', 'h2oM', 'gal')
ccolors = c('darkred', 'darkgreen', 'darkorange', 'darkblue', 'black')
#          red,  green, orange, blue,  black

# List of matrixes
# A better data structure is a matrix for the different components
# Matrix size [Ntime x Nsim] for every component
dilmat <- createDataMatrices(dil_list, compounds=compounds)
save.image(file=dataset1.file)



####################################################################
### Load the simulation data  structure ###
load(file=dataset1.file)

## plotting the data ##
# Sys.setenv(http_proxy="http://proxy.charite.de:888")
# install packages from command line via proxy
# install.packages('matrixStats')

# Plot all data curves and mean curve #
library('matrixStats')

#png(filename=paste(info.folder, '/', task, "_Dilution_Curves.png", sep=""),
#    width = 4000, height = 1000, units = "px", bg = "white",  res = 200)
time <- readTimeForSimulation(rownames(pars)[1])
par(mfrow=c(1,length(compounds)))
for (kc in seq(1, length(compounds)) ){
  # name = "PV__rbcM"
  name = paste("PV__", compounds[kc], sep="")
  print(name)
  # plot one compound
  tmp <- dilmat[[name]]
  for (ks in seq(Nsim)){
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
png(filename=paste(info.folder, '/', task, "_Dilution_Curves_Combined.png", sep=""),
    width = 1000, height = 1000, units = "px", bg = "white",  res = 150)
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
dev.off()


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
colMeans(maxtime-10)

png(filename=paste(info.folder, '/', task, "_Boxplot_MaxTimes", sep=""),
    width = 1000, height = 1000, units = "px", bg = "white",  res = 150)
boxplot(maxtime-10, col=ccolors, horizontal=T, xlab="time [s]")
dev.off()
summary(maxtime-10)

## Scatterplots of the parameters ##
library("lattice")

sortind <- unlist(as.matrix(sort.int(maxtime[["PV__rbcM"]], index.return=TRUE))[2])

maxtime[["PV__rbcM"]][sortind]
my.colors = colorRampPalette(c("light green", "yellow", "orange", "red"))
sort.colors <- my.colors(Nsim)[sortind]
png(filename=paste(info.folder, '/', task, "_Scatter_Parameters", sep=""),
    width = 1000, height = 1000, units = "px", bg = "white",  res = 150)
plot(pars[,pnames], col=sort.colors)
dev.off()




