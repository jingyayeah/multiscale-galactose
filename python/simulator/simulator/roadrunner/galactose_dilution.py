'''
Simulation with RoadRunner model for description of the Multiple Indicator
Dilution Data.

@author: Matthias Koenig
@date: 2014-12-19
'''

import roadrunner
print roadrunner.__version__

import roadrunner_tools as rt
import dilution_plots as dp
reload(rt)
reload(dp)

#########################################################################    

VERSION = 85
NC = 20
SBML_DIR = '/home/mkoenig/multiscale-galactose-results/tmp_sbml'
T_PEAK = 5000

#########################################################################    
# Multiple Indicator Dilution
#########################################################################  
# Single integration under given flux. These provides a general feeling
# how the model is behaving and what the influence of parameter changes 
# is. 
# The resulting dilution curves are a combination of dilution curves under
# varying fluxes resulting from the flux distribution within the lobulus.
# See below for the integrated flux weighted calculation.

# sbml_file = SBML_DIR + '/' + 'Galactose_v{}_Nc20_dilution.xml'.format(VERSION)
sbml_file = SBML_DIR + '/' + 'Galactose_v{}_Nc{}_dilution.xml'.format(VERSION, NC)
r = rt.load_model(sbml_file)

# set selection
compounds = ['alb', 'gal', 'galM', 'h2oM', 'rbcM', 'suc']
sel = ['time']
sel += ['[{}]'.format(item) for item in r.model.getBoundarySpeciesIds()]
sel += ['[PV__{}]'.format(item) for item in compounds]
sel += ['[PP__{}]'.format(item) for item in compounds]
sel += ['[{}]'.format(item)for item in r.model.getFloatingSpeciesIds() if item.startswith('H')]
sel += ['[{}]'.format(item)for item in r.model.getFloatingSpeciesIds() if item.startswith('S')]
sel += ['[{}]'.format(item)for item in r.model.getFloatingSpeciesIds() if item.startswith('D')]
sel += [item for item in r.model.getReactionIds() if item.startswith('H')]
sel += ["peak"]
r.selections = sel

# sel += [ "".join(["[", item, "]"]) for item in r.model.getFloatingSpeciesIds()] 
# sel += [item for item in rr.model.getReactionIds() if item.startswith('H')]

# set the boundary concentrations
# PP__gal = (0.28, 5, 12.5, 17.5) # [mM]
p_list = [
   { "[PP__gal]" : 0.28, "flow_sin" : 0.5*270E-6, 't_duration':1.0, 'y_dis': 2.0E-6},
]
inits = {}

# perform simulation
s_list = [rt.simulation(r, p, inits, absTol=1E-4, relTol=1E-4) for p in p_list]

# find the maximum of the peaks
s = s_list[0]
sel_dic = rt.selection_dict(r.selections)
for sid in ['[PV__{}]'.format(item) for item in compounds]:
    index = sel_dic.get(sid, None)    
    times = s[:, 0]
    data = s[:, index]    
    maximum = max(s[:, index])
    max_index = [i for i, item in enumerate(data) if item == maximum]
    max_time = times[max_index]
    print sid, 'max:', maximum, 'time:', max_time

# general plots 
dp.dilution_plot(s_list, r.selections)


dp.dilution_plot_by_name(s_list, r.selections, name='peak', xlim=[T_PEAK-5, T_PEAK+5])
dp.dilution_plot_by_name(s_list, r.selections, name='alb', comp_type='S', xlim=[T_PEAK-10, T_PEAK+20])
dp.dilution_plot_by_name(s_list, r.selections, name='[D10__alb]', xlim=[T_PEAK-10, T_PEAK+20])
dp.dilution_plot_by_name(s_list, r.selections, name='[PV__alb]', xlim=[T_PEAK-10, T_PEAK+20])

dp.dilution_plot_by_name(s_list, r.selections, name='galM', xlim=[T_PEAK-10, T_PEAK+20])
dp.dilution_plot_by_name(s_list, r.selections, name='galM', xlim=[0, 20])
dp.dilution_plot_by_name(s_list, r.selections, name='gal')
dp.dilution_plot_by_name(s_list, r.selections, name='gal1pM')
dp.dilution_plot_by_name(s_list, r.selections, name='gal1p')
dp.dilution_plot_by_name(s_list, r.selections, name='galtol')
dp.dilution_plot_by_name(s_list, r.selections, name='GLUT2_GAL')
dp.dilution_plot_by_name(s_list, r.selections, name='GLUT2_GALM', xlim=[T_PEAK-1, T_PEAK+4])
dp.dilution_plot_by_name(s_list, r.selections, name='GALK')
dp.dilution_plot_by_name(s_list, r.selections, name='GALKM')
dp.dilution_plot_by_name(s_list, r.selections, name='gal1pM', xlim=[5000, 6000])
dp.dilution_plot_by_name(s_list, r.selections, name='gal1p', xlim=[5000, 6000])