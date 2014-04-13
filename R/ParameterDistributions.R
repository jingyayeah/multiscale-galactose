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
# TODO: Update the python simulation scripts to generate the proper datasets

name = c('L', 'y_sin', 'y_dis', 'y_cell', 'flow_sin')
mean = c(500E-6, 4.4E-6, 0.81E-6, 7.58E-6, 200E-6)
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
  lcolor = "gray"
  abline(v=mean_scale, lty=2, col=lcolor, lwd=2)
  abline(v=mean_scale+std_scale, lty=2, col=lcolor, lwd=1)
  abline(v=mean_scale-std_scale, lty=2, col=lcolor, lwd=1)
  
  # abline(v=mean, lty=2, col=lcolor, lwd=1)
  
}
par(mfrow=c(1,1))
dev.off()

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
# Load experimental data
###############################################################
# load Koo1975
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

# Fit log normal distributions to the loaded data
library(MASS)
Koo1975.all
# generate data vector from histogramm (this is ugly, but individual data is not
# available, so generate individual data in the middle of the bin for the count number)
data <- data.frame(flow=numeric(0))
for (kr in seq(1, nrow(Koo1975.all)) ){
  for (kc in seq(1, ncol(Koo1975.all)) ){
    count = Koo1975.all[kr, kc]
    value = as.numeric( colnames(Koo1975.all)[kc])
    tmp <- data.frame(flow=rep(value, count))
    print(tmp)
    
    data <- rbind(data, tmp)
  }
}

hist(data$flow)              
fit <- fitdistr(data$flow, "lognormal")
fit
# meanlog       sdlog   
# 5.45720754   0.61782097 
# (0.02673573) (0.01890501)

sum(Koo1975.all)
barplot(Koo1975.all/sum(Koo1975.all)/100, main="RBC velocity distribution", xlab="vRBC [µm/s]", ylab="count", col=barcol)
legend("topright",  legend = Koo1975.names, fill=barcol)
x <- seq(from=1E-12, to=2000, length.out=1000)
y <- dlnorm(x, meanlog=5.45720754, sdlog=0.61782097, log = FALSE)
points(x,y, lty=1, type="l")

png(filename=paste("Koo1975_velocity_distribution_fit.png", sep=""),
    width = 800, height = 800, units = "px", bg = "white",  res = 150)
hist(data$flow, main="RBC velocity distribution", xlab="vRBC [µm/s]", ylab="count", freq=FALSE)
points(x,y, lty=1, type="l")
dev.off()


# TODO: analyse with QQplot if fits to the distribution



###############################################################
# load Puhl
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
tmp
p.y_cell
barplot(p.y_cell, main="y_cell distribution", xlab="y_cell [µm]", ylab="[%]")


#### FIT y_cell ###
# generate data vector from histogramm (this is ugly, but individual data is not
# available, so generate individual data in the middle of the bin for the count number)
data <- data.frame(flow=numeric(0))
for (kr in seq(1, nrow(p.y_cell)) ){
  for (kc in seq(1, ncol(p.y_cell)) ){
    count = p.y_cell[kr, kc]
    value = as.numeric( colnames(p.y_cell)[kc])
    tmp <- data.frame(flow=rep(value, count))
    print(tmp)
    data <- rbind(data, tmp)
  }
}
data

hist(data$flow)              
fit <- fitdistr(data$flow, "lognormal")
fit
# meanlog       sdlog   
# 5.963793114   0.079014201 
# (0.007981640) (0.005643871)

x <- seq(from=1E-12, to=2000, length.out=1000)
y <- dlnorm(x, meanlog=5.963793114, sdlog=0.079014201, log = FALSE)
points(x,y, lty=1, type="l")

#png(filename=paste("Koo1975_velocity_distribution_fit.png", sep=""),
#    width = 800, height = 800, units = "px", bg = "white",  res = 150)
p.y_cell
hist(data$flow, main="y_cell", xlab="y_cell [µm]", ylab="count", freq=FALSE, breaks=)
points(x,y, lty=1, type="l")
#dev.off()




# diameter [µm]
p.dia <- rbind(t(Puhl2003.fig3$percent))
colnames(p.dia) <- Puhl2003.fig3$diameter    # [µm]
barplot(p.dia, main="Sinusoid diameter distribution", xlab="sinusoid diameter [µm]", ylab="[%]")

p.y_sin <- p.dia
colnames(p.y_sin) <- Puhl2003.fig3$diameter/2
p.y_sin
barplot(p.y_sin, main="Sinusoid diameter distribution", xlab="sinusoid diameter [µm]", ylab="[%]")

# Fit log normal distributions to the loaded data






###############################################################
# Load the simulated parameter distribution
###############################################################


###############################################################
# Plot experimental data with simulations
###############################################################
