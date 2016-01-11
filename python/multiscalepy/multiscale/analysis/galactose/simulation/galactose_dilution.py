"""
Multiple Indicator Dilution Simulation

Single simulation of multiscale model of hepatic galactose metabolism under
given given boundary conditions.
"""

from __future__ import print_function
import os
import copy

import multiscale.modelcreator.utils.naming as naming
import multiscale.analysis.galactose.settings as settings
import multiscale.odesim.simulate.roadrunner_tools as rt


# ----------------------------------------------------------------------
# Load model
# ----------------------------------------------------------------------
core_id = 'Galactose_v{}_Nc20_dilution.xml'
# core_id = 'Galactose_v{}_Nc{}_dilution_gauss.xml'
sbml_path = os.path.join(settings.SBML_DIR, core_id.format(settings.VERSION))
print('SBML model:', sbml_path)
r = rt.load_model(sbml_path)

# ----------------------------------------------------------------------
# Set selection
# ----------------------------------------------------------------------

# load SBML and get the species ids
import libsbml
doc = libsbml.readSBMLFromFile(sbml_path)
species_ids = [s.id for s in doc.getModel().getListOfSpecies()]

def filter_items(items, f_filter):
    return sorted([item for item in items if f_filter(item)])

pp_species = filter_items(species_ids, naming.isPPSpeciesId)
pv_species = filter_items(species_ids, naming.isPVSpeciesId)
print(pv_species)
print(pp_species)

sel = ['time']
sel += ['[{}]'.format(item) for item in pp_species]
sel += ['[{}]'.format(item) for item in pv_species]
sel += ['[{}]'.format(item)for item in r.model.getFloatingSpeciesIds() if item.startswith('C')]
sel += ['[{}]'.format(item)for item in r.model.getFloatingSpeciesIds() if item.startswith('H')]
sel += ['[{}]'.format(item)for item in r.model.getFloatingSpeciesIds() if item.startswith('D')]
sel += ['[{}]'.format(item)for item in r.model.getFloatingSpeciesIds() if item.startswith('S')]

sel += [item for item in r.model.getReactionIds() if item.startswith('C')]
sel += [item for item in r.model.getReactionIds() if item.startswith('H')]
sel += [item for item in r.model.getReactionIds() if item.startswith('D')]
sel += ["peak"]
r.selections = sel
print('r.selections:', r.selections)

# ----------------------------------------------------------------------
# Set parameters & simulate
# ----------------------------------------------------------------------
reload(settings)
inits = {}

# copy the template and set additional parameters
d = copy.deepcopy(settings.D_TEMPLATE)    
d["[PP__gal]"] = 0.28
# TODO: fix the flow sinus problem (why not needed here?, what happens to the scaling in the pressure case)
# d["flow_sin"] = settings.F_FLOW * r.flow_sin

parameters_list = [d]
print('Parameters for simulations:', parameters_list)

# perform simulation
t_start = 0
t_stop = 10000
s_list = []
for ps in parameters_list:
    s, gp = rt.simulate(r, t_start, t_stop, parameters=ps, absTol=1E-5, relTol=1E-5)
    s_list.append(s)

# ----------------------------------------------------------------------
# Print maximum values of the dilution peaks
# ----------------------------------------------------------------------
from multiscale.modelcreator.utils import naming
from multiscale.analysis.galactose import misc_tools
reload(misc_tools)

# ['[PV__alb]', '[PV__gal]', '[PV__galM]', '[PV__h2oM]', '[PV__rbcM]', '[PV__suc]']
pv_concentrations = ['[{}]'.format(item) for item in pv_species]
peak_dict = misc_tools.find_peaks(s_list[0], pv_concentrations)
misc_tools.print_peaks(peak_dict)

# ----------------------------------------------------------------------
# Plots
# ----------------------------------------------------------------------
import multiscale.analysis.galactose.plot_tools as pt
reload(pt)
# plot the dilution curve
pt.pppv_plot(s_list)
pt.pppv_plot(s_list, ylim=[0,0.5])
pt.pppv_plot(s_list, ylim=[0,0.005])


