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
library('MultiscaleAnalysis')
setwd(ma.settings$dir.base)


# Set of GEC curves to create from simulations
# '2014-11-30_T1'  # normal GEC ~ f_flow
# '2014-12-03_T3'  # normal GEC ~ f_flow, N_fen (ageing)
# '2014-12-03_T5'  # normal GEC ~ f_flow, f_scale (ageing)

folders <- c('2014-11-30_T1', '2014-12-03_T3', '2014-12-03_T5')
for (folder in folders){
  assign(folder, calculate_GEC_curves(folder))
}


################################################################
## Galactose Clearance & Elimination Curves in Ageing
################################################################
# Create GEC curves in aging.
# Multiple processing of the individual GEC curves.




###########################################################################
# Control plots for GEC curves
###########################################################################
parscl <- res$parscl
head(parscl)

# TODO: create images for the analysis
plot(parscl$f_flow, parscl$flow_sin)
plot(parscl$flow_sin, parscl$R)

p1 <- ggplot(parscl, aes(flow_sin, R, colour=c_out)) + geom_point() +facet_grid(f_flow ~ N_fen)
p2 <- ggplot(parscl, aes(flow_sin, CL, colour=c_out)) + geom_point() +facet_grid(f_flow ~ N_fen)
p3 <- ggplot(parscl, aes(flow_sin, ER, colour=c_out)) + geom_point() + facet_grid(f_flow ~ N_fen)
multiplot(p1, p2, p3, cols=3)

# Plot the generated GEC curves
head(d2)
p1 <- ggplot(d2, aes(f_flow, R_per_vol_units*1500)) + geom_point() + geom_line() + facet_grid(~ N_fen)
p2 <- ggplot(d2, aes(f_flow, Q_per_vol_units)) + geom_point() + geom_line() + facet_grid(~ N_fen)
p3 <- ggplot(d2, aes(Q_per_vol_units, R_per_vol_units*1500)) + geom_point() + geom_line()+ ylim(0,5) +facet_grid(~ N_fen)
multiplot(p1, p2, p3, cols=3)
d2
