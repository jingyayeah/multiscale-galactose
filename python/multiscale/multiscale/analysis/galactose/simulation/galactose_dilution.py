"""
Multiple Indicator Dilution Simulation

Single simulation of multiscale model of hepatic galactose metabolism under
given given boundary conditions.
"""

from __future__ import print_function
import os
import copy

import multiscale.analysis.galactose.settings as settings
from multiscale.analysis.galactose.plots import dilution_plots as dp
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
# TODO: fix the flow sinus problem
# d["flow_sin"] = settings.F_FLOW * r.flow_sin

parameters_list = [d]
print('Parameters for simulations:', parameters_list)

# perform simulation
t_start = 0
t_stop = 10000
s_list = [rt.simulation(r, t_start, t_stop, parameters=ps, absTol=1E-3, relTol=1E-3) for ps in parameters_list]
s_list



# ----------------------------------------------------------------------
# Plots
# ----------------------------------------------------------------------
import multiscale.analysis.galactose.plots.roadrunner_plots as rp
reload(dp)
# mean curve
dp.dilution_plot_pppv(s_list, r.selections)
# dp.dilution_plot_pppv(s_list, r.selections, ylim=[0,0.005])


# mean curve with distribution_data
# TODO: proper filepath
exp_file = '/home/mkoenig/multiscale-galactose/results/dilution/Goresky_processed.csv'
exp_data = rp.load_dilution_data(exp_file)
rp.plot_dilution_data(exp_data)


# dp.dilution_plot_by_name(s_list, r.selections, name='peak', xlim=[T_PEAK-5, T_PEAK+5])
# dp.dilution_plot_by_name(s_list, r.selections, name='alb', comp_type='S', xlim=[T_PEAK-10, T_PEAK+20])
# dp.dilution_plot_by_name(s_list, r.selections, name='[D10__alb]', xlim=[T_PEAK-10, T_PEAK+20])

dp.dilution_plot_by_name(s_list, r.selections, name='[PP__galM]')
dp.dilution_plot_by_name(s_list, r.selections, name='[PV__galM]')
dp.dilution_plot_by_name(s_list, r.selections, name='galM', comp_type='D')
dp.dilution_plot_by_name(s_list, r.selections, name='galM', comp_type='S')
dp.dilution_plot_by_name(s_list, r.selections, name='galM', comp_type='C')
dp.dilution_plot_by_name(s_list, r.selections, name='gal', comp_type='C')
dp.dilution_plot_by_name(s_list, r.selections, name='gal1pM', comp_type="C")
dp.dilution_plot_by_name(s_list, r.selections, name='udpgalM', comp_type="C")


dp.dilution_plot_by_name(s_list, r.selections, name='[PV__alb]')
dp.dilution_plot_by_name(s_list, r.selections, name='[PV__rbcM]')

dp.dilution_plot_by_name(s_list, r.selections, name='gal', comp_type='C')
dp.dilution_plot_by_name(s_list, r.selections, name='galM', comp_type='C')
dp.dilution_plot_by_name(s_list, r.selections, name='galM', comp_type='D')

dp.dilution_plot_by_name(s_list, r.selections, name='gal1pM', comp_type="C")
dp.dilution_plot_by_name(s_list, r.selections, name='udpgalM', comp_type="C")
dp.dilution_plot_by_name(s_list, r.selections, name='udpglcM', comp_type="C")

dp.dilution_plot_by_name(s_list, r.selections, name='galM', xlim=[settings.T_PEAK-10, settings.T_PEAK+20])
dp.dilution_plot_by_name(s_list, r.selections, name='galM', xlim=[settings.T_PEAK-10, settings.T_PEAK+20], comp_type="D")
dp.dilution_plot_by_name(s_list, r.selections, name='galM', xlim=[0, 20])
dp.dilution_plot_by_name(s_list, r.selections, name='gal1p')
dp.dilution_plot_by_name(s_list, r.selections, name='galtol')
dp.dilution_plot_by_name(s_list, r.selections, name='GLUT2_GAL', comp_type='D')
dp.dilution_plot_by_name(s_list, r.selections, name='GLUT2_GALM', xlim=[settings.T_PEAK-1, settings.T_PEAK+4], comp_type='D')
dp.dilution_plot_by_name(s_list, r.selections, name='GALK')
dp.dilution_plot_by_name(s_list, r.selections, name='GALKM')
dp.dilution_plot_by_name(s_list, r.selections, name='gal1pM', xlim=[5000, 6000])
dp.dilution_plot_by_name(s_list, r.selections, name='gal1p', xlim=[5000, 6000])
dp.dilution_plot_by_name(s_list, r.selections, name='galM', xlim=[0, 6000])