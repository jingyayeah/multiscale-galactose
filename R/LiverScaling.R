################################################################
## Scaling to whole-liver
################################################################
# Whole liver function is calculated based on a sample of 
# configurations of sinusoidal units. To calculate the total liver 
# function these have to be weighted with their relative contribution
# based on the underlying probability distribution of sinusoidal 
# unit configurations. 
# Total scaling in addition depends on the global paramters of the
# person, i.e. global blood flow and liver volume. The distribution
# of sinusoidal units is scaled according to these global variables.

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
## Latin Hypercube sampling ##
# This 'multi-start' approach facilitates a broad coverage of the
# parameter search space in order to find the global optimum.
# Latin hypercube sampling [17] of the initial parameter guesses
# can be used to guarantee that each parameter estimation run
# starts in a different region in the high-dimensional parameter
# space. This method prohibits that randomly selected starting
# points are accidentally close to each other. Therefore, Latin
# hypercube sampling provides a better coverage of the space.
#
#  @author: Matthias Koenig
#  @date: 2014-05-01
################################################################

# IMPORTANT: All of the values have calculated distributions, which can be compared with
# the experimental values

# TODO: support the Latin Hypercube Sampling

# Load the parameter samples (here the parameters which are changing are defined)
# - sample of sinusoidal unit configurations 
#   (from proper sampling over the range of the underlying configurations, i.e. 
#   parameter space) -> random sampling, better latin hypercube sampling for
#   faster convergence and better sampling of hypercube)

rm(list=ls())   # Clear all objects
library(data.table)
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)

# TODO : only define the settings once here
sname <- '2014-04-30_MultipleIndicator'
tasks <- paste('T', seq(11,15), sep='')
peaks <- c('P00', 'P01', 'P02', 'P03', 'P04')
ma.settings$dir.simdata <- file.path(ma.settings$dir.results, sname, 'data')

# for (kt in seq(length(tasks))){
for (kt in seq(1)){
  task <- tasks[kt]
  peak <- peaks[kt]
  modelId <- paste('MultipleIndicator_', peak, '_', 'v13_Nc20_Nf1', sep='')
  parsfile <- file.path(ma.settings$dir.results, sname, 
                        paste(task, '_', modelId, '_parameters.csv', sep=""))
  # Load the data
  print(parsfile)
  load(file=outfileFromParsFile(parsfile))
  print(summary(pars))
}
rm(kt, peak, task)
names(pars)

# - sample results for the given parameter samples
#   (for every sample configuration results are calculated, consisting of 
#    derived geometrical parameters, and simulation results like timecourse 
#    simulations)

# Get parameters from SBML or parameter structure and calculate the derived
# variables.
all_ps = c('Nc', 'Nf', 'L', 'y_sin', 'y_dis', 'y_cell', 'flow_sin', 'f_fen', 
          'rho_liv', 'Q_liv', 'Vol_liv')
fixed_ps <- getFixedParameters(pars=pars, all_ps=all_ps)
var_ps <- getVariableParameters(pars=pars, all_ps=all_ps)
print(all_ps)
print(fixed_ps)
print(var_ps)

# Extend the parameters with the SBML parameters and calculated parameters
# showClass("_p_Parameter")
# showMethods("_p_Parameter")
library('libSBML')
filename = filename <- '/home/mkoenig/multiscale-galactose-results/tmp_sbml/Galactose_v14_Nc20_Nf1.xml'
model <- loadSBMLModel(filename)
pars <- extendParameterStructure(pars=pars, fixed_ps=fixed_ps, model=model)
head(pars)

# Now the full information about the samples is available
hist(pars$Vol_sinunit, xlim=c(0, 6E-13), breaks=20)

###########################################################################
# Define distributions of parameters which should be used for the calculation.
# If no weighting distribution exists for parameter ?? what than ??

# Distributions are loaded via
fname <- file.path(ma.settings$dir.results, 'distribution_fit_data.csv')
p.gen <- read.csv(file=fname)
rownames(p.gen) <- p.gen$name
p.gen

## create arbitrary distribution function
# create a density, distribution and quantile function from data
# Density, distribution function, quantile function
# dlnorm, plnorm, qlnorm
# -> use arbitrary distribution function to calculate the derived values

