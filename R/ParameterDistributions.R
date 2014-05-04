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
# The plots are generated with the simulated distributions.
# 
#   dlnorm(x, meanlog = 0, sdlog = 1, log = FALSE)
#   plnorm(q, meanlog = 0, sdlog = 1, lower.tail = TRUE, log.p = FALSE) (cumulative distribution)
#   qlnorm(p, meanlog = 0, sdlog = 1, lower.tail = TRUE, log.p = FALSE)
#   rlnorm(n, meanlog = 0, sdlog = 1)
#
# TODO: analyse fits with QQplot
################################################################
rm(list=ls())
library(MultiscaleAnalysis)
library(MASS)
setwd(ma.settings$dir.results)

# parameter values used in simulations (before fitting)
p.gen <- generateLogStandardParameters()
p.gen

# lists to store data and the fit parameters
data <- list()
fit <- list()

###############################################################
# flow_sin
###############################################################
Koo1975.names = c('branching', 'interconnecting', 'direct')
for (name in Koo1975.names){
  varname <- paste("Koo1975.", name, sep="");
  csvname <- file.path(ma.settings$dir.expdata, 'parameter_distributions', paste('Koo1975_Fig1_', name,'.csv', sep=''))
  assign(varname, read.csv(csvname, sep= '\t'))   
}
Koo1975.all = rbind(t(Koo1975.branching$count), t(Koo1975.interconnecting$count), t(Koo1975.direct$count))
colnames(Koo1975.all) <- Koo1975.branching$velocity
rownames(Koo1975.all)<-Koo1975.names
Koo1975.all
rm(name, varname)

# R stacked bar plot
#png(filename=paste("Koo1975_velocity_distribution.png", sep=""),
#    width = 800, height = 800, units = "px", bg = "white",  res = 150)
barcol <- gray.colors(length(Koo1975.names))
barplot(Koo1975.all, main="RBC velocity distribution", xlab="vRBC [µm/s]", ylab="count", col=barcol)
legend("topright",  legend = Koo1975.names, fill=barcol)
#dev.off()

###  fit  ###
name = 'flow_sin'
data[[name]] <- createDataFromHistogramm(Koo1975.all)             
fit[[name]] <- fitdistr(data[[name]]$x, "lognormal")
p.gen <- storeFitData(p.gen, fit[[name]], name)


###############################################################
# y_cell and y_sin
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

###  fit  ###
name = 'y_cell'
data[[name]] <- createDataFromHistogramm(p.y_cell)
fit[[name]] <- fitdistr(data[[name]]$x, "lognormal")
p.gen <- storeFitData(p.gen, fit[[name]], name)

name = 'y_sin'
data[[name]] <- createDataFromHistogramm(p.y_sin)
fit[[name]] <- fitdistr(data[[name]]$x, "lognormal")
p.gen <- storeFitData(p.gen, fit[[name]], name)

#### Store fit parameter ##############################################
# Calculate additional parameters for LHS scanning of probabilities
# lower and upper bounds at 0.01 percentile and 0.99 percentile, respectively.
# qvalues = c(0.01, 0.05, 0.5, 0.95, 0.99)
for (name in rownames(p.gen)){
  p.gen[name, "llb"] <- qlnorm(0.01, meanlog=p.gen[name, 'meanlog'], sdlog=p.gen[name, 'sdlog'], log = FALSE)/p.gen[name, 'scale_fac']
  p.gen[name, "lb"] <- qlnorm(0.05, meanlog=p.gen[name, 'meanlog'], sdlog=p.gen[name, 'sdlog'], log = FALSE)/p.gen[name, 'scale_fac']
  p.gen[name, "ub"] <- qlnorm(0.95, meanlog=p.gen[name, 'meanlog'], sdlog=p.gen[name, 'sdlog'], log = FALSE)/p.gen[name, 'scale_fac']
  p.gen[name, "uub"] <- qlnorm(0.99, meanlog=p.gen[name, 'meanlog'], sdlog=p.gen[name, 'sdlog'], log = FALSE)/p.gen[name, 'scale_fac']
}
p.gen

fname <- file.path(ma.settings$dir.results, 'distribution_fit_data.csv')
write.csv(file=fname, p.gen)


#### Create the figures ##############################################
# load simulated parameters
sname <-'2014-04-30_MultipleIndicator' 
task <- 'T11'
modelId <- 'MultipleIndicator_P00_v13_Nc20_Nf1'

parsfile <- file.path(ma.settings$dir.results, sname, 
                      paste(task, '_', modelId, '_parameters.csv', sep=""))
print(parsfile)
load(file=outfileFromParsFile(parsfile))
print(summary(pars))
head(pars)


# Settings for plots
create_plot_files = TRUE
histc = rgb(1.0, 0.0, 0.0, 0.25)
histcp = rgb(0.0, 0.0, 1.0, 0.25)
plot.width = 800 
plot.height = 800
plot.units= "px"
plot.bg = "white"
plot.res = 150

