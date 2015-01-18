# -*- coding: utf-8 -*-
'''
#########################################################################    
# Galactose Challenge / Clearance
#########################################################################  
Steady state clearance of galactose under given galactose challenge.
Here the clearance parameters and the GEC can be calculated from the model.

@author: Matthias Koenig
@date: 2014-01-15
'''

import roadrunner_tools as rt

#########################################################################    
# Load model
#########################################################################    
VERSION = 97
SBML_DIR = '/home/mkoenig/multiscale-galactose-results/tmp_sbml'
sbml_file = SBML_DIR + '/' + 'Galactose_v{}_Nc20_galchallenge.xml'.format(VERSION)
r = rt.load_model(sbml_file)

#########################################################################    
# Set selection
#########################################################################    
compounds = ['alb', 'gal', 'galM', 'h2oM', 'rbcM', 'suc']
sel = ['time']
sel += ['[{}]'.format(item) for item in r.model.getBoundarySpeciesIds()]
sel += ['[PV__{}]'.format(item) for item in compounds]
sel += ['[PP__{}]'.format(item) for item in compounds]
sel += ['[{}]'.format(item)for item in r.model.getFloatingSpeciesIds() if item.startswith('H')]
sel += ['[{}]'.format(item)for item in r.model.getFloatingSpeciesIds() if item.startswith('D')]
sel += [item for item in r.model.getReactionIds() if item.startswith('H')]
sel += [item for item in r.model.getReactionIds() if item.startswith('D')]
sel += ["peak"]
r.selections = sel

#########################################################################    
# Set parameters & simulate
######################################################################### 
import numpy as np
flow_sin = np.arange(start=0, stop=0.8, step=0.05) * r.flow_sin # [m/s] (scaling to calculate in correct volume flow range)

# set the boundary concentrations
# PP__gal = (0.28, 5, 12.5, 17.5) # [mM]
p_list = []
for f in flow_sin:
    d = { "gal_challenge" : 8,  
              "flow_sin" : f,     

              "y_dis" : 2.3E-6,
              # "y_cell" : 8.39E-6,
              
              # "f_cyto" : 0.4,
              # "scale_f" : 0.43,
              #"GALK_PA" : 0.024,
              # "GLUT2_f" : 10.0,              
              # "H2OT_f": 5.0,         
             }
    p_list.append(d)

inits = {}

# perform simulation
s_list = [rt.simulation(r, p, inits, absTol=1E-4, relTol=1E-4) for p in p_list]

#########################################################################    
# Calculate clearance parameters
######################################################################### 

# calculate the GEC for given simulation
import numpy as np
Q_sinunit = np.pi * r.y_sin**2 * flow_sin # [m³/s]
Vol_sinunit = r.Vol_sinunit   # has to be calculated with the actual variables
print (r.L * np.pi * (r.y_sin + r.y_end + r.y_dis + r.y_cell*1.4)**2)/r.Vol_sinunit



# Removal
GEC = np.zeros(len(flow_sin))
Q = np.zeros(len(flow_sin))

for k,s in enumerate(s_list):
    R = Q_sinunit[k] * (s['[PP__gal]'] - s['[PV__gal]'])
    GEC[k] = R[len(R)-1]/r.Vol_sinunit*60/1000    # [mmole/min/ml(liv)]
    Q[k] = Q_sinunit[k]/r.Vol_sinunit*60   # [ml/min/ml(liv)]

print 'GEC:', GEC, '[mmole/min/ml(liv)]'
print 'Q: {} [ml/min/ml(liv)]'.format(Q)


#########################################################################    
# Figures
######################################################################### 

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


# Add line for the used flow factor in dilution
f_fac = 0.45
Q_fac = np.pi * r.y_sin**2 * f_fac * r.flow_sin/r.Vol_sinunit*60 # [m³/s]
print 'Q_fac:', Q_fac

# GEC curve
import pylab as p
p.plot(Q, GEC, '-k')
p.plot(Q, GEC, 'ok')
p.plot([Q_fac, Q_fac], [0, max(GEC)])
p.xlabel('Q [ml/min/ml(liv)]')
p.ylabel('GEC [mmole/min/ml(liv)]')
p.title('GEC vs. Perfusion')
p.show()


# Real GEC value liver
f_vol = 0.8 # [-] volume which is parenchyma
vol_liv = 1500 # [ml] reference volume liver

print 'Q_fac cor:', Q_fac/f_vol 
print 'GEC cor:', f_vol*max(GEC)*vol_liv

p.plot(f_vol*Q, f_vol*GEC*vol_liv, '-k')
p.plot(f_vol*Q, f_vol*GEC*vol_liv, 'ok')
p.plot([Q_fac/f_vol, Q_fac/f_vol], [0, f_vol*max(GEC)*vol_liv])
p.xlabel('P [ml/min/ml(liv)]')
p.ylabel('GEC liver [mmole/min]')
p.title('GEC liver vs. Perfusion')
p.show()
# print 'Perfusion', f_vol*Q, '[ml/min/ml(liv)]'
# print 'GEC liver',  GEC*vol_liv, '[mmole/min]'

