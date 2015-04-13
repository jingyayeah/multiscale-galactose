# -*- coding: utf-8 -*-
"""
Dilution curves via integration over the distribution of pressures, resulting
in distribution of flows.
The advanced model uses the actual pressures to calculate the fluxes with
the given geometry.

@author: Matthias Koenig
@date: 2015-04-13
"""
import numpy as np
import copy
import galactose_functions as gf
import roadrunner_tools as rt
import roadrunner_plots as rp
import galactose_settings as settings

reload(settings)
reload(rp)
reload(gf)

#########################################################################    
# Flux integration of curves
#########################################################################  
# sbml_file = SBML_DIR + '/' + 'Galactose_v{}_Nc20_dilution_gauss.xml'.format(VERSION)
sbml_file = settings.SBML_DIR + '/' + 'Galactose_v{}_Nc20_dilution.xml'.format(settings.VERSION)
r = rt.load_model(sbml_file)

# selection
inits = {}
sel = ['time']
sel += [ "".join(["[", item, "]"]) for item in ['PV__alb', 'PV__gal', 'PV__galM', 'PV__h2oM', 'PV__rbcM', "PV__suc"]]
sel += [ "".join(["[", item, "]"]) for item in r.model.getBoundarySpeciesIds()]
sel += [ "".join(["[", item, "]"]) for item in r.model.getFloatingSpeciesIds() if item.startswith('H')]
sel += [ "".join(["[", item, "]"]) for item in r.model.getFloatingSpeciesIds() if item.startswith('D')]
sel += [item for item in r.model.getReactionIds() if item.startswith('H')]
sel += [item for item in r.model.getReactionIds() if item.startswith('D')]
sel += ['PP_Q']
sel_dict = rt.set_selection(r, sel)

# distribution of pressures
reload(gf)

pressure = gf.pressure_sample() # [mmHg]
p_pressure = gf.pressure_probability(pressure)

f_Pa_per_mmHg = 133.322
pressure = pressure * f_Pa_per_mmHg # [Pa]

# TODO: The volume flow becomes challenging now
# f_fac = 0.5
f_fac = 1.0

# Not simple scaling, but scaling from the offset of perivenious flow
# TODO
pressure_sin = f_fac * pressure # [m/s] (scaling to calculate in correct volume flow range)



#########################################################################    
# Set parameters and integrate
######################################################################### 
# Define the parameters
# The parameters are extended via the fluxes. I.e. for all fluxes in the
# flux sample the simulation is performed.
reload(settings)
gal_p_list = []
# for gal in [0.28]:
for gal in [0.28, 12.5, 17.5]:
    p_list = []
    for pa in pressure_sin:
        d = copy.deepcopy(settings.D_TEMPLATE) 
        d["[PP__gal]"] = gal
        d["Pa"] = pa
        d["scale_f"] = r.scale_f/2    # dog half GEC 
        p_list.append(d)
    gal_p_list.append(p_list)
print(gal_p_list)

reload(rt)
gal_f_list = []
for k, p_list in enumerate(gal_p_list):
    f_list = [rt.simulation(r, parameters=p, inits=inits, absTol=1E-3, relTol=1E-3) for p in p_list]
    gal_f_list.append(f_list)

# store the parameters
with open("flux_plots/parameters.txt", 'wb') as f:
    print>>f, p_list

#########################################################################    
# Average
#########################################################################  
# Average via probability and flux weighted summation
# Get the actual flux for the given simulation

# TODO: Necessary to readout variables during the integration for the subsequent
# calculation
# Q_sinunit = PP_Q
# 
Q_sinunit = np.pi * r.y_sin**2 * flow_sin # [m³/s]
weights = p_flux * Q_sinunit
weights = weights/sum(weights)

compounds = ['gal', 'galM', 'rbcM', 'alb', 'suc', 'h2oM']
ids = ['[PV__{}]'.format(id) for id in compounds]    
cols = ['gray', 'black', 'red', 'darkgreen', 'darkorange', 'darkblue']

timepoints=np.arange(settings.T_PEAK-5, settings.T_PEAK+35, 0.01)
av_mats = []
for f_list in gal_f_list:
    av_mats.append(gf.average_results(f_list, weights, ids, timepoints, sel))

#########################################################################    
# Dilution data
######################################################################### 
# load experimental data
exp_file = '/home/mkoenig/multiscale-galactose/results/dilution/Goresky_processed.csv'
exp_data = rp.load_dilution_data(exp_file)
# rp.plot_dilution_data(exp_data)

#########################################################################    
# Plots
######################################################################### 
reload(rp)
show_plots=True

# flux dependency of dilution profiles
tlim = [settings.T_PEAK-4, settings.T_PEAK+20]
rp.flux_plots(f_list, sel, xlim=tlim, show=show_plots)
# average curves
# rp.average_plots(timepoints, av_mats, xlim=tlim, show=show_plots)
    

rp.plot_data_with_sim(exp_data, timepoints, av_mats, scale=4.0*15.16943, time_shift=1.0)
rp.plot_gal_data_with_sim(exp_data, timepoints, av_mats, scale=4.0*15.16943, time_shift=1.0)   
 

# additional information
# plot single timecourses
rp.flux_plot(f_list, name='GLUT2_GALM', selections=sel, comp_type="D")
rp.flux_plot(f_list, name='GALKM', selections=sel)
rp.flux_plot(f_list, name='galM', selections=sel, xlim=tlim)

rp.flux_plot(f_list, name='galM', selections=sel, xlim=tlim, comp_type="H")
rp.flux_plot(f_list, name='galM', selections=sel, xlim=tlim, comp_type="D")