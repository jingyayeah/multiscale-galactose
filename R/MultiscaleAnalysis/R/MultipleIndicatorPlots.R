#' Plot the single curves
#' @export
plotCompound <- function(time, data, name, col="black", ylim=c(0.0, 0.2), xlim=c(0, 30), weights=NULL, ccols=NULL, meanData=TRUE){
  plot(numeric(0), numeric(0), 'l', main=name,
       xlab="time [s]", ylab="c [mM]", ylim=ylim, xlim=xlim)
  
  Nsim = ncol(data)
  if (is.null(weights) || is.null(ccols)){
    ccols = rep('gray', Nsim)
  }
  
  if (is.null(weights)){
    ord <- seq(1, ncol(data)) 
  }else{
    ord = order(weights)
  }
  
  for (ks in seq(Nsim)){
    lines(time, data[,ord[ks]], col=ccols[ord[ks]])
  }
  
  if (meanData){
    plotCompoundMean(time, data, weights, col)
  }
}

#' Plot the mean data.
#' 
#' Plots the mean and variance for time courses. Uses weighted calculation
#' if the weights are provided.

#' @export
plotCompoundMean <- function(time, data, weights, col){
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
  # rMeansDown[rMeansDown<0] = 0;
  lines(time, rMeans, col=col, lwd=2)
  lines(time, rMeansUp, col=col, lwd=2, lty=2)
  lines(time, rMeansDown, col=col, lwd=2, lty=2)
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

#' Make a 2D Kernel estimation.
#' @export
plot2Ddensity <- function(time, data, name, col="black", ylim=c(0.0, 0.2), xlim=c(0, 30)){
  library('KernSmooth')
  # prepare data
  Nsim <- ncol(data)
  tmax_ind <- length(which(time<100))
  Nt <- length(time[1:tmax_ind])
  x <- matrix(NA, nrow=Nsim*Nt, ncol=2)
  for (ks in seq(Nsim)){
    indices <- ((ks-1)*Nt+1):(ks*Nt)  
    tmp <- cbind(time[1:tmax_ind], data[1:tmax_ind, ks])
    x[indices,] <- tmp
  }
  est <- bkde2D(x, bandwidth=c(2, 0.02), gridsize=c(100,200), range.x=list(c(0,100), c(0,0.5)) )
  contour(est$x1, est$x2, est$fhat)
  # plot the mean and variance for time courses
  # TODO how to better calculate -> what error measurment to use
  for (ks in seq(Nsim)){
    points(time,data[,ks], col=rgb(0,100,0,20,maxColorValue=255), pch=16)
    #lines(time, data[,ks], col="gray")
  }
  rmean <- rowMeans(data)
  rstd <- rowSds(data)
  lines(time, rmean, col=col, lwd=2)
  lines(time, rmean+rstd, col=col, lwd=2, lty=2)
  lines(time, rmean-rstd, col=col, lwd=2, lty=2)
}