'''
#########################################################################    
# Pressure dependent flow
#########################################################################  
Simulation, analysis and visualization of the pressure dependent flow model.

@author: Matthias Koenig
@date: 2015-04-13
'''
import copy
import galactose_settings as settings
import roadrunner_tools as rt
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
sel += ["peak", "Vol_sinunit", "Q_sinunit"]
r.selections = sel


#########################################################################    
# Set parameters & simulate
######################################################################### 
reload(settings)
inits = {}

p_list = []
d = copy.deepcopy(settings.D_TEMPLATE)    
d["[PP__gal]"] = 0.28  # periportal galactose
# d["flow_sin"] = settings.F_FLOW * r.flow_sin  
p_list.append(d)

# perform simulations 
reload(rt)
solutions = [rt.simulation(r, p, inits, absTol=1E-8, relTol=1E-8) for p in p_list]


#########################################################################    
# Plot pressures & capillary / pore flows
######################################################################### 
import pylab as plt
import numpy as np
import simulation_tools as st

sol, gp = solutions[0]  # solution matrix and global parameters for simulation

# Static/stationary pressure and flow gradients for given pressure and 
# geometry

# Pressure along sinusoidal unit [Pa]
P = st.get_P(gp)
f_mmHg = 133.322 # [Pa per mmHg]
P.value = P.value/f_mmHg
# flows
Q = st.get_Q(gp)  # [m^3/s] volume flow (capillary)
q = st.get_q(gp)  # [m^2/s] area flow
Q_pore = q.value*gp.ix['x_sin'].value # [m^3/s] pore volume flow


# plot flows and pressure
f, ax = plt.subplots(2, 2)
# pressure
ax[0, 0].plot(P.x, P.value/f_mmHg)
ax[0, 0].set_xlabel('L [m]')
ax[0, 0].set_ylabel('P [mmHg]')
ax[0, 0].set_ylim([0,1.1*max(P.value/f_mmHg)])

# check balance of volume flows 
ax[0, 1].plot(Q.x, Q.value, 'o-')
ax[0, 1].plot(q.x, Q_pore, 'o')
ax[0, 1].plot(q.x, -np.diff(Q.value), '-')
ax[0, 1].set_xlabel('L [m]')
ax[0, 1].set_ylabel('Q [m^3/s]')
ax[0, 1].set_ylim([-0.4*max(Q.value),1.1*max(Q.value)])

# area flow
ax[1, 0].plot(q.x, q.value)
ax[1, 0].set_xlabel('L [m]')
ax[1, 0].set_ylabel('q [m^2/s]')
ax[1, 0].set_ylim([1.1*min(q.value),1.1*max(q.value)])

# volume flow
ax[1, 1].plot(q.x, Q_pore)
ax[1, 1].set_xlabel('L [m]')
ax[1, 1].set_ylabel('Q_pore [m^3/s]')
ax[1, 1].set_ylim([1.1*min(Q_pore),1.1*max(Q_pore)])

fig = plt.gcf()
fig.set_size_inches(8,8)
plt.show()

##########################################################################
# pressure flow figure (with arrows)
##########################################################################
# from matplotlib.patches import Polygon
# plt.plot([min(Q.x),-1, 21, 21], [0,3,0,3], 'o')
# plt.gca().add_patch(plt.Rectangle((1,1),width=1,height=1,
#                     color='grey', edgecolor='black' ))

Qtest = plt.quiver( Q.x, 1.5*np.ones_like(Q.x), Q.value, np.zeros_like(Q.value), units='inches')
Qtest = plt.quiver( q.x, 1.0*np.ones_like(q.x), np.zeros_like(q.value), -q.value, units='inches')
fig = plt.gcf()
fig.set_size_inches(12,4)
plt.ylim([0,3])
plt.show()
# ?plt.quiver
