################################################################
# GE calculation functions
################################################################
# Calculation of elimination and clearance information from 
# steady state timecourses for sinusoidal units.
# curves.
#
# Creation of GE response curves. Prediction of GE via these 
# response curves.
# 
# author: Matthias Koenig
# date: 2014-12-12
################################################################


#' Calculate clearance information for individual sinusoidal units.
#' 
#' Galactose elimination (R), Clearance (CL), extraction ratio (ER) and
#' galactose difference (DG=ci-co) are calculated for all sinusoidal units
#' individually.  
#' For the calculation the timecourse matrix is interpolated to get the 
#' steady state value at exactly t_end. This is necessary due to the variable
#' step sizes of the integration (different step sizes for all solutions).
#' With the steady state concentrations of periportal galactose (PP__gal) and
#' perivenous galactose (PV__gal) the elimination values are calculated.
#' @export
extend_with_galactose_clearance <- function(processed, t_end){
  ids <- processed$ids
  pars <- processed$pars
  x <- processed$x
  simIds = rownames(pars)
  
  # steady state values for the ids
  mlist <- createApproximationMatrix(x, ids=ids, simIds=simIds, points=c(t_end), reverse=FALSE)
    
  # Clearance parameters for the system #
  #-------------------------------------
  # F = Q_sinunit             # [m^3/sec]
  # c_in = 'PP__gal'[end]     # [mmol/L]
  # c_out = 'PV_gal[end]'     # [mmol/L]
  # R = F*(c_in - c_out)      # [m^3/sec * mmol/L] = [mol/sec]
  # CL = R/c_in               # [m^3/sec]
  # ER = (c_in - c_out)/c_in  # [-]
  # DG = (c_in - c_out)       # [mmol/L]
  
  c_in <- as.vector(mlist$PP__gal)   # [mmol/L]
  c_out <- as.vector(mlist$PV__gal)  # [mmol/L]
  
  parscl <- pars  
  parscl$c_in <- c_in
  parscl$c_out <- c_out
  parscl$R <- parscl$Q_sinunit * (c_in - c_out)
  parscl$ER <- (c_in - c_out)/c_in
  parscl$CL <- parscl$Q_sinunit * (c_in - c_out)/c_in
  parscl$DG <- (c_in - c_out)
  
  # reduce to the values with > 0 PP__gal (remove NaN)
  parscl <- parscl[parscl$c_in>0.0, ]
  
  return(parscl)
}

