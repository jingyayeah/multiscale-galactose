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
compounds = c( 'rbcM', 'alb', 'suc', 'h2oM')
ccolors = c('red', 'darkgreen', 'darkorange', 'darkblue' )

# Load the experimental data
gor1973 <- read.csv(file.path(ma.settings$dir.expdata, "dilution_indicator", "Goresky1973_Fig1.csv"), sep="\t")
summary(gor1973)
# Units: time [s], compound: 1000*outflow fraction/ml
gor1983 <- read.csv(file.path(ma.settings$dir.expdata, "dilution_indicator", "Goresky1983_Fig1.csv"), sep="\t")
summary(gor1983)

## Combined Dilution Curves in one plot ##
compounds = c('gal', 'rbcM', 'alb', 'suc', 'h2oM')
ccolors = c('black', 'red', 'darkgreen', 'darkorange', 'darkblue' )

# calculate the maximum values
maxTimes <- function(preprocess.mat){
  Nsim = ncol(preprocess.mat[[1]])
  print(Nsim)
  maxtime <- data.frame(tmp=numeric(Nsim))
  for (kc in seq(1, length(compounds)) ){
    name = paste("PV__", compounds[kc], sep="")
    print(name)
    maxtime[[name]] <- numeric(Nsim)    
    # find the max values for all simulations
    for (k in seq(1, Nsim)){
      maxtime[[name]][k] = time[ which.max(preprocess.mat[[name]][,k]) ]
    }
  }
  maxtime
}
maxtime <- maxTimes(preprocess.mat) 

png(filename=paste(ma.settings$dir.results, '/', task, "_Dilution_Curves_Combined.png", sep=""),
    width = 1400, height = 1400, units = "px", bg = "white",  res = 150)
# dev.off()
# par(mfrow=c(2,1), omi=c(0.5,0.3,0,0), plt=c(0.1,0.9,0,0.7))
par(mfrow=c(2,1))
#png(filename=paste(info.folder, '/', task, "_Boxplot_MaxTimes", sep=""),
#     width = 1000, height = 1000, units = "px", bg = "white",  res = 150)

boxplot(maxtime, col=ccolors, horizontal=T,  ylim=c(0,20),
        xaxt="n", # suppress the default x axis
        yaxt="n", # suppress the default y axis
        frame="f" # suppress the plotting frame
        )
summary(maxtime)

# Plot curves
plot(numeric(0), numeric(0), 
     xlim=c(0,20), ylim=c(0,16), 
     # frame="f", # suppress the plotting frame
     box="false",
     xlab="time [s]", ylab="10^3 x outflow fraction/ml")

for (kc in seq(1, length(compounds)) ){
  f_scale=70
  
  # name = "PV__rbcM"
  name = paste("PV__", compounds[kc], sep="")
  # plot one compound
  tmp <- dilmat[[name]]
  
  # plot the mean and std for time courses
  rmean <- rowMeans(tmp)
  rstd <- rowSds(tmp)
  lines(time, rmean*f_scale, col=ccolors[kc], lwd=4)
  #lines(time, (rmean+rstd)*f_scale, col=ccolors[kc], lwd=1, lty=2)
  #lines(time, (rmean-rstd)*f_scale, col=ccolors[kc], lwd=1, lty=2)
}

#          red,  green, orange, blue,  black, gray
# expcompounds = c('RBC', 'albumin', 'Na', 'sucrose', 'water', 'galactose')
# expcolors = c('red', 'darkgreen', 'gray', 'darkorange', 'darkblue', 'black')
expcompounds = c('RBC', 'albumin', 'sucrose', 'water')
expcolors = c('red', 'darkgreen', 'darkorange', 'darkblue')

## Goresky1983 & 1973 ##
plotDilutionData(gor1983, compounds=expcompounds, ccolors=expcolors, correctTime=TRUE)
plotDilutionData(gor1973[gor1973$condition=="A",], compounds=expcompounds, ccolors=expcolors, correctTime=TRUE)
plotDilutionData(gor1973[gor1973$condition=="B",], compounds=expcompounds, ccolors=expcolors, correctTime=TRUE)
plotDilutionData(gor1973[gor1973$condition=="C",], compounds=expcompounds, ccolors=expcolors, correctTime=TRUE)
legend("topright",  legend = expcompounds, fill=expcolors)
par(mfrow=c(1,1))
dev.off()

# Boxplot of the maxtimes
png(filename=paste(info.folder, '/', task, "_Boxplot_MaxTimes", sep=""),
    width = 1000, height = 1000, units = "px", bg = "white",  res = 150)
boxplot(maxtime-10, col=ccolors, horizontal=T, xlab="time [s]")
dev.off()
summary(maxtime-10)