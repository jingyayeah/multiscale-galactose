################################################################
## Galactose Clearance & Elimination Curves ##
################################################################
# Analysis of the galactose elimination simulations with varying
# galactose and varying blood flow
#
# author: Matthias Koenig
# date: 2014-05-13
################################################################
rm(list=ls())
library(data.table)
library(libSBML)
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)

###########################################################################
# load parameters
###########################################################################
sname <- '2014-05-13_Galactose'
ma.settings$dir.simdata <- file.path(ma.settings$dir.results, sname, 'data')
load_with_sims = FALSE;
task = 'T30'
modelId <- 'Galactose_v18_Nc20_Nf1'
parsfile <- file.path(ma.settings$dir.results, sname, 
                      paste(task, '_', modelId, '_parameters.csv', sep=""))

pars <- loadParameterFile(parsfile)
print(summary(pars))
names(pars)
summary(pars)
plotParameterHistogramFull(pars)

###############################################################
# preprocess data
###############################################################
# preprocess all columns
outFile <- preprocess(parsfile, ma.settings$dir.simdata)

# load the preprocessed data
outFile <- outfileFromParsFile(parsfile)
load(outFile)


###############################################################
# Calculate the clearance parameters 
###############################################################
# F = flow_sin              # [µm/sec]
# c_in = 'PP__gal'[end]     # [mmol/l]
# c_out = 'PV_gal[end]'          # [mmol/l]
# R = F*(c_in - c_out)      # [m/sec * mmol/l]
# ER = (c_in - c_out)/c_in  # [-]
# CL = R/c_in               # [µm/sec]
# GE = (c_in - c_out) 

# get the last timepoint of the component
get_last_timepoint <- function(name){
  data <- preprocess.mat[[name]]
  dims <- dim(data)
  res <- data[dims[1],]
}

c_in <- get_last_timepoint('PP__gal')
c_out <- get_last_timepoint('PV__gal')
FL <- pars$flow_sin # TODO: use correct volume flow

parscl <- pars
parscl$FL <- FL
parscl$c_in <- c_in
parscl$c_out <- c_out
parscl$R <- FL * (c_in - c_out)
parscl$ER <- (c_in - c_out)/c_in
parscl$CL <- FL * (c_in - c_out)/c_in
parscl$GE <- (c_in - c_out)

names(parscl)

# This parameters have to be scaled to the total liver
ptest <- parscl[which(parscl$deficiency==0),]
head(pars)
pars$flow_sin <- factor(pars$flow_sin)
levels(pars$flow_sin)
pars$flow_sin

# Get the additional information for the parameters
names(pars)



# Created Figure
par(mfrow=c(2,2))
  plot(ptest$c_in, ptest$GE, xlab="periportal galactose [mmol/l]", ylab="Galactose Elimination (GE) [mmol/l]")
  plot(ptest$flow_sin, ptest$GE, xlab="sinusoidal blood flow [µm/sec]", ylab="Galactose Elimination (GE) [mmol/l]")
  plot(ptest$FL, ptest$ER, xlab="sinusoidal blood flow [µm/sec]", ylab="Extraction Ratio (ER) [-]")
  plot(ptest$FL, ptest$CL, xlab="sinusoidal blood flow [µm/sec]", ylab="Clearance (CL) [µm/sec]") 
par(mfrow=c(1,1))

par(mfrow=c(1,2))
plot(ptest$c_in, ptest$GE, xlab="periportal galactose [mmol/l]", ylab="Galactose Elimination (GE) [mmol/l]")
plot(ptest$flow_sin, ptest$GE, xlab="sinusoidal blood flow [µm/sec]", ylab="Galactose Elimination (GE) [mmol/l]")
par(mfrow=c(1,1))

par(mfrow=c(1,2))
plot(ptest$FL, ptest$ER, xlab="sinusoidal blood flow [µm/sec]", ylab="Extraction Ratio (ER) [-]")
plot(ptest$FL, ptest$CL, xlab="sinusoidal blood flow [µm/sec]", ylab="Clearance (CL) [µm/sec]") 
par(mfrow=c(1,1))


plot(ptest$c_in, ptest$GE, xlab="periportal galactose [mmol/l]", ylab="Galactose Elimination (GE) [mmol/l]")
# plot the ones connected which are similar


install.packages('lattice')
data <- list()
data$x = ptest$c_in
data$y = ptest$flow_sin
data$z = ptest$GE
# data$z = ptest$ER
# data$z <- ptest$CL
zlab <- 'GE'

library(lattice)
wireframe(z ~ x * y, data=data, xlab="PP galactose [mM]", ylab="blood flow",
          zlab="GE")
p <- wireframe(z ~ x * y, data=data, xlab="PP galactose [mM]", ylab="blood flow",zlab=zlab)
npanel <- c(4, 2)
rotx <- c(-50, -80)
rotz <- seq(30, 300, length = npanel[1]+1)
update(p[rep(1, prod(npanel))], layout = npanel,
       panel = function(..., screen) {
         panel.wireframe(..., screen = list(z = rotz[current.column()],
                                            x = rotx[current.row()]))
       })



inds <- which(pars$flow_sin==2e-04)
inds
points(ptest$c_in[inds], ptest$GE[inds], col='blue')
head(pars)

######################################
plot(pars$flow_sin, (c_in-c_out)/c_in)

index = which( abs(pars$flow_sin-200E-6)<1E-10)
index
pars[index, ]
plot(c_in[index], c_in[index]-c_out[index])
plot(pars$flow_sin[index], (c_in[index]-c_out[index])/c_in[index])
summary(pars$flow_sin)



###############################################################
# Experimental data (Schirmer1986) #
# TODO: [mcg/ml] -> [mmole/L]

create_plot_files = T

# load the experimental data Schirmer1986 from csv
folder = "/home/mkoenig/multiscale-galactose/experimental_data/GEC"
names = c("Fig1", "Fig2", "Fig4", "Fig6")

if (create_plot_files == T){
  png(filename=paste("Galactose_Extraction.png", sep=""),
    width = 1000, height = 1000, units = "px", bg = "white",  res = 150)
}
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

# Flow  Clearance  ER
# [ml/min/100gm]	[-]	[-]
fig6 <- read.csv(paste(folder, "/", "Schirmer1986_Fig6.csv", sep=""))
plot(fig6[,1], fig6[,2], col="blue", xlab="Flow [ml/min/100gm]", ylab="Clearance [-] | ER [-]", xlim=c(0.0, 50), ylim=c(0.0, 1.0) )
points(fig6[,1], fig6[,3], col="red")

par(mfrow=c(1,1))
if (create_plot_files == T){
  dev.off()
}
###############################################################
