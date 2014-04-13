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
# 
#   dlnorm(x, meanlog = 0, sdlog = 1, log = FALSE)
#   plnorm(q, meanlog = 0, sdlog = 1, lower.tail = TRUE, log.p = FALSE) (cumulative distribution)
#   qlnorm(p, meanlog = 0, sdlog = 1, lower.tail = TRUE, log.p = FALSE)
#   rlnorm(n, meanlog = 0, sdlog = 1)
################################################################
results.folder <- "/home/mkoenig/multiscale-galactose-results"
code.folder    <- "/home/mkoenig/multiscale-galactose/R" 
data.folder    <- "/home/mkoenig/multiscale-galactose/experimental_data/parameter_distributions"
setwd(results.folder)

###############################################################
# parameter distribution generators
###############################################################

# parameters are lognormal distributed 
stdlog <- function(m, std){
  stdlog <- sqrt(log(1 + std^2/m^2))
} 
meanlog <- function(m, std){
  meanlog <- log(m^2/sqrt(std^2+m^2))
}

# Create data frame for the theoretical distributions
# TODO: Update the python simulation scripts to generate the proper datasets
# TODO: write the table with the meanlog and stdlog
name = c('L', 'y_sin', 'y_dis', 'y_cell', 'flow_sin')
mean = c(500E-6, 4.4E-6, 0.81E-6, 7.58E-6, 270E-6)
std  = c(125E-6, 0.45E-6, 0.3E-6, 1.25E-6, 58E-6)
unit = c('m', 'm' ,'m', 'm', 'm/s')
scale_fac = c(1E6, 1E6, 1E6, 1E6, 1E6)
scale_unit = c('µm', 'µm' ,'µm', 'µm', 'µm/s')

# Calcualte based on transformation formulas
meanlog = meanlog(mean*scale_fac, std*scale_fac)
stdlog   = stdlog(mean*scale_fac, std*scale_fac)
p.gen <- data.frame(name, mean, std, unit, meanlog, stdlog, scale_fac, scale_unit)
rownames(p.gen) <- name

# Set fitted data (see below for fit)
p.gen['y_sin', 'meanlog'] = 1.465
p.gen'y_sin', 'stdlog']  = 0.1017
p.gen['y_cell', 'meanlog'] = 2.030
p.gen'y_cell', 'stdlog'] = 0.1320
p.gen'flow_sin', 'meanlog'] = 5.457
p.gen'flow_sin', 'stdlog'] = 0.6188

p.gen





# log normal distribution
Np = length(name) 
png(filename=paste("Parameter_Distributions.png", sep=""),
    width = 800, height = 2500, units = "px", bg = "white",  res = 150)
par(mfrow=c(Np,2))
for (kp in seq(Np)){
  mean <- p.gen$mean[kp]
  std <- p.gen$std[kp]
  meanlog <- p.gen$meanlog[kp]
  stdlog <- p.gen$stdlog[kp]
  
  x <- seq(from=1E-12, to=2*mean, length.out=1000)
  y <- dlnorm(x, meanlog=meanlog, sdlog=stdlog, log = FALSE)
  xlab <- paste(p.gen$name[kp], ' [', p.gen$unit[kp]  ,']', sep="")
  
  # scale to check the values are correct
  fac <- p.gen$scale_fac[kp]
  xlab_scale <- paste(p.gen$name[kp], ' [', p.gen$scale_unit[kp]  ,']', sep="")
  x_scale <- x*fac
  mean_scale <- mean*fac
  std_scale <- std*fac
  
  # plot the histogramm (frequencies)
  xdata <- rlnorm(2000, meanlog=meanlog, sdlog=stdlog)
  xdata_scale <- xdata*fac
  hist(xdata_scale[xdata_scale<=2*mean_scale], breaks=15, plot=FALSE)
  hist(xdata_scale[xdata_scale<=2*mean_scale], breaks=15, plot=TRUE, freq=TRUE, xlim=c(0, 2*mean_scale), main=p.gen$name[kp], xlab=xlab_scale)
  
  # plot distribution
  plot(x_scale, y/max(y), xlab=xlab_scale, type='l', lty=1, lwd=2, main=p.gen$name[kp])
  
  # TODO: check the normal distribution of log(x) ??? why not
  # TODO: check the stds and means
  # if random variable X is log-normally distributed than y = log(x) has a normal
  # distribution
  # yn = (log(y)-meanlog)/stdlog
  yn = log(y)
  # points(x_scale, yn/max(yn) , col="red", type='l', lty=1, lwd=2)
  
  
  # plot the mean line and std lines (experimental data ranges)
  lcolor = "blue"
  abline(v=mean_scale, lty=2, col=lcolor, lwd=2)
  abline(v=mean_scale+std_scale, lty=2, col=lcolor, lwd=1)
  abline(v=mean_scale-std_scale, lty=2, col=lcolor, lwd=1)
  
  # abline(v=mean, lty=2, col=lcolor, lwd=1)
  
}
par(mfrow=c(1,1))
dev.off()


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


### Histogramm helper functions ###
# generate data vector from histogramm (this is ugly, but individual data is not
# available, so generate individual data in the middle of the bin for the count number)
createDataFromHistogramm <- function(dset) {
  data <- data.frame(x=numeric(0))
  for (kr in seq(1, nrow(dset)) ){
    for (kc in seq(1, ncol(dset)) ){
      count = dset[kr, kc]
      value = as.numeric( colnames(dset)[kc])
      tmp <- data.frame(x=rep(value, count))
      data <- rbind(data, tmp)
    }
  }
  data
}

# Calculate the breakpoints if the histogram data is given via equidistant
# midpoints
getBreakPointsFromMidpoints <- function(midpoints){
  breaklength = (midpoints[2]-midpoints[1])
  breaks = seq(from=midpoints[1]-0.5*breaklength, 
               to=midpoints[length(midpoints)]+0.5*breaklength, 
               length.out=length(midpoints)+1)
}

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

# TODO: analyse with QQplot if fits to the distribution


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

### Data preparation ##########################################################################
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

p.gen

###############################################################
# TODO: basic testing
# basic tests
# TODO
# rm(list=ls())
x <- seq(from=1E-12, to=1000, length.out=1000)
# y <- dlnorm(x, meanlog=0, sdlog=0.25, log = FALSE)
y <- dlnorm(x, meanlog=log(500), sdlog=0.1, log = FALSE)
plot(x,y, lty=1, type="l") #  ylim=c(-5,2)
# points(x, log(y), col="red", type='l', lty=1, lwd=2)
log(500)
exp(0.1)


###############################################################
# Load the simulated parameter distribution
###############################################################


###############################################################
# Plot experimental data with simulations
###############################################################