## flow_sin ##
name <- 'flow_sin'
if (create_plot_files == TRUE){
    fname <- paste('distribution_', name, '.png', sep="")
    png(filename=fname, width=plot.width, height=plot.height, units=plot.units, bg=plot.bg, res=plot.res)
}
plot(numeric(0), numeric(0),  main="RBC velocity distribution", 
     xlab=xlabByName(p.gen, name), ylab=ylabByName(p.gen, name),
     xlim=c(0, max(data[[name]]$x)), ylim=c(0, 0.004))
plotHistWithFit(p.gen, name, data=data[[name]], 
                midpoints=as.numeric(colnames(Koo1975.all)),
                fit=fit[[name]], histc=histc)
if (exists('pars')){
    # add the parameter hist
    tmp <- pars[, name] *p.gen[name, 'scale_fac']
    hpars <- hist(tmp, plot=FALSE, breaks=20)
    plot(hpars, col=histcp, freq=FALSE, add=T)
}
legend("topright",  legend = c('Data Koo1975', 'Simulation'), fill=c(histc, histcp))
if (create_plot_files){
    dev.off()
}


## y_cell ##
name <- 'y_cell'
if (create_plot_files == TRUE){
    fname <- paste('distribution_', name, '.png', sep="")
    png(filename=fname, width=plot.width, height=plot.height, units=plot.units, bg=plot.bg, res=plot.res)
}
plot(numeric(0), numeric(0),  main="y_cell distribution", 
     xlab=xlabByName(p.gen, name), ylab=ylabByName(p.gen, name),
     xlim=c(4, 12), ylim=c(0, 0.8))
plotHistWithFit(p.gen, name, data[[name]], 
                midpoints=as.numeric(colnames(p.y_cell)), 
                fit[[name]], histc)
if (exists('pars')){
    # add the parameter hist
    hpars <- hist(pars[, name]*p.gen[name, 'scale_fac'],
              plot=FALSE, breaks=20)
    plot(hpars, col=histcp, freq=FALSE, add=T)
}
legend("topright",  legend = c('Data Puhl2003', 'Simulation'), fill=c(histc, histcp))
if (create_plot_files){
    dev.off()
}

## y_sin ##
name <- 'y_sin'
if (create_plot_files == TRUE){
    fname <- paste('distribution_', name, '.png', sep="")
    png(filename=fname, width=plot.width, height=plot.height, units=plot.units, bg=plot.bg, res=plot.res)
}
plot(numeric(0), numeric(0),  main="Sinusoidal radius", 
     xlab=xlabByName(p.gen, name), ylab=ylabByName(p.gen, name),
     xlim=c(2, 7), ylim=c(0, 1))
plotHistWithFit(p.gen, name, data[[name]], 
                midpoints = as.numeric(colnames(p.y_sin)),
                fit[[name]], histc)
if (exists('pars')){
    # add the parameter hist
    hpars <- hist(pars[, name]*p.gen[name, 'scale_fac'], plot=FALSE, breaks=20)
    plot(hpars, col=histcp, freq=FALSE, add=T)
    legend("topright",  legend = c('Data Puhl2003', 'Simulation'), fill=c(histc, histcp))
}
if (create_plot_files){
    dev.off()
}

## y_dis ##
name = 'y_dis'
if (create_plot_files == TRUE){
    fname <- paste('distribution_', name, '.png', sep="")
    png(filename=fname, width=plot.width, height=plot.height, units=plot.units, bg=plot.bg, res=plot.res)
}
plot(numeric(0), numeric(0),  main="Width space of Disse", 
     xlab=xlabByName(p.gen, name), ylab=ylabByName(p.gen, name),
     xlim=c(0, 3.0), ylim=c(0, 2.0))
if (exists('pars')){
    # add the parameter hist  
    tmp <- pars[, name] *p.gen[name, 'scale_fac']
    hpars <- hist(tmp, plot=FALSE, breaks=20)
    plot(hpars, col=histcp, freq=FALSE, add=T)
}
plotLogNormalDistribution(p.gen, name, maxvalue=3.0)
legend("topright",  legend = c('Simulation'), fill=c(histcp))
if (create_plot_files){
    dev.off()
}

## y_sin ##
name = 'L'
if (create_plot_files == TRUE){
    fname <- paste('distribution_', name, '.png', sep="")
    png(filename=fname, width=plot.width, height=plot.height, units=plot.units, bg=plot.bg, res=plot.res)
}
plot(numeric(0), numeric(0),  main="Sinusoidal length", 
     xlab=xlabByName(p.gen, name), ylab=ylabByName(p.gen, name),
     xlim=c(0, 1000), ylim=c(0, 0.005))
if (exists('pars')){
    # add the parameter hist  
    tmp <- pars[, name] *p.gen[name, 'scale_fac']
    hpars <- hist(tmp, plot=FALSE, breaks=20)
    plot(hpars, col=histcp, freq=FALSE, add=T)
}
# add distribution
plotLogNormalDistribution(p.gen, name, maxvalue=1000)
legend("topright",  legend = c('Simulation'), fill=c(histcp))
if (create_plot_files){
    dev.off()
}
