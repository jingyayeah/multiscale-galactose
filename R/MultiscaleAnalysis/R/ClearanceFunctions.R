
#' Calculate the clearance parameters and data.frame.
#' @param folder preprocessed folder for analysis
#' @return data.frame with clearance parameters
#' @export
createClearanceDataFrame <- function(folder, t_peak=2000, t_end=10000){
  # loads the x list for the folder
  
  # steady state values for the ids
  mlist <- createApproximationMatrix(ids=ids, simIds=simIds, points=c(t_end), reverse=FALSE)
  
  # half maximal time, i.e. time to reach half steady state value
  t_half <- rep(NA, length(simIds))
  names(t_half) <- simIds
  Nsim <- length(simIds)
  # interpolate the half maximal time
  for(ks in seq(Nsim)){
    # fit the point
    points <- c( 0.5*mlist$PV__gal[[ks]] )
    data.interp <- approx(x$PV__gal[[ks]][, 2], x$PV__gal[[ks]][, 1], xout=points, method="linear")
    t_half[ks] <- data.interp[[2]] - t_peak
  }
  
  # Clearance parameters for the system #
  #-------------------------------------
  # F = flow_sin              # [µm/sec]
  # c_in = 'PP__gal'[end]     # [mmol/L]
  # c_out = 'PV_gal[end]'          # [mmol/L]
  # R = F*(c_in - c_out)      # [m/sec * mmol/l]
  # ER = (c_in - c_out)/c_in  # [-]
  # CL = R/c_in               # [µm/sec]
  # GE = (c_in - c_out) 
  
  c_in <- as.vector(mlist$PP__gal)   # [mmol/L]
  c_out <- as.vector(mlist$PV__gal)  # [mmol/L]
  FL <- pi*(pars$y_sin^2) * pars$flow_sin  # [µm^3/sec]
  
  parscl <- pars
  parscl$t_half <- as.vector(t_half)
  parscl$FL <- FL
  parscl$c_in <- c_in
  parscl$c_out <- c_out
  
  parscl$R <- FL * (c_in - c_out)
  parscl$ER <- (c_in - c_out)/c_in
  parscl$CL <- FL * (c_in - c_out)/c_in
  parscl$GE <- (c_in - c_out)
  
  # reduce to the values with > 0 PP__gal (NAN)
  parscl <- parscl[parscl$c_in>0.0, ]
  return(parscl)
}