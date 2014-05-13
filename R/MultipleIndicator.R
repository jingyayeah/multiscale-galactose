################################################################
## Evaluation of MultipleIndicator Dilution Curves ##
################################################################
# The workflow for analysis is:
# [1] preprocessing of timecourse data
# [2] analysis of the parameter samples & probability distributions
#     and weighting of the data
# [3] apply the weighting to the time course simulations. 
#
# Data is read from the preprocessed timecourse samples (TODO: arbitrary 
# preprocessing to get the necessary components out of he solution CSV).
#
# TODO: create proper with experimental data
# TODO: create the log plot
# 
# author: Matthias Koenig
# date: 2014-05-13
################################################################
rm(list=ls())
library('MultiscaleAnalysis')
library('matrixStats')
library('RColorBrewer')
library('libSBML')
setwd(ma.settings$dir.results)

#------------------------------------------------------------------------------#
sname <- '2014-05-13_MultipleIndicator'
version <- 'v17'
ma.settings$dir.simdata <- file.path(ma.settings$dir.results, sname, 'data')
task.offset <- 27
task.seq <- seq(0,2)
tasks <- paste('T', task.offset+task.seq, sep='')
peaks <- paste('P0', task.seq, sep='')
#------------------------------------------------------------------------------#

compounds = c('gal', 'rbcM', 'alb', 'suc', 'h2oM')
ccolors = c('black', 'red', 'darkgreen', 'darkorange', 'darkblue')
compounds = c('rbcM', 'alb', 'suc', 'h2oM')
ccolors = c('red', 'darkgreen', 'darkorange', 'darkblue')
pv_compounds = paste('PV__', compounds, sep='')
names(ccolors) <- pv_compounds

# Colors for probability weights
col2rgb_alpha <- function(col, alpha){
  rgb <- rgb(col2rgb(col)[[1]]/256,col2rgb(col)[[2]]/256,col2rgb(col)[[3]]/256, alpha)
}
# Colors for weights
getColorsForWeights <- function (weights) {
  print('getColorsForWeights')
  ccol = 'gray'
  Nsim = nrow(pars)
  Ncol = 7
  colpal <- brewer.pal(Ncol+2, 'Greys')
  ccols = rep(colpal[1], Nsim)
  maxValue = max(weights) 
  bw = maxValue/Ncol
  for (k in seq(Ncol)){
    ind <- which( (weights>((k-1)*bw)) & (weights <= (k*bw)))
    ccols[ind] = colpal[k+2]
    ccols[ind] = col2rgb_alpha(colpal[k+2], 0.7) 
  }
  ccols
}

# Preprocess the parameters for scaling
Ntask = length(tasks)
for (kt in seq(Ntask)){
  task <- tasks[kt]
  peak <- peaks[kt]
  modelId <- paste('MultipleIndicator_', peak, '_', version, '_Nc20_Nf1', sep='')
  parsfile <- file.path(ma.settings$dir.results, sname, 
                        paste(task, '_', modelId, '_parameters.csv', sep=""))
  # Load the data
  load(file=outfileFromParsFile(parsfile))
  
  # Parameter processing
  ps <- getParameterTypes(pars=pars)
  
  # Extend the parameters with the SBML parameters and calculated parameters
  fsbml <- file.path(ma.settings$dir.results, sname, paste(modelId, '.xml', sep=''))
  model <- loadSBMLModel(fsbml)
  pars <- extendParameterStructure(pars=pars, fixed_ps=ps$fixed, model=model)
  head(pars)
  
  # Standard distributions for normal case
  p.gen <- loadStandardDistributions()
  print(p.gen)
  
  # ECDFs for standard distributions
  ecdf.list <- createListOfStandardECDF(p.gen, ps$var)
  
  # Calculate the probabilites for single variables
  pars <- calculateProbabilitiesForVariables(pars, ecdf.list)
  # And the overall probability per sample
  pars <- calculateSampleProbability(pars, ps$var)
  head(pars)
    
  # Color definition based on probabilities
  weights <- NULL
  # weights = pars$p_sample
  if (is.null(weights)){
    ccols <- NULL 
  }else{
    ccols <- getColorsForWeights(weights)
  }
  
  # Create the plots
  time = getTimeFromPreprocessMatrix(preprocess.mat)-10.0
  plotMultipleIndicatorCurves(time, preprocess.mat, weights=weights, ccols=ccols, create_plot_files=T)
  plotMultipleIndicatorMean(time, preprocess.mat, weights=weights, create_plot_files=T)
}

# some example plots
name="PV__rbcM"
time <- getTimeFromPreprocessMatrix(preprocess.mat) - 10.0
plotCompound(time, preprocess.mat[[name]], name, col=ccolors[name], ylim=c(0,1.2))

###################################################################################
# Dilution curves with experimental data
###################################################################################
# weighted with the actual flow
# rbind.rep <- function(x, times) matrix(x, times, length(x), byrow = TRUE)
# cbind.rep <- function(x, times) matrix(x, length(x), times, byrow = FALSE)
# Q_sinunit = rbind.rep(pars$Q_sinunit, nrow(data))
# tmp = data*Q_sinunit
# rmean2 <- rowMeans(tmp)
# rmean2 <- rmean2/max(rmean2)*10

