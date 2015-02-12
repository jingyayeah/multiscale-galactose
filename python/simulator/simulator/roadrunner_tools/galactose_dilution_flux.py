# -*- coding: utf-8 -*-
"""
Dilution curves via integration over the distribution of fluxes.

Testing the influence of paramter variation on the resulting dilution 
curves.

@author: Matthias Koenig
@date: 2015-01-14
"""
import numpy as np
import galactose_functions as gf
import roadrunner_tools as rt
import roadrunner_plots as rp
reload(rp)
reload(gf)

#########################################################################    
VERSION = 104
SBML_DIR = '/home/mkoenig/multiscale-galactose-results/tmp_sbml'
T_PEAK = 5000

#########################################################################    
# Flux integration of curves
#########################################################################  
# sbml_file = SBML_DIR + '/' + 'Galactose_v{}_Nc20_dilution_gauss.xml'.format(VERSION)
sbml_file = SBML_DIR + '/' + 'Galactose_v{}_Nc20_dilution.xml'.format(VERSION)
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
sel_dict = rt.set_selection(r, sel)

# distribution of fluxes
reload(gf)
flux = gf.flux_sample() # [m/s]
print flux
p_flux = gf.flux_probability(flux)
f_fac = 0.5
flow_sin = f_fac * flux # [m/s] (scaling to calculate in correct volume flow range)

#########################################################################    
# Set parameters and integrate
######################################################################### 
# Define the parameters
# The parameters are extended via the fluxes. I.e. for all fluxes in the
# flux sample the simulation is performed.

gal_p_list = []
# for gal in [0.28]:
for gal in [0.28, 12.5, 17.5]:
    p_list = []
    for f in flow_sin:
        d = { 
              "[PP__gal]" : gal, 
              "flow_sin" : f,    
              # "y_dis" : 2.3E-6,
              # "y_cell" : 8.39E-6*1.12,
              
              # "f_cyto" : 0.4,
              # "scale_f" : 0.45/1.1,
              #"GALK_PA" : 0.024,
              # "GLUT2_f" : 7.5,              
              "H2OT_f": 0.5,
              "GALK_k_gal": 0.15
              }
        p_list.append(d)
    gal_p_list.append(p_list)

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
Q_sinunit = np.pi * r.y_sin**2 * flow_sin # [m³/s]
weights = p_flux * Q_sinunit
weights = weights/sum(weights)

compounds = ['gal', 'galM', 'rbcM', 'alb', 'suc', 'h2oM']
ids = ['[PV__{}]'.format(id) for id in compounds]    
cols = ['gray', 'black', 'red', 'darkgreen', 'darkorange', 'darkblue']

timepoints=np.arange(T_PEAK-5, T_PEAK+35, 0.01)
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
tlim = [T_PEAK-4, T_PEAK+20]
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