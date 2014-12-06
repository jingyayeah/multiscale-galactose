################################################################
## Galactose Clearance & Elimination Curves
################################################################
# Creates GEC response curves, i.e. GEC per tissue for given 
# perfusion.
# GEC is calculated based on periportal galactose challenge. 
# The GEC response curves are used to scale the simulations
# to larger liver regions and the complete liver.
# 
# Combines galactose elimination simulations for multiple 
# sinusoidal units.Simulation can vary among others in galactose 
# challenge, blood flow or metabolic parameters.
# Samples are integrated, i.e. the mean response and variations
# are calculated for a given set of sinusoidal units.
#
# author: Matthias Koenig
# date: 2014-11-30
################################################################

# Dataset for analyis
if(!exists('folder')){
  rm(list=ls())
  folder <- '2014-12-03_T5' # normal galactose challenge
}

library('MultiscaleAnalysis')
setwd(ma.settings$dir.base)

# Galactose challenge at peak time, simulation covers at least t_end
res <- calculate_GEC_curves(folder, t_peak, t_end)


###########################################################################
# Control plots for GEC curves
###########################################################################
# TODO: create images for the analysis
plot(parscl$f_flow, parscl$flow_sin)
plot(parscl$flow_sin, parscl$R)

p <- ggplot(parscl, aes(flow_sin, R, colour=c_out)) + geom_point()
p + facet_grid(f_flow ~ N_fen)

p <- ggplot(parscl, aes(flow_sin, CL, colour=c_out)) + geom_point()
p + facet_grid(f_flow ~ N_fen)

p <- ggplot(parscl, aes(flow_sin, ER, colour=c_out)) + geom_point()
p + facet_grid(f_flow ~ N_fen)

# Plot the generated GEC curves
head(d2)
p1 <- ggplot(d2, aes(f_flow, R_per_vol_units*1500)) + geom_point() + geom_line() + facet_grid(~ N_fen)
p2 <- ggplot(d2, aes(f_flow, Q_per_vol_units)) + geom_point() + geom_line() + facet_grid(~ N_fen)
p3 <- ggplot(d2, aes(Q_per_vol_units, R_per_vol_units*1500)) + geom_point() + geom_line()+ ylim(0,5) +facet_grid(~ N_fen)
multiplot(p1, p2, p3, cols=3)
d2



###########################################################################
# Conversion factor
###########################################################################
# The conversion factors via flux and volume have to be the same.
# They are calculated based on the weighted distributions of the parameters. 
# But they have to be calculated over the distribution of geometries
# TODO: check the conversion factor is correct, i.e. N_Q and N_Vol
#  N_Q = Q_liv/Q;
# with  
#  N_Vol = N_Q
#  N_Vol = f_tissue*Vol_liv/Vol_sinunit  
# => f_tissue = N_Vol * Vol_sinunit/Vol_liv
# -20% large vessels

# calculate conversion factors
calculateConversionFactors <- function(pars){
  res <- list()
  f_tissue = 0.75;
  
  # varies depending on parameters
  Q_sinunit.wmean <- wt.mean(pars[['Q_sinunit']], pars$p_sample)
  Q_sinunit.wsd <- wt.sd(pars[['Q_sinunit']], pars$p_sample)
  Vol_sinunit.wmean <- wt.mean(pars[['Vol_sinunit']], pars$p_sample)
  Vol_sinunit.wsd <- wt.sd(pars[['Vol_sinunit']], pars$p_sample)
  
  # constant normal value
  Q_liv.wmean <- wt.mean(pars[['Q_liv']], pars$p_sample)
  Q_liv.wsd <- wt.sd(pars[['Q_liv']], pars$p_sample)
  Vol_liv.wmean <- wt.mean(pars[['Vol_liv']], pars$p_sample)
  Vol_liv.wsd <- wt.sd(pars[['Vol_liv']], pars$p_sample)
  N_Vol = f_tissue*Vol_liv.wmean/Vol_sinunit.wmean
  N_Q1 = Q_liv.wmean/Q_sinunit.wmean
  
  f_flow = N_Q1/N_Vol
  N_Q = N_Q1/f_flow
  
  cat('N_Q: ', N_Q, '\n')
  cat('N_Vol: ', N_Vol, '\n')
  cat('N_Vol/N_Q1: ', N_Vol/N_Q1, '\n')
  cat('N_Vol/N_Q: ',  N_Vol/N_Q, '\n')
  cat('f_flow: ', f_flow, '\n')
  
  res$N_Q <- N_Q
  res$N_Vol <- N_Vol
  res$f_tissue <- f_tissue
  res$f_flow <- f_flow
  res
}
#res <- calculateConversionFactors(pars)
#names(res)
