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

#' Create the GEC functions from the given GEC task data
#'
#'@export
GEC_functions <- function(task){
  # Load the GEC information for task
  dir <- file.path(ma.settings$dir.base, 'results', 'GEC_curves')
  load(file=file.path(dir, sprintf('GEC_curve_%s.Rdata', task)))
  d.mean <- GEC_curves$d2
  d.se <- GEC_curves$d2.se
  
  # create spline fits
  Qvol <- d.mean$Q_per_vol_units     # perfusion [ml/min/ml]
  Rvol <- d.mean$R_per_vol_units     # GEC clearance [mmol/min/ml]
  Rvol.se <- d.se$R_per_vol_units    # GEC standard error (bootstrap) [mmol/min/ml]
  f <- splinefun(Qvol, Rvol)
  f.se <- splinefun(Qvol, Rvol.se)  
  
  return(list(f=f, f.se=f.se, Qvol=Qvol, Rvol=Rvol, Rvol.se=Rvol.se))
}

#' Plot single GEC function.
#' 
#' @export
plot_GEC_function <- function(GEC_f){
  attach(GEC_f)
  plot(Qvol, Rvol, ylim=c(0,0.003))
  curve(f, from=0, to=max(Qvol), col='red', add=T)
  curve(f.se, from=0, to=max(Qvol), col='blue', add=T)
}


#' Calculates GEC for given vectors of liver volume and blood flow.
#'
#'@export
calculate_GEC <- function(GEC_f, volLiver, flowLiver, f_tissue=0.8){  
  # calculate perfusion
  perfusion <- flowLiver/volLiver # [ml/min/ml]
  
  # GEC per volume based on perfusion
  # GEC_per_vol <- rnorm(1, mean=GEC_f$f_GEC(perfusion), sd=GEC_f$f_GEC.se(perfusion)) # mmol/min/ml
  GEC_per_vol <- GEC_f$f(perfusion) # [mmol/min/ml]
  
  # GEC for complete liver
  # GEC curves are for liver tissue. No correction for the large vessel structure
  # has been applied. Here the metabolic capacity of combined sinusoidal units.
  GEC <- GEC_per_vol * f_tissue * volLiver   # [mmol/min]
  return(list(values=GEC, perfusion=perfusion, GEC_per_vol=GEC_per_vol, f_tissue=f_tissue))
}

#' Calculates GECkg for given vectors of liver volume and blood flow.
#'
#'@export
calculate_GECkg <- function(volLiverkg, flowLiverkg, f_tissue=0.8){  
  # perfusion
  perfusion <- flowLiverkg/volLiverkg    # [ml/min/ml]
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
  
  # save GEC & GECkg
  GEC.file <- file.path(out_dir, 'GEC.Rdata')
  cat(GEC.file, '\n')
  save(GEC, file=GEC.file)
  GECkg.file <- file.path(out_dir, 'GECkg.Rdata')
  cat(GECkg.file, '\n')
  save(GECkg, file=GECkg.file)
  
  # calculate and store the quantiles
  volLiver.q <- calc_quantiles(volLiver)
  flowLiver.q <- calc_quantiles(flowLiver)
  GEC.q <- calc_quantiles(GEC)
  GECkg.q <- calc_quantiles(GECkg)
  
  # Quantiles files
  quantiles.file <- file.path(out_dir, 'GEC_quantiles.Rdata')
  cat(quantiles.file, '\n')
  save(people, volLiver.q, flowLiver.q, GEC.q, GECkg.q, file=quantiles.file)
}
