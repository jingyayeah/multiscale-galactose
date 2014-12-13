################################################################
# Multiple Indicator Dilution Curve analysis
################################################################
# Plot of the individual simulations of the distributed 
# model of sinusoidal units and calculation of the integrated
# multiple indicator response curves.
#
# author: Matthias Koenig
# date: 2014-12-13
################################################################
rm(list=ls())
library('MultiscaleAnalysis')
setwd(ma.settings$dir.base)
dir_out <- file.path(ma.settings$dir.base, 'results', 'dilution')

folder <- '2014-12-13_T9'         # Multiple indicator data
t_peak <- 5000; t_end <- 10000    # [s] peak start time & total simulation time

# Focus on interesting time for analysis
time = seq(from=t_peak-5, to=t_peak+50, by=0.05)   # approximation time for plot

info <- process_folder_info(folder)
p <- preprocess_task(folder=folder, force=TRUE) 
pars <- p$pars
sim_ids <- rownames(pars)

# Species in the dilution curves
compounds = c('gal', 'galM', 'rbcM', 'alb', 'suc', 'h2oM')
ccolors = c('gray', 'black', 'red', 'darkgreen', 'darkorange', 'darkblue')
ids <- c( paste(rep('PP__', length(compounds)), compounds, sep=''), 
          paste(rep('PV__', length(compounds)), compounds, sep=''))
ccolors <- c(ccolors, ccolors)
names(ccolors) <- ids

# Variation of background galactose levels for given tracer
# Constant injection was used to reach various steady state levels of galactose.
f.level = "PP__gal" 
gal_levels <- levels(as.factor(pars[[f.level]]))
cat('Galactose levels: ', gal_levels, '\n')

# Create approximation matrices based on time courses
# Dilution curves were simulated under varying flow conditions.
dlist <- createApproximationMatrix(p$x, ids=ids, simIds=sim_ids, points=time, reverse=FALSE)

# split ids on the factors
factors=c('f_flow', "N_fen", 'scale_f')
get_split_sims <- function(pars){
  paste('Sim', pars$sim, sep="")
}
split_sims <- dlply(pars, factors, get_split_sims)
split_info <- attr(split_sims, "split_labels")
split_info

###########################################################################
# Single curves with mean & SD
###########################################################################
# For one condition and compound all the individual timecurves are plotted.
pv_compounds = paste('PV__', compounds, sep='')
plot_compounds = pv_compounds[2:length(pv_compounds)] # don't plot PV__gal

f_flow = 0.4    # correction of flow from liver to tissue
time.rel <- time-t_peak
weights <- pars$Q_sinunit   # weighting with volume flow

create_plots = TRUE
for (gal in gal_levels){
  fname <- file.path(dir_out, sprintf('MultipleIndicator_Individual_gal%s.png', gal))
  startDevPlot(width=2000, height=500, file=fname, create_plots=create_plots)

  # Subset corresponding to flow & galactose background  
  inds = (pars$f_flow == f_flow & pars$PP__gal == gal)
  
  # create figure for every gal challenge
  par(mfrow=c(1,length(plot_compounds)) )
  for (name in plot_compounds){
    plot(numeric(0), numeric(0), type='n', 
      main=name, xlab="time [s]", ylab="c [mM]", 
      xlim=range(time.rel), ylim=c(0.0, 1.0))
    plot_compound_curves(time=time.rel, data=dlist[[name]][, inds], weights=pars$Q_sinunit[inds], 
                       col=rgb(0.5,0.5,0.5, alpha=0.2))
    plot_compound_mean(time=time.rel, data=as.matrix(dlist[[name]][, inds]), weights=pars$Q_sinunit[inds], 
                       col=ccolors[name])
  }
  par(mfrow=c(1,1))
  stopDevPlot(create_plots=create_plots)
}

###########################################################################
# Integrated dilution time curves and sds 
###########################################################################

