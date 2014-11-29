##############################################################################
# GEC curves
##############################################################################
library('MultiscaleAnalysis')

# Create the GEC functions from the given GEC task data
GEC_functions <- function(task){  
  dir <- file.path(ma.settings$dir.base, 'results', 'GEC_curves')
  load(file=file.path(dir, sprintf('GEC_curve_%s.Rdata', task)))
  str(GEC_curves)
  d.mean <- GEC_curves$d2
  d.se <- GEC_curves$d2.se
  
  # create spline fits
  x <- d.mean$Q_per_vol_units      # perfusion [ml/min/ml]
  y <- d.mean$R_per_vol_units     # GEC clearance [mmol/min/ml]
  y.se <- d.se$R_per_vol_units  # GEC standard error (bootstrap) [mmol/min/ml]
  f <- splinefun(x, y)
  f.se <- splinefun(x, y.se)  
  
  plot(x,y, ylim=c(0,0.003))
  curve(f, from=0, to=3.5, col='red', add=T)
  curve(f.se, from=0, to=3.5, col='blue', add=T)
  
  return(list(f_GEC=f, f_GEC.se=f.se)) 
}

calculate_GEC <- function(volLiver, flowLiver, f_tissue=0.8){  
  # perfusion
  perfusion <- flowLiver/volLiver # [ml/min/ml]
  
  # GEC per volume based on perfusion
  # GEC_per_vol <- rnorm(1, mean=GEC_f$f_GEC(perfusion), sd=GEC_f$f_GEC.se(perfusion)) # mmol/min/ml
  GEC_per_vol <- GEC_f$f_GEC(perfusion) # [mmol/min/ml]
  
  # GEC for complete liver
  # GEC curves are for liver tissue. No correction for the large vessel structure
  # has been applied. Here the metabolic capacity of combined sinusoidal units.
  GEC <- GEC_per_vol * f_tissue * volLiver   # [mmol/min]
  return(list(values=GEC, perfusion=perfusion, GEC_per_vol=GEC_per_vol, f_tissue=f_tissue))
}

calculate_GECkg <- function(volLiverkg, flowLiverkg, f_tissue=0.8){  
  # perfusion
  perfusion <- flowLiverkg/volLiverkg    # [ml/min/ml]
  # GEC per volume based on perfusion
  # GEC_per_vol <- rnorm(1, mean=GEC_f$f_GEC(perfusion), sd=GEC_f$f_GEC.se(perfusion)) # mmol/min/ml
  GEC_per_vol <- GEC_f$f_GEC(perfusion)  # [mmol/min/ml]
  
  # GEC for liver per kg
  # GEC curves are for liver tissue. No correction for the large vessel structure
  # has been applied. Here the metabolic capacity of combined sinusoidal units.
  GECkg <- GEC_per_vol * f_tissue * volLiverkg  # [mmol/min/kg]
  return(list(values=GECkg, perfusion=perfusion, GEC_per_vol=GEC_per_vol, f_tissue=f_tissue))
}