# Create a density estimate
# ! Possible problems with outliers in density estimation
name = 'flow_sin'
Npoints = 1000
y1 <- rlnorm(Npoints, meanlog=p.gen[name, 'meanlog'], sdlog=p.gen[name, 'sdlog'])
y2 <- rlnorm(Npoints, meanlog=1.3*p.gen[name, 'meanlog'], sdlog=0.4*p.gen[name, 'sdlog'])
ytest <- c(y1, y2)


y1 <- rlnorm(10000, meanlog=p.gen[name, 'meanlog'], sdlog=p.gen[name, 'sdlog'])
ecdf.tmp1 <- ecdf(y1)
plot(ecdf.tmp1)


# Empirical cumulative distribution function) is a step function with jumps i/n at observation values, 
# where i is the number of tied observations at that value
# Multivariate Empirical Cumulative Distribution Functions
# ecdf
ecdf.tmp <- ecdf(ytest)
plot(ecdf.tmp)
ecdf.tmp
# The quantile(obj, ...) method computes the same quantiles as quantile(x, ...) would where x is the original sample


summary(ytest)
lb = 0.0;
ub = 10 * mean(ytest); 
plot(ytest)
hist(ytest, breaks=30, xlim=c(lb, ub))
dtest <- density(ytest, from=lb, to=ub, bw=100)
plot(dtest, xlim=c(lb, ub))



# use the density to calculate the p_sample
# Now we have density and samples -> get the new p_sample values
# needed is a distribution function (cumulative) or empirical cumulative 
# distribution function

p_test <- getProbabilitiesForSamples(pars=pars, p.gen=p.gen, name=name)






# For every var_ps a distribution has to exist
# TODO: Make sure that over all the probabilities is integrated
print(var_ps)
Nsim <- nrow(pars)
p_sample <- rep(1, Nsim)
for (name in var_ps){
    print(name)
    p_name = paste('p_', name, sep='')
    p_data <- getProbabilitiesForSamples(pars, p.gen, name)
    pars[[p_name]] <- p_data
    # calculate the combined probability based on the parameter probabilities
    # statistical independence assumed (multiply the probabilities)
    # ??? this is strange - make sure it is valid
    # This is the main trick and should be valid
    # TODO: fix
    p_sample = p_sample * p_data
}
# Normalize p_sample
pars$p_sample <- p_sample/sum(p_sample)
sum(pars$p_sample)
plot(pars$p_sample)
plot(pars$p_y_cell)
plot(pars$y_cell, pars$p_y_cell)

# weight samples with their probability i.e. get the probability for every
# varied parameter and 

# Calculate weighted values based on the probabilities for sample
# Weighted mean, variance and standard deviation calculations
head(pars)
name='Q_sinunit'
wmean <- wt.mean(pars[[name]], pars$p_sample)
wvar <- wt.var(pars[[name]], pars$p_sample)
wsd <- wt.sd(pars[[name]], pars$p_sample)
plotWeighted(pars, p.gen, name)

# Generate plots
plot.width = 800 
plot.height = 800
plot.units= "px"
plot.bg = "white"
plot.res = 150
for (name in var_ps){
    fname = paste('test_distribution_', name, '.png', sep="") 
    print(fname)
    png(filename=fname, width=plot.width, height=plot.height, units=plot.units, bg=plot.bg, res=plot.res)
    plotWeighted(pars, p.gen, name)
    dev.off()
}


###########################################################################
# Calculate values based on the distribution weighted samples:

# The conversion factor via flux and via volume have to be the same.
# They are calculated based on the weighted distributions of the parameters. 
# But they have to be calculated over the distribution of geometries
# N_Q = Q_liv/Q_sinunit;
# N_Vol = N_Q
# f_tissue = 1/N_Q * Vol_liv/Vol_sinunit

# calculate conversion factors
calculateConversionFactors(pars.new){
    Nsim <- nrow(pars.new)
}

# the mean/std results based on the integration over the parameter distribution
# the mean/std for the sample variables for control


# Scale to whole liver function based on the conversion factors


# TODO: evaluate the convergence of the method depending on the number of 
#       drawn samples.

# Resampling ( https://en.wikipedia.org/wiki/Resampling_%28statistics%29 )
# Estimating the precision of sample statistics (medians, variances, percentiles) by using subsets of available data (jackknifing) or drawing randomly with replacement from a set of data points (bootstrapping)
# Validating models by using random subsets (bootstrapping, cross validation)
# approximate permutation test, Monte Carlo permutation tests or random permutation tests