# mean curve with distribution_data
import os
from multiscale.multiscale_settings import MULTISCALE_GALACTOSE
exp_file = os.path.join(MULTISCALE_GALACTOSE, 'results', 'dilution', 'Goresky_processed.csv')
exp_data = pt.load_dilution_data(exp_file)
pt.plot_dilution_data(exp_data)


# pt.dilution_plot_by_name(s_list, r.selections, name='peak', xlim=[T_PEAK-5, T_PEAK+5])
# pt.dilution_plot_by_name(s_list, r.selections, name='alb', comp_type='S', xlim=[T_PEAK-10, T_PEAK+20])
# pt.dilution_plot_by_name(s_list, r.selections, name='[D10__alb]', xlim=[T_PEAK-10, T_PEAK+20])

pt.dilution_plot_by_name(s_list, r.selections, name='[PP__galM]')
pt.dilution_plot_by_name(s_list, r.selections, name='[PV__galM]')
pt.dilution_plot_by_name(s_list, r.selections, name='galM', comp_type='D')
pt.dilution_plot_by_name(s_list, r.selections, name='galM', comp_type='S')
pt.dilution_plot_by_name(s_list, r.selections, name='galM', comp_type='C')
pt.dilution_plot_by_name(s_list, r.selections, name='gal', comp_type='C')
pt.dilution_plot_by_name(s_list, r.selections, name='gal1pM', comp_type="C")
pt.dilution_plot_by_name(s_list, r.selections, name='udpgalM', comp_type="C")


pt.dilution_plot_by_name(s_list, r.selections, name='[PV__alb]')
pt.dilution_plot_by_name(s_list, r.selections, name='[PV__rbcM]')

pt.dilution_plot_by_name(s_list, r.selections, name='gal', comp_type='C')
pt.dilution_plot_by_name(s_list, r.selections, name='galM', comp_type='C')
pt.dilution_plot_by_name(s_list, r.selections, name='galM', comp_type='D')

pt.dilution_plot_by_name(s_list, r.selections, name='gal1pM', comp_type="C")
pt.dilution_plot_by_name(s_list, r.selections, name='udpgalM', comp_type="C")
pt.dilution_plot_by_name(s_list, r.selections, name='udpglcM', comp_type="C")

pt.dilution_plot_by_name(s_list, r.selections, name='galM', xlim=[settings.T_PEAK-10, settings.T_PEAK+20], comp_type="C")
pt.dilution_plot_by_name(s_list, r.selections, name='galM', xlim=[settings.T_PEAK-10, settings.T_PEAK+20], comp_type="D")
pt.dilution_plot_by_name(s_list, r.selections, name='galM', xlim=[0, 20], comp_type="C")
pt.dilution_plot_by_name(s_list, r.selections, name='gal1p', comp_type="C")
pt.dilution_plot_by_name(s_list, r.selections, name='galtol', comp_type="C")
pt.dilution_plot_by_name(s_list, r.selections, name='GLUT2_GAL', comp_type='D')
pt.dilution_plot_by_name(s_list, r.selections, name='GLUT2_GALM', xlim=[settings.T_PEAK-1, settings.T_PEAK+4], comp_type='D')
pt.dilution_plot_by_name(s_list, r.selections, name='GALK', comp_type="C")
pt.dilution_plot_by_name(s_list, r.selections, name='GALKM', comp_type="C")
pt.dilution_plot_by_name(s_list, r.selections, name='gal1pM', xlim=[5000, 6000], comp_type="C")
pt.dilution_plot_by_name(s_list, r.selections, name='gal1p', xlim=[5000, 6000], comp_type="C")
pt.dilution_plot_by_name(s_list, r.selections, name='galM', xlim=[0, 6000], comp_type="C")