# -*- coding: utf-8 -*-
'''
#########################################################################    
# Galactose Challenge / Clearance
#########################################################################  
Steady state clearance of galactose under given galactose challenge.

@author: Matthias Koenig
@date: 2014-01-15
'''
import roadrunner
print roadrunner.__version__

import roadrunner_tools as rt
import dilution_plots as dp

#########################################################################    
# Load model
#########################################################################    
VERSION = 93
NC = 20
SBML_DIR = '/home/mkoenig/multiscale-galactose-results/tmp_sbml'
T_PEAK = 5000

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
sel += ['[{}]'.format(item)for item in r.model.getFloatingSpeciesIds() if item.startswith('S')]
sel += ['[{}]'.format(item)for item in r.model.getFloatingSpeciesIds() if item.startswith('D')]
sel += [item for item in r.model.getReactionIds() if item.startswith('H')]
sel += [item for item in r.model.getReactionIds() if item.startswith('D')]
sel += ["peak"]
r.selections = sel


#########################################################################    
# Set parameters & simulate
######################################################################### 
flow_sin = 0.5 * r.flow_sin # [m/s] (scaling to calculate in correct volume flow range)

# set the boundary concentrations
# PP__gal = (0.28, 5, 12.5, 17.5) # [mM]
p_list = [
   { "gal_challenge" : 8, 
     "flow_sin" : flow_sin,
     "y_dis" : 2.4E-6,
     "f_cyto" : 0.5,
     "scale_f" : 0.85,           
     "H2OT_f": 5.0,
     "GLUT2_f" : 7, },
]

inits = {}

# perform simulation
s_list = [rt.simulation(r, p, inits, absTol=1E-4, relTol=1E-4) for p in p_list]
import pylab as p
test = s_list[0]
p.plot(test['time'], test['[PV__gal]'])
p.plot(test['time'], test['[PP__gal]'])

# calculate the GEC for given simulation
# removal
Q_sinunit = np.pi * r.y_sin**2 * flow_sin # [m³/s]
Vol_sinunit = r.Vol_sinunit
print Q_sinunit
# Removal
R = Q_sinunit * (test['[PP__gal]'] - test['[PV__gal]'])
# GEC per volume tissue [mmol/min/ml]

GEC = R/r.Vol_sinunit*60/1000    # [mmole/min/ml(liv)]
Q = Q_sinunit/r.Vol_sinunit*60   # [ml/min/ml(liv)]
print GEC[len(GEC)-1]
print Q


p.plot(test['time'], R)
p.plot(test['time'], GEC)



#########################################################################    
# Plots
######################################################################### 
import roadrunner_plots as rp




# mean curve
dp.dilution_plot_pppv(s_list, r.selections)
# dp.dilution_plot_pppv(s_list, r.selections, ylim=[0,0.005])


# mean curve with data
exp_file = '/home/mkoenig/multiscale-galactose/results/dilution/Goresky_processed.csv'
exp_data = rp.load_dilution_data(exp_file)
rp.plot_dilution_data(exp_data)


# dp.dilution_plot_by_name(s_list, r.selections, name='peak', xlim=[T_PEAK-5, T_PEAK+5])
# dp.dilution_plot_by_name(s_list, r.selections, name='alb', comp_type='S', xlim=[T_PEAK-10, T_PEAK+20])
# dp.dilution_plot_by_name(s_list, r.selections, name='[D10__alb]', xlim=[T_PEAK-10, T_PEAK+20])

dp.dilution_plot_by_name(s_list, r.selections, name='gal')
dp.dilution_plot_by_name(s_list, r.selections, name='gal1pM')
dp.dilution_plot_by_name(s_list, r.selections, name='udpgalM')
dp.dilution_plot_by_name(s_list, r.selections, name='udpglcM')

dp.dilution_plot_by_name(s_list, r.selections, name='galM', xlim=[T_PEAK-10, T_PEAK+20])
dp.dilution_plot_by_name(s_list, r.selections, name='galM', xlim=[T_PEAK-10, T_PEAK+20], comp_type="D")
dp.dilution_plot_by_name(s_list, r.selections, name='galM', xlim=[0, 20])
dp.dilution_plot_by_name(s_list, r.selections, name='gal1p')
dp.dilution_plot_by_name(s_list, r.selections, name='galtol')
dp.dilution_plot_by_name(s_list, r.selections, name='GLUT2_GAL', comp_type='D')
dp.dilution_plot_by_name(s_list, r.selections, name='GLUT2_GALM', xlim=[T_PEAK-1, T_PEAK+4], comp_type='D')
dp.dilution_plot_by_name(s_list, r.selections, name='GALK')
dp.dilution_plot_by_name(s_list, r.selections, name='GALKM')
dp.dilution_plot_by_name(s_list, r.selections, name='gal1pM', xlim=[5000, 6000])
dp.dilution_plot_by_name(s_list, r.selections, name='gal1p', xlim=[5000, 6000])
dp.dilution_plot_by_name(s_list, r.selections, name='galM', xlim=[0, 6000])