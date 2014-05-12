rm(list=ls())

################################################################
## Galactose Clearance & Elimination Curves ##
################################################################
# author: Matthias Koenig
# date: 2014-04-07
################################################################
results.folder <- "/home/mkoenig/multiscale-galactose-results"
code.folder    <- "/home/mkoenig/multiscale-galactose/R" 
task <- "T1"
modelId <- "Galactose_v8_Nc20_Nf1"
# here the parameter files are stored
info.folder <- '2014-04-08'
# here the ini & csv of the integrations are stored
data.folder <- 'django/timecourse/2014-04-08'

setwd(results.folder)

###############################################################
# Load data
###############################################################

# Load the parameter file & create histogramm of parameters
source(paste(code.folder, '/', 'ParameterFile.R', sep=""))
# Overview of the distribution parameters
summary(pars)


# Load the pp and pv data
source(paste(code.folder, '/', 'ReadDataFunctions.R', sep=""))

dataset_gal.file <- paste(info.folder, '/', modelId, '_gal','.rdata', sep="")
gal_list = readPPPVData()

# List of matrixes
compounds = c('h2oM', 'gal')
ccolors = c('darkblue', 'black')
prefixes = c('PP__', 'PV__')

galmat <- createDataMatrices(gal_list, compounds=compounds, prefixes=prefixes)
save.image(file=dataset_gal.file)
tail(galmat)

# Plot the timecourses
#png(filename=paste(info.folder, '/', task, "_Dilution_Curves.png", sep=""),
#    width = 4000, height = 1000, units = "px", bg = "white",  res = 200)
source(paste(code.folder, '/', 'PlotDataFunctions.R', sep=""))
plotAllTimecourses(galmat, compounds, ylim=c(0,6))

indices = which(pars$deficiency==0)
hist(pars$deficiency)

length(indices)
summary(pars[indices,] )

plotTimecourses(galmat[['PV__gal']][,indices], main="PV__gal'", ylim=c(0,6))
test <- pars[indices,]
hist(test$PP__gal,breaks=20)

tail(test)


)###############################################################
# Calculate the clearance parameters 
###############################################################
# Create data frame for calculation
# extend the pars

get_c_in <- function(){
  data <- galmat[['PP__gal']]
  dims <- dim(data)
  c_in <- data[dims[1],]
}

get_c_out <- function(){
  data <- galmat[['PV__gal']]
  dims <- dim(data)
  c_in <- data[dims[1],]
}

c_out <- get_c_out()
c_in <- get_c_in()
# plot(c_out, c_in)

FL = pars$flow_sin * 1E6 # TODO: recalculate with the actual flow values

parscl <- pars

parscl$FL <- FL   
parscl$c_in <- c_in
parscl$c_out <- c_out
parscl$R <- FL * (c_in - c_out)
parscl$ER <- (c_in - c_out)/c_in
parscl$CL <- FL * (c_in - c_out)/c_in
parscl$GE <- (c_in - c_out)

names(parscl)

# Calculate the clearance parameters
# F = flow_sin              # [µm/sec]
# c_in = 'PP__gal'[end]     # [mmol/l]
# c_out = 'PV_gal[end]'          # [mmol/l]
# R = F*(c_in - c_out)      # [m/sec * mmol/l]
# ER = (c_in - c_out)/c_in  # [-]
# CL = R/c_in               # [µm/sec]
# GE = (c_in - c_out) 

# This parameters have to be scaled to the total liver



#
ptest <- parscl[which(parscl$deficiency==0),]
# Created Figure
par(mfrow=c(2,2))
plot(ptest$c_in, ptest$GE, xlab="periportal galactose [mmol/l]", ylab="Galactose Elimination (GE) [mmol/l]")
plot(ptest$FL, ptest$GE, xlab="sinusoidal blood flow [µm/sec]", ylab="Galactose Elimination (GE) [mmol/l]")
plot(ptest$FL, ptest$ER, xlab="sinusoidal blood flow [µm/sec]", ylab="Extraction Ratio (ER) [-]")
plot(ptest$FL, ptest$CL, xlab="sinusoidal blood flow [µm/sec]", ylab="Clearance (CL) [µm/sec]") 
par(mfrow=c(1,1))



###############################################################

# Experimental data (Schirmer1986) #
# TODO: [mcg/ml] -> [mmole/L]

# load the experimental data Schirmer1986 from csv
folder = "/home/mkoenig/multiscale-galactose/experimental_data/galactose_clearance"
names = c("Fig1", "Fig2", "Fig4", "Fig6")

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

# Flow  Clearance  ER
# [ml/min/100gm]	[-]	[-]
fig6 <- read.csv(paste(folder, "/", "Schirmer1986_Fig6.csv", sep=""))
plot(fig6[,1], fig6[,2], col="blue", xlab="Flow [ml/min/100gm]", ylab="Clearance [-] | ER [-]", xlim=c(0.0, 50), ylim=c(0.0, 1.0) )
points(fig6[,1], fig6[,3], col="red")

par(mfrow=c(1,1))
dev.off()

###############################################################




