################################################################
## Evaluation of MultipleIndicator Dilution Curves ##
################################################################
# preprocessing of the data has to be done before.
# see MultipleIndicatorPreprocessing.R
#
# author: Matthias Koenig
# date: 2014-04-20
################################################################
rm(list=ls())
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)

sname <- '2014-04-20_MultipleIndicator'
ma.settings$dir.simdata <- file.path(ma.settings$dir.results, sname, 'data')
tasks <- c('T1', 'T2', 'T3', 'T4', 'T5')
peaks <- c('P00', 'P01', 'P02', 'P03', 'P04')

  task <- tasks[1]
  peak <- peaks[1]
  modelId <- paste('MultipleIndicator_', peak, '_v10_Nc20_Nf1', sep='')
  parsfile <- file.path(ma.settings$dir.results, sname, 
                        paste(task, '_', modelId, '_parameters.csv', sep=""))
  load(file=outfileFromParsfile(parsfile))

summary(pars)

compounds = c('gal', 'rbcM', 'alb', 'suc', 'h2oM')
ccolors = c('black', 'red', 'darkgreen', 'darkorange', 'darkblue')
pv_compounds = paste('PV__', compounds, sep='')
names(ccolors) <- pv_compounds

####################################################################

library('matrixStats')

# Plot the single curves with the mean
plotCompound <- function(time, data, name, col="black", ylim=c(0.0, 0.2), xlim=c(0, 30)){
  # plot the single curves
  plot(numeric(0), numeric(0), 'l', main=name,
       xlab="time [s]", ylab="c [mM]", ylim=ylim, xlim=xlim)
  
  Nsim <- ncol(data)
  for (ks in seq(Nsim)){
      lines(time, data[,ks], col="gray")
  }
  
  # plot the mean and variance for time courses
  # TODO how to better calculate -> what error measurment to use
  rmean <- rowMeans(data)
  rstd <- rowSds(data)
  lines(time, rmean, col=col, lwd=2)
  lines(time, rmean+rstd, col=col, lwd=2, lty=2)
  lines(time, rmean-rstd, col=col, lwd=2, lty=2)
}

# Make a scatter plot
plotCompoundScatter <- function(time, data, name, col="black", ylim=c(0.0, 0.2), xlim=c(0, 30)){
  # plot the single curves
  plot(numeric(0), numeric(0), 'l', main=name,
       xlab="time [s]", ylab="c [mM]", ylim=ylim, xlim=xlim)
  
  Nsim <- ncol(data)
  for (ks in seq(Nsim)){
    points(time,data[,ks], col=rgb(0,100,0,25,maxColorValue=255), pch=16)
    #lines(time, data[,ks], col="gray")
  }
  
  # plot the mean and variance for time courses
  # TODO how to better calculate -> what error measurment to use
  rmean <- rowMeans(data)
  rstd <- rowSds(data)
  lines(time, rmean, col=col, lwd=2)
  lines(time, rmean+rstd, col=col, lwd=2, lty=2)
  lines(time, rmean-rstd, col=col, lwd=2, lty=2)
}

plot2Ddensity <- function(time, data, name, col="black", ylim=c(0.0, 0.2), xlim=c(0, 30)){
  
  library('KernSmooth')
  # prepare data
  Nsim <- ncol(data)
  tmax_ind <- length(which(time<100))
  Nt <- length(time[1:tmax_ind])
  x <- matrix(NA, nrow=Nsim*Nt, ncol=2)
  for (ks in seq(Nsim)){
    indices <- ((ks-1)*Nt+1):(ks*Nt)  
    tmp <- cbind(time[1:tmax_ind], data[1:tmax_ind, ks])
    x[indices,] <- tmp
  }
  est <- bkde2D(x, bandwidth=c(2, 0.02), gridsize=c(100,200), range.x=list(c(0,100), c(0,0.5)) )
  contour(est$x1, est$x2, est$fhat)
  # plot the mean and variance for time courses
  # TODO how to better calculate -> what error measurment to use
  for (ks in seq(Nsim)){
    points(time,data[,ks], col=rgb(0,100,0,20,maxColorValue=255), pch=16)
    #lines(time, data[,ks], col="gray")
  }
  rmean <- rowMeans(data)
  rstd <- rowSds(data)
  lines(time, rmean, col=col, lwd=2)
  lines(time, rmean+rstd, col=col, lwd=2, lty=2)
  lines(time, rmean-rstd, col=col, lwd=2, lty=2)

}
name="PV__alb"
plot2Ddensity(time, MI.mat[[name]][,], name, col=ccolors[name], ylim=c(0,0.8))

time <- readTimeForSimulation(ma.settings$dir.simdata, rownames(pars)[1]) -10.0
Nc <- length(pv_compounds)

create_plot_files = FALSE
if (create_plot_files == TRUE){
  png(filename=paste(ma.settings$dir.results, '/', task, "_Dilution_Curves.png", sep=""),
    width = 4000, height = 1000, units = "px", bg = "white",  res = 200)
}
par(mfrow=c(1,Nc))
for (name in pv_compounds){
  plotCompound(time, MI.mat[[name]], name, col=ccolors[name])
}
par(mfrow=c(1,1))
if (create_plot_files == TRUE){
  dev.off()
}
dev.off()

name="PV__alb"
plotCompound(time, MI.mat[[name]][,1:200], name, col=ccolors[name], ylim=c(0,0.8))
plotCompoundScatter(time, MI.mat[[name]][,], name, col=ccolors[name], ylim=c(0,0.8))
plot2Ddensity(time, MI.mat[[name]][,], name, col=ccolors[name], ylim=c(0,0.8))

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

# Maxtime boxplots
# calculate the maximum values
maxtime <- data.frame(tmp=numeric(nrow(pars)))

for (kc in seq(1, length(compounds)) ){  
  name = paste("PV__", compounds[kc], sep="")
  print(name)
  maxtime[[name]] <- numeric(nrow(pars))    
  # find the max values for all simulations
  for (k in seq(1, nrow(pars))){
    maxtime[[name]][k] = time[ which.max(dilmat[[name]][,k]) ]
  }
}
maxtime$tmp <- NULL
colMeans(maxtime)

png(filename=paste(ma.settings$dir.results, '/', task, "_Dilution_Curves_Combined.png", sep=""),
    width = 1400, height = 1400, units = "px", bg = "white",  res = 150)
# dev.off()
# par(mfrow=c(2,1), omi=c(0.5,0.3,0,0), plt=c(0.1,0.9,0,0.7))
par(mfrow=c(2,1))

#png(filename=paste(info.folder, '/', task, "_Boxplot_MaxTimes", sep=""),
#     width = 1000, height = 1000, units = "px", bg = "white",  res = 150)

boxplot(maxtime, col=ccolors, horizontal=T,  ylim=c(0,20),
        xaxt="n", # suppress the default x axis
        yaxt="n", # suppress the default y axis
        frame="f" # suppress the plotting frame
        )
summary(maxtime)

# Plot curves
plot(numeric(0), numeric(0), 
     xlim=c(0,20), ylim=c(0,16), 
     # frame="f", # suppress the plotting frame
     box="false",
     xlab="time [s]", ylab="10^3 x outflow fraction/ml")

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
legend("topright",  legend = expcompounds, fill=expcolors)
par(mfrow=c(1,1))
dev.off()



