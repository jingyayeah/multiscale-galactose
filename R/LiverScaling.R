################################################################
## Scaling to whole-liver
################################################################
# This is a crucial part of the model. The results for the 
# specific condition & person have to be generated based on the
# set of simulations for a broad range of conditions.
#
# Use the person/condition specific simulation parameters to scale
# the sample of simulation to the actual result.

# Given: 
# - sample of parameters
# - sample results for the given parameter samples
# - distribution of parameters for the given condition/person 
#   - these can result from whole liver data, i.e. different flow distribution from total 
#     liver flow
# - whole liver volume/mass for scaling. 


# Latin Hypercube sampling
# This
# ‘‘multi-start’’ approach facilitates a broad coverage of the
# parameter search space in order to find the global optimum.
# Latin hypercube sampling [17] of the initial parameter guesses
# can be used to guarantee that each parameter estimation run
# starts in a different region in the high-dimensional parameter
# space. This method prohibits that randomly selected starting
# points are accidentally close to each other (Materials and
#                                              Methods: Latin hypercube sampling).
# 
# For the generation of the initial parameter guesses purely
# random sampling or Latin hypercube sampling [17] can be used
# (Figure 10a,b). Drawing N Latin hypercube samples in 2D can be
# illustrated by dividing the space into N2 boxes. For the first
# sample, one box in the first row is selected and then drawn from
# within this box randomly. For the second sample, one box in the
# second row is selected, except of the columns that have previously
# already been drawn from, and then drawn from within this box
# randomly.
# Latin hypercube sampling is favorable compared to purely
# random generation because Latin hypercube sampling prohibits
# two randomly selected starting points from being accidentally close
# to each other (Figure 10c,d). In contrast, for a random generation
# samples are sometimes very close to each other. Therefore, Latin
# hypercube sampling provides a better coverage of the space.



# author: Matthias Koenig
# date: 2014-04-29

# Load the parameter samples (here the parameters which are changing are defined)
rm(list=ls())   # Clear all objects
library(data.table)
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)

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
hist(pars$y_cell)
names(pars)


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

p <- Model_getParameter(model, 'id_not_in_parameters')
id <- Parameter_getId(p)
value <- Parameter_getValue(p)
print(id)
print(value)


# Get parameters from SBML or parameters and calculate rest from it
# Nf, Nc, L, x_cell, y_sin, y_dis, y_cell, flow_sin
names = c('Nc', 'Nf', 'L', 'y_sin', 'y_dis', 'y_cell', 'flow_sin', 
          'Dalb', 'Dgal', 'Dh2oM', 'DrbcM', 'Dsuc', 'f_fen')
# All names which are not in pars
var_names = setdiff(names, getParsNames(pars)) 
print(var_names)

for (name in var_names){
  p <- Model_getParameter(model, name)
  id <- Parameter_getId(p)
  value <- Parameter_getValue(p)
  print(id)
  print(value)
}

# Create a data <- frame of the calculated values

Dalb	
Dgal
Dh2oM
DrbcM
Dsuc
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






