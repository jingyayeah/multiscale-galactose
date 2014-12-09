################################################################
## MultipleIndicatorFunctions
################################################################
# Helper functions for Multiple Indicator Dilution analysis.
#
# author: Matthias Koenig
# date: 2014-12-06
################################################################

#' Plot single multiple-dilution indicator dataset.
#' 
#' @param data dataset to be plotted
#' @param correctTime set TRUE if the time should be corrected
#' @export 
plotDilutionData <- function(data, compounds, ccolors, correctTime=FALSE){
  if (correctTime){
    data <- correctDilutionTimes(data)
  }
  Nc = length(compounds)
  for (kc in seq(Nc)){
    compound <- compounds[kc]
    ccolor <- ccolors[kc]
    # check for data for compound
    cdata = data[data$compound==compound,]
    if (nrow(cdata)>0){
      points(cdata$time, cdata$outflow, col=ccolor)
      lines(cdata$time, cdata$outflow, col=ccolor, lty=2, lwd=2)
      legend("topright",  legend=compounds, fill=ccolors) 
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
plot_compound_curves <- function(time, data, name, weights){
  # single curves
  Nsim = ncol(data)
  for (k in seq(Nsim)){
    lines(time, data[, k],col=rgb(0.5,0.5,0.5, alpha=0.1))
  }
}

#' Plot the mean data.
#' 
#' Plots the mean and standard deviation for time courses. Uses weighted calculation
#' if the weights are provided.
#' @export
plot_compound_mean <- function(time, data, weights, col){
  if (is.null(weights)){
    rMeans <- rowMeans(data)
    rSds <- rowSds(data)
  }else{
    Nt = length(time)
    rMeans = numeric(Nt)
    rSds = numeric(Nt)
    for (k in seq(Nt)){
      rMeans[k] = wt.mean(data[k, ], weights) 
      rSds[k] = wt.sd(data[k, ], weights)
    }
  }
  rMeansUp <- rMeans+rSds
  rMeansDown <- rMeans-rSds
  lines(time, rMeans, col=col, lwd=2)
  lines(time, rMeansUp, col=col, lwd=2, lty=2)
  # rMeansDown[rMeansDown<0] = 0;
  # lines(time, rMeansDown, col=col, lwd=2, lty=2)
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
