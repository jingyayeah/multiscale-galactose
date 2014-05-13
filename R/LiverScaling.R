################################################################
## Analysis of Sampling Distributon & Scaling to whole-liver
################################################################
#
# Whole liver function is calculated based on a sample of 
# configurations of sinusoidal units. To calculate the total liver 
# function these have to be weighted with their relative contribution
# based on the underlying probability distribution of sinusoidal 
# unit configurations. 
# Total scaling in addition depends on the global paramters of the
# person, i.e. global blood flow and liver volume. The distribution
# of sinusoidal units is scaled according to these global variables.
#
# Given: 
# - sample of sinusoidal unit configurations 
#   (from proper sampling over the range of the underlying configurations, i.e. 
#   parameter space) -> random sampling, better latin hypercube sampling for
#   faster convergence and better sampling of hypercube)
#
# - sample results for the given parameter samples
#   (for every sample configuration results are calculated, consisting of 
#    derived geometrical parameters, and simulation results like timecourse 
#    simulations)
#
# - assumed distribution of parameters for the given condition/person 
#   (these are the actual distributions of the parameters for the sinusoidal 
#    units. These can result from whole liver data, i.e. different flow distribution from total 
#    liver flow. Depending on the simulated conditions these can vary)
#
# - whole liver volume/mass for scaling to organ & whole body level
#   (even with the same underlying distributions within the liver, there is still 
#    person to person variance in liver volume)
#
# TODO: evaluate result convergence with sample size 
#
#  @author: Matthias Koenig
#  @date: 2014-05-01

rm(list=ls())
library(data.table)
library(libSBML)
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)
#------------------------------------------------------------------------------#
sname <- '2014-05-13_MultipleIndicator'
version <- 'v18'
ma.settings$dir.simdata <- file.path(ma.settings$dir.results, sname, 'data')
task.offset <- 31
task.seq <- seq(0,2)
tasks <- paste('T', task.offset+task.seq, sep='')
peaks <- paste('P0', task.seq, sep='')
#------------------------------------------------------------------------------#

# Settings for plots
create_plot_files = FALSE
plot.width = 800 
plot.height = 800
plot.units= "px"
plot.bg = "white"
plot.res = 150

###########################################################################
# Load parameters for samples
###########################################################################

# for (kt in seq(length(tasks))){
# ? all the things are only applied to the first component of the solution
for (kt in seq(1)){
  task <- tasks[kt]
  peak <- peaks[kt]
  modelId <- paste('MultipleIndicator_', peak, '_', version, '_Nc20_Nf1', sep='')
  parsfile <- file.path(ma.settings$dir.results, sname, 
                        paste(task, '_', modelId, '_parameters.csv', sep=""))
  # Load the data
  pars <- loadParameterFile(parsfile)
  print(summary(pars))
}
rm(kt)
names(pars)

# Plot all parameter histogramm
# overview of distribution in single dimension
if (create_plot_files == TRUE){
  fname <- file.path(ma.settings$dir.results, sname, 
                     paste(task, '_', modelId, '_plotParameterHistogramFull.png', sep=""))
  png(filename=fname, width=1400, height=400, units=plot.units, bg=plot.bg, res=plot.res)
}
plotParameterHistogramFull(pars=pars)
if (create_plot_files == TRUE){
  dev.off()
}

# Plot scatterplot of parameters
# the index of parameters is encoded as color to test for shuffling effects
library(RColorBrewer)
colpal <- brewer.pal(9, 'YlOrRd')
Nsim = nrow(pars)
ccols <- colorRampPalette(colpal)(Nsim) # exend the color palette
pnames <- getParameterNames(pars)

if (create_plot_files == TRUE){
  fname <- file.path(ma.settings$dir.results, sname, 
                     paste(task, '_', modelId, '_plotParameterScatterFull.png', sep=""))
  png(filename=fname, width=1400, height=1400, units=plot.units, bg=plot.bg, res=120)
}
  plot(pars[, pnames], col=ccols, pch=15)
if (create_plot_files == TRUE){
  dev.off()
}

###########################################################################
# Do the parameters preprocessing & use
# Probabilites of parameters & samples based on ECDFs 
###########################################################################
# TODO: definitely some problem with the weighting of the parameter samples
#       with the given probability, especially if it is already sampled from
#       gven distributions -> fix 
ps <- getParameterTypes(pars=pars)

# Extend the parameters with the SBML parameters and calculated parameters
fsbml <- file.path(ma.settings$dir.results, sname, paste(modelId, '.xml', sep=''))
model <- loadSBMLModel(fsbml)
pars <- extendParameterStructure(pars=pars, fixed_ps=ps$fixed, model=model)
head(pars)

# Standard distributions for normal case
p.gen <- loadStandardDistributions()
print(p.gen)

# ECDFs for standard distributions
ecdf.list <- createListOfStandardECDF(p.gen, ps$var)

# Calculate the probabilites for single variables
pars <- calculateProbabilitiesForVariables(pars, ecdf.list)
# And the overall probability per sample
pars <- calculateSampleProbability(pars, ps$var)
head(pars)

