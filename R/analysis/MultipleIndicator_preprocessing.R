################################################################
# Preprocess Multiple Indicator Dilution data
################################################################
# Read the timecourse data and creates reduced data structures
# for simplified query and visualization.
#
# Run with: Rscript
# author: Matthias Koenig
# date: 2014-07-30
rm(list=ls())

# - data folder & how to interpolate the information
folder <- '2014-07-30_T25'
t.approx <- seq(from=0, to=100, by=0.1)
plot(seq(1,length(t.approx)), t.approx )

##

library(data.table)
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)
ma.settings$simulator <- 'ROADRUNNER'

# read the file information from the folder
tmp <- strsplit(folder, '_')
date <- tmp[[1]][1]
task <- tmp[[1]][2]
rm(tmp)
modelXML <- list.files(path=file.path(ma.settings$dir.results, folder), pattern='.xml')
# remove the '.xml'
modelId <- substr(modelXML,1,nchar(modelXML)-4)
ma.settings$dir.simdata <- file.path(ma.settings$dir.results, folder, task)
parsfile <- file.path(ma.settings$dir.results, folder, 
                      paste(task, '_', modelId, '_parameters.csv', sep=""))

###############################################################
# preprocess data
###############################################################
pars <- loadParameterFile(file=parsfile)
head(pars)
names(pars)

#plotParameterHistogramFull(pars)   

# more efficient preprocessing ?
# read all the information in Rdata files
# createColumnDataFiles(pars, dir=ma.settings$dir.simdata)
# head(pars)


# do parallell - Parallel calculation (mclapply):
library(parallel)
numWorkers <- 12

workerFunc <- function(simId){
  print(simId)
  fname <- getSimulationFileFromSimulationId(ma.settings$dir.simdata, simId)
  data <- readDataForSimulationFile(fname)
  save(data, file=paste(fname, '.Rdata', sep=''))
}
values = rownames(pars)
res <- mclapply(values, workerFunc, mc.cores = numWorkers)

# now all the Rdata files exist: it is necessary to put the things together for the different ids
# this should hopefully be fast,
# here the problems with the variable timesteps arise

compounds = c('PP__gal', 'PV__gal')
compounds[1]

# Read the data
simIds = rownames(pars)
Nsim = length(simIds)

# compund names
Nc <- length(compounds)


# create empty matrix first
tmp = vector('list', Nc)
tmp
names(tmp) <- compounds
tmp

# create a matrix 
for (kc in seq(10)){
  # read the data
  fname <- getSimulationFileFromSimulationId(ma.settings$dir.simdata, simIds[kc])
  print(fname)
  load(paste(fname, '.Rdata', sep=''))
  Ntime = nrow(data)
  tmp <- matrix(data=NA, nrow = Ntime, ncol = Nsim)
  colnames(tmp) <- simIds
#   rownames(tmp) <- time
#   
#   for(ks in seq(Nsim)){
#     data.approx <- approx(datalist[[ks]][, 'time'], datalist[[ks]][, kc], xout=time, method="linear")
#     tmp[, ks] <- data.approx[[2]]
#   }
#   mat[[kc]] <- tmp;
}

plot(data$time, data$PV__gal)


rm(list=ls())
# loads variable of name data
load('/home/mkoenig/multiscale-galactose-results/2014-07-30_T25/T25/Galactose_v21_Nc20_dilution_Sim30042_roadrunner.csv.Rdata')




#######################################
# 
# create empty matrix first
createDataMatricesVarSteps <- function(compound_id, dir, simIds, time){
  Nsim = length(simIds)
  
  # compund names
  compounds <- colnames(datalist[[1]])
  Nc <- length(compounds)
  
  # create empty matrix first
  mat = vector('list', Nc)
  names(mat) <- compounds
  
  Ntime = length(time)
  
  for (kc in seq(Nc)){
    tmp <- matrix(data=NA, nrow = Ntime, ncol = Nsim)
    colnames(tmp) <- simulations
    rownames(tmp) <- time
    
    for(ks in seq(Nsim)){
      data.approx <- approx(datalist[[ks]][, 'time'], datalist[[ks]][, kc], xout=time, method="linear")
      tmp[, ks] <- data.approx[[2]]
    }
    mat[[kc]] <- tmp;
  }
  mat
}


# outFile <- preprocess(pars, ma.settings$dir.simdata, time=t.approx)

