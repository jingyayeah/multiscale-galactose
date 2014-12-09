################################################################
# Preprocess Multiple Indicator Dilution (MID) data
################################################################
# Read the timecourse data and creates reduced data structures
# for simplified query and visualization.
# MID is calculated under varying galactose challenges.
# Necessary to reproduce the peak structure as well as the different 
# galactose curves.
#
# TODO: not all simulations reached steady state when the peak is 
# given -> start the peak later ~ 5000 s
# TODO: add the experimental data with the curves
# TODO: adaptation of galactose parameters to describe the curves (transport relative to metabolism)
# TODO: plot the single curves
#
# author: Matthias Koenig
# date: 2014-12-09
################################################################
rm(list=ls())
library('MultiscaleAnalysis')
setwd(ma.settings$dir.base)

# Set folder and peak times for analysis
folder <- '2014-12-08_T7'   # Multiple indicator data
# folder.mean <- '2014-12-08_T8'   # Multiple indicator data mean
t_peak <- 1000              # [s] MID peak start
t_end <- 5000               # [s] simulation time

# Process the integration time curves
info <- process_folder_info(folder)
p <- preprocess_task(folder=folder, force=FALSE) 
pars <- p$pars
names(p)

# Species in the dilution curves
compounds = c('gal', 'galM', 'rbcM', 'alb', 'suc', 'h2oM')
ccolors = c('gray', 'black', 'red', 'darkgreen', 'darkorange', 'darkblue')
ids <- c( paste(rep('PP__', length(compounds)), compounds, sep=''), 
          paste(rep('PV__', length(compounds)), compounds, sep=''))
ccolors <- c(ccolors, ccolors)
names(ccolors) <- ids
ccolors

# Variation in background galactose levels
f.level = "PP__gal" 
gal_levels <- levels(as.factor(pars[[f.level]]))

# Approximation matrix
simIds <- rownames(pars)
time = seq(from=t_peak-5, to=t_peak+50, by=0.02)
dlist <- createApproximationMatrix(p$x, ids=ids, simIds=simIds, points=time, reverse=FALSE)


###########################################################################
# Plot individual timecourses
###########################################################################
# This is the dimension-reduced data-set.
# split the dataset under the given galactose challenge
plot.ids = c('PP__gal', 'PV__gal') # plot the pp and pv galactose (background galactose)
plot.colors = c( rgb(0.5,0.5,0.5, alpha=0.3), rgb(0,0,1.0, alpha=0.3) )
names(plot.colors) <- plot.ids

# create subplot for the different background levels of galactose
xlimits <- c(t_peak-5, t_peak+200)
ylimits <- c(0.0, 1.2*max(as.numeric(gal_levels)))
nrow = ceiling(sqrt(length(gal_levels)))
par(mfrow=c(nrow, nrow))
for (gal in gal_levels){
  # empty plot
  plot(numeric(0), numeric(0), xlim=xlimits, ylim=ylimits, 
       main=paste(f.level, '=', gal), xlab='time [s]', ylab='concentration [mM]')
  
  # find the simulation rows for the level &
  # plot all the single simulations for the level
  gal_rows <- which(pars[[f.level]]==gal)
  for (k in gal_rows){
    for (id in plot.ids){
      points(p$x[[id]][[k]]$time, p$x[[id]][[k]][[2]], 
             type='l', col=plot.colors[[id]])      
    }
  }
}
par(mfrow=c(1,1))

