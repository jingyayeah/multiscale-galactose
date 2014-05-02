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
  c$cov
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

#' Calculates the probability associated with the sample based on the
#' underlying distribution.
#' 
#' In which units is it coming out (transformed units)
#' ! Important to keep track of the units !
#' TODO: do the fit for unscaled data in basis units
#' TODO: generalize to arbitrary distributions of parameters
#' @param pars parameter structure
#' @param p.gen distribution generator functions
#' @param name name of parameter 
#' @export
getProbabilitiesForSamples <- function(pars, p.gen, name){
  Nsim = nrow(pars)
  d <- sort(pars[[name]]) 
  
  # get the mean points
  mpoints <- 0.5*(d[1:(Nsim-1)] + d[2:Nsim])
  # Add the boundary points
  mpoints <- c(0, mpoints, 10*max(mpoints))
  
  # Calculate the cumulative probability associated with every sample
  # Scaling so that the values fit to the parameter distributions
  c_sample <- plnorm(mpoints*p.gen[name, 'scale_fac'], 
                     meanlog=p.gen[name, 'meanlog'], sdlog=p.gen[name, 'sdlog'], 
                     log = FALSE)
  
  cat('# c_sample #\n')
  cat(c_sample, '\n')
  
  # TODO: make the calculations via the ecdf than general input data can be used.
  cat('# ec_sample #\n')
  d_sample <- dlnorm(mpoints*p.gen[name, 'scale_fac'], 
                     meanlog=p.gen[name, 'meanlog'], sdlog=p.gen[name, 'sdlog'], 
                     log = FALSE)
  f.ecdf <- ecdf(d_sample)
  ec_sample <- f.ecdf(mpoints*p.gen[name, 'scale_fac'])
  cat(ec_sample, '\n')
  
  print(summary(c_sample))
  print(summary(ec_sample))
  
  # get the probability associated with the interval
  p_sample = c_sample[2:(Nsim+1)] - c_sample[1:Nsim]
  
  print(sum(p_sample))
  p_sample
}

#' Plot the weighted parameter values with underlying distribution.
#' @param pars parameter structure
#' @param p.gen distribution generator functions
#' @param name name of parameter 
#' @export
plotWeighted <- function (pars, p.gen, name) {
  data = pars[[name]]
  wt = pars$p_sample
  # TODO: carful
  # wt = pars[[paste('p_', name, sep="")]]
  wmean <- wt.mean(data, wt)
  wvar <- wt.var(data, wt)
  wsd <- wt.sd(data, wt)
  
  # figure
  cols = c('gray', 'black', 'red', 'blue')
  lwd = rep(2,4)
  type = rep('l',4)
  cutoff = 0.9; lb = (1-cutoff)*min(data); ub = (1+cutoff)*max(data)
  Np = 1000;
  
  # histogramm of samples
  hist(data, freq=FALSE, breaks=20, xlim=c(lb, ub), 
       main=paste(name, ' [', p.gen[name, 'unit'], ']', sep=""), 
       col=cols[1])
  
  x <- seq(from=lb, to=ub, length.out=Np)
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
  
  # real distribution
  scale_fac = p.gen[name, 'scale_fac'] 
  xr <- seq(from=lb, to=ub*scale_fac, length.out=Np)
  yr <- dlnorm(xr, meanlog=p.gen[name, 'meanlog'], sdlog=p.gen[name, 'sdlog'], log = FALSE)
  xr <- xr/scale_fac
  yr <- yr*scale_fac
  points(xr, yr, col=cols[4], type=type[4], lwd=lwd[4])
  
  legend("topright", legend=c("samples", "samples dist", "weighted samples dist", "real dist"),
         col=cols, lwd=lwd, cex=0.4)
}


