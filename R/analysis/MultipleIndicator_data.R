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
# Data integration
###############################################################
gor1973.A <- gor1973[gor1973$condition=="A",]
gor1973.B <- gor1973[gor1973$condition=="B",]
gor1973.C <- gor1973[gor1973$condition=="C",]

plot(numeric(0), numeric(0), 
     xlim=c(0,30), ylim=c(0,16), 
     xlab="time [s]", ylab="10^3 x outflow fraction/ml", main="Goresky1973 & 1983")
plotDilutionData(gor1983, compounds, ccolors, time_shift=-rbc_time_offset(gor1983))
plotDilutionData(gor1973.A, compounds, ccolors, time_shift=-rbc_time_offset(gor1973.A)+0.75)
plotDilutionData(gor1973.B, compounds, ccolors, time_shift=-rbc_time_offset(gor1973.B)+1.5)
plotDilutionData(gor1973.C, compounds, ccolors, time_shift=-rbc_time_offset(gor1973.C)+1.5)
legend("topright",  legend=compounds, fill=ccolors) 

# create combined dataset with corrected times
# necessary to timeshift individual experiments in different animals
# to get identical start times for dilution curves
gor1983$condition <- '-'
gor1983$study <- 'gor1983'
gor1983$time_shift <- -rbc_time_offset(gor1983)

gor1973$study <- 'gor1973'
gor1973$time_shift <- NA
gor1973$time_shift[gor1973$condition == 'A'] <-   -rbc_time_offset(gor1973.A) + 0.75
gor1973$time_shift[gor1973$condition == 'B'] <-  -rbc_time_offset(gor1973.B) + 1.5
gor1973$time_shift[gor1973$condition == 'C'] <-  -rbc_time_offset(gor1973.C) + 1.5
d = rbind(gor1983, gor1973)
d$time_exp <- d$time
d$time <- d$time_exp + d$time_shift

# create combined dataset with corrected times
fname <- file.path(ma.settings$dir.base, 'results', 'dilution', 'Goresky_processed.csv')
write.table(d, file=fname, sep='\t', col.names=TRUE, row.names=FALSE, quote=FALSE)

create_plots = TRUE
fname.plot <- paste(fname, '.png', sep='')
startDevPlot(file=fname.plot, width=1200, height=1200, create_plots=create_plots)
plot(numeric(0), numeric(0), 
     xlim=c(0,25), ylim=c(0,16), 
     xlab="time [s]", ylab="10^3 x outflow fraction/ml", main="Goresky1973 & 1983")
plotDilutionData(d[d$study=="gor1983",], compounds, ccolors)
plotDilutionData(d[d$study=="gor1973" & d$condition=="A",], compounds, ccolors)
plotDilutionData(d[d$study=="gor1973" & d$condition=="B",], compounds, ccolors)
plotDilutionData(d[d$study=="gor1973" & d$condition=="C",], compounds, ccolors)
legend("topright",  legend=compounds, fill=ccolors, pt.bg=add.alpha(ccolors, 0.6)) 
stopDevPlot(create_plot=TRUE)

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