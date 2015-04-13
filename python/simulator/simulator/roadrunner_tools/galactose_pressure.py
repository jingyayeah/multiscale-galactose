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

# plot the pressure & flow profile
def get_P(r):
    ''' Get the pressure vector with respective 
        positions from the model.'''
    Nc = int(r.Nc)
    P = np.zeros(Nc+2)
    x = np.zeros(Nc+2)
    # PP and PV pressure
    pp_id = getPPId()
    pv_id = getPVId()
    P[0] = r[getPressureId(pp_id)]
    P[P.size-1] = r[getPressureId(pv_id)]    
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

def get_Q(r):
    ''' Capillary flow vector. '''
    Nc = int(r.Nc)
    Q = np.zeros(Nc+1)
    x = np.zeros(Nc+1)
    # PP and PV pressure
    pp_id = getPPId()
    pv_id = getPVId()
    Q[0] = r[getQFlowId(pp_id)]
    Q[Q.size-1] = r[getQFlowId(pv_id)]    
    
    x[0] = r[getPositionId(pp_id)]
    x[Q.size-1] = r[getPositionId(pv_id)]
    
    # midpoint sinusoidal pressure
    for k in xrange(Nc-1):
        sid1 = getSinusoidId(k+1)
        sid2 = getSinusoidId(k+2)
        # flow
        Q_str = getQFlowId(sid1, sid2)
        Q[k+1] = r[Q_str]
        # position      
        x_str = getPositionId(sid1, sid2)
        x[k+1] = r[x_str]
        
    return (x, Q)

def get_q(r):
    ''' Pore flow vector. '''
    Nc = int(r.Nc)
    q = np.zeros(Nc)
    x = np.zeros(Nc)
    # midpoint pore flows
    for k in xrange(Nc):
        sid = getSinusoidId(k+1)
        # flow
        q[k] = r[getqFlowId(sid)]
        # position      
        x[k] = r[getPositionId(sid)]
    return (x, q)


import pylab as plt
# plt.figure(num=None, figsize=(8, 6), dpi=80, facecolor='w', edgecolor='k')
f, ax = plt.subplots(2, 2)

# [0, 0] Pressure along sinusoidal unit [mmHg]
x, P = get_P(r)
f_mmHg = 133.322
P = P/f_mmHg

ax[0, 0].plot(x, P)
ax[0, 0].set_xlabel('L [m]')
ax[0, 0].set_ylabel('P [mmHg]')
ax[0, 0].set_ylim([0,1.1*max(P)])

# Flows
x_Q, Q = get_Q(r)  # [m^3/s] volume flow (capillary)
x_q, q = get_q(r)  # [m^2/s] area flow
# check balance of volume flows 
ax[0, 1].plot(x_Q, Q, 'o-')
ax[0, 1].plot(x_q, Q_pore, 'o')
ax[0, 1].plot(x_q, -np.diff(Q), '-')
ax[0, 1].set_xlabel('L [m]')
ax[0, 1].set_ylabel('Q [m^3/s]')
ax[0, 1].set_ylim([-0.4*max(Q),1.1*max(Q)])

# area flow
ax[1, 0].plot(x_q, q)
ax[1, 0].set_xlabel('L [m]')
ax[1, 0].set_ylabel('q [m^2/s]')
ax[1, 0].set_ylim([1.1*min(q),1.1*max(q)])

Q_pore = q*r['x_sin']
ax[1, 1].plot(x_q, Q_pore)
ax[1, 1].set_xlabel('L [m]')
ax[1, 1].set_ylabel('Q_pore [m^3/s]')
ax[1, 1].set_ylim([1.1*min(Q_pore),1.1*max(Q_pore)])

fig = plt.gcf()
fig.set_size_inches(8,8)
plt.show()

##########################################################################
# TODO: make a pressure flow figure (with arrows)
##########################################################################

from matplotlib.patches import Polygon
plt.plot([-1,-1, 21, 21], [0,3,0,3], 'o')

plt.gca().add_patch(plt.Rectangle((1,1),width=1,height=1,
                    color='grey', edgecolor='black' ))


Qtest = plt.quiver( x_Q, 1.5*np.ones_like(x_Q), Q, np.zeros_like(Q), units='inches')
Qtest = plt.quiver( x_q, 1.0*np.ones_like(x_q), np.zeros_like(q), -q, units='inches')
fig = plt.gcf()
fig.set_size_inches(12,4)
plt.ylim([0,3])

plt.show()
# ?plt.quiver
