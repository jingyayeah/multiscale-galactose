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
import pylab as plt
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
sbml_file = settings.SBML_DIR + '/' + 'Galactose_v{}_Nc20_dilution.xml'.model_format(settings.VERSION)
r = rt.load_model(sbml_file)

# selection
inits = {}
sel = ['time']
sel += [ "".join(["[", item, "]"]) for item in ['PV__alb', 'PV__gal', 'PV__galM', 'PV__h2oM', 'PV__rbcM', "PV__suc"]]
sel += [ "".join(["[", item, "]"]) for item in r.model.getBoundarySpeciesIds()]
sel += [ "".join(["[", item, "]"]) for item in r.model.getFloatingSpeciesIds() if item.startswith('C')]
sel += [ "".join(["[", item, "]"]) for item in r.model.getFloatingSpeciesIds() if item.startswith('D')]
sel += [ "".join(["[", item, "]"]) for item in r.model.getFloatingSpeciesIds() if item.startswith('S')]
sel += [item for item in r.model.getReactionIds() if item.startswith('C')]
sel += [item for item in r.model.getReactionIds() if item.startswith('D')]
sel += ['PP_Q', 'Q_sinunit', 'Vol_sinunit', 'Pa']

sel_dict = rt.set_selection(r, sel)

# distribution of pressures
reload(gf)
pressure = gf.pressure_sample() # [mmHg]
p_pressure = gf.pressure_probability(pressure)

# Not simple scaling, but scaling from the offset of perivenious pressure
# Pressure scaling is more work than the previous flow scaling
pressure_sin = r.Pb + settings.F_FLOW *(pressure-r.Pb) # [m/s] (scaling to calculate in correct volume flow range)

f_Pa_per_mmHg = 133.322
pressure = pressure * f_Pa_per_mmHg # [Pa]

# TODO: The volume flow becomes challenging
# TODO: Recalculate the necessary factor to account for scaling of local 
# perfusion to global perfusion
# f_fac = 0.5 (before)
f_fac = settings.F_FLOW # 0.9



#########################################################################    
# Set parameters and integrate
######################################################################### 
# Define the parameters
# The parameters are extended via the fluxes. I.e. for all fluxes in the
# flux sample the odesim is performed.
reload(settings)
gal_p_list = []
for gal in [0.28]:
# for gal in [0.28, 12.5, 17.5]:
    p_list = []
    for pa in pressure_sin:
        d = copy.deepcopy(settings.D_TEMPLATE) 
        d["[PP__gal]"] = gal
        d["Pa"] = pa
        d["scale_f"] = r.scale_f/2    # dog half GEC of human
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
# Average via probability and flux weighted summation with volume flows
# from odesim

# flow is constant in odesim, so readout of first element is sufficient
def get_par_from_solutions(name, solutions):
    return [sol[name][0] for sol in solutions]
    
Q_sinunit = get_par_from_solutions('Q_sinunit', f_list)
Pa = get_par_from_solutions('Pa', f_list)

plt.plot(pressure_sin, Pa, 'o-')
plt.plot([0, np.max(pressure_sin)], [0, np.max(pressure_sin)], color='gray' )
plt.show()

weights = p_pressure * Q_sinunit
weights = weights/sum(weights)
print(weights)

plt.plot(pressure_sin, weights, 'o-')

compounds = ['gal', 'galM', 'rbcM', 'alb', 'suc', 'h2oM']
ids = ['[PV__{}]'.model_format(id) for id in compounds]    
cols = ['gray', 'black', 'red', 'darkgreen', 'darkorange', 'darkblue']

timepoints=np.arange(settings.T_PEAK-5, settings.T_PEAK+35, 0.01)
av_mats = []
for f_list in gal_f_list:
    av_mats.append(gf.average_results(f_list, weights, ids, timepoints, sel))

#########################################################################    
# Dilution distribution_data
######################################################################### 
# load experimental distribution_data
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
f_scale = 70 # 55 (f_fac=1.0)
rp.plot_data_with_sim(exp_data, timepoints, av_mats, scale=f_scale, time_shift=1.0)
rp.plot_gal_data_with_sim(exp_data, timepoints, av_mats, scale=f_scale, time_shift=1.0)   
 

# additional information (necessary that the respective components are
# available in the selection)

# plot single timecourses
rp.flux_plot(f_list, name='GLUT2_GALM', selections=sel, comp_type="D", xlim=tlim)
rp.flux_plot(f_list, name='GALKM', selections=sel, comp_type="C", xlim=tlim)
rp.flux_plot(f_list, name='galM', selections=sel, comp_type="D", xlim=tlim)

rp.flux_plot(f_list, name='galM', selections=sel, xlim=tlim, comp_type="H")
rp.flux_plot(f_list, name='galM', selections=sel, xlim=tlim, comp_type="D")


# some testdata
rp.flux_plot((f_list[0],), name='rbcM', selections=sel, xlim=tlim, comp_type="S")
rp.flux_plot((f_list[0],), name='rbcM', selections=sel, xlim=tlim, comp_type="D")