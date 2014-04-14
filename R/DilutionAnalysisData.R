################################################################
## Evaluate Experimental Galactose Dilution Curves ##
################################################################
# author: Matthias Koenig
# date: 2014-04-14

rm(list=ls())   # Clear all objects
###############################################################
folder = list()
folder$results <- "/home/mkoenig/multiscale-galactose-results"
folder$code    <- "/home/mkoenig/multiscale-galactose/R" 
folder$expdata    <- "/home/mkoenig/multiscale-galactose/experimental_data/dilution_indicator"
folder
setwd(folder$results)

###############################################################
# Load experimental data 
###############################################################
compounds = c('RBC', 'albumin', 'Na', 'sucrose', 'water', 'galactose')
ccolors = c('darkred', 'darkgreen', 'gray', 'darkorange', 'darkblue', 'black')
#          red,  green, orange, blue,  black, gray

# Plot one multiple-dilution indicator dataset
plotDilutionData <- function(data, correctTime=FALSE){
  Nc = length(compounds)
  for (kc in seq(Nc)){
    compound <- compounds[kc]
    ccolor <- ccolors[kc]
    # check for data for compound
    cdata = data[data$compound==compound,]
    if (correctTime == TRUE){
      cdata <- correctDilutionTimes(cdata)
    }
    
    if (nrow(cdata)>0){
      points(cdata$time, cdata$outflow, col=ccolor)
      lines(cdata$time, cdata$outflow, col=ccolor, lty=1, lwd=4)
    }
  }
}

# The dilution curves have to be corrected, so that the zero timepoint
# is the first measured data point
correctDilutionTimes <- function(data){
  dnew <- data;
  dnew$time <- dnew$time - min(data$time)
  dnew
}

## Goresky1973 ##
# Units: time [s], compound: 1000*outflow fraction/ml 
# A : galactose 5mg/100ml | glucose 117 mg/100ml
# gor1973.A <- gor1973[gor1973$condition == 'A',]

# B: galactose 225mg/100ml | glucose 103 mg/100ml
# gor1973.B <- gor1973[gor1973$condition == 'B', ]

# C: galactose 225mg/100ml | glucose 103 mg/100ml
# gor1973.C <- gor1973[gor1973$condition == 'C',]

gor1973 <- read.csv(paste(folder$expdata, "/", "Goresky1973_Fig1.csv", sep=""), sep="\t")
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
gor1983 <- read.csv(paste(folder$expdata, "/", "Goresky1983_Fig1.csv", sep=""), sep="\t")
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


# plotDilutionData(vil1996)
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


# TODO: plot all the data in the same plot

