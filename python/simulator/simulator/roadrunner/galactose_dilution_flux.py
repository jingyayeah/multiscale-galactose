# -*- coding: utf-8 -*-
"""
Dilution curves via integration over the distribution of fluxes.

Testing the influence of paramter variation on the resulting dilution 
curves.

@author: Matthias Koenig
@date: 2014-12-19
"""
import roadrunner
import numpy as np
import galactose_functions as gf
import roadrunner_tools as rt
import roadrunner_plots as rp
#########################################################################    

VERSION = 79
SBML_DIR = '/home/mkoenig/multiscale-galactose-results/tmp_sbml'
T_PEAK = 5000

#########################################################################    
# Flux integration of curves
#########################################################################  
sbml_file = SBML_DIR + '/' + 'Galactose_v{}_Nc20_dilution.xml'.format(VERSION)
# sbml_file = SBML_DIR + '/' + 'Galactose_v{}_Nc20_dilution_gauss.xml'.format(VERSION)
r = rt.load_model(sbml_file)


# selection
inits = {}
sel = ['time']
sel += [ "".join(["[", item, "]"]) for item in ['PV__alb', 'PV__gal', 'PV__galM', 'PV__h2oM', 'PV__rbcM', "PV__suc"]]
sel += [ "".join(["[", item, "]"]) for item in r.model.getBoundarySpeciesIds()]
sel += [ "".join(["[", item, "]"]) for item in r.model.getFloatingSpeciesIds() if item.startswith('H')]
sel += [item for item in r.model.getReactionIds() if item.startswith('H')]
sel_dict = rt.set_selection(r, sel)

# distribution of fluxes
flux = gf.flux_sample()
p_flux = gf.flux_probability(flux)

# Define the parameters
# The parameters are extended via the fluxes. I.e. for all fluxes in the
# flux sample the simulation is performed.

#for gal in [0.28, 12.5, 17.5]:
gal_p_list = []
for gal in [0.28]:
    p_list = []
    for f in flux:
        d = { 
              't_duration':1.0,
              "[PP__gal]" : gal, 
              "flow_sin" : f*1E-6 * 0.50,               
              "y_dis" : 3.5E-6,
              # "y_cell" : 2*7.58E-6,
              #"L" : 500E-6,
              #"H2OT_f": 3.0,
              "GLUT2_f" : 10.0, 
              #"GLUT2_k_gal" : 27.8,
              "GALK_PA" :  0.03,
              "scale_f" : 0.84*6.4E-15} 
        p_list.append(d)
    gal_p_list.append(p_list)

gal_f_list = []
for k, p_list in enumerate(gal_p_list):
    f_list = [rt.simulation(r, parameters=p, inits=inits, absTol=1E-4, relTol=1E-4) for p in p_list]
    gal_f_list.append(f_list)

#########################################################################    
# Average
#########################################################################  
# Average via probability and flux weighted summation
Q_sinunit = np.pi * r.y_sin**2 * flux # [m³/s]
weights = p_flux * Q_sinunit
weights = weights/sum(weights)

compounds = ['gal', 'galM', 'rbcM', 'alb', 'suc', 'h2oM']
ids = ['PV__{}'.format(id) for id in compounds]    
cols = ['gray', 'black', 'red', 'darkgreen', 'darkorange', 'darkblue']

timepoints=np.arange(T_PEAK-5, T_PEAK+35, 0.05)
av_mats = []
for f_list in gal_f_list:
    av_mats.append(gf.average_results(f_list, weights, ids, timepoints, sel))
# plot single simulations & average results
rp.flux_plots(gal_f_list, sel)
rp.average_plots(timepoints, av_mats)

# load experimental data
exp_file = '/home/mkoenig/multiscale-galactose/results/dilution/Goresky_processed.csv'
exp_data = rp.load_dilution_data(exp_file)
# plot_dilution_data(exp_data)

# rectangular peak
# plot_data_with_sim(exp_data, timepoints, av_mats, scale=20*4.3*15.16943, time_shift=1.3)
# plot_gal_data_with_sim(exp_data, timepoints, av_mats, scale=20*4.3*15.16943, time_shift=1.3)        

# gauss peak
rp.plot_data_with_sim(exp_data, timepoints, av_mats, scale=4.3*15.16943, time_shift=0.8)
rp.plot_gal_data_with_sim(exp_data, timepoints, av_mats, scale=4.3*15.16943, time_shift=0.8)        

# additional information
rp.flux_plot(f_list, name='GLUT2_GALM', selections=sel)
rp.flux_plot(f_list, name='GALKM', selections=sel)
rp.flux_plot(f_list, name='galM', selections=sel)