################################################################
# GEC calculation functions
################################################################
# Calculation of GEC curves and GEC values from given GEC
# curves.
#
# TODO: handle the dependencies of GEC curves of given anthropomorphic
# information. For instance the change in GEC with aging.
# I.e. the actual GEC value depends on GEC function depending on people 
# information.
# 
# author: Matthias Koenig
# date: 2014-12-06
################################################################

#' Calculate half maximal times from the processed data
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

###########################################################################
# Galactose clearance by individual sinusoidal unit
###########################################################################
#' Calculates clearance information for sinusoidal unit.
#' 
#' Here the central calculation of clearance for a sinusoidal unit based
#' on the periportal and perivenious steady state concentration 
#' differences is performed. For ever sinusoidal unit the data is calculated.
#' In a first step the timecourse matrix is approximated for the 
#' steady state data point (tend), which is necessary due to the variable
#' time steps in the individual integrations.
#' In a second step the actual clearance parameters are calculated based
#' on the steady state concentration matrix.
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


#' Bootstrap of the calculation function.
#' The number of samples in the bootstrap corresponds to the available samples.
#' @export
f_integrate_GEC_bootstrap <- function(dset, funct, B=1000){
  # bootstraping the function on the given dataset
  dset.mean <- f_integrate_GEC(dset)
  
  # calculate for bootstrap samples
  N <- nrow(dset)
  dset.boot <- data.frame(matrix(NA, ncol=ncol(dset.mean), nrow=B))
  names(dset.boot) <- names(dset.mean)
  
  for (k in seq(1,B)){
    # create the sample by replacement
    # these are the indices of the rows to take from the orignal dataframe
    inds <- sample(seq(1,N), size=N, replace=TRUE)
    
    # create the bootstrap data.frame
    df.boot <- dset[inds, ]
    # calculate the values for the bootstrap df
    dset.boot[k, ] <- f_integrate_GEC(df.boot)[1, ]
  }
  # now the function can be applied on the bootstrap set
  dset.funct <- data.frame(matrix(NA, ncol=ncol(dset.mean), nrow=1))
  names(dset.funct) <- names(dset.mean)
  for (i in seq(1,ncol(dset.mean))){
    dset.funct[1,i] <- funct(dset.boot[,i])
  }
  return(dset.funct)
}


#' Get GEC curve file name for given task.
#' 
#' @export
GEC_curve_file <- function(task){
  dir <- file.path(ma.settings$dir.base, 'results', 'GEC_curves')
  file.path(dir, sprintf('GEC_curve_%s.Rdata', task))
}

#' Calculate GEC curves for task folder.
#' 
#' Integrates over the available simulations and calculates the individual
#' GEC for the combinations of provided factors.
#' Folders have the format: 
#' 
#' @export
calculate_GEC_curves <- function(folder, t_peak=2000, t_end=10000, 
                                 factors=c('f_flow', "gal_challenge", "N_fen", 'scale_f'),
                                 # factors=c('f_flow', "N_fen", 'scale_f'),
                                 force=FALSE, B=1000){
  # Test if folder exists
  fname <- file.path(ma.settings$dir.results, folder)
  if (!file.exists(fname)){
   stop(sprintf('Folder does not exist: %s', fname)) 
  }
  
  # Process the integration time curves
  processed <- preprocess_task(folder=folder, force=force) 
  
  # Calculate the galactose clearance parameters
  parscl <- extend_with_galactose_clearance(processed=processed, t_peak, t_end=t_end)
  
  # Perform analysis split by factors.
  # Generates the necessary data points for the interpolation of the GEC
  # curves and creates an estimate of error via bootstrap.
  cat('Calculate mean GEC\n')
  d.mean <- ddply(parscl, factors, f_integrate_GEC)
  cat('Calculate se GEC (bootstrap)\n')
  d.se <- ddply(parscl, factors, f_integrate_GEC_bootstrap, funct=sd, B=B)
  
  # save the GEC curves 
  GEC_curves <- list(d.mean=d.mean, d.se=d.se)
  GEC.file <- GEC_curve_file(processed$info[['task']])
  cat(GEC.file, '\n')
  save('parscl', 'GEC_curves', file=GEC.file)  
  
  return( list(parscl=parscl, GEC_curves=GEC_curves, GEC.file=GEC.file) )
}

#' Create the GEC functions from the given GEC task data.
#' The functions have to be calculated based on the subsets.
#'
#'@export
GEC_functions <- function(task){
  # Load the GEC data points
  load(file=GEC_curve_file(task))
  d.mean <- GEC_curves$d.mean
  d.se <- GEC_curves$d.se
  
  # create spline fits
  Qvol <- d.mean$Q_per_vol_units     # perfusion [ml/min/ml]
  Rvol <- d.mean$R_per_vol_units     # GEC clearance [mmol/min/ml]
  Rvol.se <- d.se$R_per_vol_units    # GEC standard error (bootstrap) [mmol/min/ml]
  f <- splinefun(Qvol, Rvol)
  f.se <- splinefun(Qvol, Rvol.se)  
  
  return(list(f=f, f.se=f.se, d.mean=d.mean, d.se=d.se))
}