###########################################################################
# Calculate mean time curves and sds 
###########################################################################
plotMeanCurves <- function(dlist, f.level, compounds, ccolors){
  for (kc in seq(length(compounds))){
    compound <- compounds[kc]
    col <- ccolors[kc]
    id <- paste('PV__', compound, sep='')
    
    # different levels
    # plot.levels <- levels(as.factor(pars[[f.level]]))
    plot.levels = c("0.28", "12.5", "17.5")
    for (p.level in plot.levels){
      sim_rows <- which(pars[[f.level]]==p.level)
      tmp <- dlist[[id]][ ,sim_rows]
      w <- pars$Q_sinunit[sim_rows] # weighting with the volume flow F
      
      row.means <- rowMeans(tmp)
      row.wmeans <- rowWeightedMeans(tmp, w=w)
      row.medians <- rowMedians(tmp)
      row.wmedians <- rowWeightedMedians(tmp, w=w)
      row.sds <- rowSds(tmp)
      
      time = as.numeric(rownames(tmp))
      points(time, row.wmeans, col=col, lwd=2, type='l', lty=1)
      #points(time, row.wmeans+row.sds, col='Orange', lwd=2, type='l', lty=1)
      #points(time, row.wmedians, col=col, lwd=2, type='l', lty=2)
    
      points(time, row.means, col=col, lwd=0.5, type='l', lty=2)
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


# TODO: how is the concentration of the the dilute related to the dilution fraction
# -> calculate via the total amount of tracer injected
# Add legend

par(mfrow=c(2,1))
time.range <- c(t_peak-5, t_peak+25)
# normal plot
plot(numeric(0), numeric(0), log='y', xlim=time.range, ylim=c(1E-2,0.5),
     main='Log Dilution Curves', xlab="Time [s]", ylab="Concentration [ml]")
plotMeanCurves(dlist, f.level, compounds, ccolors)
# log plot
plot(numeric(0), numeric(0), xlim=time.range, ylim=c(0,0.3),
     main='Dilution Curves', xlab="Time [s]", ylab="Concentration [ml]")
plotMeanCurves(dlist, f.level, compounds, ccolors)
par(mfrow=c(1,1))

###########################################################################
# Mean curves with experimental data
###########################################################################


# compounds = c('rbcM', 'alb', 'suc', 'h2oM')
# ccolors = c('red', 'darkgreen', 'darkorange', 'darkblue')
pv_compounds = paste('PV__', compounds, sep='')
names(ccolors) <- pv_compounds

# some example plots of single time curves
name <- "PV__alb"
test <- dlist[[name]]
names(test)

time.rel <- time-t_peak
plot_single_compound(time.rel, dlist[[name]], name, col=ccolors[name], ylim=c(0,2.1))


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
calculateMaxTimes <- function(preprocess.mat, compounds, time.offset){
  Nsim = ncol(preprocess.mat[[1]])
  maxtime <- data.frame(tmp=numeric(Nsim))
  for (kc in seq(1, length(compounds)) ){
    name = paste("PV__", compounds[kc], sep="")
    print(name)
    data <- preprocess.mat[[name]]
    time = as.numeric(rownames(data))
    maxtime[[name]] <- numeric(Nsim)    
    # find the max values for all simulations
    for (k in seq(1, Nsim)){
      maxtime[[name]][k] = time[ which.max(data[,k]) ]- time.offset
    }
  }
  maxtime$tmp <- NULL
  maxtime
}

tmp <- calculateMaxTimes(preprocess.mat, compounds, 10.0)
head(tmp)
summary(tmp)

# Create the boxplots with the mean curves
createFullPlot <- function (maxtime, ccolors, time.offset, scale_f) {
  if (create_plot_files){
    png(filename=paste(ma.settings$dir.results, '/', task, "_MultipleIndicator_with_experimental_data.png", sep=""),
        width = 1400, height = 1400, units = "px", bg = "white",  res = 150)
  }
  par(mfrow=c(2,1))
  boxplot(maxtime, col=ccolors, horizontal=T,  ylim=c(0,20),
          xaxt="n", # suppress the default x axis
          yaxt="n", # suppress the default y axis
          bty="n") # suppress the plotting frame
  
  # Plot curves
  plot(numeric(0), numeric(0), xlim=c(0,20), ylim=c(0,20),
       xlab="time [s]", ylab="10^3 x outflow fraction/ml")
  
  # plot the mean and std for time courses
  for (kc in seq(1, length(compounds)) ){
    name = paste("PV__", compounds[kc], sep="")
    data <- preprocess.mat[[name]]  #+1E-06 fix for logscale
    time <- as.numeric(rownames(data))-time.offset
    
    # plot the mean and std for time courses
    rmean <- rowMeans(data)
    rstd <- rowSds(data)
    lines(time, rmean*scale_f, col=ccolors[kc], lwd=4)
    lines(time, (rmean+rstd)*scale_f, col=ccolors[kc], lwd=1, lty=2)
    lines(time, (rmean-rstd)*scale_f, col=ccolors[kc], lwd=1, lty=2)
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

createBoxPlot <- function (maxtime, ccolors, time.offset) {
  # Boxplot of the maxtimes
  if (create_plot_files){
    png(filename=paste(ma.settings$dir.results, '/', task, "_Boxplot_MaxTimes", sep=""),
        width = 1000, height = 1000, units = "px", bg = "white",  res = 150)
  }
  boxplot(maxtime-time.offset, col=ccolors, horizontal=T, xlab="time [s]")
  if (create_plot_files){
    dev.off()
  }
}

# create the plots
create_plot_files = TRUE
compounds = c('rbcM', 'alb', 'suc', 'h2oM')
ccolors = c('red', 'darkgreen', 'darkorange', 'darkblue')
time.offset = 10.0  # peak start of input

expcompounds = c('RBC', 'albumin', 'sucrose', 'water')
expcolors = c('red', 'darkgreen', 'darkorange', 'darkblue')
gor1973 <- read.csv(file.path(ma.settings$dir.expdata, "dilution_indicator", "Goresky1973_Fig1.csv"), sep="\t")
summary(gor1973)
# Units: time [s], compound: 1000*outflow fraction/ml
gor1983 <- read.csv(file.path(ma.settings$dir.expdata, "dilution_indicator", "Goresky1983_Fig1.csv"), sep="\t")
summary(gor1983)

m1 = max(gor1983$outflow)
m2 = max(gor1973[gor1973$condition=="A",'outflow'])
m3 = max(gor1973[gor1973$condition=="B",'outflow'])
m4 = max(gor1973[gor1973$condition=="C",'outflow'])
scale_f = (m1+m2+m3+m4)/4;
data <-   #+1E-06 fix for logscale
  
  rmean_rbc <- rowMeans(preprocess.mat[['PV__rbcM']])
scale_f <- scale_f/max(rmean_rbc);
scale_f

for (kt in seq(Ntask)){
  task <- tasks[kt]
  peak <- peaks[kt]
  modelId <- paste('MultipleIndicator_', peak, '_', version, '_Nc20_Nf1', sep='')
  parsfile <- file.path(ma.settings$dir.results, sname, 
                        paste(task, '_', modelId, '_parameters.csv', sep=""))
  # Load the data
  load(file=outfileFromParsFile(parsfile))
  # Calculate the max times
  maxtime <- calculateMaxTimes(preprocess.mat, compounds, time.offset) 
  print(summary(maxtime))
  createFullPlot(maxtime, ccolors, time.offset=time.offset, scale_f)
  # createBoxPlot(maxtime, ccolors, time.offset=time.offset)
}


















############################################################
# Plot single simulation
############################################################
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
    time <- p$x[[id]][[simId]]$time
    tmp.data <- p$x[[id]][[simId]][[2]]
    points(time, tmp.data, type='l', col=col)
    tmp.tmax <- time[which.max(tmp.data)]
    abline(v=tmp.tmax, col=col)
  }
}
