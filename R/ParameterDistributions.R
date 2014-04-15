rm(list=ls())
################################################################
## Parameter Distributions ##
################################################################
# author: Matthias Koenig
# date: 2014-04-13
#
# Distributions are assumed to be lognormal distributed
# Density, distribution function, quantile function and random generation 
# for the log normal distribution whose logarithm has mean equal to meanlog 
# and standard deviation equal to sdlog.
# Log-normal distributions are fitted to the experimental histogramm data.
# 
#   dlnorm(x, meanlog = 0, sdlog = 1, log = FALSE)
#   plnorm(q, meanlog = 0, sdlog = 1, lower.tail = TRUE, log.p = FALSE) (cumulative distribution)
#   qlnorm(p, meanlog = 0, sdlog = 1, lower.tail = TRUE, log.p = FALSE)
#   rlnorm(n, meanlog = 0, sdlog = 1)
################################################################

library(MultiscaleAnalysis)

dname <-'2014-04-13_Dilution_Curves' 
task <- 'T3'
modelId <- 'Dilution_Test'

# Set the folders
setwd(ma.settings$dir.results)
ma.settings$dir.simdata <- file.path(ma.settings$dir.results, dname)

# load the parameter file
pars <- loadParsFile(ma.settings$dir.simdata, task=task, modelId=modelId)
head(pars)

###############################################################
# parameter distribution generators
###############################################################
# TODO: Update the python simulation scripts to generate the proper datasets

# Create data frame for the theoretical distributions
name = c('L', 'y_sin', 'y_dis', 'y_cell', 'flow_sin')
mean = c(500E-6, 4.4E-6, 1.2E-6, 7.58E-6, 270E-6)
std  = c(125E-6, 0.45E-6, 0.4E-6, 1.25E-6, 58E-6)
unit = c('m', 'm' ,'m', 'm', 'm/s')
scale_fac = c(1E6, 1E6, 1E6, 1E6, 1E6)
scale_unit = c('µm', 'µm' ,'µm', 'µm', 'µm/s')

# meanlog and meanstd are for the scaled variables, i.e. in scale_units
meanlog = meanlog(mean*scale_fac, std*scale_fac)
stdlog   = stdlog(mean*scale_fac, std*scale_fac)
p.gen <- data.frame(name, mean, std, unit, meanlog, stdlog, scale_fac, scale_unit)
rownames(p.gen) <- name
p.gen$name <- as.character(p.gen$name)
rm(name, mean, std, unit, scale_fac, scale_unit, meanlog, stdlog)

# TODO: write the table with the meanlog and stdlog
# Set fitted data (see below for fit)
p.gen['y_sin', 'meanlog'] = 1.465
p.gen['y_sin', 'stdlog']  = 0.1017
p.gen['y_cell', 'meanlog'] = 2.030
p.gen['y_cell', 'stdlog'] = 0.1320
p.gen['flow_sin', 'meanlog'] = 5.457
p.gen['flow_sin', 'stdlog'] = 0.6188
p.gen

###############################################################
# Load experimental data
###############################################################
# Koo1975 #
Koo1975.names = c('branching', 'interconnecting', 'direct')
Koo1975.branching <- read.csv(paste(data.folder, "/", "Koo1975_Fig1_branching.csv", sep=""), sep="\t")
Koo1975.inter <- read.csv(paste(data.folder, "/", "Koo1975_Fig1_interconnecting.csv", sep=""), sep="\t")
Koo1975.direct <- read.csv(paste(data.folder, "/", "Koo1975_Fig1_direct.csv", sep=""), sep="\t")

Koo1975.all = rbind(t(Koo1975.branching$count), t(Koo1975.inter$count), t(Koo1975.direct$count))
colnames(Koo1975.all) <- Koo1975.branching$velocity
rownames(Koo1975.all)<-Koo1975.names
Koo1975.all

# R stacked bar plot
#png(filename=paste("Koo1975_velocity_distribution.png", sep=""),
#    width = 800, height = 800, units = "px", bg = "white",  res = 150)
barcol <- gray.colors(length(Koo1975.names))
barplot(Koo1975.all, main="RBC velocity distribution", xlab="vRBC [µm/s]", ylab="count", col=barcol)
legend("topright",  legend = Koo1975.names, fill=barcol)
#dev.off()


