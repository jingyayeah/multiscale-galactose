################################################################
## MultipleIndicatorFunctions
################################################################
# Helper functions for Multiple Indicator Dilution analysis.
#
# author: Matthias Koenig
# date: 2014-12-06
################################################################

#' Get the maximal values of the dilution data.
#' 
#' @param data experimental dataset
#' @param correctTime should the time be corrected
#' @export 
getDilutionDataMaxima <- function(data, compounds){
  print('getDilutionDataMaxima')
  Nc = length(compounds)
  maxima <- numeric(Nc)
  for (kc in seq(Nc)){
    compound <- compounds[kc]
    cdata = data[data$compound==compound,]
    print(head(cdata))
    maxima(kc) <- max(cdata)
  }
  maxima
}

#' Calculation of time offset for experimental dilution curves
#' based on RBC peak.
#' 
#' Extrapolated time of first appearance of RBC tracer.
#' extrapolate between second and first point to zero
#  correct curves, so that the diluation starts at time 0s + offset
#' @export 
rbc_time_offset <- function(data){
  
  t1 <- data[data$compound == 'RBC',][1,1]
  t2 <- data[data$compound == 'RBC',][2,1]
  y1 <- data[data$compound == 'RBC',][1,2]
  y2 <- data[data$compound == 'RBC',][2,2]
  t0 <- t2 - y2*(t2-t1)/(y2-y1) # correction time via linear interpolation to zero
  return (t0)
}


#' Plot single multiple-dilution indicator dataset.
#' 
#' Complete multiple indicator curves can be shifted via time_shift
#' to integrate multiple datasets.
#' @param data dataset to be plotted
#' @param correctTime set TRUE if the time should be corrected
#' @export 
plotDilutionData <- function(data, compounds, ccolors, time_shift=0){ 
  Nc = length(compounds)
  for (kc in seq(Nc)){
    compound <- compounds[kc]
    ccolor <- ccolors[kc]
    # check for data for compound
    cdata = data[data$compound==compound,]
    if (nrow(cdata)>0){
      
      points(cdata$time+time_shift, cdata$outflow, col=ccolor, pch=22, bg=add.alpha(ccolor, 0.6), cex=1.2)
      lines(cdata$time+time_shift, cdata$outflow, col=ccolor, lty=2, lwd=1)
    }
  }
}

#' Colors for probability weights
#'@export
col2rgb_alpha <- function(col, alpha){
  rgb <- rgb(col2rgb(col)[[1]]/256,col2rgb(col)[[2]]/256,col2rgb(col)[[3]]/256, alpha)
}

#' Colors for weights
#' @export
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


#' Plots individual multiple indicator dilution curves.
#' 
#' Data is a data matrix with simulations in columns and timepoints in rows.
#' Column ids correspond to the simulation identifiers, row ids to the timepoints.
#' @export
plot_compound_curves <- function(time, data, name, weights, col=rgb(0.5,0.5,0.5, alpha=0.1)){
  # single curves
  Nsim = ncol(data)
  for (k in seq(Nsim)){
    lines(time, data[, k],col=col)
  }
}


#' Create dilution plots of mean curves
#' The individual dilution curves are weighted with the volume flow of the
#' respective sinusoidal units.
#' @export
plot_mean_curves <- function(dlist, pars, subset, f.level, compounds, ccolors, scale=1.0, time_shift=0.0, std=TRUE, max_vals=TRUE){
  weights <- pars$Q_sinunit
  
  for (kc in seq(length(compounds))){
    compound <- compounds[kc]
    col <- ccolors[kc]
    id <- paste('PV__', compound, sep='')
    
    if (id == 'PV__gal'){
      next
    }
    
    # different levels
    plot.levels <- levels(as.factor(pars[[f.level]]))
    for (p.level in plot.levels){
      # get subset of data belonging to galactose level and the subset
      sim_rows <- intersect(which(pars[[f.level]]==p.level), which(rownames(pars) %in% subset))
      # cat('Simulation rows:', sim_rows, pars$sim[sim_rows], '\n')
      w <- weights[sim_rows]
      data <- scale * as.matrix(dlist[[id]][ ,sim_rows])
      time = as.numeric(rownames(data))-t_peak + time_shift
      plot_compound_mean(time=time, data=data, weights=w, col=col, std=std, max_vals=max_vals)
    }
  }
}


