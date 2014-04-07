rm(list=ls())   # Clear all objects
setwd("/home/mkoenig/multiscale-galactose-results/")

################################################################
## Galactose Clearance & Elimination Curves ##
################################################################
# author: Matthias Koenig
# date: 2014-04-07

# load the experimental data Schirmer1986 from csv
folder = "/home/mkoenig/multiscale-galactose/experimental_data/galactose_clearance"

# Schirmer_Fig1
# Galactose  GE
# [mcg/ml]	[mcg/min/100g]
fig1 <- read.csv(paste(folder, "/", "Schirmer1986_Fig1.csv", sep=""))
head(fig1)
names(fig1)
plot(fig1$Galactose, fig1$GE)

# Schirmer_Fig2
# per_Galactose  per_GE
# [ml/mcg *1E4]	[100g*min/mcg*1E4]
fig2 <- read.csv(paste(folder, "/", "Schirmer1986_Fig2.csv", sep=""))
head(fig2)
names(fig2)
plot(fig2$per_Galactose, fig2$per_GE)

# Schirmer_Fig4
# Vmax_per_FKm  ER
# [-]	[-]
fig4 <- read.csv(paste(folder, "/", "Schirmer1986_Fig4.csv", sep=""))
head(fig4)
names(fig4)
plot(fig4[,1], fig4[,2])

# Schirmer_Fig6  	
# Flow	Clearance	ER
# [ml/min/100gm]	[-]	[-]
fig6 <- read.csv(paste(folder, "/", "Schirmer1986_Fig6.csv", sep=""))
head(fig6)
names(fig6)
plot(fig6[,1], fig6[,2])
points(fig6[,1], fig6[,3])
################################################################


