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