#' Plot the mean data.
#' 
#' Plots the mean and standard deviation for time courses. Uses weighted calculation
#' if the weights are provided.
#' Other available functions are rowMins, rowMaxs & rowQuantiles.
#' @export
plot_compound_mean <- function(time, data, weights, col, std=TRUE, max_vals=TRUE){
  
#   # unweighted
#   r.means <- rowMeans(data)
#   r.sds <- rowSds(data)
#   
#   # plot mean & mean+sd
#   lines(time, r.means, col=col, lwd=2, lty=2)
#   if (std){
#     lines(time, r.means+r.sds, col=col, lwd=1, lty=2)
#   }
#   # lines for the max values
#   tmax <- time[which.max(r.means)]
#   abline(v=tmax, col=col, lwd=0.5)
  
  if (!is.null(weights)){
    # weighted
    Nt = length(time)
    r.wmeans = numeric(Nt)
    r.wsds = numeric(Nt)
    for (k in seq(Nt)){
      r.wmeans[k] = wt.mean(data[k, ], weights) 
      r.wsds[k] = wt.sd(data[k, ], weights)
    }
    # plot mean & mean+sd
    lines(time, r.wmeans, col=col, lwd=2, lty=1)
    if (std){
      lines(time, r.wmeans+r.wsds, col=col, lwd=1, lty=1)
    }
    
    # lines for the max values
    if (max_vals){
      tmax <- time[which.max(r.wmeans)]
      abline(v=tmax, col=col, lwd=0.5)  
    }
  }
  
}


#' Create scatter plot of the dilution curve data
#' @export
plotCompoundScatter <- function(time, data, name, col="black", ylim=c(0.0, 0.2), xlim=c(0, 30)){
  # plot the single curves
  plot(numeric(0), numeric(0), 'l', main=name,
       xlab="time [s]", ylab="c [mM]", ylim=ylim, xlim=xlim)
  
  Nsim <- ncol(data)
  for (ks in seq(Nsim)){
    points(time,data[,ks], col=rgb(0,100,0,25,maxColorValue=255), pch=16)
    #lines(time, data[,ks], col="gray")
  }
  
  # plot the mean and variance for time courses
  # TODO how to better calculate -> what error measurment to use
  rmean <- rowMeans(data)
  rstd <- rowSds(data)
  lines(time, rmean, col=col, lwd=2)
  lines(time, rmean+rstd, col=col, lwd=2, lty=2)
  lines(time, rmean-rstd, col=col, lwd=2, lty=2)
}

#' Plot all the single curves with mean and std
#' They have to be weighted with the actual probability assicociated with the samples.
#'
#'@export
plotMultipleIndicatorCurves <- function(time, preprocess.mat, weights, ccols, create_plot_files=F){
  Nc <- length(pv_compounds)
  
  # Create the plot
  if (create_plot_files == TRUE){
    png(filename=paste(ma.settings$dir.results, '/', task, "_Dilution_Curves.png", sep=""),
        width = 4000, height = 1000, units = "px", bg = "white",  res = 200)
  }  
  par(mfrow=c(1,Nc))
  xlim=c(0,20)
  ylim=c(0,1.8)
  for (name in pv_compounds){
    inds <- which((time<=xlim[2]))
    data <- preprocess.mat[[name]]
    plotCompound(time[inds], data[inds, ], name, col=ccolors[name], 
                 xlim=xlim, ylim=ylim, weights, ccols)
  }
  par(mfrow=c(1,1))
  if (create_plot_files == TRUE){
    dev.off()
  }
}

#' All MultipleIndicator curves in one plot
#'
#'@export
plotMultipleIndicatorMean <- function(time, preprocess.mat, weights, create_plot_files=F, 
                                      xlim=c(0,20), ylim=c(0,1.5)){
  plot_name <- "_Dilution_Curves_Combined.png"
  if (create_plot_files == TRUE){
    png(filename=paste(ma.settings$dir.results, '/', task, plot_name, sep=""),
        width = 800, height = 800, units = "px", bg = "white")
  }
  par(mfrow=c(1,1))
  # only plot subset of data
  plot(numeric(0), numeric(0), 'l', 
       xlab="time [s]", ylab="c [mM]", xlim=xlim, ylim=ylim)
  for (name in pv_compounds){
    inds <- which((time<=xlim[2]))
    data <- preprocess.mat[[name]]
    plotCompoundMean(time[inds], data[inds, ], weights, col=ccolors[name])
  }
  par(mfrow=c(1,1))
  dev.off()
}
