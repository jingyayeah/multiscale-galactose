#' Calculate the stdlog for log-normal distribution from given mean and std.
#' @param m mean
#' @param std standard deviation
#' @return stdlog for corresponding log-normal distribution
#' @export
stdlog <- function(m, std){
  stdlog <- sqrt(log(1 + std^2/m^2))
}

#' Calculate the meanlog for log-normal distribution from given mean and std.
#' @param m mean
#' @param std standard deviation
#' @return meanlog for corresponding log-normal distribution
#' @export
meanlog <- function(m, std){
  meanlog <- log(m^2/sqrt(std^2+m^2))
}

#' Weighted mean
#' x and wt have to be of same length
#' wt.mean <- sum(wt*x)/sum(wt)
#' @param x data 
#' @param wt weights
#' @export
wt.mean <- function(x, wt){
  weighted.mean(x, wt)
}

#' Weighted unbiased variance, i.e. (N-1)
#' x and wt have to be of same length
#' @param x data 
#' @param wt weights
#' @export
wt.var <- function(x, wt){
  y <- as.matrix(x)
  c <- cov.wt(y, wt)
  c$cov[1,1]
}

#' Weighted unbiased standard deviation
#' x and wt have to be of same length
#' @param x data 
#' @param wt weights
#' @export
wt.sd <- function(x, wt){
  var <- wt.var(x, wt)
  sqrt(var)
}

#' Calculates probability for sample based ECDFs.
#' 
#' Uses the given ECDF to get the associated probabilities for the data points.
#' 
#' @param x data to calculate probabilities for
#' @param f.ecdf underlying empirical cumulative distribution function
#' @return list with fields p (probabilites) and mpoints (used midpoints) 
#' @export
getProbabilitiesForData <- function(x, f.ecdf, lb=0, ub=10*max(x)){
  res <- list()
  
  # use the order to sort and unsort
  ord <- order(x)
  x.sorted <- x[ord] #same as sort(d) 
  
  # calculate midpoints
  Nsim = nrow(pars)
  midpoints <- 0.5*(x.sorted[1:(Nsim-1)] + x.sorted[2:Nsim])
  
  # Add the boundary points (high upper value which should collect the
  # remaining probability for the last data point)
  if (lb > min(x)){
    lb = min(x)
    warning('problems with lower bound')
  }
  if (ub < max(x)){
    ub = max(x)
    warning('problems with upper bound')
  }
  res$midpoints <- c(lb, midpoints, ub)
  
  # Calculate the cumulative probability associated with every sample
  c_sample <- f.ecdf(res$midpoints)
  # get the probability associated with the interval
  p.sorted = c_sample[2:(Nsim+1)] - c_sample[1:Nsim]
  
  # do the unsorting with the order
  #do stuff, then revert
  res$p <- p.sorted[order(ord)]
  print(sum(res$p))

  res
}

#' Plot the weighted parameter values with underlying distribution.
#' @param pars parameter structure
#' @param p.gen distribution generator functions
#' @param name name of parameter 
#' @export
plotWeighted <- function (pars, p.gen, name) {
  data = pars[[name]]
  wt = pars$p_sample
  
  # calculate the weighted values
  wmean <- wt.mean(data, wt)
  wvar <- wt.var(data, wt)
  wsd <- wt.sd(data, wt)
  
  # figure
  cols = c('gray', 'black', 'red', 'blue')
  lwd = rep(2,4)
  type = rep('l',4)
  cutoff = 0.9; 
  lb = (1-cutoff) * min(data)
  ub = (1+cutoff) * max(data)
  Npoints = 1000
  
  # histogramm of samples
  hist(data, freq=FALSE, breaks=20, xlim=c(lb, ub), 
       main=paste(name, ' [', p.gen[name, 'unit'], ']', sep=""), 
       col=cols[1])
  
  x <- seq(from=lb, to=ub, length.out=Npoints)
  # Here also log normal distributions have to be used, so 
  # transformation of mean and std has to be applied
  # y <- dnorm(x, mean=mean, sd=sd)
  # calculated distribution based on samples
  mean <- mean(data)
  sd <- sd(data)
  meanlog = meanlog(mean, sd)
  sdlog   = stdlog(mean, sd)
  y <- dlnorm(x, meanlog=meanlog, sdlog=sdlog)
  points(x, y, col=cols[2], type=type[2], lwd=lwd[2])
  
  # calculated distribution based on weighted samples with probabilies
  #y <- dnorm(x, mean=wmean, sd=wsd)
  wmeanlog = meanlog(wmean, wsd)
  wsdlog   = stdlog(wmean, wsd)
  y <- dlnorm(x, meanlog=wmeanlog, sdlog=wsdlog)
  points(x, y, col=cols[3], type=type[3], lwd=lwd[3])
  
  # real distribution if existing
  if (!is.na(p.gen[name, 'meanlog'])){
    scale_fac = p.gen[name, 'scale_fac']
  
    xr <- seq(from=lb, to=ub*scale_fac, length.out=Npoints)
    yr <- dlnorm(xr, meanlog=p.gen[name, 'meanlog'], sdlog=p.gen[name, 'sdlog'], log = FALSE)
    xr <- xr/scale_fac
    yr <- yr*scale_fac
    points(xr, yr, col=cols[4], type=type[4], lwd=lwd[4])
  }
  legend("topright", legend=c("samples", "samples dist", "weighted samples dist", "real dist"),
         col=cols, lwd=lwd, cex=0.9)
}
