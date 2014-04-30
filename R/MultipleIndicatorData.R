################################################################
## Evaluate Experimental Galactose Dilution Curves ##
################################################################
# author: Matthias Koenig
# date: 2014-04-14


###############################################################
rm(list=ls())
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)

compounds = c('RBC', 'albumin', 'Na', 'sucrose', 'water', 'galactose')
ccolors = c('darkred', 'darkgreen', 'gray', 'darkorange', 'darkblue', 'black')
#          red,  green, orange, blue,  black, gray


###############################################################
# Load experimental data 
###############################################################
## Goresky1973 ##
# Units: time [s], compound: 1000*outflow fraction/ml 
# A : galactose 5mg/100ml | glucose 117 mg/100ml
# gor1973.A <- gor1973[gor1973$condition == 'A',]

# B: galactose 225mg/100ml | glucose 103 mg/100ml
# gor1973.B <- gor1973[gor1973$condition == 'B', ]

# C: galactose 225mg/100ml | glucose 103 mg/100ml
# gor1973.C <- gor1973[gor1973$condition == 'C',]

gor1973 <- read.csv(file.path(ma.settings$dir.expdata, "dilution_indicator", "Goresky1973_Fig1.csv"), sep="\t")
summary(gor1973)

plotDilutionDataGoresky1973 <- function(correctTime=FALSE){
  #plot the curves, i.e compound against time
  condition.levels = levels(gor1973$condition);
  par(mfrow=c(length(condition.levels),1))
  for (condition in condition.levels){
    name = paste("Goresky1973", condition)
    print(name)
    plot(numeric(0), numeric(0), 
         xlim=c(0,30), ylim=c(0,16), 
         xlab="time [s]", ylab="10^3 x outflow fraction/ml", main=name)
    data <- gor1973[gor1973$condition == condition, ]
    plotDilutionData(data,  correctTime)  
  }
  par(mfrow=c(1,1))  
}

plot(numeric(0), numeric(0), 
     xlim=c(0,30), ylim=c(0,16), 
     xlab="time [s]", ylab="10^3 x outflow fraction/ml", main="Goresky1973")
plotDilutionDataGoresky1973()

plot(numeric(0), numeric(0), 
     xlim=c(0,30), ylim=c(0,16), 
     xlab="time [s]", ylab="10^3 x outflow fraction/ml", main="Goresky1973")
plotDilutionDataGoresky1973(correctTime=TRUE)


## Goresky1983 ##
# Units: time [s], compound: 1000*outflow fraction/ml
gor1983 <- read.csv(file.path(ma.settings$dir.expdata, "dilution_indicator", "Goresky1983_Fig1.csv"), sep="\t")
summary(gor1983)
plot(numeric(0), numeric(0), 
     xlim=c(0,30), ylim=c(0,16), 
     xlab="time [s]", ylab="10^3 x outflow fraction/ml", main="Goresky1973")
plotDilutionData(gor1983)

plot(numeric(0), numeric(0), 
     xlim=c(0,30), ylim=c(0,16), 
     xlab="time [s]", ylab="10^3 x outflow fraction/ml", main="Goresky1973")
plotDilutionData(gor1983, correctTime=TRUE)


## Goresky1983 & 1973 ##
plot(numeric(0), numeric(0), 
     xlim=c(0,30), ylim=c(0,16), 
     xlab="time [s]", ylab="10^3 x outflow fraction/ml", main="Goresky1973 & 1983")
plotDilutionData(gor1983, correctTime=TRUE)
plotDilutionData(gor1973[gor1973$condition=="A",], correctTime=TRUE)
plotDilutionData(gor1973[gor1973$condition=="B",], correctTime=TRUE)
plotDilutionData(gor1973[gor1973$condition=="C",], correctTime=TRUE)


## Villeneuve1996 ##
# data is in log
plot(numeric(0), numeric(0), 
     xlim=c(0,120), ylim=c(0,4000), 
     xlab="time [s]", ylab="10^3 x outflow fraction", main="Villeneuve1996")