#' Plot single GEC function.
#' 
#' @export
plot_GEC_function <- function(GEC_f){
  f <- GEC_f$f
  f.se <- GEC_f$f.se
  d.mean <- GEC_f$d.mean
  d.se <- GEC_f$d.se
  
  x <- d.mean$Q_per_vol_units
  y <- d.mean$R_per_vol_units
  y.se <- d.se$R_per_vol_units
  
  plot(x, y, type='n',main='Galactose clearance ~ perfusion', 
       xlab='Liver perfusion [ml/min/ml]', ylab='GEC per volume tissue [mmol/min/ml]', font=1, font.lab=2, ylim=c(0,1.5*max(y)))
  
  x.grid <- seq(from=0, to=max(x), length.out=100)
  fx <- f(x.grid)
  fx.se <- f.se(x.grid)
  
  xp <- c(x.grid, rev(x.grid))
  yp <- c(fx+2*fx.se, rev(fx-2*fx.se))
  polygon(xp,yp, col = rgb(0,0,0, 0.3), border = NA)
  # lines(x, y+2*y.se, col=rgb(0,0,0, 0.8))
  # lines(x, y-2*y.se, col=rgb(0,0,0, 0.8))
  points(x, y, pch=21, col='black', bg=rgb(0,0,0, 0.8))
  # lines(x, y, col='black', lwd=2)
  # add spline functions
 
  lines(x.grid, fx, col='blue', lwd=2)
  lines(x.grid, fx+2*fx.se, col='black')
  lines(x.grid, fx-2*fx.se, col='black')
  
  legend('topleft', legend=c('mean GEC (Ns=1000 sinusoidal units)', '+-2SE (bootstrap, Nb=1000)',
                                 'GEC spline function'), 
         lty=c(1, 1, 1), col=c('black', rgb(0,0,0,0.8), 'blue'), lwd=c(2,1,2))
}

#################################################################################
# Using GEC curves for calculation of GEC
#################################################################################

#' Calculates GEC for given vectors of liver volume and blood flow.
#'
#'@export
calculate_GEC <- function(GEC_f, volLiver, flowLiver, f_tissue=0.8){  
  # calculate parenchyma perfusion
  perfusion <- flowLiver/(f_tissue*volLiver) # [ml/min/ml]
  
  # GEC per volume based on perfusion
  # GEC_per_vol <- rnorm(1, mean=GEC_f$f_GEC(perfusion), sd=GEC_f$f_GEC.se(perfusion)) # mmol/min/ml
  GEC_per_vol <- GEC_f$f(perfusion) # [mmol/min/ml]
  
  # GEC for complete liver
  # GEC curves are for liver tissue. No correction for the large vessel structure
  # has been applied. Here the metabolic capacity of combined sinusoidal units.
  GEC <- GEC_per_vol * f_tissue*volLiver   # [mmol/min]
  return(list(values=GEC, perfusion=perfusion, GEC_per_vol=GEC_per_vol, f_tissue=f_tissue))
}

#' Calculates GECkg for given vectors of liver volume and blood flow.
#'
#'@export
calculate_GECkg <- function(volLiverkg, flowLiverkg, f_tissue=0.8){  
  # parenchyma perfusion
  perfusion <- flowLiverkg/(f_tissue*volLiverkg)  # [ml/min/ml]
  # GEC per volume based on perfusion
  # GEC_per_vol <- rnorm(1, mean=GEC_f$f_GEC(perfusion), sd=GEC_f$f_GEC.se(perfusion)) # mmol/min/ml
  GEC_per_vol <- GEC_f$f(perfusion)  # [mmol/min/ml]
  
  # GEC for liver per kg
  # GEC curves are for liver tissue. No correction for the large vessel structure
  # has been applied. Here the metabolic capacity of combined sinusoidal units.
  GECkg <- GEC_per_vol * f_tissue * volLiverkg  # [mmol/min/kg]
  return(list(values=GECkg, perfusion=perfusion, GEC_per_vol=GEC_per_vol, f_tissue=f_tissue))
}


#' Calculate quantiles for the data.
#' 
#'@export
calc_quantiles <- function(data, q.values=c(0.025, 0.25, 0.5, 0.75, 0.975)){
  qdata <- apply(data, 1, quantile, q.values)
  return ( t(qdata) )
}

#' Predict GEC and GECkg for people.
#' 
#' Predicts the GEC and GECkg for given people. Calculates the 
#' quantiles and stores some of the individual samples
#'@export
predict_GEC <- function(people, GEC_f, volLiver, flowLiver, out_dir){
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
