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

# Galactose challenge, with galactosemias
folder <- '2014-07-30_T25'

folders <- paste('2014-08-13_T', seq(33,49), sep='')
for (folder in folders){
  source(file=file.path(ma.settings$dir.code, 'analysis', 'Preprocess.R'), 
       echo=TRUE, local=FALSE)
}
stop('finished preprocessing')
###########################################################################
# Plot large set of single timecourses directly from x
# The large-scale plot is only possible on the dimension reduced data sets.
# Select id and plot levels.

# which ids splitted under which levels
f.level = "gal_challenge"  # "PP__gal" 
plot.ids = c('PP__gal', 'PV__gal')
plot.colors = c( rgb(0.5,0.5,0.5, alpha=0.3), rgb(0.5,0.5,1.0, alpha=0.3) )
names(plot.colors) <- plot.ids

# set the minimal and maximal time for plotting
xlimits <- c(1995, 2200)
ylimits <- c(0.0, 6.0)

# create subplot for all the different levels
plot.levels <- levels(as.factor(pars[[f.level]]))
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

## Approximation matrix for full analysis ##
# approximation time vector for dilution
t.approx = seq(from=995, to=1050, by=0.2)

# approximation time vector for gal_challange
t.approx = seq(from=1995, to=2200, by=5)
mlist <- createApproximationMatrix(ids=ids, simIds=simIds, points=t.approx)

###############################################################
# now calculate things on the matrix 
# i.e. mean, std, 

# Calculate the volume flow for weigthing
pars$F <- pi*(pars$y_sin^2) * pars$flow_sin
plot(pars$flow_sin, pars$F)
plot(pars$y_sin, pars$F)

#####
# levels
f.level = "gal_challenge"  # "PP__gal" 
f.level <- "PP__gal" 
## Calculate the matrix
library('matrixStats')
compounds = c('gal', 'galM', 'rbcM', 'alb', 'suc', 'h2oM')
ccolors = c('gray', 'black', 'red', 'darkgreen', 'darkorange', 'darkblue')

stats <- list('vector', length(t.approx))
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

#########

## plot the mean timecourses ##


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
      w <- pars$F[sim_rows] # weighting with the volume flow F
      
      row.means <- rowMeans(tmp)
      row.wmeans <- rowWeightedMeans(tmp, w=w)
      row.medians <- rowMedians(tmp)
      row.wmedians <- rowWeightedMedians(tmp, w=w)
      row.sds <- rowSds(tmp)
      
      time = as.numeric(rownames(tmp))
      points(time, row.wmeans, col=col, lwd=2, type='l', lty=1)
      #points(time, row.wmeans+row.sds, col='Orange', lwd=2, type='l', lty=1)
      #points(time, row.wmedians, col=col, lwd=2, type='l', lty=2)
    
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
# Dilution
time.min=995

par(mfrow=c(2,1))
plot(numeric(0), numeric(0), log='y', xlim=c(time.min, 1025), ylim=c(1E-2,0.5))
plotMeanCurves(mlist, f.level, compounds, ccolors)
plot(numeric(0), numeric(0), xlim=c(time.min, 1025), ylim=c(0,0.3))
plotMeanCurves(mlist, f.level, compounds, ccolors)
par(mfrow=c(1,1))

# Gal challenge
plot(numeric(0), numeric(0), xlim=c(min(t.approx), max(t.approx)), ylim=c(0,7))
plotMeanCurves(mlist, f.level, compounds=compounds, ccolors=ccolors)



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