### FIT flow_sin #################################################################################
library(MASS)
data <- createDataFromHistogramm(Koo1975.all)
hist(data$x)              
fit <- fitdistr(data$x, "lognormal")
fit
# meanlog       sdlog   
# 5.45720754   0.61782097 
# (0.02673573) (0.01890501)
barplot(Koo1975.all/sum(Koo1975.all)/100, main="RBC velocity distribution", xlab="vRBC [µm/s]", ylab="count", col=barcol)
legend("topright",  legend = Koo1975.names, fill=barcol)
x <- seq(from=1E-12, to=2000, length.out=1000)
y <- dlnorm(x, meanlog=5.45720754, sdlog=0.61782097, log = FALSE)
points(x,y, lty=1, type="l")

#png(filename=paste("Koo1975_flow_sin_distribution_fit.png", sep=""),
#    width = 800, height = 800, units = "px", bg = "white",  res = 150)
name = 'flow_sin'
midpoints = as.numeric(colnames(Koo1975.all))
hist(data$x, main="RBC velocity distribution", xlab="vRBC [µm/s]", ylab="count", freq=FALSE, 
     breaks=getBreakPointsFromMidpoints(midpoints))
points(x,y, lty=1, type="l")
mean <- p.gen[name, "mean"]
std <- p.gen[name, "std"]
fac <- p.gen[name, "scale_fac"]

abline(v=mean*fac, lty=1, col=lcolor, lwd=2)
abline(v=(mean+std)*fac, lty=2, col=lcolor, lwd=1)
abline(v=(mean-std)*fac, lty=2, col=lcolor, lwd=1)
#dev.off()


###############################################################
# Puhl2003 #
###############################################################
library(MASS)
# velocity [mm/s], [%]
Puhl2003.fig2 <- read.csv(paste(data.folder, "/", "Puhl2003_Fig2.csv", sep=""), sep="\t", colClasses="numeric")
# fsd [1/cm], [%]
Puhl2003.fig4 <- read.csv(paste(data.folder, "/", "Puhl2003_Fig4.csv", sep=""), sep="\t", colClasses="numeric")
# diameter [µm]
Puhl2003.fig3 <- read.csv(paste(data.folder, "/", "Puhl2003_Fig3.csv", sep=""), sep="\t", colClasses="numeric")

# RBC velocity in [µm/s]
p.vel <- rbind(t(Puhl2003.fig2$percent))
colnames(p.vel) <- Puhl2003.fig2$velocity*1000    # [µm/s]
barplot(p.vel, main="RBC velocity distribution", xlab="vRBC [µm/s]", ylab="[%]")

# fsd in [1/cm], means in [µm]
p.fsd <- rbind(t(Puhl2003.fig4$percent))
colnames(p.fsd) <- Puhl2003.fig4$FSD    # [1/cm]
barplot(p.fsd, main="FSD distribution", xlab="FSD [1/cm]", ylab="[%]")

# cell layer [µm]
p.y_cell <- p.fsd
tmp <- 1E4/(2*Puhl2003.fig4$FSD) -1E6*(p.gen["y_sin", "mean"] + p.gen["y_dis", "mean"]) 
colnames(p.y_cell) <- t(tmp)
rm(tmp)
barplot(p.y_cell, main="y_cell distribution", xlab="y_cell [µm]", ylab="[%]")

# sinusoidal diameter [µm]
p.dia <- rbind(t(Puhl2003.fig3$percent))
colnames(p.dia) <- Puhl2003.fig3$diameter    # [µm]
barplot(p.dia, main="Sinusoid diameter distribution", xlab="sinusoid diameter [µm]", ylab="[%]")

# sinusoidal radius [µm]
p.y_sin <- p.dia
colnames(p.y_sin) <- Puhl2003.fig3$diameter/2
barplot(p.y_sin, main="Sinusoid radius distribution", xlab="sinusoid radius [µm]", ylab="[%]")


### FIT y_cell #################################################################################
data <- createDataFromHistogramm(p.y_cell)
fit <- fitdistr(data$x, "lognormal")
fit
# meanlog        sdlog   
# 2.029971370   0.131976775 
# (0.013331668) (0.009426912)
lcolor = "blue"
png(filename=paste("Puhl2003_y_cell_fit.png", sep=""),
    width = 800, height = 800, units = "px", bg = "white",  res = 150)
name = 'y_cell';
# histogramm
midpoints = as.numeric(colnames(p.y_cell))
hist(data$x, main=name, xlab="y_cell [µm]", freq=FALSE, 
     breaks=getBreakPointsFromMidpoints(midpoints), 
     ylim=c(0,1), xlim=c(4,12))
# distribution
x <- seq(from=1E-12, to=3*max(data), length.out=1000)
y <- dlnorm(x, meanlog=fit$estimate["meanlog"], sdlog=fit$estimate["sdlog"], log = FALSE)
points(x,y, lty=1, type="l")
# plot the mean line and std lines (experimental data ranges)
mean <- p.gen[name, "mean"]
std <- p.gen[name, "std"]
fac <- p.gen[name, "scale_fac"]

