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
