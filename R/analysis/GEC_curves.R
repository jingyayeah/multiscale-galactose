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
  folder <- '2014-12-03_T5' # normal galactose challenge
  rm(list=ls())
}

library('MultiscaleAnalysis')
setwd(ma.settings$dir.base)

# Galactose challenge at peak time, simulation covers at least t_end
t_peak <- 2000; t_end <- 10000 # [s]

# Process the integration time curves
processed <- preprocess_task(folder=folder, force=TRUE) 
names(processed)

# Calculate the galactose clearance parameters
parscl <- extend_with_galactose_clearance(processed=processed, 
                                            t_peak=t_peak, t_end=t_end)
head(parscl)

# Perform analysis split by factors
# Generates the necessary data points for the interpolation of the GEC
# curves.
library('plyr')
d2 <- ddply(parscl, c("gal_challenge", "N_fen", 'f_flow'), f_analyse)



###########################################################################
# GEC curves
###########################################################################
# Some control plots
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

# combined plot of the individual with the mean simulations
names(d2)
plot(d2$Q_per_vol_units, d2$mean.R, ylim=c(0, 2.0*max(d2$mean.R)), lwd=2, col='blue')
lines(d2$Q_per_vol_units, d2$mean.R, lwd=2, col='blue')
lines(d2$Q_per_vol_units, d2$mean.R+d2$sd.R, col='Gray', lwd=2)
lines(d2$Q_per_vol_units, d2$mean.R-d2$sd.R, col='Gray', lwd=2)
points(parscl$Q_sinunit/parscl$Vol_sinunit*60, parscl$R, cex=0.2, bg=rgb(0,0,0,0.5))
head(parscl)

###########################################################################
# Bootstrap the GEC curves
###########################################################################
# bootstrap calculation of function
# The number of samples in the bootstrap corresponds to the available samples.
f_bootstrap <- function(dset, funct, B=1000){
  # bootstraping the function on the given dataset
  dset.mean <- f_analyse(dset)
  
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
    dset.boot[k, ] <- f_analyse(df.boot)[1, ]
  }
  # now the function can be applied on the bootstrap set
  dset.funct <- data.frame(matrix(NA, ncol=ncol(dset.mean), nrow=1))
  names(dset.funct) <- names(dset.mean)
  for (i in seq(1,ncol(dset.mean))){
    dset.funct[1,i] <- funct(dset.boot[,i])
  }
  return(dset.funct)
}
# Calculate bootstrap sd for confidence intervals
d2.se <- ddply(parscl, c("gal_challenge", "N_fen", 'f_flow'), f_bootstrap, funct=sd, B=1000)

head(d2)    # point estimate (mean values)
head(d2.se) # bootstrap SE

###########################################################################
# Fit the GEC curves
###########################################################################
x <- d2$Q_per_vol_units
y1 <- d2$R_per_vol_units
y2 <- d2.se$R_per_vol_units
f1 <- approxfun(x, y1, method = "linear")
f2 <- splinefun(x, y1)
f2.se <- splinefun(x, y2)
plot(x,y1, ylim=c(0,0.003))
curve(f1, from=0, to=3.5, col='red', add=T)
curve(f2, from=0, to=3.5, col='blue', add=T)
curve(f2.se, from=0, to=3.5, col='blue', add=T)


# save everything
GEC_curves <- list(d2=d2, d2.se=d2.se)
d2.file <- file.path(ma.settings$dir.expdata, 'processed',
                     paste('GEC_curve_', task, '.Rdata', sep=''))
cat(d2.file)          
save('d2', 'd2.se', 'parscl', 'GEC_curves', file=d2.file)


########################################
# Figure GEC ~ perfusion (bootstrap)
########################################
create_plots=F
startDevPlot(create_plots)

stopDevPlot(create_plots)

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
