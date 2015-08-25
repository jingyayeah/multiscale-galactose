################################################################
## GE heterogeneity
################################################################
# Calculate the galactose elimination (GE), clearance (CL), 
# extraction ratio (ER) for sets of simulations for given 
# perfusion and galactose concentration.
#
# GE is calculated based on periportal galactose challenge and
# the steady state difference periportal/perivenious.
# Integration over multiple sinusoidal units is performed to 
# calculate GEC for a region of interest.
#
# author: Matthias Koenig
# date: 2015-02-12
################################################################

# Preprocess all the data from the raw data 
rm(list=ls())
library('MultiscaleAnalysis')
library('libSBML')
library('plyr')
setwd(ma.settings$dir.base)

# Preprocess raw data and integrate over the sinusoidal units
factors <- c('f_flow', "gal_challenge")
fs <- get_age_GE_folders()
fs
tmp <- integrate_GE_folders(df_folders=fs, factors=factors) 
parscl <- tmp$parscl
dfs <- tmp$dfs
rm(tmp)

# In the plots the individual data points for the simulated 
# steady state galactose levels and flows
gal_levels <- as.numeric(levels(as.factor(dfs[[1]]$gal_challenge )))
gal_levels
f_levels <- as.numeric(levels(as.factor(dfs[[1]]$f_flow)))
f_levels


# This is all the raw data
# which is used to fit the GEC curves
parscl
colnames(parscl[[1]])
gec_data20 <- parscl[[1]]

idx <- (gec_data20$gal_challenge == 2.00)
table(idx)

plot(gec_data20$Q_sinunit[idx]/gec_data20$Vol_sinunit[idx], gec_data20$CL[idx], pch=16, col=rgb(0.5, 0.5,0.5, 0.5),
     main="Galactose Challenge 2.0 [mM], age=20 [yr]")
# Boxplot of galactose clearance
plot(x=NA, y=NA, type="n",
     main="Galactose Challenge 2.0 [mM], age=20 [yr]", 
     xlim=c(min(f_levels), max(f_levels)),
     ylim=c(min(gec_data20$CL), max(gec_data20$CL)),
     )
for (f in f_levels){
  idx <- (gec_data20$gal_challenge == 2.00 & gec_data20$f_flow==f)
  boxplot(gec_data20$CL[idx], at=f, boxwex=0.05, col="grey", add=TRUE)
}




