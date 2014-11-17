################################################################
# Preprocess Multiple Indicator Dilution (MID) data
################################################################
# Read the timecourse data and creates reduced data structures
# for simplified query and visualization.
# MID is calculated under varying galactose challenges.
# 
# Necessary to reproduce the peak structure as well as the different 
# galactose curves.
#
# author: Matthias Koenig
# date: 2014-11-17
################################################################
rm(list=ls())
library(data.table)
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)

t_peak <- 1000              # [s] MID peak start
t_end <- 5000               # [s] simulation time
folder <- '2014-11-17_T3'   # Multiple indicator data

source(file=file.path(ma.settings$dir.code, 'analysis', 'Preprocess.R'), 
       echo=TRUE, local=FALSE)

# parameters are already extended with SBML information
head(pars)

###########################################################################
# Plot individual timecourses
###########################################################################
# This is the dimension-reduced data-set.

# split the dataset under the given galactose challenge
f.level = "PP__gal"      
gal_levels <- levels(as.factor(pars[[f.level]]))
print(gal_levels)

plot.ids = c('PP__gal', 'PV__gal')
plot.colors = c( rgb(0.5,0.5,0.5, alpha=0.3), rgb(0,0,1.0, alpha=0.3) )
names(plot.colors) <- plot.ids

# set limits based on peak location
xlimits <- c(t_peak-5, t_peak+200)
ylimits <- c(0.0, max(as.numeric(gal_levels)))

# create subplot for all the different levels
head(pars)
nrow = ceiling(sqrt(length(plot.levels)))
par(mfrow=c(nrow, nrow))
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

###########################################################################
# Calculate mean time curves and sds 
###########################################################################
library('matrixStats')

plotMeanCurves <- function(mlist, f.level, compounds, ccolors){
  for (kc in seq(length(compounds))){
    compound <- compounds[kc]
    col <- ccolors[kc]
    id <- paste('PV__', compound, sep='')
    
    # different levels
    plot.levels <- levels(as.factor(pars[[f.level]]))
    for (p.level in plot.levels){
      sim_rows <- which(pars[[f.level]]==p.level)
      tmp <- mlist[[id]][ ,sim_rows]
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

# Dilution curves
t.approx = seq(from=t_peak-5, to=t_peak+50, by=0.2)
time <- t.approx
simIds <- rownames(pars)
mlist <- createApproximationMatrix(ids=ids, simIds=simIds, points=t.approx, reverse=FALSE)

compounds = c('gal', 'galM', 'rbcM', 'alb', 'suc', 'h2oM')
ccolors = c('gray', 'black', 'red', 'darkgreen', 'darkorange', 'darkblue')
f.level <- "PP__gal" 

time.min=995
par(mfrow=c(2,1))
plot(numeric(0), numeric(0), log='y', xlim=c(time.min, 1025), ylim=c(1E-2,0.5))
plotMeanCurves(mlist, f.level, compounds, ccolors)
plot(numeric(0), numeric(0), xlim=c(time.min, 1025), ylim=c(0,0.3))
plotMeanCurves(mlist, f.level, compounds, ccolors)
par(mfrow=c(1,1))

# TODO: add experimental data (Goresky) to plot


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
    time <- x[[id]][[simId]]$time
    tmp.data <- x[[id]][[simId]][[2]]
    points(time, tmp.data, type='l', col=col)
    tmp.tmax <- time[which.max(tmp.data)]
    abline(v=tmp.tmax, col=col)
  }
}

hist(pars$flow_sin, breaks = 40)
