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
#
# TODO: analyse fits with QQplot
################################################################
# Settings for plots
create_plot_files = TRUE
histc = rgb(1.0, 0.0, 0.0, 0.25)
histcp = rgb(0.0, 0.0, 1.0, 0.25)
plot.width = 800 
plot.height = 800
plot.units= "px"
plot.bg = "white"
plot.res = 150

library(MultiscaleAnalysis)
library(MASS)
setwd(ma.settings$dir.results)

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
pars <- pars[pars$status=='DONE', ]
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
storeFitData(fit, name)
fit

# Figure #
if (create_plot_files == TRUE){
  fname <- paste('distribution_', name, '.png', sep="")
  png(filename=fname, width=plot.width, height=plot.height, units=plot.units, bg=plot.bg, res=plot.res)
}

  plot(numeric(0), numeric(0),  main="RBC velocity distribution", 
     xlab=xlabByName(p.gen, name), ylabByName(p.gen, name),
     xlim=c(0, max(data$x)), ylim=c(0, 0.004))
  plotHistWithFit(p.gen, name, data=data, 
                midpoints=as.numeric(colnames(Koo1975.all)),
                fit=fit, histc=histc)
  # add the parameter hist
  hpars <- hist(pars[, name]*p.gen[name, 'scale_fac'],
              plot=FALSE, breaks=20)
  plot(hpars, col=histcp, freq=FALSE, add=T)
  legend("topright",  legend = c('Data Koo1975', 'Simulation'), fill=c(histc, histcp))

if (create_plot_files){
  dev.off()
}

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
storeFitData(fit, name)
fit

# Figure #
if (create_plot_files == TRUE){
  fname <- paste('distribution_', name, '.png', sep="")
  png(filename=fname, width=plot.width, height=plot.height, units=plot.units, bg=plot.bg, res=plot.res)
}

  plot(numeric(0), numeric(0),  main="y_cell distribution", 
     xlab=xlabByName(p.gen, name), ylabByName(p.gen, name),
     xlim=c(4, 12), ylim=c(0, 1))
  plotHistWithFit(p.gen, name, data, 
                midpoints=as.numeric(colnames(p.y_cell)), 
                fit, histc)
  legend("topright",  legend = c('Puhl2003'), fill=histc)

  # add the parameter hist
  hpars <- hist(pars[, name]*p.gen[name, 'scale_fac'],
              plot=FALSE, breaks=20)
  plot(hpars, col=histcp, freq=FALSE, add=T)
  legend("topright",  legend = c('Data Puhl2003', 'Simulation'), fill=c(histc, histcp))

if (create_plot_files){
  dev.off()
}

#### FIT y_sin #################################################################################
name = 'y_sin'
data <- createDataFromHistogramm(p.y_sin)
fit <- fitdistr(data$x, "lognormal")
storeFitData(fit, name)
fit


# Figure #
if (create_plot_files == TRUE){
  fname <- paste('distribution_', name, '.png', sep="")
  png(filename=fname, width=plot.width, height=plot.height, units=plot.units, bg=plot.bg, res=plot.res)
}

  plot(numeric(0), numeric(0),  main="Sinusoidal radius", 
     xlab=xlabByName(p.gen, name), ylabByName(p.gen, name),
     xlim=c(2, 7), ylim=c(0, 1))
  plotHistWithFit(p.gen, name, data, 
                midpoints = as.numeric(colnames(p.y_sin)),
                fit, histc)
  legend("topright",  legend = c('Puhl2003'), fill=histc)

  # add the parameter hist
  hpars <- hist(pars[, name]*p.gen[name, 'scale_fac'], plot=FALSE, breaks=20)
  plot(hpars, col=histcp, freq=FALSE, add=T)
  legend("topright",  legend = c('Data Puhl2003', 'Simulation'), fill=c(histc, histcp))

if (create_plot_files){
  dev.off()
}

#### Sim y_dis  #################################################################################
name = 'y_dis'

# Figure #
if (create_plot_files == TRUE){
  fname <- paste('distribution_', name, '.png', sep="")
  png(filename=fname, width=plot.width, height=plot.height, units=plot.units, bg=plot.bg, res=plot.res)
}

  plot(numeric(0), numeric(0),  main="Width space of Disse", 
     xlab=xlabByName(p.gen, name), ylab=ylabByName(p.gen, name),
     xlim=c(0, 3), ylim=c(0, 2.0))

  # add the parameter hist  
  data <- pars[, name] *p.gen[name, 'scale_fac']
  hpars <- hist(data, plot=FALSE, breaks=20)
  plot(hpars, col=histcp, freq=FALSE, add=T)

  # fit distribution
  plotDistribution(p.gen, name, maxvalue=2*max(data))

  legend("topright",  legend = c('Simulation'), fill=c(histcp))

if (create_plot_files){
  dev.off()
}

#### Sim L  #################################################################################
name = 'L'

# Figure #
if (create_plot_files == TRUE){
  fname <- paste('distribution_', name, '.png', sep="")
  png(filename=fname, width=plot.width, height=plot.height, units=plot.units, bg=plot.bg, res=plot.res)
}

  plot(numeric(0), numeric(0),  main="Sinusoid length", 
     xlab=xlabByName(p.gen, name), ylab=ylabByName(p.gen, name),
     xlim=c(0, 1000), ylim=c(0, 0.005))
  # add the parameter hist  
  data <- pars[, name] *p.gen[name, 'scale_fac']
  hpars <- hist(data, plot=FALSE, breaks=20)
  plot(hpars, col=histcp, freq=FALSE, add=T)
  # add distribution
  plotDistribution(p.gen, name, maxvalue=2*max(data))
  legend("topright",  legend = c('Simulation'), fill=c(histcp))

if (create_plot_files){
  dev.off()
}