abline(v=mean*fac, lty=1, col=lcolor, lwd=2)
abline(v=(mean+std)*fac, lty=2, col=lcolor, lwd=1)
abline(v=(mean-std)*fac, lty=2, col=lcolor, lwd=1)
dev.off()

#### FIT y_sin #################################################################################
data <- createDataFromHistogramm(p.y_sin)
fit <- fitdistr(data$x, "lognormal")
fit
# meanlog        sdlog   
# 1.465273310   0.101714488 
# (0.010274715) (0.007265321)
png(filename=paste("Puhl2003_y_sin_fit.png", sep=""),
    width = 800, height = 800, units = "px", bg = "white",  res = 150)
name = 'y_sin'
# histogramm
midpoints = as.numeric(colnames(p.y_sin))
hist(data$x, main="y_sin", xlab="y_sin [µm]", freq=FALSE, 
     breaks=getBreakPointsFromMidpoints(midpoints), 
     ylim=c(0,1))
# distribution
x <- seq(from=1E-12, to=3*max(data), length.out=1000)
y <- dlnorm(x, meanlog=fit$estimate["meanlog"], sdlog=fit$estimate["sdlog"], log = FALSE)
points(x,y, lty=1, type="l")
# plot the mean line and std lines (experimental data ranges)
mean <- p.gen[name, "mean"]
std <- p.gen[name, "std"]
fac <- p.gen[name, "scale_fac"]

abline(v=mean*fac, lty=1, col=lcolor, lwd=2)
abline(v=(mean+std)*fac, lty=2, col=lcolor, lwd=1)
abline(v=(mean-std)*fac, lty=2, col=lcolor, lwd=1)
dev.off()

# TODO: analyse with QQplot if fits to the distribution


###############################################################
# Here everything comes together
# log normal distribution from given parameters
# This is the check if parameters were fitted properly.
# TODO: plot all the data in one image (parameters, exp data and distribution)
Np = nrow(p.gen) 
png(filename=paste("Parameter_Distributions.png", sep=""),
     width = 800, height = 2000, units = "px", bg = "white",  res = 150)
par(mfrow=c(Np,2))
for (kp in seq(Np)){
  name <- p.gen$name[kp]
  mean <- p.gen$mean[kp]
  std  <- p.gen$std[kp]
  fac <- p.gen$scale_fac[kp]
  meanlog <- p.gen$meanlog[kp]
  stdlog  <- p.gen$stdlog[kp]
  
  # scale to check the values are correct
  xlab_scale <- paste(p.gen$name[kp], ' [', p.gen$scale_unit[kp]  ,']', sep="")
  
  # plot the histogramm (frequencies)
  xdata <- rlnorm(2000, meanlog=meanlog, sdlog=stdlog)
  xdata <- xdata[xdata <= 2*mean*fac]
  # not used
  
  # plot distribution
  x <- seq(from=1E-12, to=2*mean*fac, length.out=1000)
  y <- dlnorm(x, meanlog=meanlog, sdlog=stdlog, log = FALSE)
  
  # use the parameters data
  xdata <- pars[[name]]*fac
  
  hdata <- hist(xdata, breaks=15, plot=FALSE)
  hdata$counts <- hdata$counts/max(hdata$count)
  hdata
  plot(hdata, xlim=c(0, 2*mean*fac), main=name, xlab=xlab_scale)
  # hist(xdata, breaks=15, plot=TRUE, freq=TRUE, xlim=c(0, 2*mean*fac), main=name, xlab=xlab_scale)
  lcolor = "blue"
  abline(v=mean*fac, lty=1, col=lcolor, lwd=2)
  abline(v=(mean+std)*fac, lty=2, col=lcolor, lwd=1)
  abline(v=(mean-std)*fac, lty=2, col=lcolor, lwd=1)
  points(x, y/max(y), xlab=xlab_scale, type='l', lty=1, lwd=2, main=p.gen$name[kp])
  
  plot(x, y/max(y), xlab=xlab_scale, type='l', lty=1, lwd=2, main=p.gen$name[kp])
    
  # plot the mean line and std lines (experimental data ranges)
  abline(v=mean*fac, lty=1, col=lcolor, lwd=2)
  abline(v=(mean+std)*fac, lty=2, col=lcolor, lwd=1)
  abline(v=(mean-std)*fac, lty=2, col=lcolor, lwd=1)
}
par(mfrow=c(1,1))
dev.off()
###############################################################