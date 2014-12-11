################################################################
# Preprocess Multiple Indicator Dilution (MID) data
################################################################
# Read the timecourse data and creates reduced data structures
# for simplified query and visualization.
# MID is calculated under varying galactose challenges.
# Necessary to reproduce the peak structure as well as the different 
# galactose curves.
#
# TODO: add the experimental data with the curves
# TODO: adaptation of galactose parameters to describe the curves (transport relative to metabolism)
# TODO: plot the single curves
#
# author: Matthias Koenig
# date: 2014-12-11
################################################################
rm(list=ls())
library('MultiscaleAnalysis')
setwd(ma.settings$dir.base)

# Set folder and peak times for analysis
folder <- '2014-12-11_T16'   # Multiple indicator data
# folder.mean <- '2014-12-08_T8'   # Multiple indicator data mean
t_peak <- 5000               # [s] MID peak start
t_end <- 10000               # [s] simulation time
time = seq(from=t_peak-5, to=t_peak+50, by=0.2) # approximation time for plot

# Process the integration time curves
info <- process_folder_info(folder)
p <- preprocess_task(folder=folder, force=FALSE) 
pars <- p$pars
sim_ids <- rownames(pars)
names(p)

# Species in the dilution curves
compounds = c('gal', 'galM', 'rbcM', 'alb', 'suc', 'h2oM')
ccolors = c('gray', 'black', 'red', 'darkgreen', 'darkorange', 'darkblue')
ids <- c( paste(rep('PP__', length(compounds)), compounds, sep=''), 
          paste(rep('PV__', length(compounds)), compounds, sep=''))
ccolors <- c(ccolors, ccolors)
names(ccolors) <- ids
ccolors

# Variation of background galactose levels for given tracer
f.level = "PP__gal" 
gal_levels <- levels(as.factor(pars[[f.level]]))
cat('Galactose levels: ', gal_levels, '\n')

################################################################
# Create approximation matrices based on time courses
# Dilution curves were simulated under varying flow conditions.
dlist <- createApproximationMatrix(p$x, ids=ids, simIds=sim_ids, points=time, reverse=FALSE)

# split ids on the factors
factors=c('f_flow', "N_fen", 'scale_f')
get_split_sims <- function(pars){
  paste('Sim', pars$sim, paste="")
}
split_sims <- dlply(pars, factors, get_split_sims)
split_info <- attr(split_sims, "split_labels")
split_info

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
# Plotting subsets of the approximation matrix.
# Creates the main dilution plot of the mean curves.
plot_mean_curves <- function(dlist, pars, subset, f.level, compounds, ccolors){
  weights <- pars$Q_sinunit
  
  for (kc in seq(length(compounds))){
    compound <- compounds[kc]
    col <- ccolors[kc]
    id <- paste('PV__', compound, sep='')
    
    # different levels
    # plot.levels <- levels(as.factor(pars[[f.level]]))
    plot.levels = c("0.28", "12.5", "17.5")
    for (p.level in plot.levels){
      
      # get subset of data
      sim_rows <- which(pars[[f.level]]==p.level)
      
      w <- weights[sim_rows]
      data <- dlist[[id]][ ,sim_rows]
      time = as.numeric(rownames(data))-t_peak
      # plot
      plot_compound_mean(time=time, data=data, weights=w, col=col)
    }
  }
}

# plot mean dilution curves
par(mfrow=c(2,1))
time.range <- c(0, 20)
# normal plot
plot(numeric(0), numeric(0), xlim=time.range, ylim=c(0,0.7), type='n',
     main='Dilution Curves', xlab="Time [s]", ylab="Concentration [ml]")
plot_mean_curves(dlist, pars, subset, f.level, compounds, ccolors)

# log plot
plot(numeric(0), numeric(0), log='y', xlim=time.range, ylim=c(1E-2,0.7),
     main='Log Dilution Curves', xlab="Time [s]", ylab="Concentration [ml]")
plot_mean_curves(dlist, pars, subset, f.level, compounds, ccolors)

legend("topright",  legend=compounds, fill=ccolors) 
par(mfrow=c(1,1))

###########################################################################
# Single curves with mean & SD
###########################################################################
# compounds = c('rbcM', 'alb', 'suc', 'h2oM')
# ccolors = c('red', 'darkgreen', 'darkorange', 'darkblue')
pv_compounds = paste('PV__', compounds, sep='')
names(ccolors) <- pv_compounds

# some example plots of single time curves
name <- "PV__alb"
time.rel <- time-t_peak
weights <- pars$Q_sinunit   # weighting with volume flow

# create empty plot
plot(numeric(0), numeric(0), type='n', 
     main=name, xlab="time [s]", ylab="c [mM]", xlim=c(0, 30), ylim=c(0.0, 0.2))
plot_compound_curves(time=time.rel, data=dlist[[name]], weights=weights)
plot_compound_mean(time=time.rel, data=dlist[[name]], weights=weights, col=ccolors[name])


###################################################################################
# Dilution curves with experimental data
###################################################################################
###########################
# Experimental data
###########################
# TODO: how is the concentration of the the dilute related to the dilution fraction
# -> calculate via the total amount of tracer injected
# Add legend

# Load experimental data
gor1973 <- read.csv(file.path(ma.settings$dir.expdata, "dilution_indicator", "Goresky1973_Fig1.csv"), sep="\t")
summary(gor1973)
gor1983 <- read.csv(file.path(ma.settings$dir.expdata, "dilution_indicator", "Goresky1983_Fig1.csv"), sep="\t")
summary(gor1983)

# necessary to scale to same values
m1 = max(gor1983$outflow)
m2 = max(gor1973[gor1973$condition=="A",'outflow'])
m3 = max(gor1973[gor1973$condition=="B",'outflow'])
m4 = max(gor1973[gor1973$condition=="C",'outflow'])
scale_f = (m1+m2+m3+m4)/4;
scale_f

# plotDilutionData(gor1983, expcompounds, expcolors, correctTime=TRUE)
# plotDilutionData(gor1973[gor1973$condition=="A",], expcompounds, expcolors, correctTime=TRUE)
# plotDilutionData(gor1973[gor1973$condition=="B",], expcompounds, expcolors, correctTime=TRUE)
# plotDilutionData(gor1973[gor1973$condition=="C",], expcompounds, expcolors, correctTime=TRUE)

expcompounds = c('galactose', 'RBC', 'albumin', 'sucrose', 'water')
expcolors = c('black', 'red', 'darkgreen', 'darkorange', 'darkblue')
table(gor1983$compound)
table(gor1973$compound)


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

tmp <- calculateMaxTimes(data, compounds, 10.0)
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
