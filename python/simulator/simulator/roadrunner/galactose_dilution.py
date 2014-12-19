'''
Simulation with RoadRunner model for description of the Multiple Indicator
Dilution Data.

@author: Matthias Koenig
@date: 2014-12-19
'''

import roadrunner
print roadrunner.__version__

from roadrunner_tools import *

import dilution_plots as dp
reload(dp)

#########################################################################    

VERSION = 79
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

sbml_file = SBML_DIR + '/' + 'Galactose_v{}_Nc20_dilution.xml'.format(VERSION)
# sbml_file = SBML_DIR + '/' + 'Galactose_v{}_Nc20_dilution_gauss.xml'.format(VERSION)
r = load_model(sbml_file)

# set selection
sel = ['time']
sel += [ "".join(["[", item, "]"]) for item in r.model.getBoundarySpeciesIds()]
sel += [ "".join(["[", item, "]"]) for item in ['PV__alb', 'PV__gal', 'PV__galM', 'PV__h2oM', 'PV__rbcM', "PV__suc"]]
sel += [ "".join(["[", item, "]"]) for item in r.model.getFloatingSpeciesIds() if item.startswith('H')]
sel += [item for item in r.model.getReactionIds() if item.startswith('H')]
sel += ["peak"]
sel_dict = set_selection(r, sel)

# sel += [ "".join(["[", item, "]"]) for item in r.model.getFloatingSpeciesIds()] 
# sel += [item for item in rr.model.getReactionIds() if item.startswith('H')]

# set the boundary concentrations
# PP__gal = (0.28, 5, 12.5, 17.5) # [mM]
p_list = [
   { "[PP__gal]" : 0.28, "flow_sin" : 0.5*270E-6, 't_duration':1.0, 'y_dis': 2.0E-6, 'Dsuc': 1.0*9.1E-10},
   { "[PP__gal]" : 0.28, "flow_sin" : 0.5*270E-6, 't_duration':1.0, 'y_dis': 2.0E-6, 'Dsuc': 0.8*9.1E-10},
   { "[PP__gal]" : 0.28, "flow_sin" : 0.5*270E-6, 't_duration':1.0, 'y_dis': 2.0E-6, 'Dsuc': 0.5*9.1E-10},
]
inits = {}

# perform simulation
s_list = [simulation(r, sel, p, inits, absTol=1E-8, relTol=1E-8) for p in p_list]
reload(dp)
dp.dilution_plot(s_list, r.selections, xlim=None, ylim=None)
dp.dilution_plot(s_list, r.selections)

# s1 = s_list[1]
# import pylab as plt
# plt.plot(s1[:, sel_dict['time']], s1[:, sel_dict['peak']])
# plt.xlim([4995, 5010])
# plt.show()

dp.dilution_plot_by_name(s_list, r.selections, name='peak', xlim=[t_peak-5, t_peak+5])
dp.dilution_plot_by_name(s_list, r.selections, name='galM', xlim=[t_peak-10, t_peak+20])
dp.dilution_plot_by_name(s_list, r.selections, name='galM', xlim=[0, 20])
dp.dilution_plot_by_name(s_list, r.selections, name='gal')
dp.dilution_plot_by_name(s_list, r.selections, name='gal1pM')
dp.dilution_plot_by_name(s_list, r.selections, name='gal1p')
dp.dilution_plot_by_name(s_list, r.selections, name='galtol')
dp.dilution_plot_by_name(s_list, r.selections, name='GLUT2_GAL')
dp.dilution_plot_by_name(s_list, r.selections, name='GLUT2_GALM', xlim=[t_peak-1, t_peak+4])
dp.dilution_plot_by_name(s_list, r.selections, name='GALK')
dp.dilution_plot_by_name(s_list, r.selections, name='GALKM')
dp.dilution_plot_by_name(s_list, r.selections, name='gal1pM', xlim=[5000, 6000])
dp.dilution_plot_by_name(s_list, r.selections, name='gal1p', xlim=[5000, 6000])


