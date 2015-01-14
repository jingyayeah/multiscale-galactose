'''
#########################################################################    
# Multiple Indicator Dilution
#########################################################################  
Single integration under given flux. These provides a general feeling
how the model is behaving and what the influence of parameter changes is. 
The resulting dilution curves are a combination of dilution curves under
varying fluxes resulting from the flux distribution within the lobulus.
See below for the integrated flux weighted calculation.

Simulation with RoadRunner model for description of the Multiple Indicator
Dilution Data.

@author: Matthias Koenig
@date: 2014-12-19
'''

import roadrunner
print roadrunner.__version__

import roadrunner_tools as rt
import dilution_plots as dp

#########################################################################    
# Load model
#########################################################################    
VERSION = 92
NC = 20
SBML_DIR = '/home/mkoenig/multiscale-galactose-results/tmp_sbml'
T_PEAK = 5000

# sbml_file = SBML_DIR + '/' + 'Galactose_v{}_Nc20_dilution.xml'.format(VERSION)
sbml_file = SBML_DIR + '/' + 'Galactose_v{}_Nc{}_dilution_gauss.xml'.format(VERSION, NC)
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

# sel += [ "".join(["[", item, "]"]) for item in r.model.getFloatingSpeciesIds()] 
# sel += [item for item in rr.model.getReactionIds() if item.startswith('H')]

#########################################################################    
# Set parameters & simulate
######################################################################### 
# set the boundary concentrations
# PP__gal = (0.28, 5, 12.5, 17.5) # [mM]
p_list = [
   { "[PP__gal]" : 0.28, "flow_sin" : 1.5*0.5*270E-6, 't_duration':0.5, 'y_dis': 1.2E-6},
]

inits = {}

# perform simulation
s_list = [rt.simulation(r, p, inits, absTol=1E-4, relTol=1E-4) for p in p_list]

#########################################################################    
# Analyse peaks
######################################################################### 
# find the maximum of the peaks
s = s_list[0]
print '{:20s}{:10s}{:10s}'.format('sid', 'time', 'max')

for sid in ['[PV__{}]'.format(item) for item in compounds]:
    times = s['time']
    data = s[sid]    
    max_value = max(data)
    max_index = [i for i, item in enumerate(data) if item == max_value]
    max_time = times[max_index[0]]
    print '{:20s}{:5.3f}  {:5.3f}'.format(sid, max_time, max_value)

#########################################################################    
# Plots
######################################################################### 
import roadrunner_plots as rp
# mean curve
dp.dilution_plot_pppv(s_list, r.selections)

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