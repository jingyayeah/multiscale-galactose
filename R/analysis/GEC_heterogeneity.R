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

plot(gec_data20$Q_sinunit[idx]/gec_data20$Vol_sinunit[idx], gec_data20$CL[idx], pch=16, col=rgb(0.5, 0.5,0.5, 0.5),
     main="Galactose Challenge 2.0 [mM], age=20 [yr]")


# Boxplot of galactose clearance
# --------------------------------------
f_tissue <- 0.85
gal_chal <- 2.0
perfusion_levels <- as.numeric(levels(as.factor(dfs[[1]]$Q_per_vol_units)))

fname <- file.path(ma.settings$dir.base, 'results', 'heterogeneity', paste('GE_heterogeneity_', gal_chal, 'mM.png', sep=""))
png(filename=fname, width=1000, height=1000, units = "px", bg = "white",  res=140)

plot(x=NA, y=NA, type="n",
     main=paste("Galactose Challenge", gal_chal, "[mM]"),
     ylab="GE [µmol/min/ml(tissue)]",
     xlab="Perfusion [ml/min/ml(tissue)]",
     xlim=c(0, max(perfusion_levels)),
     ylim=c(0, max(gec_data20$R/gec_data20$Vol_sinunit*60*f_tissue)),
     font.lab=2, cex.lab=1.4
     )
for (k in 1:length(f_levels)){
  f <- f_levels[k]
  idx <- (gec_data20$gal_challenge == gal_chal & gec_data20$f_flow==f)
  # convert units to [µmol/min/ml(tissue)]
  boxplot(gec_data20$R[idx]/gec_data20$Vol_sinunit[idx]*60*f_tissue, at=perfusion_levels[k], boxwex=0.05, col="grey", add=TRUE, axes=F)
}

d <- dfs[[1]]
idx <- d$gal_challenge==gal_chal
points(d$Q_per_vol_units[idx], d$R_per_vol_units[idx], col="blue", pch=15)
lines(d$Q_per_vol_units[idx], d$R_per_vol_units[idx], col="blue")
legend("bottomright", legend=c("tissue mean", "single sinusoids"), pch=15, col=c("blue", "gray"), bty="n")

dev.off()