# Create dilution plots of mean curves
plot_mean_curves <- function(dlist, pars, subset, f.level, compounds, ccolors, scale=1.0, std=TRUE){
  weights <- pars$Q_sinunit
  
  for (kc in seq(length(compounds))){
    compound <- compounds[kc]
    col <- ccolors[kc]
    id <- paste('PV__', compound, sep='')
    
    # different levels
    plot.levels <- levels(as.factor(pars[[f.level]]))
    for (p.level in plot.levels){
      # get subset of data belonging to galactose level and the subset
      sim_rows <- intersect(which(pars[[f.level]]==p.level), which(rownames(pars) %in% subset))
      # cat('Simulation rows:', sim_rows, pars$sim[sim_rows], '\n')
      w <- weights[sim_rows]
      data <- scale * as.matrix(dlist[[id]][ ,sim_rows])
      time = as.numeric(rownames(data))-t_peak
      plot_compound_mean(time=time, data=data, weights=w, col=col, std=std)
    }
  }
}

###################################################################################
# Dilution curves with experimental data
###################################################################################
# TODO: how is the concentration of the the dilute related to the dilution fraction
# -> calculate via the total amount of tracer injected
# Add legend

split_info

# plot mean dilution curves
# subset = rownames(pars)
subset = split_sims[[which(split_info$f_flow==0.3)]]
scale = 1.0

par(mfrow=c(2,1))
time.range <- c(0, 30)
# normal plot
plot(numeric(0), numeric(0), xlim=time.range, ylim=c(0,0.4*scale), type='n',
     main='Dilution Curves', xlab="Time [s]", ylab="Concentration [ml]")
plot_mean_curves(dlist, pars, subset, f.level, compounds, ccolors, scale=scale)

# log plot
plot(numeric(0), numeric(0), log='y', xlim=time.range, ylim=c(1E-3,0.4*scale),
     main='Log Dilution Curves', xlab="Time [s]", ylab="Concentration [ml]")
plot_mean_curves(dlist, pars, subset, f.level, compounds, ccolors, scale=scale)

legend("topright",  legend=compounds, fill=ccolors) 
par(mfrow=c(1,1))

####################################################

# Load experimental data
gor1973 <- read.csv(file.path(ma.settings$dir.expdata, "dilution_indicator", "Goresky1973_Fig1.csv"), sep="\t")
summary(gor1973)
gor1983 <- read.csv(file.path(ma.settings$dir.expdata, "dilution_indicator", "Goresky1983_Fig1.csv"), sep="\t")
summary(gor1983)

expcompounds = c('galactose', 'RBC', 'albumin', 'sucrose', 'water')
expcolors = c('black', 'red', 'darkgreen', 'darkorange', 'darkblue')


# scaling of the outflow curves for comparison
m1 = max(gor1983$outflow)
m2 = max(gor1973[gor1973$condition=="A",'outflow'])
m3 = max(gor1973[gor1973$condition=="B",'outflow'])
m4 = max(gor1973[gor1973$condition=="C",'outflow'])
scale = (m1+m2+m3+m4)/4;
scale = 4.55*scale
offset = 0

time.range <- c(0, 27)
split_sims
split_info
subset = split_sims[[which(split_info$f_flow==0.4)]]
# normal plot
plot(numeric(0), numeric(0), xlim=time.range, ylim=c(0,17), type='n',
     main='Dilution Curves', xlab="Time [s]", ylab="Concentration [ml]")
plot_mean_curves(dlist, pars, subset, f.level, compounds, ccolors, scale=scale, std=FALSE)

plotDilutionData(gor1983, expcompounds, expcolors, correctTime=TRUE, offset=offset)
plotDilutionData(gor1973[gor1973$condition=="A",], expcompounds, expcolors, correctTime=TRUE, offset=offset)
plotDilutionData(gor1973[gor1973$condition=="B",], expcompounds, expcolors, correctTime=TRUE, offset=offset)
plotDilutionData(gor1973[gor1973$condition=="C",], expcompounds, expcolors, correctTime=TRUE, offset=offset)


###########################################################################
# Boxplot of maximum times
###########################################################################

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

boxplot(maxtime, col=ccolors, horizontal=T,  ylim=c(0,20),
        xaxt="n", # suppress the default x axis
        yaxt="n", # suppress the default y axis
        bty="n") # suppress the plotting frame

###########################################################################
# Plot all individual timecourses
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