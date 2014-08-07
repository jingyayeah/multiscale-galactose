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


# Alternative dimension reduction based on the RDP algorithm
# http://en.wikipedia.org/wiki/Ramer%E2%80%93Douglas%E2%80%93Peucker_algorithm
# Ramer–Douglas–Peucker algorithm
reduceDimension <- function(df){
  # Reduction of dimensionality for given dataframe consisting
  # of time, data
  # The first and last element are kept as well as all inner elements, which
  # are not identical to the previous one in respect to the data
  Nr = nrow(df)
  unique_indices <- abs(df[2:(Nr-1),2]-df[1:(Nr-2),2])>1E-8  
  indices <- c(TRUE, unique_indices, TRUE)
  res <- df[indices, ]
}

addEventPoints <- function(df){
  
}


# define the objects of interest (not too many are possible)
ids <- c('PP__gal', 'PV__gal', 'PP__galM', 'PV__galM')
id <- ids[1]

# create list of timecourses for one component
simIds = rownames(pars)
Nsim = length(simIds)

# Create the empty data structures
rm(tmp)
tmp = vector('list', length(ids))
names(tmp) <- ids
for (id in ids){
  elist <- vector('list', Nsim)
  names(elist) <- simIds
  tmp[[id]] <- elist
}

for (ks in seq(Nsim)){
# for (ks in seq(10)){
  print(ks/Nsim)

  # read the data into -> data
  fname <- getSimulationFileFromSimulationId(ma.settings$dir.simdata, simIds[ks])
  load(paste(fname, '.Rdata', sep=''))
    
  # assign the data
  for (id in ids){
    df <- data[, c('time', id)];
    tmp[[id]][[ks]] <- reduceDimension(df)
  }
}
head(tmp$PP__galM)



makeTransparent<-function(someColor, alpha=100)
{
  newColor<-col2rgb(someColor)
  apply(newColor, 2, function(curcoldata){rgb(red=curcoldata[1], green=curcoldata[2],
                                              blue=curcoldata[3],alpha=alpha, maxColorValue=255)})
}


col=makeTransparent('Red', 0.5)
col

head(pars)
gal_levels <- levels(factor(pars$PP__gal))
gal_levels <- gal_levels[c(2,4,5)]
gal_levels

# plot some of the timecourses
PV__galM <- tmp[['PV__galM']]

par(mfrow=c(1,length(gal_levels)))
# create subplot for all the different levels
for (gal_level in gal_levels){
  # empty plot
  plot(numeric(0), numeric(0), xlim=c(999,1040), ylim=c(0,0.5))
  
  # find the simulation rows for the level
  gal_rows <- which(pars$PP__gal==gal_level)

  # plot all the single simulations for the level
  for (k in gal_rows){
    points(PV__galM[[k]]$time, PV__galM[[k]][[2]], type='l', col=rgb(0.5,0.5,0.5, alpha=0.1 ))      
  }
}
par(mfrow=c(1,1))



# data approximation
#     data.approx <- approx(datalist[[ks]][, 'time'], datalist[[ks]][, kc], xout=time, method="linear")
#     tmp[, ks] <- data.approx[[2]]


df <- tmp[[1]]
Nr <- nrow(df)
df[2:(Nr-1),2]
df[2,]

head(tmp[[1]])
head(tmp[[100]])
plot(data$time, data$PV__gal)
dim(tmp[[500]])

test <- tmp[[1]]
head(test)
plot(test[[1]], test[[2]], ylim=c(0, 0.1))

duplicated()

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

