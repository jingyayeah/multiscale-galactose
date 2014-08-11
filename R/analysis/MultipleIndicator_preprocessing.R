################################################################
# Preprocess Multiple Indicator Dilution data
################################################################
# Read the timecourse data and creates reduced data structures
# for simplified query and visualization.
#
# Run with: Rscript
# author: Matthias Koenig
# date: 2014-08-11
################################################################
rm(list=ls())
library(data.table)
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)

# folder <- '2014-07-30_T25'
folder <- '2014-07-30_T26'


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
rm(modelXML)

# make a results folder
dir.create(file.path(folder, 'results'), showWarnings = FALSE)

# read the parameter file
pars <- loadParameterFile(file=parsfile)
simIds = rownames(pars)
head(pars)
plotParameterHistogramFull(pars)   

###############################################################
# preprocess data
###############################################################
# more efficient preprocessing ?
# read all the information in Rdata files
# createColumnDataFiles(pars, dir=ma.settings$dir.simdata)

## parallel preprocessing (mclapply) ##
library(parallel)
workerFunc <- function(simId){
  print(simId)
  fname <- getSimulationFileFromSimulationId(ma.settings$dir.simdata, simId)
  data <- readDataForSimulationFile(fname)
  save(data, file=paste(fname, '.Rdata', sep=''))
}
Ncores <- 12
res <- mclapply(simIds, workerFunc, mc.cores=Ncores)
rm(Ncores)

###############################################################
# now all the Rdata files exist: 
# putting things together from the different calculations to calculate
# statistical values
# The variable timesteps have to be accounted for.

## Dimension Reduction ## 
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

## Add Event timepoints ##
# necessary to add event points for plotting purposes.
# Otherwise there are large jumps in the values during plotting
addEventPoints <- function(df){
  Nr = nrow(df)
  event_indices <- 1 + which(abs(df[2:Nr,2]-df[1:(Nr-1),2])>0.1)
  # add rows to the dataframe at the end
  rnew <- data.frame( (df[event_indices, 1]-1E-8), df[(event_indices-1),2] )
  names(rnew) <- names(df)
  # print(sprintf("%.10f",rnew[1]))
  df <- rbind(df, rnew)  
  # sort the data frame
  df <- df[with(df, order(time)),]
}

# Creates list of lists for the given ids from the timeseries data.
# Perfoms Dimensionality reduction and adds interpolated timepoints 
# for the events
createDataMatrices <- function(ids, out.fname, simIds){
  # Create the list for storage of the matrices
  x <- vector('list', length(ids))
  names(x) <- ids
  
  # Create list of lists
  Nsim = length(simIds)
  for (id in ids){  
    x[[id]] <- vector('list', Nsim)
    names(x[[id]]) <- simIds
  }
  
  # Fill the lists
  
  for (ks in seq(Nsim)){
    cat(ks/Nsim*100, '\n')  
    # load data as 'data' and put in list
    fname <- getSimulationFileFromSimulationId(ma.settings$dir.simdata, simIds[ks])
    load(paste(fname, '.Rdata', sep=''))
    for (id in ids){
      df <- data[, c('time', id)];
      df <- reduceDimension(df)
      df <- addEventPoints(df)
      x[[id]][[ks]] <- df
    }
  }
  save(x, ids, file=out.fname)
  return(x)
}

## Create timeseries list of lists ##
# dictionary of the available names
fname <- getSimulationFileFromSimulationId(ma.settings$dir.simdata, simIds[1])
ids.dict <- names(data)

ids <- c("PP__alb", "PP__gal", "PP__galM", "PP__h2oM", "PP__rbcM", "PP__suc",
         "PV__alb", "PV__gal", "PV__galM", "PV__h2oM", "PV__rbcM", "PV__suc")
x.fname <- paste(folder, '/results/x.Rdata', sep='')

# make the preprocessing
x <- createDataMatrices(ids=ids, out.fname=x.fname, simIds=simIds)
# load the data without preprocessing
load(file=x.fname)


###############################################################

# calculate functions on the reduced sets
# use t-approx to make the corresponding matrix
# than calculate values on the matrix
# 1. calculate the matrix 5000 x 200/0.05 (4000)
#                              x 50/0.01 (5000)   
length(ids.dict)

# data approximation
#     data.approx <- approx(datalist[[ks]][, 'time'], datalist[[ks]][, kc], xout=time, method="linear")
#     tmp[, ks] <- data.approx[[2]]

# time vector for approximation matrix
time.min <- 995
time.max <- 1050
time = seq(from=time.min, to=time.max, by=0.2)
Ntime = length(time)

mat <- vector('list', length(ids))
names(mat) <- ids

for (id in ids){
  # setup the empty matrix
  mat[[id]] <- matrix(data=NA, nrow=Ntime, ncol=Nsim)
  colnames(mat[[id]]) <- simIds
  rownames(mat[[id]]) <- time
  
  # fill the matrix
  for(ks in seq(Nsim)){
    datalist <- x[[id]]
    data.interp <- approx(datalist[[ks]][, 'time'], datalist[[ks]][, 2], xout=time, method="linear")
    mat[[id]][, ks] <- data.interp[[2]]
  }
}


head(mat)
summary(mat)

