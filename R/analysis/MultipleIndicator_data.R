################################################################
## Experimental Data for Dilution Curves
################################################################
# Data from Goresky and Villeneuve.
# The Goresky data is simulated.
#
# author: Matthias Koenig
# date: 2014-11-17
################################################################

rm(list=ls())
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)

create_plots = FALSE
compounds = c('RBC', 'albumin', 'Na', 'sucrose', 'water', 'galactose')
ccolors = c('darkred', 'darkgreen', 'gray', 'darkorange', 'darkblue', 'black')

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
    plot(numeric(0), numeric(0), type='n',
         xlim=c(0,30), ylim=c(0,16), 
         xlab="time [s]", ylab="10^3 x outflow fraction/ml", main=name)
    data <- gor1973[gor1973$condition == condition, ]
    plotDilutionData(data, compounds, ccolors, correctTime=correctTime)
  }
  par(mfrow=c(1,1))  
}
startDevPlot(file=file.path(ma.settings$dir.results, 'figures', 'MultipleIndicator_Goresky1973_1.png'), create_plots=create_plots)
plotDilutionDataGoresky1973()
stopDevPlot()
startDevPlot(file=file.path(ma.settings$dir.results, 'figures', 'MultipleIndicator_Goresky1973_2.png'), create_plots=create_plots)
plotDilutionDataGoresky1973(correctTime=TRUE)
stopDevPlot()


###############################################################
## Goresky1983 ##
# Units: time [s], compound: 1000*outflow fraction/ml
gor1983 <- read.csv(file.path(ma.settings$dir.expdata, "dilution_indicator", "Goresky1983_Fig1.csv"), sep="\t")
summary(gor1983)
plot(numeric(0), numeric(0), 
     xlim=c(0,30), ylim=c(0,16), 
     xlab="time [s]", ylab="10^3 x outflow fraction/ml", main="Goresky1973")
plotDilutionData(gor1983, compounds, ccolors)


startDevPlot(file=file.path(ma.settings$dir.results, 'figures', 'MultipleIndicator_Goresky1983_1.png'), create_plots=create_plots)
plot(numeric(0), numeric(0), 
     xlim=c(0,30), ylim=c(0,16), 
     xlab="time [s]", ylab="10^3 x outflow fraction/ml", main="Goresky1973")
plotDilutionData(gor1983, compounds, ccolors, correctTime=TRUE)
stopDevPlot()


## Goresky1983 & 1973 ##
startDevPlot(file=file.path(ma.settings$dir.results, 'figures', 'MultipleIndicator_Goresky_1.png'), create_plots=create_plots)
plot(numeric(0), numeric(0), 
     xlim=c(0,30), ylim=c(0,16), 
     xlab="time [s]", ylab="10^3 x outflow fraction/ml", main="Goresky1973 & 1983")
plotDilutionData(gor1983, compounds, ccolors, correctTime=TRUE)
plotDilutionData(gor1973[gor1973$condition=="A",], compounds, ccolors, correctTime=TRUE)
plotDilutionData(gor1973[gor1973$condition=="B",], compounds, ccolors, correctTime=TRUE)
plotDilutionData(gor1973[gor1973$condition=="C",], compounds, ccolors, correctTime=TRUE)
stopDevPlot()

###############################################################
## Villeneuve1996 ##
# data is in log
vil1996 <- read.csv(file.path(ma.settings$dir.expdata, "dilution_indicator", "Villeneuve1996_Fig3.csv"), sep="\t")
summary(vil1996)
startDevPlot(file=file.path(ma.settings$dir.results, 'figures', 'MultipleIndicator_Villeneuve1996_1.png'), create_plots=create_plots)
plot(numeric(0), numeric(0), 
     xlim=c(0,120), ylim=c(0,4000), 
     xlab="time [s]", ylab="10^3 x outflow fraction", main="Villeneuve1996")
plotDilutionData(vil1996, compounds, ccolors, correctTime=TRUE)
stopDevPlot()

# scaling for comparison
vil1996$outflow <- 1/200 * vil1996$outflow
# Plot all the dilution curves in the same plot
startDevPlot(file=file.path(ma.settings$dir.results, 'figures', 'MultipleIndicator_All_1.png'), create_plots=create_plots)
plot(numeric(0), numeric(0), 
     xlim=c(0,120), ylim=c(0,20), 
     xlab="time [s]", ylab="10^3 x outflow fraction", main="Villeneuve1996")
plotDilutionData(vil1996, compounds, ccolors, correctTime=TRUE)
plotDilutionData(gor1983, compounds, ccolors, correctTime=TRUE)
plotDilutionData(gor1973[gor1973$condition=="A",], compounds, ccolors, correctTime=TRUE)
plotDilutionData(gor1973[gor1973$condition=="B",], compounds, ccolors, correctTime=TRUE)
plotDilutionData(gor1973[gor1973$condition=="C",], compounds, ccolors, correctTime=TRUE)
stopDevPlot()