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

# author: Matthias Koenig
# date: 2014-04-29


# Load the parameter samples (additional variables have to be written)




# Load the corresponding simulation results of interest

# Define distribution of parameters which should be used for the calculation

# Calculate the mean/std results based on the integration over the parameter distribution

# Scale to whole liver function






