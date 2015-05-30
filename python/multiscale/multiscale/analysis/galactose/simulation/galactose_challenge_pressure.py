# -*- coding: utf-8 -*-
"""
Galactose Challenge

Variation under different periportal pressures and periportal galactose 
challenges. Model is simulated to steady state under the given conditions.

"""

import os
import copy
import numpy as np

from multiscale.analysis.galactose import settings as settings
import multiscale.odesim.simulate.roadrunner_tools as rt

reload(settings)

# -----------------------------------------------------------------------------
# Load model
# -----------------------------------------------------------------------------
sbml_file = os.path.join(settings.SBML_DIR, 'Galactose_v{}_Nc20_galchallenge.xml'.format(settings.VERSION))
r = rt.load_model(sbml_file)

# -----------------------------------------------------------------------------
# Set selection
# -----------------------------------------------------------------------------
compounds = ['alb', 'gal', 'galM', 'h2oM', 'rbcM', 'suc']  # PP/PV species
sel = ['time']
sel += ['[PP__{}]'.format(item) for item in compounds]
sel += ['[PV__{}]'.format(item) for item in compounds]
sel += ['[{}]'.format(item)for item in r.model.getFloatingSpeciesIds() if item.startswith('H')]
sel += ['[{}]'.format(item)for item in r.model.getFloatingSpeciesIds() if item.startswith('D')]
sel += [item for item in r.model.getReactionIds() if item.startswith('H')]
sel += [item for item in r.model.getReactionIds() if item.startswith('D')]
sel += ["peak", 'PP_Q', 'Q_sinunit', 'Vol_sinunit', 'Pa']
r.selections = sel

# -----------------------------------------------------------------------------
# Set parameters & simulate
# -----------------------------------------------------------------------------
# integrations time
t_start = 0
t_stop = 10000
absolute = 1E-4
relative = 1E-4

# [A] Simulation of pressure dependency
# TODO: proper definition in mmHg (consistency) & offset of pressure from base pressure
print '# Pressure Dependency #'
pressure = np.linspace(2.1, 10, num=10)     # [mmHg]
f_Pa_per_mmHg = 133.322
pressure = pressure * f_Pa_per_mmHg # [Pa]

pa_pars = []
for pa in pressure:
    d = copy.deepcopy(settings.D_TEMPLATE)    
    d["Pa"] = pa
    pa_pars.append(d)

# perform simulation
pa_solutions = []
for ps in pa_pars:
    s, gp = rt.simulation(r, t_start, t_stop, parameters=ps, absTol=absolute, relTol=relative)
    pa_solutions.append(s)


# [B] Simulation galactose dependency
print '# Galactose Dependency #'
gal_challenge = np.arange(start=0, stop=9.0, step=1.0)
gal_pars = []
for gal in gal_challenge:
    d = copy.deepcopy(settings.D_TEMPLATE)    
    d["gal_challenge"] = gal
    gal_pars.append(d)
    
# perform simulation
gal_solutions = []
for ps in gal_pars:
    s, gp = rt.simulation(r, t_start, t_stop, parameters=ps, absTol=absolute, relTol=relative)
    gal_solutions.append(s)



#########################################################################    
# Calculate clearance parameters
######################################################################### 
# calculate GEC for simulations
# GE is already scaled to the tissue & correct units
def get_par_from_solutions(name, solutions):
    res = np.zeros(len(solutions))
    for k, s in enumerate(solutions):
        res[k] = s[name][0]
    return res

# Account for large vessel structure
f_tissue = 0.8

# TODO: provide set of analysis functions to calculate these values directly
# from the time courses. I.e. rewrite the analysis performed in R to python.


# Calculate galactose elimination (perfusion dependence)
Q_sinunit = get_par_from_solutions('Q_sinunit', pa_solutions)      # [m³/s]
Vol_sinunit = get_par_from_solutions('Vol_sinunit', pa_solutions)  # [m³]
GE_pa = np.zeros_like(pressure)   # galactose elimination
P_pa = np.zeros_like(pressure)         # perfusion
for k,s in enumerate(pa_solutions):
    R = Q_sinunit[k] * (s['[PP__gal]'] - s['[PV__gal]'])    # GE removal
    GE_pa[k] = R[len(R)-1]/Vol_sinunit[k]*60 * f_tissue         # [µmole/min/ml(liv)] 
    P_pa[k] = Q_sinunit[k]/Vol_sinunit[k]*60 * f_tissue         # [ml/min/ml(liv)]

import pylab as plt
plt.plot(Vol_sinunit, 'o-')
plt.plot(Q_sinunit, 'o-')
plt.plot(Q_sinunit/Vol_sinunit, 'o-')

# Calculate galactose elimination (galactose dependence)
Q_sinunit = get_par_from_solutions('Q_sinunit', gal_solutions)      # [m³/s]
Vol_sinunit = get_par_from_solutions('Vol_sinunit', gal_solutions)  # [m³]
GE_gal = np.zeros_like(gal_challenge)
for k,s in enumerate(gal_solutions):
    R = Q_sinunit[k] * (s['[PP__gal]'] - s['[PV__gal]'])
    GE_gal[k] = R[len(R)-1]/Vol_sinunit[k]*60 *f_tissue    # [µmole/min/ml(liv)]


#########################################################################    
# Figures
######################################################################### 
import pylab as plt
# Galactose elimination vs galactose challenge
plt.plot(gal_challenge, GE_gal, '-k')
plt.plot(gal_challenge, GE_gal, 'ok')
plt.xlabel('galactose [mmol/L]')
plt.ylabel('GE [mmole/min/ml(liv)]')
plt.show()

# PP - PV gal difference
for s in gal_solutions:
    plt.plot(s['time'], s['[PP__gal]'], '-b')    
    plt.plot(s['time'], s['[PV__gal]'], '-k')    
plt.xlim([0, 10000])
plt.title('PP and PV galactose')
plt.xlabel('time [s]')
plt.ylabel('galactose [mM]')
plt.show()

plt.plot(GE_pa, 'o-')
plt.plot(P_pa, 'o-')


# GE curve vs perfusion
plt.plot(P_pa, GE_pa, '-k')
plt.plot(P_pa, GE_pa, 'ok')
plt.title('GE vs. Perfusion')
plt.xlabel('P [ml/min/ml(liv)]')
plt.ylabel('GE [mumole/min/ml(liv)]')
plt.show()


# GE per liver liver
vol_liv = 1500   # [ml] reference volume liver
print 'GEC [mmole/min]:', GE_pa*vol_liv/1000

plt.plot(P_pa*vol_liv, GE_pa*vol_liv, '-k')
plt.plot(P_pa*vol_liv, GE_pa*vol_liv, 'ok')
plt.xlabel('Q [ml/min]')
plt.ylabel('GE [mmole/min]')
plt.title('GEC vs. Perfusion')
plt.show()
