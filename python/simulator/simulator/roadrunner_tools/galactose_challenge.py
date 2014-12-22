'''
Simulations of galactose challenge.

@author: Matthias Koenig
@date: 2014-12-19
'''
import roadrunner
print roadrunner.__version__

from roadrunner_tools import *
from roadrunner_plots import plot_all

#########################################################################    

VERSION = 79
SBML_DIR = '/home/mkoenig/multiscale-galactose-results/tmp_sbml'

#########################################################################    
# Galactose Challenge
#########################################################################

# load file    
sbml_file = SBML_DIR + '/' + 'Galactose_v{}_Nc20_galchallenge.xml'.format(VERSION)
print sbml_file
r = load_model(sbml_file)

# set selection
sel = ['time']
sel += [ "".join(["[", item, "]"]) for item in r.model.getBoundarySpeciesIds()]
sel += [ "".join(["[", item, "]"]) for item in ['PV__alb', 'PV__gal', 'PV__galM', 'PV__h2oM', 'PV__rbcM', "PV__suc"]]
sel_dict = set_selection(r, sel)
# sel += [ "".join(["[", item, "]"]) for item in r.model.getFloatingSpeciesIds()] 
# sel += [item for item in rr.model.getReactionIds() if item.startswith('H')]

parameters = { "gal_challenge" : 8.0, }
inits = {}
s = simulation(r, sel, parameters, inits)
print s.colnames


# create some plots
plot_all(r)