# now calculate things on the matrix and store
# i.e. mean, std, 

# subsetting by the level
gal_levels <- levels(factor(pars$PP__gal))
#gal_levels <- gal_levels[c(2,4,5)]
gal_levels

# Calculate the volume flow for weigthing
pars$F <- pi*(pars$y_sin^2) * pars$flow_sin

plot(pars$flow_sin, pars$F)
plot(pars$y_sin, pars$F)



## plot the mean timecourses ##
library('matrixStats')
compounds = c('gal', 'galM', 'rbcM', 'alb', 'suc', 'h2oM')
ccolors = c('gray', 'black', 'red', 'darkgreen', 'darkorange', 'darkblue')

plotMeanCurves <- function(){
for (kc in seq(length(compounds))){
  compound <- compounds[kc]
  col <- ccolors[kc]
  id <- paste('PV__', compound, sep='')
  for (gal_level in gal_levels){
    # find the simulation rows for the level
    gal_rows <- which(pars$PP__gal==gal_level)
  
    tmp <- mat[[id]][,gal_rows]
    w <- pars$F[gal_rows] # weighting with the volume flow F

    row.means <- rowMeans(tmp)
    row.wmeans <- rowWeightedMeans(tmp, w=w)
    row.medians <- rowMedians(tmp)
    row.wmedians <- rowWeightedMedians(tmp, w=w)
    
    points(time, row.wmeans, col=col, lwd=2, type='l', lty=1)
    points(time, row.wmedians, col=col, lwd=2, type='l', lty=2)
    
    #points(time, row.means, col=col, lwd=2, type='l', lty=1)
    #points(time, rowMedians(tmp), col=col, lwd=2, type='l', lty=3)
  
    #points(time, rowMins(tmp), col='Red', lwd=2, type='l', lty=2)
    #points(time, rowMaxs(tmp), col='Red', lwd=2, type='l', lty=2)
    #points(time, rowQuantiles(tmp,probs=c(0.25)), col='Green', lwd=2, type='l', lty=3)
    #points(time, rowQuantiles(tmp,probs=c(0.75)), col='Green', lwd=2, type='l', lty=3)  
    
    # lines for the max values
    tmax.wmeans <- time[which.max(row.wmeans)]
    cat("tmax [", id , "] = ", tmax.wmeans, "\n")
    tmax.means <- time[which.max(row.means)]
    abline(v=tmax.wmeans, col=col)
    #abline(v=tmax.means, col=col)
  }
}
}
par(mfrow=c(2,1))
plot(numeric(0), numeric(0), log='y', xlim=c(time.min, 1025), ylim=c(1E-2,0.5))
plotMeanCurves()
plot(numeric(0), numeric(0), xlim=c(time.min, 1025), ylim=c(0,0.3))
plotMeanCurves()
par(mfrow=c(1,1))
     
#########
# The galactose peaks come almost with the RBC peaks ?
# why (in single simulation this is different)

# sort the pars to find matching simulations
pars.sorted <- pars[with(pars, order(y_cell, y_sin, L, y_dis, flow_sin, PP__gal)), ]
head(pars.sorted)


N=54
plot(numeric(0), numeric(0), xlim=c(time.min, 1025), ylim=c(0,0.3))
testIds = rownames(pars.sorted)[(1+N*5):(5+N*5)]
for (simId in testIds){
  for (kc in seq(length(compounds))){
    compound <- compounds[kc]
    print(compound)
    id <- paste('PV__', compound, sep="")
    print(id)
    col <- ccolors[kc]
    time <- x[[id]][[simId]]$time
    tmp.data <- x[[id]][[simId]][[2]]
    points(time, tmp.data, type='l', col=col)
    tmp.tmax <- time[which.max(tmp.data)]
    abline(v=tmp.tmax, col=col)
  }
}

hist(pars$flow_sin, breaks = 40)
summary(pars$flow_sin)

###########################################################################
# Plot large set of single timecourses.
# The large-scale plot is only possible on the dimension reduced data sets.
# Select id and plot levels.

# which ids splitted under which levels
f.level = "gal_challenge"  # "PP__gal" 
plot.ids = c('PP__gal', 'PV__gal')
plot.colors = c( rgb(0.5,0.5,0.5, alpha=0.3), rgb(0.5,0.5,1.0, alpha=0.3) )
names(plot.colors) <- plot.ids

# set the minimal and maximal time for plotting
xlimits <- c(1800, 2500)
ylimits <- c(0.0, 7.0)

# create subplot for all the different levels
nrow = ceiling(sqrt(length(plot.levels)))
par(mfrow=c(nrow, nrow))
plot.levels <- levels(as.factor(pars[[f.level]]))
for (p.level in plot.levels){
  # empty plot
  plot(numeric(0), numeric(0), xlim=xlimits, ylim=ylimits, 
       main=paste(f.level, '=', p.level))
  
  # find the simulation rows for the level &
  # plot all the single simulations for the level
  gal_rows <- which(pars[[f.level]]==p.level)
  for (k in gal_rows){
    for (id in plot.ids){
      points(x[[id]][[k]]$time, x[[id]][[k]][[2]], 
           type='l', col=plot.colors[[id]])      
    }
  }
}
par(mfrow=c(1,1))


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

