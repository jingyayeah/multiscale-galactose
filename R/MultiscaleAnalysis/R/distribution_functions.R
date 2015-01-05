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
#' Parameters are fitted in SI units.
#' @export
generateLogStandardParameters <- function(p.exp){
  name = p.exp$name
  mean = p.exp$mean
  std  = p.exp$std
  unit = p.exp$unit
  scale_fac = p.exp$scale_fac
  scale_unit = p.exp$scale_unit
    
  # meanlog and meanstd are for unscaled SI parameters
  meanlog = meanlog(mean, std)
  sdlog   = stdlog(mean, std)
  
  meanlog_error = rep(NA, length(meanlog))
  sdlog_error = rep(NA, length(sdlog))
  
  p.gen <- data.frame(name, mean, std, unit, meanlog, meanlog_error, sdlog, sdlog_error, scale_fac, scale_unit)
  rownames(p.gen) <- name
  p.gen$name <- as.character(p.gen$name)
  
  return (p.gen)
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

#' Plot the histogramm of the data used for fitting the distributions.
#' @export
plotFitHistogram <- function(p.gen, name, data, midpoints, col=rgb(1.0, 0.0, 0.0, 0.25)){  
  
  # plot the scaled histogram
  h <- hist(data$x, breaks=getBreakPointsFromMidpoints(midpoints), plot=FALSE)
  plot(h, col=col, freq=FALSE, add=T)
}

#' Plot parameter histogramm of the sinusoidal unit samples.
#' @export
plotParsHistogram <- function(p.gen, name){
  if (exists('pars')){
    # add the parameter hist
    hpars <- hist(pars[, name]/p.gen[name, 'scale_fac'],
                  plot=FALSE, breaks=20)
    plot(hpars, col=histcp, freq=FALSE, add=T)
  }
}


#' Plot the log normal density distribution.
#' @param p.gen information about the parameters
#' @param name of the parameter
#' @param max.value for calculation of distribution
#' @export
plotLogNormalDistribution <- function(p.gen, name, max.value, N=1000, lcolor='blue'){
  mean <- p.gen[name, "mean"]
  std <- p.gen[name, "std"]
  scale <- p.gen[name, "scale_fac"]
  
  # Calculate the SI distribution
  x <- seq(from=1E-12, to=max.value, length.out=N)
  y <- dlnorm(x, 
              meanlog=p.gen[name, 'meanlog'], 
              sdlog=p.gen[name, 'sdlog'], 
              log = FALSE)
  # Scale to desired values (area under curve constant)
  x <- x/scale
  y <- y*scale
  points(x,y, lty=1, type="l", lwd=3)
  
  # plot the mean and std lines
  abline(v=mean/scale, lty=1, col=lcolor, lwd=2)
  abline(v=(mean+std)/scale, lty=2, col=lcolor, lwd=1)
  abline(v=(mean-std)/scale, lty=2, col=lcolor, lwd=1)
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