################################################################
## Galactose Clearance & Elimination Curves
################################################################
# Analysis of galactose elimination simulations for sets of 
# sinusoidal units.
# Simulation can vary among others in galactose challange, blood
# flow or metabolic network/capacity (for instance galactosemias).
# 
# Samples are integrated, i.e. the mean response and variations
# are calculated for a given set of sinusoidal units.
#
# This script is used to calculate the GEC response curves for 
# given samples of sinusoidal units. These GEC response curves
# are used for scaling of the tissue model to complete liver.
#
# Clearance is tested via a galactose challenge periportal. 
# For the calculation of the GEC capacity the metabolic capacity
# is saturated (i.e in the high galactose range).
#
# TODO: perform postprocessing directly after the simulation
#
# author: Matthias Koenig
# date: 2014-11-11
################################################################

rm(list=ls())
setwd(ma.settings$dir.results)

library(MultiscaleAnalysis)
library(libSBML)
library(data.table); library(matrixStats);

# Galactose challenge at peak time, simulation covers at least t_end
t_peak <- 2000 # [s]
t_end <- 10000 # [s]

# Dataset for analyis
folder <- '2014-11-08_T53' # normal galactose challenge
pars <- loadParameterFile(file='/home/mkoenig/multiscale-galactose-results/2014-11-08_T53/T53_Galactose_v24_Nc20_galchallenge_parameters.csv')

# Some visual analysis of the parameters
head(pars)
plotParameterHistogramFull(pars=pars)
library('ggplot2')
# distribution of flows 
ggplot(pars, aes(factor(f_flow), flow_sin)) + geom_boxplot() + geom_point()
mean(pars$flow_sin[pars$f_flow==0.5])
summary(pars$flow_sin[pars$f_flow==0.5])

# Preprocess the dataset 
# Here the important subcomponents are loaded from the integration csv files
source(file=file.path(ma.settings$dir.code, 'analysis', 'Preprocess.R'), 
       echo=TRUE, local=FALSE)


# Extend the parameters with the SBML and calculated parameters
ps <- getParameterTypes(pars=pars)
f.sbml <- file.path(ma.settings$dir.results, folder, paste(modelId, '.xml', sep=''))
model <- loadSBMLModel(f.sbml)
pars <- extendParameterStructure(pars=pars, fixed_ps=ps$fixed, model=model)
head(pars)

# Calculate the galactose clearance parameters
parscl <- createGalactoseClearanceDataFrame(t_peak=2000, t_end=10000)

# reduce to the values with > 0 PP__gal (remove NaN)
parscl <- parscl[parscl$c_in>0.0, ]
summary(parscl)


plot(parscl$f_flow, parscl$flow_sin)
plot(parscl$flow_sin, parscl$R)

library('ggplot2')
p <- ggplot(parscl, aes(flow_sin, R, colour=c_out)) + geom_point()
p + facet_grid(f_flow ~ gal_challenge)

p <- ggplot(parscl, aes(flow_sin, CL, colour=c_out)) + geom_point()
p + facet_grid(f_flow ~ gal_challenge)

p <- ggplot(parscl, aes(flow_sin, ER, colour=c_out)) + geom_point()
p + facet_grid(f_flow ~ gal_challenge)


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

d2 <- ddply(parscl, c("gal_challenge", 'f_flow'), f_analyse)
save('d2', 'parscl', file='/home/mkoenig/multiscale-galactose/experimental_data/processed/GEC_curve_T53_new.Rdata')

###########################################################################
# GEC curves
###########################################################################
# Plot the generated GEC curves
# TODO: save the plots
head(d2)
p1 <- ggplot(d2, aes(f_flow, R_per_vol_units*1500)) + geom_point() + geom_line() + facet_grid(~ gal_challenge)
p2 <- ggplot(d2, aes(f_flow, Q_per_vol_units)) + geom_point() + geom_line() + facet_grid(~ gal_challenge)
p3 <- ggplot(d2, aes(Q_per_vol_units, R_per_vol_units*1500)) + geom_point() + geom_line()+ ylim(0,5) +facet_grid(~ gal_challenge)
multiplot(p1, p2, p3, cols=3)

# combined plot of the individual with the mean simulations
names(d2)
plot(d2$Q_per_vol_units, d2$mean.R, ylim=c(0, 2.0*max(d2$mean.R)), lwd=2, col='blue')
lines(d2$Q_per_vol_units, d2$mean.R, lwd=2, col='blue')
lines(d2$Q_per_vol_units, d2$mean.R+d2$sd.R, col='Gray', lwd=2)
lines(d2$Q_per_vol_units, d2$mean.R-d2$sd.R, col='Gray', lwd=2)
points(parscl$Q_sinunit/parscl$Vol_sinunit*60, parscl$R, cex=0.2, bg=rgb(0,0,0,0.5))
head(parscl)



