################################################################
# Multiple Indicator Dilution Curve analysis
################################################################
# Plot of the individual simulations of the distributed 
# model of sinusoidal units and calculation of the integrated
# multiple indicator response curves.
#
# author: Matthias Koenig
# date: 2015-02-20
################################################################
rm(list=ls())
library('MultiscaleAnalysis')
library('libSBML')
setwd(ma.settings$dir.base)
dir_out <- file.path(ma.settings$dir.base, 'results', 'dilution')

folder <- '2015-02-13_T42'         # Multiple indicator data
t_peak <- 5000; t_end <- 10000    # [s] peak start time & total simulation time

# Focus on interesting time for analysis
time = seq(from=t_peak-5, to=t_peak+50, by=0.05)   # approximation time for plot

info <- process_folder_info(folder)
info
p <- preprocess_task(folder=folder, force=FALSE) 
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

f_flow = 0.5    
time.rel <- time-t_peak
weights <- pars$Q_sinunit   # weighting with volume flow

create_plots = TRUE
for (gal in gal_levels){
  fname <- file.path(dir_out, sprintf('MultipleIndicator_Individual_%s_gal%s.png', info$task, gal))
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
                       col=rgb(0.5,0.5,0.5, alpha=0.1))
    plot_compound_mean(time=time.rel, data=as.matrix(dlist[[name]][, inds]), weights=pars$Q_sinunit[inds], 
                       col=ccolors[name])
  }
  par(mfrow=c(1,1))
  stopDevPlot(create_plots=create_plots)
}


###################################################################################
# Dilution curves with experimental data
###################################################################################
# plot mean dilution curves
subset = split_sims[[which(split_info$f_flow==f_flow)]]
scale = 1.0

par(mfrow=c(2,1))
time.range <- c(0, 30)
# normal plot
plot(numeric(0), numeric(0), xlim=time.range, ylim=c(0,0.4*scale), type='n',
     main='Dilution Curves', xlab="Time [s]", ylab="Concentration [ml]")
plot_mean_curves(dlist, pars, subset, f.level, compounds, ccolors, scale=scale, std=FALSE)

# log plot
plot(numeric(0), numeric(0), log='y', xlim=time.range, ylim=c(1E-3,0.4*scale),
     main='Log Dilution Curves', xlab="Time [s]", ylab="Concentration [ml]")
plot_mean_curves(dlist, pars, subset, f.level, compounds, ccolors, scale=scale)

legend("topright",  legend=compounds, fill=ccolors) 
par(mfrow=c(1,1))

####################################################
# Load experimental data
d <- read.csv(file.path(ma.settings$dir.base, "results", "dilution", "Goresky_processed.csv"), sep="\t")
expcompounds = c('galactose', 'RBC', 'albumin', 'sucrose', 'water')
expcolors = c('black', 'red', 'darkgreen', 'darkorange', 'darkblue')

#-----------------------------
# Plot all components
#-----------------------------
do_plot = TRUE
if (do_plot){
  fname <- file.path(dir_out, 'MultipleIndicator_Mean.png')
  cat(fname, '\n')
  png(filename=fname, width=1800, height=1000, units = "px", bg = "white",  res = 150)
}

par(mfrow=c(1,2))
plot(numeric(0), numeric(0), type='n',
     xlim=c(0,30), ylim=c(0,16), 
     xlab="time [s]", ylab="10^3 x outflow fraction/ml", font.lab=2)
plotDilutionData(d[d$study=="gor1983",], expcompounds, expcolors)
plotDilutionData(d[d$study=="gor1973" & d$condition=="A",], expcompounds, expcolors)
plotDilutionData(d[d$study=="gor1973" & d$condition=="B",], expcompounds, expcolors)
plotDilutionData(d[d$study=="gor1973" & d$condition=="C",], expcompounds, expcolors)

# plot simulation
max.rbc = max(d$outflow) # maximum of experimental rbc curves
max.rbc
scale = 4.1*max.rbc
time_shift = 1.7
subset = split_sims[[which(split_info$f_flow==0.5)]]
plot_mean_curves(dlist, pars, subset, f.level, compounds, ccolors, scale=scale, time_shift=time_shift, std=FALSE, max_vals=FALSE)

Nc=length(expcompounds)
legend("topright",  
       legend=expcompounds,
       pch=rep(22, Nc),
       col=expcolors,
       pt.bg=add.alpha(expcolors, 0.7),
       lty=rep(2, Nc),
       cex=0.8, bty='n') 

#-----------------------------
# Plot galactose
#-----------------------------
igal = 1
plot(numeric(0), numeric(0), type='n',
     xlim=c(0,30), ylim=c(0,3), 
     xlab="time [s]", ylab="10^3 x outflow fraction/ml", font.lab=2)
plotDilutionData(d[d$study=="gor1983",], expcompounds[igal], expcolors[igal])
plotDilutionData(d[d$study=="gor1973" & d$condition=="A",], expcompounds[igal], expcolors[igal])
plotDilutionData(d[d$study=="gor1973" & d$condition=="B",], expcompounds[igal], expcolors[igal])
plotDilutionData(d[d$study=="gor1973" & d$condition=="C",], expcompounds[igal], expcolors[igal])

# plot simulation
plot_mean_curves(dlist, pars, subset, f.level, compounds[2], ccolors[2], 
                 scale=scale, time_shift=time_shift, std=FALSE, max_vals=FALSE)
text(x=rep(0.7, 3), y=c(1.3, 2.5, 2.9), labels=c('0.28mM', '12.5mM', '17.5mM'), cex=0.8, font.lab=2)
par(mfrow=c(1,1))
if (do_plot){
  dev.off()
}

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