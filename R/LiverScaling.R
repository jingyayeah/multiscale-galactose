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

# Get additional information from the SBML file
# showClass("_p_Parameter")
# showMethods("_p_Parameter")

library('libSBML')
filename = filename <- '/home/mkoenig/multiscale-galactose-results/tmp_sbml/Galactose_v14_Nc20_Nf1.xml'
doc        = readSBML(filename);
errors   = SBMLDocument_getNumErrors(doc);
SBMLDocument_printErrors(doc);
model = SBMLDocument_getModel(doc);
rm(errors)

# Get all parameter names from model
lofp <- Model_getListOfParameters(model)
Np <- ListOf_size(lofp)
model_pids <- character(Np)
for (kp in seq(0, (Np-1))){  
    p <- ListOfParameters_get(lofp, kp)
    model_pids[kp+1] <- Parameter_getId(p)
}
rm(lofp, Np, p, kp)

# Get the following parameters from SBML or the parameters file to calculate
# the derived variables.
names = c('Nc', 'Nf', 'L', 'y_sin', 'y_dis', 'y_cell', 'flow_sin', 'f_fen', 
          'rho_liv', 'Q_liv', 'Vol_liv')

# All parameters which are fixed in the model
fixed_ps = setdiff(names, getParsNames(pars))
print(fixed_ps)

# All parameters which are varied, i.e. depend on sample
var_ps = setdiff(names, fixed_ps)
print(var_ps)

# Create extended data frame with the calculated values
extendPars <- function(pars, fixed_ps){
    X <- pars
    Nsim <- nrow(pars)
    
    # the fixed parameters in model
    for (pid in fixed_ps){
        if (pid %in% model_pids){
            p <- Model_getParameter(model, pid)
            value <- Parameter_getValue(p)
            # create a variable with the name
            X[[pid]] <- rep(value, Nsim)
        } else {
            cat('parameter not in model:', name, '\n')    
        }
    }
    
    attach(X)
    Nb   =     Nf*Nc 		
    x_cell 	= 	L/Nc
    x_sin 	= 	x_cell/Nf
    A_sin 	= 	pi*y_sin^2 		
    A_dis 	= 	pi*(y_sin+y_dis)^2-A_sin 		
    A_sindis 	= 	2*pi*y_sin*x_sin 		
    Vol_sin 	= 	A_sin*x_sin 		
    Vol_dis 	= 	A_dis*x_sin 		
    Vol_cell 	= 	pi*(y_sin+y_dis+y_cell)^2*x_cell-pi*(y_sin+y_dis)^2*x_cell 		
    Vol_pp 	= 	Vol_sin 		
    Vol_pv 	= 	Vol_sin
    f_sin   = 	Vol_sin/(Vol_sin+Vol_dis+Vol_cell) 		
    f_dis 	= 	Vol_dis/(Vol_sin+Vol_dis+Vol_cell) 		
    f_cell 	= 	Vol_cell/(Vol_sin+Vol_dis+Vol_cell) 		
    Vol_sinunit 	= 	L*pi*(y_sin+y_dis+y_cell)^2 		
    Q_sinunit 	= 	pi*y_sin^2*flow_sin 		
    m_liv 	= 	rho_liv*Vol_liv 		
    q_liv 	= 	Q_liv/m_liv
    
    X$Nb = Nb  	
    X$x_cell = x_cell
    X$x_sin = x_sin
    X$A_sin = A_sin
    X$A_dis = A_dis
    X$A_sindis = A_sindis
    X$Vol_sin = Vol_sin
    X$Vol_dis = Vol_dis
    X$Vol_cell = Vol_cell
    X$Vol_pp = Vol_pp 		
    X$Vol_pv = Vol_pv
    X$f_sin = f_sin
    X$f_dis = f_dis
    X$f_cell = f_cell
    X$Vol_sinunit = Vol_sinunit
    X$Q_sinunit = Q_sinunit
    X$m_liv = m_liv
    X$q_liv = q_liv
    detach(X)
    X
}
pars <- extendPars(pars, fixed_ps)
head(pars)
hist(pars$Vol_sinunit, xlim=c(0, 6E-13), breaks=20)

###########################################################################
# Define distributions of parameters which should be used for the calculation.
# If no weighting distribution exists for parameter ?? what than ??

# Distributions are loaded via
fname <- file.path(ma.settings$dir.results, 'distribution_fit_data.csv')
p.gen <- read.csv(file=fname)
rownames(p.gen) <- p.gen$name
p.gen


# In which units is it coming out (transformed units)
# ! Important to keep track of the units !
# TODO: do the fit for unscaled data in basis units
getProbabilitiesForSamples <- function(pars, p.gen, name){
    Nsim = nrow(pars)
    
    # sort the data
    d <- sort(pars[[name]])  

    # get the mean points
    mpoints <- 0.5*(d[1:(Nsim-1)] + d[2:Nsim])
    
    # Add the boundary points
    mpoints <- c(0, mpoints, 10*max(mpoints))
    
    # Calculate the cumulative probability associated with every sample
    # Scaling so that the values fit to the parameter distributions
    c_sample <- plnorm(mpoints*p.gen[name, 'scale_fac'], 
                    meanlog=p.gen[name, 'meanlog'], sdlog=p.gen[name, 'sdlog'], 
                    log = FALSE)
    
    print(summary(c_sample))
    # get the probability associated with the interval
    p_sample = c_sample[2:(Nsim+1)] - c_sample[1:Nsim]
    # plot(p_sample)
    print(sum(p_sample))

    p_sample
}

# For every var_ps a distribution has to exist
print(var_ps)
Nsim <- nrow(pars)
p_sample <- rep(1, Nsim)
for (name in var_ps){
    print(name)
    p_name = paste('p_', name, sep='')
    p_data <- getProbabilitiesForSamples(pars, p.gen, name)
    pars[[p_name]] <- p_data
    
    # statistical independence assumed (multiply the probabilities)
    # ??? this is strange - make sure it is valid
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
calculateWeightedValue <- function(pars, name){
    m <- sum(pars$p_sample * pars[[name]])
}
m_L <- calculateWeightedValue(pars, 'L')
m_L
m_L2 <-  sum(pars$p_L * pars$L)
m_L2
head(pars)

# calculate the combined probability based on the parameter probabilities
name="y_cell"
x <- seq(from=0, to=1000, length.out=1000)
y <- dlnorm(x, meanlog=p.gen[name, 'meanlog'], sdlog=p.gen[name, 'sdlog'], log = FALSE)
plot(x, y)
help(dlnorm)
plot(sort(pars$L), seq(1, length(pars$L)))




# Density, distribution function, quantile function
# dlnorm, plnorm, qlnorm

# TODO: create arbitrary destribution function
# create a density, distribution and quantile function from data


# Create a density estimate
y1 <- rlnorm(10000, meanlog=p.gen[name, 'meanlog'], sdlog=p.gen[name, 'sdlog'])
y2 <- rlnorm(10000, meanlog=0.5*p.gen[name, 'meanlog'], sdlog=4*p.gen[name, 'sdlog'])
ytest <- c(y1, y2)
plot(ytest)
hist(ytest, breaks=40)
ytest
dtest <- density(ytest, from=0, to=max(ytest), bw=20)
summary(ytest)
plot(dtest)

# Empircal Distribution Functions
# Multivariate Empirical Cumulative Distribution Functions
# ecdf




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