###########################################################################
# Calculation of GEC curves
###########################################################################
#' Calculation of galactose clearance parameters via integration
#' of multiple sinusoidal units (region of interest).
#' Important to integrate only over samples from the same underlying distribution.
#' mean & sd values are the mean and sd between the different sinusoidal 
#' units. 
#' Q_per_vol & R_per_vol are the perfusion of the region of interest and
#' the corresponding removal of galactose per region of interest.
#' Be aware of the units !
#' 
#' Calculates: mean, sd, q
#' 
#' @param x Called with extended parameter data.frame containing clearance per sinusoidal unit.
#' @param f_tissue Parenchymal tissue fractions
#' @export
f_integrate_GE <- function(x, f_tissue=0.8, vol_liver=1500){  
  # ------------------------
  # General calculations
  # ------------------------
  # number of samples
  N <- length(x$Vol_sinunit)
  
  # Here integrated values over the sample of sinusoidal units are calculated.
  # total volume (sinusoidal unit volume)
  sum.Vol_sinunit <- sum(x$Vol_sinunit) # [m^3]
  # total volume of tissue (sinusoidal unit and the corresponding larger vessels)
  sum.Vol_tissue <- sum.Vol_sinunit/f_tissue  # [m^3]
  # total flow
  sum.Q_sinunit <- sum(x$Q_sinunit)     # [m^3/sec]
  # total removal
  sum.R <- sum(x$R) # [mole/sec]
  # total clearance
  sum.CL <- sum(x$CL) # [m^3/sec]
  
  ## values normalized to volume 
  Q_per_vol <- sum.Q_sinunit/sum.Vol_tissue      # [m^3/sec/m^3(tissue)] = [ml/sec/ml(tissue)] 
  R_per_vol <- sum.R/sum.Vol_tissue              # [mole/sec/m^3(tissue)]
  CL_per_vol <- sum.CL/sum.Vol_tissue            # [m^3/sec/m^3(tissue)]
  
  ## proper units for flow and clearance
  Q_per_vol_units <- Q_per_vol*60                 # [ml/min/ml(tissue)]
  R_per_vol_units <- R_per_vol*60                 # [µmole/min/ml(tissue)]
  CL_per_vol_units <- CL_per_vol*60               # [ml/min/ml(tissue)]
  
  ## create absolute values with liver volume
  Q_abs_vol_units <- Q_per_vol_units*vol_liver      # [ml/min]
  R_abs_vol_units <- R_per_vol_units*vol_liver/1000 # [mmole/min]
  CL_abs_vol_units <- CL_per_vol_units*vol_liver    # [ml/min/ml(tissue)]
  
  # ---------------------------------------------------
  # mean, sd, quantiles for sample of sinusoidal units
  # ---------------------------------------------------
  Vol_sinunit <- list()
  Vol_sinunit$name <- 'Volume of sinusoidal unit'
  Vol_sinunit$unit <- 'm^3'
  Vol_sinunit$mean <- mean(x$Vol_sinunit)
  Vol_sinunit$sd <- sd(x$Vol_sinunit)
  
  Q_sinunit <- list()
  Q_sinunit$name <- 'Blood flow of sinusoidal unit'
  Q_sinunit$unit <- 'm^3/sec'
  Q_sinunit$mean <- mean(x$Q_sinunit) # [m^3/sec]
  Q_sinunit$sd <- sd(x$Q_sinunit)     # [m^3/sec]
  
  c_in <- list()
  c_in$name <- 'PP galactose'
  c_in$unit <- 'mmol/L'
  c_in$mean <- mean(x$c_in)
  c_in$sd <- sd(x$c_in)    
  
  c_out <- list()
  c_out$name <- 'PV galactose'
  c_out$unit <- 'mmol/L'
  c_out$mean <- mean(x$c_out)
  c_out$sd <- sd(x$c_out)
  
  CL <- list()
  CL$name <- 'Clearance'
  CL$unit <- 'm^3/sec'
  CL$mean <- mean(x$CL)
  CL$sd <- sd(x$CL)    
  
  R <- list()
  R$name <- 'Removal'
  R$unit <- 'mole/sec'
  R$mean <- mean(x$R) # [mole/sec]
  R$sd <- sd(x$R)     # [mole/sec]
  
  # pp - pv difference
  DG <- list()
  DG$name <- 'Galactose difference (PP - PV)'
  DG$unit <- 'mmole/L'
  DG$mean <- mean(x$DG) # [mmole/L]
  DG$sd <- sd(x$DG)     # [mmole/L]
  
  # Extraction ratio
  ER <- list()
  ER$name <- 'Extraction ratio'
  ER$unit <- '-'
  ER$mean <- mean(x$ER) # [-]
  ER$sd <- sd(x$ER)     # [-]
  
  data.frame(N=N,
       Vol_sinunit=Vol_sinunit,
       Q_sinunit=Q_sinunit,
       c_in=c_in,
       c_out=c_out,
       CL=CL,
       R=R,
       DG=DG,
       ER=ER,
       Q_per_vol=Q_per_vol, 
       R_per_vol=R_per_vol,
       CL_per_vol=CL_per_vol,
       Q_per_vol_units=Q_per_vol_units, 
       R_per_vol_units=R_per_vol_units,
       CL_per_vol_units=CL_per_vol_units,
       Q_abs_vol_units=Q_abs_vol_units, 
       R_abs_vol_units=R_abs_vol_units,
       CL_abs_vol_units=CL_abs_vol_units)
}


