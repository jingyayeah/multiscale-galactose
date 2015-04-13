'''
#########################################################################    
# Pressure dependent flow
#########################################################################  
Analysis and visualization of the pressure dependent flow model with 
local pore flow.

@author: Matthias Koenig
@date: 2015-04-13
'''
import copy
import galactose_settings as settings
import roadrunner_tools as rt
import dilution_plots as dp
reload(settings)

#########################################################################    
# Load model
#########################################################################    
sbml_file = settings.SBML_DIR + '/' + 'Galactose_v{}_Nc20_dilution.xml'.format(settings.VERSION)
# sbml_file = SBML_DIR + '/' + 'Galactose_v{}_Nc{}_dilution_gauss.xml'.format(VERSION, NC)
r = rt.load_model(sbml_file)

#########################################################################    
# Set selection
#########################################################################
# define the subpart of interest of the simulation
compounds = ['alb', 'gal', 'galM', 'h2oM', 'rbcM', 'suc']
sel = ['time']
sel += ['[{}]'.format(item) for item in r.model.getBoundarySpeciesIds()]
sel += ['[PV__{}]'.format(item) for item in compounds]
sel += ['[PP__{}]'.format(item) for item in compounds]
sel += ['[{}]'.format(item)for item in r.model.getFloatingSpeciesIds() if item.startswith('H')]
sel += ['[{}]'.format(item)for item in r.model.getFloatingSpeciesIds() if item.startswith('S')]
sel += ['[{}]'.format(item)for item in r.model.getFloatingSpeciesIds() if item.startswith('C')]
sel += ['[{}]'.format(item)for item in r.model.getFloatingSpeciesIds() if item.startswith('D')]
sel += [item for item in r.model.getReactionIds() if item.startswith('H')]
sel += [item for item in r.model.getReactionIds() if item.startswith('C')]
sel += [item for item in r.model.getReactionIds() if item.startswith('D')]
sel += [item for item in r.model.getReactionIds() if item.startswith('F_')]


sel += ["peak"]
r.selections = sel


# sel += [ "".join(["[", item, "]"]) for item in r.model.getFloatingSpeciesIds()] 
# sel += [item for item in rr.model.getReactionIds() if item.startswith('H')]

#########################################################################    
# Set parameters & simulate
######################################################################### 
reload(settings)
inits = {}
p_list = []

d = copy.deepcopy(settings.D_TEMPLATE)    
d["[PP__gal]"] = 0.28
d["flow_sin"] = settings.F_FLOW * r.flow_sin  
p_list.append(d)
print d

# perform simulation
s_list = [rt.simulation(r, p, inits, absTol=1E-8, relTol=1E-8) for p in p_list]

sim = s_list[0]

#########################################################################    
# Plot pressures 
######################################################################### 
from pandas import DataFrame
import pandas as pd
# create the global parameter DataFrame
parameters = DataFrame({'value': r.model.getGlobalParameterValues()}, 
                       index = r.model.getGlobalParameterIds())
Nc = int(parameters.ix['Nc'].value)
# much simpler access via direct querying of the roadrunner object


# Create vector of pressures, capillary flows and pore flows
# [PP, S01, S02, ..., SNc, PV] pressure
# Pore flows q
                     
from modelcreator.tools.naming import *

import pylab as p

# plot the pressure & flow profile
def getPressureVector(r):
    ''' Get the pressure vector with respective 
        positions from the model.'''
    Nc = int(r.Nc)
    P = np.zeros(Nc+2)
    x = np.zeros(Nc+2)
    # PP and PV pressure
    pp_id = getPPId()
    pv_id = getPVId()
    P[0] = r[getPressureId(pv_id)]
    P[P.size-1] = r[getPressureId(pp_id)]    
    x[0] = r[getPositionId(pp_id)]
    x[Nc+1] = r[getPositionId(pv_id)]
    
    # midpoint sinusoidal pressure
    for k in xrange(Nc):
        s_id = getSinusoidId(k+1)
        # pressure
        p_str = getPressureId(s_id)
        P[k+1] = r[p_str]
        # position        
        x_str = getPositionId(s_id)
        x[k+1] = r[x_str]
        
    return (x, P)

# plot in mmHg
x, P = getPressureVector(r)
f_mmHg = 322
P = P/f_mmHg
p.plot(x, P)

r.PP_P
r.S01_P


Q = 

                   
                    
                     







