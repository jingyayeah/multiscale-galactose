
rm(list=ls())   # Clear all objects
setwd("/home/mkoenig/multiscale-galactose-results/")

################################################################
## Galactose Clearance & Elimination Curves ##
################################################################
# author: Matthias Koenig
# date: 2014-04-07

# load the experimental data Schirmer1986 from excel
install.packages("XLConnect")
library("XLConnect")
file_Schirmer1986 = "/home/mkoenig/multiscale-galactose/experimental_data/galactose_clearance/Koenig_galactose_clearance.xlsx"
excel.file <- file.path(file_Schirmer1986)
elements <- readWorksheetFromFile(excel.file, sheet="Schirmer1986_Fig2")







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
