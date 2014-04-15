
#' Generates the standard parameters for meanlog and stdlog based on mean and std.
#' @return data.frame of standard parameters
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


#' Calculate the stdlog for log-normal distribution from given mean and std
#' @param m mean
#' @param std standard deviation
#' @return stdlog for corresponding log-normal distribution
#' @export
stdlog <- function(m, std){
  stdlog <- sqrt(log(1 + std^2/m^2))
}

#' Calculate the meanlog for log-normal distribution from given mean and std
#' @param m mean
#' @param std standard deviation
#' @return meanlog for corresponding log-normal distribution
#' @export
meanlog <- function(m, std){
  meanlog <- log(m^2/sqrt(std^2+m^2))
}

#' Generate data vector from histogramm.
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

#' Plot the density distribution.
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
#' @param name of the parameter
#' @param fit fit results
#' @export
storeFitData <- function(p.gen, fit, name){
  p.gen[name, 'meanlog'] = fit$estimate['meanlog']
  p.gen[name, 'sdlog'] = fit$estimate['sdlog']
  p.gen[name, 'meanlog_error'] = fit$sd['meanlog']
  p.gen[name, 'sdlog_error'] = fit$sd['sdlog']
  p.gen;
}