#' Calculate half maximal times from the processed data
#' 
#' Preprocessing of the half maximal time from the response curves, i.e. 
#' how fast is the half maximum reached after galactose challenge.
#' @export
calc_half_max_time <- function(processed, t_peak, t_end){
  ids <- processed$ids
  pars <- processed$pars
  x <- processed$x
  simIds = rownames(pars)
  
  # steady state values for the ids
  mlist <- createApproximationMatrix(x, ids=ids, simIds=simIds, points=c(t_end), reverse=FALSE)
  
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
  return (as.vector(t_half)) # [s]
}


#################################################################################
# GE response curves for prediction of GE and GEkg (GEC and GECkg)
#################################################################################

#' Predicts galactose elimination (GE) for given vectors of liver volume and blood flow
#' based on GE response functions.
#' 
#' Under high galactose concentrations, i.e. gal=8.0mM, the maximal galactose elimination
#' rate is reached (GEC).
#'@export
predict_GE <- function(GEC_f, volLiver, flowLiver, galactose=8.0, age=20){
  # perfusion by given liver volume and flow
  perfusion <- flowLiver/volLiver # [ml/min/ml]
  
  # GEC per volume based on perfusion
  GE_per_vol <- GE_f$f(perfusion, galactose, age) # [mmol/min/ml]
  
  # GEC for complete liver
  GE <- GE_per_vol * volLiver  # [mmol/min]
  return(list(GE=GE, 
              perfusion=perfusion, 
              galactose=galactose,
              age=age,
              GE_per_vol=GE_per_vol))
}

#' Predicts galactose elimination per bodyweight (GEkg) 
#' for given vectors of liver volume and blood flow based on GE response functions.
#' 
#' Under high galactose concentrations, i.e. gal=8.0mM, the maximal galactose elimination
#' rate is reached (GEC).
#'@export
predict_GEkg <- function(volLiverkg, flowLiverkg, galactose=8.0, age=20){  
  perfusion <- flowLiverkg/volLiverkg  # [ml/min/ml]
  # GEC per volume based on perfusion
  GE_per_vol <- GEC_f$f(perfusion)  # [mmol/min/ml]
  
  # GE per body weight
  GEkg <- GE_per_vol * volLiverkg  # [mmol/min/kg]
  return(list(GEkg=GEkg,
              perfusion=perfusion, 
              galactose=galactose,
              age=age,
              GE_per_vol=GE_per_vol))
}

#' Predict GE and GEkg for multiple people.
#' 
#' Predicts the GEC and GECkg for given people. Calculates the 
#' quantiles and stores some of the individual samples
#'@export
predict_GE_people <- function(people, GEC_f, volLiver, flowLiver, out_dir, galactose=8.0){
  stop('Not implemented')
  # TODO: get the age from the people data
  GEC_all <- calculate_GEC(GEC_f, volLiver, flowLiver)
  GEC <- GEC_all$values
  m.bodyweight <- matrix(rep(people$bodyweight, ncol(GEC)),
                         nrow=nrow(GEC), ncol=ncol(GEC))
  GECkg <- GEC/m.bodyweight
  
  files <- list()
  # save people
  files$people <- file.path(out_dir, 'people.Rdata')
  save(people, files$people)
  
  # save GEC & GECkg
  files$GEC <- file.path(out_dir, 'GEC.Rdata')
  save(GEC, file=files$GEC)
  
  files$GECkg <- file.path(out_dir, 'GECkg.Rdata')
  save(GECkg, file=files$GECkg)
}

#' Calculate quantiles for the data.
#' 
#'@export
calc_quantiles <- function(data, q.values=c(0.025, 0.25, 0.5, 0.75, 0.975)){
  qdata <- apply(data, 1, quantile, q.values)
  return ( t(qdata) )
}