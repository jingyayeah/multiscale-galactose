
#' Plot single multiple-dilution indicator dataset.
#' 
#' @param data dataset to be plotted
#' @param correctTime set TRUE if the time should be corrected
#' @export 
plotDilutionData <- function(data, compounds=compounds, ccolors=ccolors, correctTime=FALSE){
  Nc = length(compounds)
  for (kc in seq(Nc)){
    compound <- compounds[kc]
    ccolor <- ccolors[kc]
    # check for data for compound
    cdata = data[data$compound==compound,]
    if (correctTime == TRUE){
      cdata <- correctDilutionTimes(cdata)
    }
    
    if (nrow(cdata)>0){
      points(cdata$time, cdata$outflow, col=ccolor)
      lines(cdata$time, cdata$outflow, col=ccolor, lty=2, lwd=2)
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

#' Corrects the dilution times, so that zero timepoint is first datapoint.
#' 
#' @param data data to be corrected
#' @return new data with corrected times
#' @export
correctDilutionTimes <- function(data){
  dnew <- data;
  # TODO: properly extrapolate to zero
  dnew$time <- dnew$time - min(data$time) + 1.0
  dnew
}