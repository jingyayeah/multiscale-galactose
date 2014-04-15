################################################################
## Evaluate Galactose Dilution Curves ##
################################################################
# author: Matthias Koenig
# date: 2014-04-13

rm(list=ls())   # Clear all objects
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)

###############################################################
results.folder <- "/home/mkoenig/multiscale-galactose-results"
code.folder    <- "/home/mkoenig/multiscale-galactose/R" 

task <- "T4"
modelId <- "Dilution_Curves_v9_Nc20_Nf1"
ma.settings$dir.simdata <- file.path(ma.settings$dir.results, 'django/timecourse/2014-04-15')
ma.settings$dir.simdata

pars <- loadParsFile(ma.settings$dir.results, task=task, modelId=modelId)
pars <- pars[pars$status=="DONE", ]
summary(pars)

compounds = c('gal', 'rbcM', 'alb', 'suc', 'h2oM')
ccolors = c('black', 'red', 'darkgreen', 'darkorange', 'darkblue' )
#            red,  green, orange, blue,  black


########################################################################
### Create simulation data structure ###
# Now working with the resulting ODE integration results, i.e. load the 
# timecourse data for the individual simulations and do the analysis with
# the data.

# File for storage
dataset1.file <- paste(ma.settings$dir.results, '/', modelId, '_dataset1','.rdata', sep="")
dil_list = readPPPVData(ma.settings$dir.simdata)

# A better data structure is a matrix for the different components
# Matrix size [Ntime x Nsim] for every component
dilmat <- createDataMatrices(ma.settings$dir.simdata, dil_list, compounds=compounds)
save.image(file=dataset1.file)

####################################################################
### Load the simulation data  structure ###
load(file=dataset1.file)

# Plot all data curves and mean curve #
library('matrixStats')
library('MultiscaleAnalysis')
png(filename=paste(ma.settings$dir.results, '/', task, "_Dilution_Curves.png", sep=""),
    width = 4000, height = 1000, units = "px", bg = "white",  res = 200)
time <- readTimeForSimulation(ma.settings$dir.simdata, rownames(pars)[1]) -10.0
par(mfrow=c(1,length(compounds)))
for (kc in seq(length(compounds)) ){
  # name = "PV__rbcM"
  name = paste("PV__", compounds[kc], sep="")
  print(name)
  # plot one compound
  tmp <- dilmat[[name]]
  for (ks in seq(nrow(pars))){
    if (ks == 1){
      plot(time, tmp[,ks], col="gray", 'l', main=name, xlab="time [s]", ylab="c [mM]", ylim=c(0.0, 0.2), xlim=c(0, 30) )
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
nrow(pars)

## Combined Dilution Curves in one plot ##
png(filename=paste(info.folder, '/', task, "_Dilution_Curves_Combined.png", sep=""),
    width = 1000, height = 1000, units = "px", bg = "white",  res = 150)
par(mfrow=c(1,1))
for (kc in seq(1, length(compounds)) ){
  
  # name = "PV__rbcM"
  name = paste("PV__", compounds[kc], sep="")
  # plot one compound
  tmp <- dilmat[[name]]
  # plot the mean and variance for time courses
  rmean <- rowMeans(tmp)
  rstd <- rowSds(tmp)
  if (kc==1){
    plot(time, rmean, col=ccolors[kc], lwd=3, 'l', 
         main="Dilution Curves", xlab="time [s]", ylab="c [mM]", 
         ylim=c(0.0, 0.20), xlim=c(0.0, 30) )
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

###################################################################################
# Dilution curves with experimental data
###################################################################################
library('matrixStats')
library('MultiscaleAnalysis')

task <- "T4"
modelId <- "Dilution_Curves_v9_Nc20_Nf1"
dataset1.file <- paste(ma.settings$dir.results, '/', modelId, '_dataset1','.rdata', sep="")
load(file=dataset1.file)
pars <- loadParsFile(ma.settings$dir.results, task=task, modelId=modelId)
pars <- pars[pars$status=="DONE", ]
summary(pars)

## Combined Dilution Curves in one plot ##
png(filename=paste(ma.settings$dir.results, '/', task, "_Dilution_Curves_Combined.png", sep=""),
    width = 2000, height = 1000, units = "px", bg = "white",  res = 150)

time <- readTimeForSimulation(ma.settings$dir.simdata, rownames(pars)[1]) -10.0
compounds = c('gal', 'rbcM', 'alb', 'suc', 'h2oM')
ccolors = c('black', 'red', 'darkgreen', 'darkorange', 'darkblue' )
compounds = c( 'rbcM', 'alb', 'suc', 'h2oM')
ccolors = c('red', 'darkgreen', 'darkorange', 'darkblue' )

gor1973 <- read.csv(file.path(ma.settings$dir.expdata, "dilution_indicator", "Goresky1973_Fig1.csv"), sep="\t")
summary(gor1973)
# Units: time [s], compound: 1000*outflow fraction/ml
gor1983 <- read.csv(file.path(ma.settings$dir.expdata, "dilution_indicator", "Goresky1983_Fig1.csv"), sep="\t")
summary(gor1983)

plot(numeric(0), numeric(0), 
     xlim=c(0,20), ylim=c(0,16), 
     xlab="time [s]", ylab="10^3 x outflow fraction/ml", main="Goresky1973 & 1983")
par(mfrow=c(1,1))
for (kc in seq(1, length(compounds)) ){
  f_scale=70
  
  # name = "PV__rbcM"
  name = paste("PV__", compounds[kc], sep="")
  # plot one compound
  tmp <- dilmat[[name]]
  
  # plot the mean and std for time courses
  rmean <- rowMeans(tmp)
  rstd <- rowSds(tmp)
  lines(time, rmean*f_scale, col=ccolors[kc], lwd=4)
  #lines(time, (rmean+rstd)*f_scale, col=ccolors[kc], lwd=1, lty=2)
  #lines(time, (rmean-rstd)*f_scale, col=ccolors[kc], lwd=1, lty=2)
}

#          red,  green, orange, blue,  black, gray
# expcompounds = c('RBC', 'albumin', 'Na', 'sucrose', 'water', 'galactose')
# expcolors = c('red', 'darkgreen', 'gray', 'darkorange', 'darkblue', 'black')
expcompounds = c('RBC', 'albumin', 'sucrose', 'water')
expcolors = c('red', 'darkgreen', 'darkorange', 'darkblue')

## Goresky1983 & 1973 ##
plotDilutionData(gor1983, compounds=expcompounds, ccolors=expcolors, correctTime=TRUE)
plotDilutionData(gor1973[gor1973$condition=="A",], compounds=expcompounds, ccolors=expcolors, correctTime=TRUE)
plotDilutionData(gor1973[gor1973$condition=="B",], compounds=expcompounds, ccolors=expcolors, correctTime=TRUE)
plotDilutionData(gor1973[gor1973$condition=="C",], compounds=expcompounds, ccolors=expcolors, correctTime=TRUE)
par(mfrow=c(1,1))
legend("topright",  legend = expcompounds, fill=expcolors)

dev.off()



