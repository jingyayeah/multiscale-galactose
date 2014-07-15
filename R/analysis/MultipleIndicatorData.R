################################################################
## Experimental Data for Dilution Curves
################################################################
# Data from Goresky and Villeneuve.
#
# TODO: remove warnings (problems with time correction)
# TODO: proper correction of zero times
# TODO: create plots of data
#
# author: Matthias Koenig
# date: 2014-04-14

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
    plotDilutionData(data, compounds, ccolors, correctTime)
  }
  par(mfrow=c(1,1))  
}
plotDilutionDataGoresky1973()
plotDilutionDataGoresky1973(correctTime=TRUE)

###############################################################
## Goresky1983 ##
# Units: time [s], compound: 1000*outflow fraction/ml
gor1983 <- read.csv(file.path(ma.settings$dir.expdata, "dilution_indicator", "Goresky1983_Fig1.csv"), sep="\t")
summary(gor1983)
plot(numeric(0), numeric(0), 
     xlim=c(0,30), ylim=c(0,16), 
     xlab="time [s]", ylab="10^3 x outflow fraction/ml", main="Goresky1973")
plotDilutionData(gor1983, compounds, ccolors)

plot(numeric(0), numeric(0), 
     xlim=c(0,30), ylim=c(0,16), 
     xlab="time [s]", ylab="10^3 x outflow fraction/ml", main="Goresky1973")
plotDilutionData(gor1983, compounds, ccolors, correctTime=TRUE)


## Goresky1983 & 1973 ##
plot(numeric(0), numeric(0), 
     xlim=c(0,30), ylim=c(0,16), 
     xlab="time [s]", ylab="10^3 x outflow fraction/ml", main="Goresky1973 & 1983")
plotDilutionData(gor1983, correctTime=TRUE)
plotDilutionData(gor1973[gor1973$condition=="A",], compounds, ccolors, correctTime=TRUE)
plotDilutionData(gor1973[gor1973$condition=="B",], compounds, ccolors, correctTime=TRUE)
plotDilutionData(gor1973[gor1973$condition=="C",], compounds, ccolors, correctTime=TRUE)

###############################################################
## Villeneuve1996 ##
# data is in log
plot(numeric(0), numeric(0), 
     xlim=c(0,120), ylim=c(0,4000), 
     xlab="time [s]", ylab="10^3 x outflow fraction", main="Villeneuve1996")
vil1996 <- read.csv(file.path(ma.settings$dir.expdata, "dilution_indicator", "Villeneuve1996_Fig3.csv"), sep="\t")
summary(vil1996)
plotDilutionData(vil1996, compounds, ccolors, correctTime=TRUE)


# Plot all the dilution curves in the same plot
plot(numeric(0), numeric(0), 
     xlim=c(0,120), ylim=c(0,20), 
     xlab="time [s]", ylab="10^3 x outflow fraction", main="Villeneuve1996")

# scaling for comparison
vil1996$outflow <- 1/200 * vil1996$outflow
plotDilutionData(vil1996, compounds, ccolors, correctTime=TRUE)
plotDilutionData(gor1983, compounds, ccolors, correctTime=TRUE)
plotDilutionData(gor1973[gor1973$condition=="A",], compounds, ccolors, correctTime=TRUE)
plotDilutionData(gor1973[gor1973$condition=="B",], compounds, ccolors, correctTime=TRUE)
plotDilutionData(gor1973[gor1973$condition=="C",], compounds, ccolors, correctTime=TRUE)


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
