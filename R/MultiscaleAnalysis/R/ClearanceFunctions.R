
#' Calculate the clearance parameters and data.frame.
#' Necessary to provide the peak and simulation end time for calculation.
#' Here additional values from the simulation curves are added.
#' @param folder preprocessed folder for analysis
#' @return data.frame with clearance parameters
#' @export
createClearanceDataFrame <- function(t_peak=2000, t_end=10000){
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
  # F = Q_sinunit             # [m^3/sec]
  # c_in = 'PP__gal'[end]     # [mmol/L]
  # c_out = 'PV_gal[end]'     # [mmol/L]
  # R = F*(c_in - c_out)      # [m^3/sec * mmol/L] = [mol/sec]
  # ER = (c_in - c_out)/c_in  # [-]
  # CL = R/c_in               # [m^3/sec]
  # DG = (c_in - c_out)       # [mmol/L]
  
  c_in <- as.vector(mlist$PP__gal)   # [mmol/L]
  c_out <- as.vector(mlist$PV__gal)  # [mmol/L]

  
  parscl <- pars
  
  parscl$t_half <- as.vector(t_half)
  parscl$c_in <- c_in
  parscl$c_out <- c_out
  
  parscl$R <- parscl$Q_sinunit * (c_in - c_out)
  parscl$ER <- (c_in - c_out)/c_in
  parscl$CL <- parscl$Q_sinunit * (c_in - c_out)/c_in
  parscl$DG <- (c_in - c_out)
  
  # reduce to the values with > 0 PP__gal (NAN)
  # parscl <- parscl[parscl$c_in>0.0, ]
  return(parscl)
}