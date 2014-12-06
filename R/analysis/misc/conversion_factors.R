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