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
library(MASS)
setwd(ma.settings$dir.results)
histc = rgb(1.0, 0.0, 0.0, 0.25)

###############################################################
# parameter values used in simulations
###############################################################
p.gen <- generateLogStandardParameters()
p.gen

###############################################################
# load simulated parameters
###############################################################
dname <-'2014-04-13_Dilution_Curves' 
task <- 'T3'
modelId <- 'Dilution_Test'
ma.settings$dir.simdata <- file.path(ma.settings$dir.results, dname)
pars <- loadParsFile(ma.settings$dir.simdata, task=task, modelId=modelId)
head(pars)

###############################################################
# Load experimental data
###############################################################
# Koo1975 #
Koo1975.names = c('branching', 'interconnecting', 'direct')
for (name in Koo1975.names){
  varname <- paste("Koo1975.", name, sep="");
  csvname <- file.path(ma.settings$dir.expdata, 'parameter_distributions', paste('Koo1975_Fig1_', name,'.csv', sep=''))
  data <- read.csv(csvname, sep= '\t')
  assign(varname, data)   
}
Koo1975.all = rbind(t(Koo1975.branching$count), t(Koo1975.interconnecting$count), t(Koo1975.direct$count))
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
name = 'flow_sin'
data <- createDataFromHistogramm(Koo1975.all)             
fit <- fitdistr(data$x, "lognormal")
fit
# Store fit parameter
p.gen[name, 'meanlog'] = fit$estimate['meanlog']
p.gen[name, 'sdlog'] = fit$estimate['sdlog']
p.gen[name, 'meanlog_error'] = fit$sd['meanlog']
p.gen[name, 'sdlog_error'] = fit$sd['sdlog']
p.gen
fit$sd['sdlog']

plot(numeric(0), numeric(0),  main="RBC velocity distribution", 
     xlab="vRBC [µm/s]", ylab="count", 
     xlim=c(0, max(data$x)), ylim=c(0, 0.004),
     col=barcol)
midpoints = as.numeric(colnames(Koo1975.all))
plotHistWithFit(p.gen, name, data=data, midpoints=midpoints,
                fit=fit, histc=histc)
# add the parameter hist


legend("topright",  legend = c('Koo1975'), fill=histc)


###############################################################
# Puhl2003 #
###############################################################
library(MASS)
# velocity [mm/s], [%]
csvname <- file.path(ma.settings$dir.expdata, 'parameter_distributions', paste('Puhl2003_Fig2.csv', sep=''))
Puhl2003.fig2 <- read.csv(csvname, sep="\t", colClasses="numeric")

# fsd [1/cm], [%]
csvname <- file.path(ma.settings$dir.expdata, 'parameter_distributions', paste('Puhl2003_Fig4.csv', sep=''))
Puhl2003.fig4 <- read.csv(csvname, sep="\t", colClasses="numeric")

# diameter [µm]
csvname <- file.path(ma.settings$dir.expdata, 'parameter_distributions', paste('Puhl2003_Fig3.csv', sep=''))
Puhl2003.fig3 <- read.csv(csvname, sep="\t", colClasses="numeric")

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
name = 'y_cell'
data <- createDataFromHistogramm(p.y_cell)
fit <- fitdistr(data$x, "lognormal")
fit
p.gen[name, 'meanlog'] = fit$estimate['meanlog']
p.gen[name, 'sdlog'] = fit$estimate['sdlog']
p.gen[name, 'meanlog_error'] = fit$sd['meanlog']
p.gen[name, 'sdlog_error'] = fit$sd['sdlog']

# png(filename=paste("Puhl2003_y_cell_fit.png", sep=""),
#     width = 800, height = 800, units = "px", bg = "white",  res = 150)
plot(numeric(0), numeric(0),  main="y_cell distribution", 
     xlab="y_cell [µm]", ylab="frequency",
     xlim=c(4, 12), ylim=c(0, 1),
     col=barcol)
midpoints = as.numeric(colnames(p.y_cell))
plotHistWithFit(p.gen, name, data, midpoints, fit, histc)
legend("topright",  legend = c('Puhl2003'), fill=histc)
# dev.off()

#### FIT y_sin #################################################################################
name = 'y_sin'
data <- createDataFromHistogramm(p.y_sin)
fit <- fitdistr(data$x, "lognormal")
fit
p.gen[name, 'meanlog'] = fit$estimate['meanlog']
p.gen[name, 'sdlog'] = fit$estimate['sdlog']
p.gen[name, 'meanlog_error'] = fit$sd['meanlog']
p.gen[name, 'sdlog_error'] = fit$sd['sdlog']

#png(filename=paste("Puhl2003_y_sin_fit.png", sep=""),
#    width = 800, height = 800, units = "px", bg = "white",  res = 150)
plot(numeric(0), numeric(0),  main="sinusoid radius distribution", 
     xlab="y_sin [µm]", ylab="frequency",
     xlim=c(2, 7), ylim=c(0, 1),
     col=barcol)
midpoints = as.numeric(colnames(p.y_sin))
plotHistWithFit(p.gen, name, data, midpoints, fit, histc)
legend("topright",  legend = c('Puhl2003'), fill=histc)
# dev.off()

p.gen

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