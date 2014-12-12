################################################################
## Distribution functions 
################################################################
#
# author: Matthias Koenig
# date: 2014-12-12
################################################################
#' Calculate the stdlog for log-normal distribution from given mean and std.
#' 
#' @param m mean
#' @param std standard deviation
#' @return stdlog for corresponding log-normal distribution
#' @export
stdlog <- function(m, std){
  stdlog <- sqrt(log(1 + std^2/m^2))
}

#' Calculate the meanlog for log-normal distribution from given mean and std.
#' 
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

#' Generates the standard parameters for meanlog and stdlog based on mean and std.
#' 
#' The parameters are the reported mean and standard deviations from experiments.
#' These data is used if no histograms are available to fit the distributions.
#' TODO: Store the information in file and read
#' @export
generateLogStandardParameters <- function(){
  
  name = c('L', 'y_sin', 'y_dis', 'y_cell', 'flow_sin')
  mean = c(500E-6, 4.4E-6, 1.2E-6, 7.58E-6, 270E-6)
  std  = c(125E-6, 0.45E-6, 0.4E-6, 1.25E-6, 58E-6)
  unit = c('m', 'm' ,'m', 'm', 'm/s')
  scale_fac = c(1E6, 1E6, 1E6, 1E6, 1E6)
  scale_unit = c('µm', 'µm' ,'µm', 'µm', 'µm/s')
  
  # meanlog and meanstd are for the scaled variables, i.e. in scale_units
  meanlog = meanlog(mean*scale_fac, std*scale_fac)
  sdlog   = stdlog(mean*scale_fac, std*scale_fac)
  
  meanlog_error = rep(NA, length(meanlog))
  sdlog_error = rep(NA, length(sdlog))
  
  p.gen <- data.frame(name, mean, std, unit, meanlog, meanlog_error, sdlog, sdlog_error, scale_fac, scale_unit)
  rownames(p.gen) <- name
  p.gen$name <- as.character(p.gen$name)
  
  p.gen
}

#' Generates a possible data vector from given histogramm.
#' Necessary for fitting distributions to histogramm data.
#' Count data points are generated in the middle of every bin.
#' @param dset histogram dataset
#' @return data frame with x as data
#' @export
createDataFromHistogramm <- function(dset) {
  data <- data.frame(x=numeric(0))
  for (kr in seq(1, nrow(dset)) ){
    for (kc in seq(1, ncol(dset)) ){
      count = dset[kr, kc]
      value = as.numeric( colnames(dset)[kc])
      tmp <- data.frame(x=rep(value, count))
      data <- rbind(data, tmp)
    }
  }
  data
}

#' Calculatesbreakpoints for histogram data with equidistant midpoints.
#' @param midpoints vector of midpoints of bins
#' @return vector of breakpoints
#' @export
getBreakPointsFromMidpoints <- function(midpoints){
  breaklength = (midpoints[2]-midpoints[1])
  breaks = seq(from=midpoints[1]-0.5*breaklength, 
               to=midpoints[length(midpoints)]+0.5*breaklength, 
               length.out=length(midpoints)+1)
}

#' Plot the histogramm of the data with the fit.
#' @param p.gen information about the parameters
#' @param data data underlying the histogram
#' @param fit lognormal fit estimates from fitdistr
#' @export
plotHistWithFit <- function(p.gen, name, data, midpoints, fit, histc=rgb(1.0, 0.0, 0.0, 0.25)){  
  # plot the fit distribution
  plotLogNormalDistribution(p.gen, name, 2*max(data$x))
  
  # plot the histogram
  h <- hist(data$x, breaks=getBreakPointsFromMidpoints(midpoints), plot=FALSE)
  plot(h, col=histc, freq=FALSE, add=T)
}

#' Plot the log normal density distribution.
#' @param p.gen information about the parameters
#' @param name of the parameter
#' @param maxvalue for calculation of distribution
#' @export
plotLogNormalDistribution <- function(p.gen, name, maxvalue, N=1000, lcolor='blue'){
  x <- seq(from=1E-12, to=maxvalue, length.out=N)
  y <- dlnorm(x, 
              meanlog=p.gen[name, 'meanlog'], 
              sdlog=p.gen[name, 'sdlog'], 
              log = FALSE)
  points(x,y, lty=1, type="l", lwd=3)
  
  # plot the mean and std lines
  mean <- p.gen[name, "mean"]
  std <- p.gen[name, "std"]
  fac <- p.gen[name, "scale_fac"]
  abline(v=mean*fac, lty=1, col=lcolor, lwd=2)
  abline(v=(mean+std)*fac, lty=2, col=lcolor, lwd=1)
  abline(v=(mean-std)*fac, lty=2, col=lcolor, lwd=1)
}

#' Get the axis label.
#' @param p.gen information about the parameters
#' @param name of the parameter
#' @return axis label
#' @export
xlabByName <-function(p.gen, name){
  label <- paste(name, ' [', p.gen[name, 'scale_unit'], ']', sep="")
}

