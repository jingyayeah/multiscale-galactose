################################################################
## MultipleIndicatorFunctions
################################################################
# Helper functions for Multiple Indicator analysis.
#
# author: Matthias Koenig
# date: 2014-11-17
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

#' Correct the dilutation times, so starting at first
#' 
#' @export 
correctDilutionTimes <- function(data, offset=0){
  # extrapolate between second and first point to zero
  # correct curves, so that the diluation starts at time 0s + offset
  t1 <- data[data$compound == 'RBC',][1,1]
  t2 <- data[data$compound == 'RBC',][2,1]
  y1 <- data[data$compound == 'RBC',][1,2]
  y2 <- data[data$compound == 'RBC',][2,2]
  t0 <- t2 - y2*(t2-t1)/(y2-y1) # coorection time
  cat('t0 = ', t0, '\n')
  dnew <- data
  dnew$time <- dnew$time - t0 + offset
  
  return(dnew)
}
