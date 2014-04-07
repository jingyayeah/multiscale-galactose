rm(list=ls())   # Clear all objects
setwd("/home/mkoenig/multiscale-galactose-results/")

################################################################
## Galactose Clearance & Elimination Curves ##
################################################################
# author: Matthias Koenig
# date: 2014-04-07

# TODO: Read about the galactose elimination rates
# TODO: [mcg/ml] -> [mmole/L]

# load the experimental data Schirmer1986 from csv
folder = "/home/mkoenig/multiscale-galactose/experimental_data/galactose_clearance"
names = c("Fig1", "Fig2", "Fig4", "Fig6")

################################################################
png(filename=paste("Galactose_Extraction.png", sep=""),
     width = 1000, height = 1000, units = "px", bg = "white",  res = 150)
par(mfrow=c(2,2))

# Galactose  GE
# [mcg/ml]  [mcg/min/100g]
fig1 <- read.csv(paste(folder, "/", "Schirmer1986_Fig1.csv", sep=""))
plot(fig1$Galactose, fig1$GE, xlab="galactose [mcg/ml]", ylab="GE [mcg/min/100g]", xlim=c(0.0, 700), ylim=c(0.0, 700) )

# per_Galactose  per_GE
# [ml/mcg *1E4]  [100g*min/mcg*1E4]
fig2 <- read.csv(paste(folder, "/", "Schirmer1986_Fig2.csv", sep=""))
plot(fig2$per_Galactose, fig2$per_GE, xlab="1/galactose [ml/mcg*1E4]", ylab="1/GE [100g*min/mcg*1E4]", xlim=c(-20, 50), ylim=c(0.0, 70))

# Vmax_per_FKm  ER
# [-]  [-]
fig4 <- read.csv(paste(folder, "/", "Schirmer1986_Fig4.csv", sep=""))
plot(fig4[,1], fig4[,2], xlab="Vmax/FKm [-]", ylab="ER [-]", xlim=c(0.0, 5.0), ylim=c(0.0, 1.0))

# Flow  Clearance	ER
# [ml/min/100gm]	[-]	[-]
fig6 <- read.csv(paste(folder, "/", "Schirmer1986_Fig6.csv", sep=""))
plot(fig6[,1], fig6[,2], col="blue", xlab="Flow [ml/min/100gm]", ylab="Clearance [-] | ER [-]", xlim=c(0.0, 50), ylim=c(0.0, 1.0) )
points(fig6[,1], fig6[,3], col="red")

par(mfrow=c(1,1))
dev.off()