#' Get the axis label.
#' @param p.gen information about the parameters
#' @param name of the parameter
#' @return axis label
#' @export
ylabByName <-function(p.gen, name){
  label <- paste('density', ' [1/(', p.gen[name, 'scale_unit'], ')]', sep="")
}

#' Writes the fit parameter to the global parameter object.
#' @param name name of the parameter
#' @param fit fit results
#' @export
storeFitData <- function(p.gen, fit, name){
  p.gen[name, 'meanlog'] = fit$estimate['meanlog']
  p.gen[name, 'sdlog'] = fit$estimate['sdlog']
  p.gen[name, 'meanlog_error'] = fit$sd['meanlog']
  p.gen[name, 'sdlog_error'] = fit$sd['sdlog']
  p.gen;
}

# #' Calculates probability for sample based ECDFs.
# #' 
# #' Uses the given ECDF to get the associated probabilities for the data points.
# #' 
# #' @param x data to calculate probabilities for
# #' @param f.ecdf underlying empirical cumulative distribution function
# #' @return list with fields p (probabilites) and mpoints (used midpoints) 
# #' @export
# getProbabilitiesForData <- function(x, f.ecdf, lb=0, ub=10*max(x)){
#   res <- list()
#   
#   # use the order to sort and unsort
#   ord <- order(x)
#   x.sorted <- x[ord] #same as sort(d) 
#   
#   # calculate midpoints
#   Nsim = nrow(pars)
#   midpoints <- 0.5*(x.sorted[1:(Nsim-1)] + x.sorted[2:Nsim])
#   
#   # Add the boundary points (high upper value which should collect the
#   # remaining probability for the last data point)
#   if (lb > min(x)){
#     lb = min(x)
#     warning('problems with lower bound')
#   }
#   if (ub < max(x)){
#     ub = max(x)
#     warning('problems with upper bound')
#   }
#   res$midpoints <- c(lb, midpoints, ub)
#   
#   # Calculate the cumulative probability associated with every sample
#   c_sample <- f.ecdf(res$midpoints)
#   # get the probability associated with the interval
#   p.sorted = c_sample[2:(Nsim+1)] - c_sample[1:Nsim]
#   
#   # do the unsorting with the order
#   #do stuff, then revert
#   res$p <- p.sorted[order(ord)]
#   print(sum(res$p))
# 
#   res
# }
# 
# #' Plot the weighted parameter values with underlying distribution.
# #' @param pars parameter structure
# #' @param p.gen distribution generator functions
# #' @param name name of parameter 
# #' @export
# plotWeighted <- function (pars, p.gen, name) {
#   data = pars[[name]]
#   wt = pars$p_sample
#   
#   # calculate the weighted values
#   wmean <- wt.mean(data, wt)
#   wvar <- wt.var(data, wt)
#   wsd <- wt.sd(data, wt)
#   
#   # figure
#   cols = c('gray', 'black', 'red', 'blue')
#   lwd = rep(2,4)
#   type = rep('l',4)
#   cutoff = 0.9; 
#   lb = (1-cutoff) * min(data)
#   ub = (1+cutoff) * max(data)
#   Npoints = 1000
#   
#   # histogramm of samples
#   hist(data, freq=FALSE, breaks=20, xlim=c(lb, ub), 
#        main=paste(name, ' [', p.gen[name, 'unit'], ']', sep=""), 
#        col=cols[1])
#   
#   x <- seq(from=lb, to=ub, length.out=Npoints)
#   # Here also log normal distributions have to be used, so 
#   # transformation of mean and std has to be applied
#   # y <- dnorm(x, mean=mean, sd=sd)
#   # calculated distribution based on samples
#   mean <- mean(data)
#   sd <- sd(data)
#   meanlog = meanlog(mean, sd)
#   sdlog   = stdlog(mean, sd)
#   y <- dlnorm(x, meanlog=meanlog, sdlog=sdlog)
#   points(x, y, col=cols[2], type=type[2], lwd=lwd[2])
#   
#   # calculated distribution based on weighted samples with probabilies
#   #y <- dnorm(x, mean=wmean, sd=wsd)
#   wmeanlog = meanlog(wmean, wsd)
#   wsdlog   = stdlog(wmean, wsd)
#   y <- dlnorm(x, meanlog=wmeanlog, sdlog=wsdlog)
#   points(x, y, col=cols[3], type=type[3], lwd=lwd[3])
#   
#   # real distribution if existing
#   if (!is.na(p.gen[name, 'meanlog'])){
#     scale_fac = p.gen[name, 'scale_fac']
#   
#     xr <- seq(from=lb, to=ub*scale_fac, length.out=Npoints)
#     yr <- dlnorm(xr, meanlog=p.gen[name, 'meanlog'], sdlog=p.gen[name, 'sdlog'], log = FALSE)
#     xr <- xr/scale_fac
#     yr <- yr*scale_fac
#     points(xr, yr, col=cols[4], type=type[4], lwd=lwd[4])
#   }
#   legend("topright", legend=c("samples", "samples dist", "weighted samples dist", "real dist"),
#          col=cols, lwd=lwd, cex=0.9)
# }
