################################################################
## Evaluation of MultipleIndicator Dilution Curves ##
################################################################
# preprocessing of the data has to be done before.
# see MultipleIndicatorPreprocessing.R
#
# TODO 
#
# author: Matthias Koenig
# date: 2014-04-20
################################################################
rm(list=ls())
library('MultiscaleAnalysis')
library('matrixStats')
setwd(ma.settings$dir.results)

# Plot all the single curves with mean and std
# They have to be weighted with the actual probability assicociated with the samples.
plotMultipleIndicatorCurves <- function(time, weights, ccols, create_plot_files=F){
  Nc <- length(pv_compounds)
  
  # Create the plot
  if (create_plot_files == TRUE){
    png(filename=paste(ma.settings$dir.results, '/', task, "_Dilution_Curves.png", sep=""),
        width = 4000, height = 1000, units = "px", bg = "white",  res = 200)
  }
  
  par(mfrow=c(1,Nc))
  for (name in pv_compounds){
    plotCompound(time, MI.mat[[name]], name, col=ccolors[name], xlim=c(0,20), ylim=c(0,2.5), weights, ccols)
  }
  
  par(mfrow=c(1,1))
  if (create_plot_files == TRUE){
    dev.off()
  }
}



# Get colors for probability weights
library(RColorBrewer)
col2rgb_alpha <- function(col, alpha){
  rgb <- rgb(col2rgb(col)[[1]]/256,col2rgb(col)[[2]]/256,col2rgb(col)[[3]]/256, alpha)
}

display.brewer.all(n=NULL, type="all", select=NULL, exact.n=TRUE)
ccol = 'gray'
Nsim = nrow(pars)
Ncol = 7
colpal <- brewer.pal(Ncol+2, 'Greys')
ccols = rep(colpal[1], Nsim)
maxValue = max(pars$p_sample) 
bw = maxValue/Ncol
for (k in seq(Ncol)){
 ind <- which( (pars$p_sample>((k-1)*bw)) & (pars$p_sample <= (k*bw)))
 ccols[ind] = colpal[k+2]
 ccols[ind] = col2rgb_alpha(colpal[k+2], 0.7) 
}
plot(pars$p_sample, col=ccols, pch=15)
summary(ccols)
tail(ccols)


plotMultipleIndicatorCurves(time, pars$p_sample, ccols=ccols, create_plot_files=T)




## Combined Dilution Curves in one plot ##
plotMultipleIndicatorMean <- function(time, create_plot_files=F){
  Nc <- length(pv_compounds)
  
  if (create_plot_files == TRUE){
    png(filename=paste(ma.settings$dir.results, '/', task, "_Dilution_Curves_Combined.png", sep=""),
        width = 1000, height = 1000, units = "px", bg = "white")
  }
  par(mfrow=c(1,1))
  plot(numeric(0), numeric(0), 'l', 
       xlab="time [s]", ylab="c [mM]", xlim=c(0,30), ylim=c(0,1.5))
  for (kc in seq(1, length(compounds)) ){
    for (name in pv_compounds){
      plotCompoundMean(time, MI.mat[[name]], col=ccolors[name])
    }
  }
  par(mfrow=c(1,1))
  dev.off()
}

# calculate the maximum values
maxTimes <- function(data){
  Nsim = ncol(data)
  maxtime <- data.frame(tmp=numeric(Nsim))
  for (kc in seq(1, length(compounds)) ){
    name = paste("PV__", compounds[kc], sep="")
    print(name)
    maxtime[[name]] <- numeric(Nsim)    
    # find the max values for all simulations
    for (k in seq(1, Nsim)){
      maxtime[[name]][k] = time[ which.max(dilmat[[name]][,k]) ]
    }
  }
}


####################################################################
library(RColorBrewer)
# display.brewer.all(n=NULL, type="all", select=NULL, exact.n=TRUE)
compounds = c('gal', 'rbcM', 'alb', 'suc', 'h2oM')
ccolors = c('black', 'red', 'darkgreen', 'darkorange', 'darkblue')
pv_compounds = paste('PV__', compounds, sep='')
names(ccolors) <- pv_compounds

## Load the preprocessed data ##
sname <- '2014-05-04_MultipleIndicator'
version <- 'v14'
ma.settings$dir.simdata <- file.path(ma.settings$dir.results, sname, 'data')
tasks <- paste('T', seq(16,20), sep='')
peaks <- c('P00', 'P01', 'P02', 'P03', 'P04')