# calculate the max times
calculateMaxTimes <- function(preprocess.mat, compounds){
  Nsim = ncol(preprocess.mat[[1]])
  maxtime <- data.frame(tmp=numeric(Nsim))
  for (kc in seq(1, length(compounds)) ){
    name = paste("PV__", compounds[kc], sep="")
    time = as.numeric(rownames(data))
    data <- preprocess.mat[[name]]
    maxtime[[name]] <- numeric(Nsim)    
    # find the max values for all simulations
    for (k in seq(1, Nsim)){
      maxtime[[name]][k] = time[ which.max(data[,k]) ]
    }
  }
  maxtime$tmp <- NULL
  maxtime
}

# Create the boxplots with the mean curves
createFullPlot <- function () {
  if (create_plot_files){
    png(filename=paste(ma.settings$dir.results, '/', task, "_Dilution_Curves_Combined.png", sep=""),
        width = 1400, height = 1400, units = "px", bg = "white",  res = 150)
  }
  par(mfrow=c(2,1))
  boxplot(maxtime, col=ccolors, horizontal=T,  ylim=c(0,20),
          xaxt="n", # suppress the default x axis
          yaxt="n", # suppress the default y axis
          frame="f" # suppress the plotting frame
  )
  # Plot curves
  plot(numeric(0), numeric(0), 
       xlim=c(0,20), ylim=c(0,20),
       # xlim=c(0,40), ylim=c(1E-3,20), log="y",
       # frame="f", # suppress the plotting frame
       xlab="time [s]", ylab="10^3 x outflow fraction/ml")
  
  f_scale=40
  for (kc in seq(1, length(compounds)) ){
    name = paste("PV__", compounds[kc], sep="")
    data <- preprocess.mat[[name]] + 1E-06
    
    # plot the mean and std for time courses
    rmean <- rowMeans(data)
    rstd <- rowSds(data)
    lines(time, rmean*f_scale, col=ccolors[kc], lwd=4)
    # lines(time, rmean2, col=ccolors[kc], lwd=4, lty=2)
    # lines(time, (rmean+rstd)*f_scale, col=ccolors[kc], lwd=1, lty=2)
    # lines(time, (rmean-rstd)*f_scale, col=ccolors[kc], lwd=1, lty=2)
  }
  
  ## Add the experimental data from Goresky1983 & 1973 ##
  plotDilutionData(gor1983, compounds=expcompounds, ccolors=expcolors, correctTime=TRUE)
  plotDilutionData(gor1973[gor1973$condition=="A",], compounds=expcompounds, ccolors=expcolors, correctTime=TRUE)
  plotDilutionData(gor1973[gor1973$condition=="B",], compounds=expcompounds, ccolors=expcolors, correctTime=TRUE)
  plotDilutionData(gor1973[gor1973$condition=="C",], compounds=expcompounds, ccolors=expcolors, correctTime=TRUE)
  legend("topright",  legend = expcompounds, fill=expcolors)
  par(mfrow=c(1,1))
  if (create_plot_files){
    dev.off()
  }
}

createBoxPlot <- function () {
  # Boxplot of the maxtimes
  if (create_plot_files){
    png(filename=paste(ma.settings$dir.results, '/', task, "_Boxplot_MaxTimes", sep=""),
        width = 1000, height = 1000, units = "px", bg = "white",  res = 150)
  }
  boxplot(maxtime-10, col=ccolors, horizontal=T, xlab="time [s]")
  if (create_plot_files){
    dev.off()
  }
}

# create the plots
create_plot_files = TRUE
compounds = c('rbcM', 'alb', 'suc', 'h2oM')
ccolors = c('red', 'darkgreen', 'darkorange', 'darkblue')

expcompounds = c('RBC', 'albumin', 'sucrose', 'water')
expcolors = c('red', 'darkgreen', 'darkorange', 'darkblue')
gor1973 <- read.csv(file.path(ma.settings$dir.expdata, "dilution_indicator", "Goresky1973_Fig1.csv"), sep="\t")
summary(gor1973)
# Units: time [s], compound: 1000*outflow fraction/ml
gor1983 <- read.csv(file.path(ma.settings$dir.expdata, "dilution_indicator", "Goresky1983_Fig1.csv"), sep="\t")
summary(gor1983)

for (kt in seq(Ntask)){
  task <- tasks[kt]
  peak <- peaks[kt]
  modelId <- paste('MultipleIndicator_', peak, '_', version, '_Nc20_Nf1', sep='')
  parsfile <- file.path(ma.settings$dir.results, sname, 
                        paste(task, '_', modelId, '_parameters.csv', sep=""))
  # Load the data
  load(file=outfileFromParsFile(parsfile))
  # Calculate the max times
  maxtime <- calculateMaxTimes(preprocess.mat, compounds) 
  print(summary(maxtime))
  createFullPlot()
  createBoxPlot()
}