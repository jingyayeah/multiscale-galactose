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
names(pars)

# - sample results for the given parameter samples
#   (for every sample configuration results are calculated, consisting of 
#    derived geometrical parameters, and simulation results like timecourse 
#    simulations)

# Get the additional parameters from the SBML file directly necessary for scaling, i.e 
# calculate from the formulas
# i.e. evalutate the AST nodes
# What is needed ?
# The Volumes ?
library('libSBML')
filename = filename <- '/home/mkoenig/multiscale-galactose-results/tmp_sbml/Galactose_v14_Nc20_Nf1.xml'
doc        = readSBML(filename);
errors   = SBMLDocument_getNumErrors(doc);
SBMLDocument_printErrors(doc);
model = SBMLDocument_getModel(doc);

# Get parameters from SBML or parameters and calculate rest from it
# Nf, Nc, L, x_cell, y_sin, y_dis, y_cell, flow_sin
names = c('Nc', 'Nf', 'L', 'y_sin', 'y_dis', 'y_cell', 'flow_sin', 'f_fen')
# All names which are not in pars
var_names = setdiff(names, getParsNames(pars)) 
print(var_names)

# Get all parameter names
lofp <- Model_getListOfParameters(model)
Np <- ListOf_size(lofp)
p_names <- character(Np)
for (k in seq(0, (Np-1))){  
    p <- ListOfParameters_get(lofp, k)
    p_names[k+1] <- Parameter_getId(p)
}

for (name in var_names){
    if (name %in% p_names){
        p <- Model_getParameter(model, name)
        print(Parameter_getId(p))    
    } else {
      cat('parameter not in model:', name, '\n')    
    }
}

# showClass("_p_Parameter")
# showMethods("_p_Parameter")


# Create a data <- frame of the calculated values

# 

sb <- Model_getElementBySId(model, "test")
sb

f_fen

# Calculate derived values
Nb   = 	Nf*Nc 		
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
 

# The two conversion factors have to be the same
# But they have to be calculated over the distribution of geometries
# => this is postprocessing
# N_Q = Q_liv/Q_sinunit;
# N_Vol = N_Q
# f_tissue = 1/N_Q * Vol_liv/Vol_sinunit

# All of the values have calculated distributions, which can be compared with
# the experimental values





# Here formulas which have to correspond to the total formulas




# Load the corresponding simulation results of interest


# Define distributions of parameters which should be used for the calculation



# Calculate the mean/std results based on the integration over the parameter distribution

# Scale to whole liver function

# TODO: evaluate the convergence of the method depending on the number of 
#       drawn samples.




