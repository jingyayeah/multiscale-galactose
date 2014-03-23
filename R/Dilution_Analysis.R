# Clear all objects
rm(list=ls())
setwd("/home/mkoenig/multiscale-galactose-results/dataR_dilution")

################################################################
## Evaluate Galactose Dilution Curves ##
################################################################
# author: Matthias Koenig
# date: 2014-03-23

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

# Create a function that plots the value of "z" against the "y" value
plotParameterHist <- function(name){
  x <- pars[,name] 
  print(x)
  hist(x, breaks=20, xlab=name, main=paste("Histogram", name))
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

readDataForSim <- function(sim){
  tmp <- read.csv(paste("data/", modelId, "_", sim, "_copasi.csv", sep=""))
  row.names(tmp) <- tmp$time
  tmp$time <- NULL
  
  # reduce data to PP__ and PV__ data
  pppv.index <- which(grepl("^PP__", names(tmp)) | grepl("^PV__", names(tmp)) )
  tmp <- tmp[, pppv.index]
}

dilution <- list()
for (sim in row.names(pars) ){
  print(paste("Read CSV for:", sim))
  v[[sim]] = readDataForSim(sim)
}
save(v, file="T2_Dilution_Data.rdata")

# make tables for the differnt components

nrow(pars)


name = "PV__rbcM"
d.PV__rbcM <- matrix(, nrow = nrow(v[[1]]), ncol = nrow(pars))
for(k in 1:nrow(pars)){
  sim <- row.names(pars)[k]
  d.PV__rbcM[, k] <- v[[sim]][, name]
}
names(d.PV__rbcM) <- row.names(pars)
row.names(d.PV__rbcM) <- names(v[[sim]])

names(v[[sim]])
head(d.PV__rbcM)



compound = "h2oM"
time = as.numeric(row.names(v[["Sim1"]]))
count = 1
for (name in names(v)){
  tmp = v[[name]]
  compoundName = paste("PV__", compound, sep="")
  if (count == 1){
    sumtmp = tmp[[compoundName]]
    plot(time, tmp[[compoundName]], 'l')
  } else {
    sumtmp = sumtmp + tmp[[compoundName]]
    lines(time, tmp[[compoundName]])
  }
  count = count + 1
  if (count == 100){
    lines(time, sumtmp/100, 'b', color='g')
  }
}

  

plot(row.names(test), test[,])
for (k in seq(2, length(names(test)))){
  lines(row.names(test), test[,k])
}


# Plot a simulation
plot(row.names(test), test[,1])
for (k in seq(2, length(names(test)))){
  lines(row.names(test), test[,k])
}