# for (kt in seq(length(tasks))){
for (kt in seq(1)){
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
  
  # Get the time for the plot
  time = getTimeFromMIMAT(MI.mat) -10.0
  
  # Create the plots
  # Here the unweighted simulation results are obtained
  plotMultipleIndicatorCurves(time=time, weights=pars$p_sample, create_plot_files=FALSE)
  
  # createMeanPlot(time, create_plot_files=TRUE)
  
  
}

###########################################################################
# Calculate weighted derived values
###########################################################################
# Calculate weighted values based on the probabilities for sample
# Weighted mean, variance and standard deviation calculations
name='Q_sinunit'
wmean <- wt.mean(x, pars$p_sample)
wvar <- wt.var(x, pars$p_sample)
wsd <- wt.sd(x, pars$p_sample)
wsd

# Generate plots
plot.width = 800 
plot.height = 800
plot.units= "px"
plot.bg = "white"
plot.res = 150
for (name in ps.var){
  fname = paste('test_distribution_', name, '.png', sep="") 
  print(fname)
  png(filename=fname, width=plot.width, height=plot.height, units=plot.units, bg=plot.bg, res=plot.res)
  plotWeighted(pars, p.gen, name)
  dev.off()
}




####################################################################

name="PV__rbcM"
time <- readTimeForSimulation(ma.settings$dir.simdata, rownames(pars)[1])-10.0
Nc <- length(pv_compounds)
plotCompound(time, MI.mat[[name]], name, col=ccolors[name], ylim=c(0,0.8))

boxplot(MI.mat[[name]][1:40, 1:100])
plot2Ddensity(time, MI.mat[[name]][,], name, col=ccolors[name], ylim=c(0,0.8))


plotCompoundScatter(time, MI.mat[[name]][,], name, col=ccolors[name], ylim=c(0,0.8))
plot2Ddensity(time, MI.mat[[name]][,], name, col=ccolors[name], ylim=c(0,0.8))


###################################################################################
# Dilution curves with experimental data
###################################################################################
library('matrixStats')
library('MultiscaleAnalysis')

# Load the experimental data
gor1973 <- read.csv(file.path(ma.settings$dir.expdata, "dilution_indicator", "Goresky1973_Fig1.csv"), sep="\t")
summary(gor1973)
# Units: time [s], compound: 1000*outflow fraction/ml
gor1983 <- read.csv(file.path(ma.settings$dir.expdata, "dilution_indicator", "Goresky1983_Fig1.csv"), sep="\t")
summary(gor1983)


# Load the preprocessed simulations data
sname <- '2014-04-20_MultipleIndicator'
version <- 'v11'
ma.settings$dir.simdata <- file.path(ma.settings$dir.results, sname, 'data')
tasks <- paste('T', seq(6,10), sep='')
peaks <- c('P00', 'P01', 'P02', 'P03', 'P04')

for (kt in seq(length(tasks))){
  task <- tasks[kt]
  peak <- peaks[kt]
  modelId <- paste('MultipleIndicator_', peak, '_', version, '_Nc20_Nf1', sep='')
  parsfile <- file.path(ma.settings$dir.results, sname, 
                        paste(task, '_', modelId, '_parameters.csv', sep=""))
  # Load the data
  load(file=outfileFromParsFile(parsfile))
  summary(pars)
  
  # Create the plots
  createExpPlot(create_plot_files=TRUE)
  
}

## Combined Dilution Curves in one plot ##
time <- readTimeForSimulation(ma.settings$dir.simdata, rownames(pars)[1]) -10.0
compounds = c('gal', 'rbcM', 'alb', 'suc', 'h2oM')
ccolors = c('black', 'red', 'darkgreen', 'darkorange', 'darkblue' )
compounds = c( 'rbcM', 'alb', 'suc', 'h2oM')
ccolors = c('red', 'darkgreen', 'darkorange', 'darkblue' )

# Maxtime boxplots
# calculate the maximum values
maxtime <- data.frame(tmp=numeric(nrow(pars)))

for (kc in seq(1, length(compounds)) ){  
  name = pv_compounds[kc]
  print(name)
  maxtime[[name]] <- numeric(nrow(pars))    
  # find the max values for all simulations
  for (k in seq(1, nrow(pars))){
    maxtime[[name]][k] = time[ which.max(dilmat[[name]][,k]) ]
  }
}


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