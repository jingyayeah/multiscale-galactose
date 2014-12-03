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
rm(list=ls())
setwd(ma.settings$dir.results)
library('MultiscaleAnalysis')
library('libSBML')
library('data.table'); library('matrixStats');
library('ggplot2')

# Galactose challenge at peak time, simulation covers at least t_end
t_peak <- 2000 # [s]
t_end <- 10000 # [s]

# Dataset for analyis
if(!exists('folder')){
  folder <- '2014-11-30_T1' # normal galactose challenge
}
cat('GEC curves: ', folder, '\n')

# Some visual analysis of the parameters
# pars <- loadParameterFile(file='/home/mkoenig/multiscale-galactose-results/2014-11-17_T5/T5_Galactose_v25_Nc20_galchallenge_parameters.csv')
# head(pars)
# plotParameterHistogramFull(pars=pars)
# library('ggplot2')
# distribution of flows 
# ggplot(pars, aes(factor(f_flow), flow_sin)) + geom_boxplot() + geom_point()
# mean(pars$flow_sin[pars$f_flow==0.5])
# summary(pars$flow_sin[pars$f_flow==0.5])

# Preprocess dataset 
# Here the important subcomponents are loaded from the integration csv files
source(file=file.path(ma.settings$dir.code, 'analysis', 'Preprocess.R'), 
       echo=TRUE, local=FALSE)


# Calculate the galactose clearance parameters
parscl <- createGalactoseClearanceDataFrame(t_peak=2000, t_end=10000)

# reduce to the values with > 0 PP__gal (remove NaN)
parscl <- parscl[parscl$c_in>0.0, ]
summary(parscl)


plot(parscl$f_flow, parscl$flow_sin)
plot(parscl$flow_sin, parscl$R)

head(parscl)

library('ggplot2')
p <- ggplot(parscl, aes(flow_sin, R, colour=c_out)) + geom_point()
p + facet_grid(f_flow ~ N_fen)

p <- ggplot(parscl, aes(flow_sin, CL, colour=c_out)) + geom_point()
p + facet_grid(f_flow ~ N_fen)

p <- ggplot(parscl, aes(flow_sin, ER, colour=c_out)) + geom_point()
p + facet_grid(f_flow ~ N_fen)


library(plyr)
# Analyse the data split by group (f_flow)
# TODO: f_tissue has to come from model definition & must be used in scaling to the liver
# no correction for large vessel performed during the integration on tissue scale.

f_analyse <- function(x){  
  # number of samples
  N_sunits <- length(x$Vol_sinunit)
  
  # total volume (sinusoidal unit volume)
  sum.Vol_sinunit <- sum(x$Vol_sinunit) # [m^3]
  # total flow
  sum.Q_sinunit <- sum(x$Q_sinunit)     # [m^3/sec]
  # total removal
  sum.R <- sum(x$R) # [mole/sec]
  
  ## normalize to volume 
  Q_per_vol <- sum.Q_sinunit/sum.Vol_sinunit     # [m^3/sec/m^3(liv)] = [ml/sec/ml(liv)] 
  R_per_vol <- sum.R/sum.Vol_sinunit             # [mole/sec/m^3(liv)]
  
  ## proper units for flow and clearance
  Q_per_vol_units <- Q_per_vol*60                 # [ml/min/ml(liv)]
  R_per_vol_units <- R_per_vol*60/1000            # [mmole/min/ml(liv)]
  
  ## mean, sd over sinusoidal unit samples
  # volume (sinusoidal 
  mean.Vol_sinunit <- mean(x$Vol_sinunit) # [m^3]
  sd.Vol_sinunit <- sd(x$Vol_sinunit)     # [m^3]
  # flow
  mean.Q_sinunit <- mean(x$Q_sinunit) # [m^3/sec]
  sd.Q_sinunit <- sd(x$Q_sinunit)     # [m^3/sec]
  # removal
  mean.R <- mean(x$R) # [mole/sec]
  sd.R <- sd(x$R)     # [mole/sec]
  # pp - pv difference
  mean.DG <- mean(x$DG) # [mmole/L]
  sd.DG <- sd(x$DG)     # [mmole/L]
  # Extraction ratio
  mean.ER <- mean(x$ER) # [-]
  sd.ER <- sd(x$ER)     # [-]
  
  data.frame(N_sunits,
             mean.Vol_sinunit, mean.Q_sinunit, mean.R, mean.DG, mean.ER,
             sd.Vol_sinunit, sd.Q_sinunit, sd.R, sd.DG, sd.ER,
             sum.Vol_sinunit, sum.Q_sinunit, sum.R,
             Q_per_vol, R_per_vol,
             Q_per_vol_units, R_per_vol_units)
}

d2 <- ddply(parscl, c("gal_challenge", "N_fen", 'f_flow'), f_analyse)

###########################################################################
# GEC curves
###########################################################################
# Plot the generated GEC curves
# TODO: save the plots
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
plot(d2$Q_per_vol_units, d2$R_per_vol_units, type='n',main='Galactose clearance ~ perfusion', 
     xlab='Liver perfusion [ml/min/ml]', ylab='GEC per volume tissue [mmol/min/ml]', font=1, font.lab=2, ylim=c(0,1.5*max(d2$R_per_vol_units)))
x <- c(d2$Q_per_vol_units, rev(d2$Q_per_vol_units))
y <- c(d2$R_per_vol_units+2*d2.se$R_per_vol_units, rev(d2$R_per_vol_units-2*d2.se$R_per_vol_units))
polygon(x,y, col = rgb(0,0,0, 0.3), border = NA)
lines(d2$Q_per_vol_units, d2$R_per_vol_units+2*d2.se$R_per_vol_units, col=rgb(0,0,0, 0.8))
lines(d2$Q_per_vol_units, d2$R_per_vol_units-2*d2.se$R_per_vol_units, col=rgb(0,0,0, 0.8))
points(d2$Q_per_vol_units, d2$R_per_vol_units, pch=21, col='black', bg=rgb(0,0,0, 0.8))
lines(d2$Q_per_vol_units, d2$R_per_vol_units, col='black', lwd=2)
legend('bottomright', legend=c('mean GEC (Ns=1000 sinusoidal units)', '+-2SE (bootstrap, Nb=1000)'), 
       lty=c(1, 1), col=c('black', rgb(0,0,0,0.8)), lwd=c(2,1))
stopDevPlot(create_plots)

d2

###################################################################
# TODO: create the GEC curves here
# TODO: check the conversion factor is correct, i.e. N_Q and N_Vol


###########################################################################
# Conversion factor
###########################################################################
# The conversion factors via flux and volume have to be the same.
# They are calculated based on the weighted distributions of the parameters. 
# But they have to be calculated over the distribution of geometries
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
