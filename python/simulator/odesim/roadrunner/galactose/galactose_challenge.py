# -*- coding: utf-8 -*-
"""
#########################################################################
# Galactose Challenge / Clearance
#########################################################################
Steady state clearance of galactose under given galactose challenge.
Here the clearance parameters and the GEC can be calculated from the model.

@author: Matthias Koenig
@date: 2015-02-12
"""
import copy
import numpy as np
import galactose_settings as settings
import roadrunner_tools as rt
reload(settings)

#########################################################################    
# Load model
#########################################################################    
sbml_file = settings.SBML_DIR + '/' + 'Galactose_v{}_Nc20_galchallenge.xml'.model_format(settings.VERSION)
r = rt.load_model(sbml_file)

#########################################################################    
# Set selection
#########################################################################    
compounds = ['alb', 'gal', 'galM', 'h2oM', 'rbcM', 'suc']
sel = ['time']
sel += ['[{}]'.model_format(item) for item in r.model.getBoundarySpeciesIds()]
sel += ['[PV__{}]'.model_format(item) for item in compounds]
sel += ['[PP__{}]'.model_format(item) for item in compounds]
sel += ['[{}]'.model_format(item)for item in r.model.getFloatingSpeciesIds() if item.startswith('H')]
sel += ['[{}]'.model_format(item)for item in r.model.getFloatingSpeciesIds() if item.startswith('D')]
sel += [item for item in r.model.getReactionIds() if item.startswith('H')]
sel += [item for item in r.model.getReactionIds() if item.startswith('D')]
sel += ["peak"]
r.selections = sel

#########################################################################    
# Set parameters & simulate
######################################################################### 
reload(settings)

# flow dependency
f_sin1 = np.arange(start=0, stop=0.3, step=0.05) * r.flow_sin # [m/s] (scaling to calculate in correct volume flow range)
f_sin2 = np.arange(start=0.3, stop=1.6, step=0.3) * r.flow_sin # [m/s] (scaling to calculate in correct volume flow range)
flow_sin = np.concatenate((f_sin1, f_sin2))

# gal dependency
gal_challenge = np.arange(start=0, stop=9.0, step=1.0)

inits = {}
# template of general parameter changes

# flow dependency
p_list = []
for f in flow_sin:
    d = copy.deepcopy(settings.D_TEMPLATE)    
    d["flow_sin"] = f
    p_list.append(d)
print '# Flow Dependency #'
s_list = [rt.simulation(r, p, inits, absTol=1E-4, relTol=1E-4) for p in p_list]

# gal dependency
pgal_list = []
for gal in gal_challenge:
    d = copy.deepcopy(settings.D_TEMPLATE)    
    d["gal_challenge"] = gal
    d["flow_sin"] = settings.F_FLOW * r.flow_sin  
    pgal_list.append(d)
print '# Galactose Dependency #'
# perform odesim
sgal_list = [rt.simulation(r, p, inits, absTol=1E-4, relTol=1E-4) for p in pgal_list]

#########################################################################    
# Calculate clearance parameters
######################################################################### 
# calculate the GEC for given odesim
import numpy as np
# ?? what is going on here ??
Q_sinunit = np.pi * r.y_sin**2 * flow_sin # [m³/s]
Vol_sinunit = r.Vol_sinunit   # has to be calculated with the actual variables
f_modvol = (r.L * np.pi * (r.y_sin + r.y_end + r.y_dis + 8.39E-6*1.12)**2)/r.Vol_sinunit
# print f_modvol

# Account for large vessel structure
f_tissue = 0.8

# Calculate galactose elimination (perfusion dependence)
GE = np.zeros(len(flow_sin))
P = np.zeros(len(flow_sin))
for k,s in enumerate(s_list):
    R = Q_sinunit[k] * (s['[PP__gal]'] - s['[PV__gal]'])
    GE[k] = R[len(R)-1]/r.Vol_sinunit*60 * f_tissue         # [µmole/min/ml(liv)]
    P[k] = Q_sinunit[k]/r.Vol_sinunit*60 * f_tissue         # [ml/min/ml(liv)]

# Calculate galactose elimination (galactose dependence)
GEgal = np.zeros(len(gal_challenge))
for k,s in enumerate(sgal_list):
    Q_sinunit_gal = np.pi * r.y_sin**2 * 0.5*r.flow_sin # [m³/s]
    R = Q_sinunit_gal * (s['[PP__gal]'] - s['[PV__gal]'])
    GEgal[k] = R[len(R)-1]/r.Vol_sinunit*60 *f_tissue    # [µmole/min/ml(liv)]


#########################################################################    
# Figures
######################################################################### 
import pylab as p
p.plot(gal_challenge, GEgal, '-k')
p.plot(gal_challenge, GEgal, 'ok')
p.xlabel('galactose [mmol/L]')
p.ylabel('GE [mmole/min/ml(liv)]')
p.show()

# PP - PV gal difference
import pylab as p
for s in s_list:
    p.plot(s['time'], s['[PP__gal]'], '-b')    
    p.plot(s['time'], s['[PV__gal]'], '-k')    
p.xlim([0, 10000])
p.title('PP and PV galactose')
p.xlabel('time [s]')
p.ylabel('galactose [mM]')
p.show()

# GE curve
import pylab as p
p.plot(P, GE, '-k')
p.plot(P, GE, 'ok')
p.xlabel('P [ml/min/ml(liv)]')
p.ylabel('GE [µmole/min/ml(liv)]')
p.title('GE vs. Perfusion')
p.show()


# GE per liver liver
vol_liv = 1500 # [ml] reference volume liver
print 'GEC [mmole/min]:', max(GE)*vol_liv

p.plot(P*vol_liv, GE*vol_liv, '-k')
p.plot(P*vol_liv, GE*vol_liv, 'ok')
p.xlabel('Q [ml/min]')
p.ylabel('GE [mmole/min]')
p.title('GEC vs. Perfusion')
p.show()
