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
data.folder    <- "/home/mkoenig/multiscale-galactose/experimental_data/parameter_distributions/"

setwd(results.folder)

###############################################################
# parameter distribution generators
###############################################################
# This are the values reported in the publication and used to 
# generate the simulated parameter distr
# L        500µm    125µm
# y_sin    4.4µm    0.45µm
# y_dis    0.8µm    0.3µm
# y_cell   6.9µm    1.25µm
# flow_sin    200µm/s    50µm/s

# parameters are lognormal distributed 
stdlog <- function(m, std){
  stdlog <- sqrt(log(1 + std^2/m^2))
} 
meanlog <- function(m, std){
  stdlog <- stdlog(m, std)
  # meanlog <- log(m) - stdlog^2/2
  meanlog <- log(m^2/sqrt(std^2+m^2))
}

# Create data frame for the theoretical distributions
name = c('L', 'y_sin', 'y_dis', 'y_cell', 'flow_sin')
mean = c(500E-6, 4.4E-6, 0.8E-6, 6.9E-6, 200E-6)
std  = c(125E-6, 0.45E-6, 0.3E-6, 1.25E-6, 200E-6)
unit = c('m', 'm' ,'m', 'm', 'm/s')
scale_fac = c(1E6, 1E6, 1E6, 1E6, 1E6)
scale_unit = c('µm', 'µm' ,'µm', 'µm', 'µm/s')

meanlog = meanlog(mean, std)
stdlog   = stdlog(mean, std)
p.gen <- data.frame(name, mean, std, unit, meanlog, stdlog, scale_fac, scale_unit)
rownames(p.gen) <- name


# log normal distribution
Np = length(name) 
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
  hist(xdata_scale[xdata_scale<=2*mean_scale], breaks=15, plot=FALSE, freq=TRUE)
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
  
  
  # plot the mean line and std lines
  lcolor = "gray"
  abline(v=mean_scale, lty=2, col=lcolor, lwd=2)
  abline(v=mean_scale+std_scale, lty=2, col=lcolor, lwd=1)
  abline(v=mean_scale-std_scale, lty=2, col=lcolor, lwd=1)
  
  # abline(v=mean, lty=2, col=lcolor, lwd=1)
  
}
par(mfrow=c(1,1))




# basic tests
# rm(list=ls())
x <- seq(from=1E-12, to=1000, length.out=1000)
# y <- dlnorm(x, meanlog=0, sdlog=0.25, log = FALSE)
y <- dlnorm(x, meanlog=log(500), sdlog=0.1, log = FALSE)
plot(x,y, lty=1, type="l") #  ylim=c(-5,2)
# points(x, log(y), col="red", type='l', lty=1, lwd=2)
log(500)
exp(0.1)

###############################################################
# Load experimental data
###############################################################





###############################################################
# Load the simulated parameter distribution
###############################################################


###############################################################
# Plot experimental data with simulations
###############################################################