vil1996 <- read.csv(paste(folder$expdata, "/", "Villeneuve1996_Fig3.csv", sep=""), sep="\t")
summary(vil1996)
plotDilutionData(vil1996.scale, correctTime=TRUE)


# Plot all the dilution curves in the same plot
plot(numeric(0), numeric(0), 
     xlim=c(0,120), ylim=c(0,20), 
     xlab="time [s]", ylab="10^3 x outflow fraction", main="Villeneuve1996")
vil1996.scale <- vil1996
vil1996.scale$outflow <- 1/200 * vil1996.scale$outflow
plotDilutionData(vil1996.scale, correctTime=TRUE)
plotDilutionData(gor1983, correctTime=TRUE)
plotDilutionData(gor1973[gor1973$condition=="A",], correctTime=TRUE)
plotDilutionData(gor1973[gor1973$condition=="B",], correctTime=TRUE)
plotDilutionData(gor1973[gor1973$condition=="C",], correctTime=TRUE)


###############################################################
# Plot with simulations data
###############################################################
## Goresky1983 & 1973 ##
plot(numeric(0), numeric(0), 
     xlim=c(0,30), ylim=c(0,16), 
     xlab="time [s]", ylab="10^3 x outflow fraction/ml", main="Goresky1973 & 1983")
plotDilutionData(gor1983, correctTime=TRUE)
plotDilutionData(gor1973[gor1973$condition=="A",], correctTime=TRUE)
plotDilutionData(gor1973[gor1973$condition=="B",], correctTime=TRUE)
plotDilutionData(gor1973[gor1973$condition=="C",], correctTime=TRUE)

### Load the simulation data  structure ###
folder.info <- '2014-04-13_Dilution_Curves'
modelId <- 'Dilution_Test'
dataset1.file <- paste(folder.info, '/', modelId, '_dataset1','.rdata', sep="")
load(file=dataset1.file)


## Combined Dilution Curves in one plot ##
#png(filename=paste(info.folder, '/', task, "_Dilution_Curves_Combined.png", sep=""),
#    width = 1000, height = 1000, units = "px", bg = "white",  res = 150)

library('matrixStats')

sim_compounds = c('rbcM', 'alb', 'suc', 'h2oM', 'gal')
sim_colors = c('darkred', 'darkgreen', 'darkorange', 'darkblue', 'black')



time <- readTimeForSimulation(rownames(pars)[1])
time <- time - 10;
sim_scale = 80;
plot(numeric(0), numeric(0), col=sim_colors[kc], lwd=1, 'l', main="Dilution Curves", xlab="time [s]", ylab="c [mM]", ylim=c(0.0, 0.30*sim_scale), xlim=c(0.0, 30) )
for (kc in seq(1, length(sim_compounds)) ){
  print(kc)
  # name = "PV__rbcM"
  name = paste("PV__", sim_compounds[kc], sep="")
  print(name)
  # plot one compound
  tmp <- dilmat[[name]]
  
  tmp_scale <- tmp*sim_scale
  
  # plot the mean and variance for time courses
  rmean <- rowMeans(tmp_scale)
  rstd <- rowSds(tmp_scale)
  
  lines(time, rmean, col=sim_colors[kc], lwd=2)
  lines(time, rmean+rstd, col=sim_colors[kc], lwd=1, lty=2)
  # lines(time, rmean-rstd, col=sim_colors[kc], lwd=1, lty=2)
}
# par(mfrow=c(1,1))
#dev.off()

plotDilutionData(gor1983, correctTime=TRUE)
plotDilutionData(gor1973[gor1973$condition=="A",], correctTime=TRUE)
plotDilutionData(gor1973[gor1973$condition=="B",], correctTime=TRUE)
plotDilutionData(gor1973[gor1973$condition=="C",], correctTime=TRUE)

##########################################################################

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