###########################################################################
# Generate control plots
var_ps <- names(ecdf.list)
for (name in var_ps){
    f.ecdf <- ecdf.list[[name]]
    x <- pars[[name]];
    head(x)
    if (create_plot_files == TRUE){
      fname <- file.path(ma.settings$dir.results, sname, 
                         paste(task, '_', modelId, '_samples_', name, '.png', sep=""))
      png(filename=fname, width=1000, height=1400, units=plot.units, bg=plot.bg, res=plot.res)
    }

    xlab = paste(name, ' [', p.gen[name, 'unit'], ']', sep="")
    plotProbabilitiesForVariable(x, f.ecdf, xlab=xlab);
    # par(ask=TRUE)
    
    if (create_plot_files == TRUE){
      dev.off()
    }
}

# Plot sample probability with ECDF
if (create_plot_files == TRUE){
  fname <- file.path(ma.settings$dir.results, sname, 
                     paste(task, '_', modelId, '_p_sample' , '.png', sep=""))
  png(filename=fname, width=1400, height=800, units=plot.units, bg=plot.bg, res=plot.res)
}
  par(mfrow=c(1,2))
  # probability
  plot(sort(pars$p_sample, decreasing=TRUE), ylab="p(x1)*p(x1) ... p(xN)", main="probability")
  abline(h=0.0, col='black')
  abline(v=0.0, col='black')

  # ecdf
  plot(ecdf(sort(pars$p_sample, decreasing=TRUE)), main="ECDF")
  abline(h=0.0, col='black')
  abline(h=1.0, col='black')
  abline(v=0.0, col='black')
  par(mfrow=c(1,1))
if (create_plot_files == TRUE){
  dev.off()
}

###########################################################################
# Arbitrary parameter ECDFs
###########################################################################
# TODO

###########################################################################
# Calculate weighted derived values
###########################################################################
# Calculate weighted values based on the probabilities for sample
# Weighted mean, variance and standard deviation calculations
name='flow_sin'
wmean <- wt.mean(pars[[name]], pars$p_sample)
wmean
wvar <- wt.var(pars[[name]], pars$p_sample)
wvar
wsd <- wt.sd(pars[[name]], pars$p_sample)
wsd
plotWeighted(pars, p.gen, name)

# Generate plots
plot.width = 800 
plot.height = 800
plot.units= "px"
plot.bg = "white"
plot.res = 150
for (name in ps$var){
  fname = paste('test_distribution_', name, '.png', sep="") 
  print(fname)
  png(filename=fname, width=plot.width, height=plot.height, units=plot.units, bg=plot.bg, res=plot.res)
  plotWeighted(pars, p.gen, name)
  dev.off()
}

###########################################################################
# Scale to whole-liver
###########################################################################
# The conversion factor via flux and via volume have to be the same.
# They are calculated based on the weighted distributions of the parameters. 
# But they have to be calculated over the distribution of geometries
# N_Q = Q_liv/Q_sinunit;
# N_Vol = N_Q
# N_Vol = f_tissue*Vol_liv/Vol_sinunit  => f_tissue = N_Vol * Vol_sinunit/Vol_liv
# -20% large vessels

# calculate conversion factors
calculateConversionFactors <- function(pars){
    res <- list()
    f_tissue = 0.75;
    
    # varies depending on parameters
    Q_sinunit.wmean <- wt.mean(pars[['Q_sinunit']], pars$p_sample)
    Q_sinunit.wsd <- wt.sd(pars[['Q_sinunit']], pars$p_sample)
    Vol_sinunit.wmean <- wt.mean(pars[['Vol_sinunit']], pars$p_sample)
    Vol_sinunit.wsd <- wt.sd(pars[['Vol_sinunit']], pars$p_sample)
    
    # constant normal value
    Q_liv.wmean <- wt.mean(pars[['Q_liv']], pars$p_sample)
    Q_liv.wsd <- wt.sd(pars[['Q_liv']], pars$p_sample)
    Vol_liv.wmean <- wt.mean(pars[['Vol_liv']], pars$p_sample)
    Vol_liv.wsd <- wt.sd(pars[['Vol_liv']], pars$p_sample)
    N_Vol = f_tissue*Vol_liv.wmean/Vol_sinunit.wmean
    N_Q1 = Q_liv.wmean/Q_sinunit.wmean
    f_flow = N_Q1/N_Vol
    N_Q = N_Q1/f_flow
    
    cat('N_Q: ', N_Q, '\n')
    cat('N_Vol: ', N_Vol, '\n')
    cat('N_Vol/N_Q1: ', N_Vol/N_Q1, '\n')
    cat('N_Vol/N_Q: ',  N_Vol/N_Q, '\n')
    cat('f_flow: ', f_flow, '\n')
    
    res$N_Q <- N_Q
    res$N_Vol <- N_Vol
    res$f_tissue <- f_tissue
    res$f_flow <- f_flow
    res
}
res <- calculateConversionFactors(pars)
names(res)

###########################################################################
# Scale things to whole liver
###########################################################################
# How do changes in liver size and blood flow change the results
# [A] liver size -> different conversion factor with
# N_Vol.new = N_Vol.alt * Vol_liv.new/Vol_liv.ref 
# => parameters are scaled linearly with the liver volume (i.e. smaller or bigger liver
#     with same constitution)

# [B] changes in global blood flow
# N_Q.new = f_tissue * N_Vol.new
# -> new meanstd & variance for local blood flow
# Q_liv.wmean.new = Q_liv.wmean * N_Q.new/N_Q
# i.e. if the blood flow goes down, than the mean velocity through the sinusoids goes down

