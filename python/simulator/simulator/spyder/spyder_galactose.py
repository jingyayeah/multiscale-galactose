'''
Simulation with RoadRunner model for description of the Multiple Indicator
Dilution Data.

@author: mkoenig
'''
import time
import roadrunner
print roadrunner.__version__


t_peak = 5000

def load_model(sbml):
    print 'Loading :', sbml_file
    start = time.clock()
    r = roadrunner.RoadRunner(sbml)
    print 'SBML Rules load :', (time.clock()- start)    
    return(r)

def set_parameters(r, parameters):
    changed = dict()
    for key, value in parameters.iteritems():
        changed[key] = r.model[key]
        r.model[key] = value 
    r.reset()
    return changed

def reset_changed(r, changed):
    for key, value in changed.iteritems():
        r.model[key] = value  
    r.reset()

def set_inits(r, inits):
    changed = dict()
    for key, value in inits.iteritems():
        changed[key] = r.model[key]
        name = "".join(['init([', key, '])'])
        r.model[name] = value 
    return changed
    
def simulation(r, selection, parameters, inits, absTol=1E-6, relTol=1E-6):
    # reset the initial concentrations
    r.reset()
    # set selection
    r.selections = selection
    # set parameters
    changed = set_parameters(r, parameters)
    # in a second step set the initial changes
    set_inits(r, inits)
          
    # absTol is defined relative to the amounts
    absTol = absTol * min(r.model.getCompartmentVolumes())
    start = time.clock()
    s = r.simulate(0, 10000, absolute=absTol, relative=relTol, variableStep=True, stiff=True, plot=False)      
    print 'Integration time:', (time.clock()- start)
    reset_changed(r, changed)
    
    return s
    
def plot(r, show=True):
    import pylab as p
    result = r.getSimulationData()
    if result is None:
        raise Exception("no simulation result")
    
    times = result[:,0]

    selections = r.selections
    for i in range(1, len(selections)):
        series = result[:,i]
        name = selections[i]
        p.plot(times, series, label=str(name))
        p.legend()
    if show:
        p.show()


def position_in_list(list, y):
    for k, x in enumerate(list):
        if x == y:
            return k
    return -1
    
def selection_dict(selection):
    d = {}
    for k, s in enumerate(sel):
        d[s] = k
    return d
    
def dilution_plots(s_list, selections, show=True):
    ''' Plot of the dilution curves '''
    compounds = ['gal', 'galM', 'rbcM', 'alb', 'suc', 'h2oM']
    ccols = ['gray', 'black', 'red', 'darkgreen', 'darkorange', 'darkblue']
    pp_ids = ['PP__{}'.format(id) for id in compounds]    
    pv_ids = ['PV__{}'.format(id) for id in compounds]
    ids = pp_ids + pv_ids
    cols = ccols + ccols
    
    # TODO: axis names     
    
    # plot all the individual solutions    
    
    import pylab as p    
    for s in s_list:
        times = s[:,0]
        for k, id in enumerate(ids):
            # find in which place of the solution the component is encoded
            i_sel = position_in_list(selections, '[{}]'.format(id))
            if i_sel < 0:
                raise Exception("{} not in selection".format(id))
            series = s[:,i_sel]
            name = selections[i_sel]
            p.plot(times, series, color=cols[k], label=str(name))
            # p.legend()
    # adapt the axis
    p.xlim(t_peak-5, t_peak+30)
    p.ylim(0, 0.5)
    p.show()
    
    # Plot the peak
    for s in s_list:
        times = s[:,0]
        for k, id in enumerate(['PP__galM', 'PV__galM']):
            # find in which place of the solution the component is encoded
            i_sel = position_in_list(selections, '[{}]'.format(id))
            if i_sel < 0:
                raise Exception("{} not in selection".format(id))
            series = s[:,i_sel]
            name = selections[i_sel]
            p.plot(times, series, color=cols[k], label=str(name))
            # p.legend()
    # adapt the axis
    p.xlim(t_peak-5, t_peak+2)
    p.ylim(0, 2.1)
    p.show()

def dilution_plots_gal(s_list, selections, name, xlim=[t_peak-5, t_peak+30]):
    ''' Plot of the dilution curves.
        Necessary to handle concentrations and fluxes.    
    '''
    print '#'*80    
    print name
    print '#'*80
    ids =  [item for item in selections if ( (item.startswith('[H') | item.startswith('H')) 
                                    & (item.endswith('__{}]'.format(name)) | item.endswith('__{}'.format(name))) )]
    if len(ids) == 0:
        ids = [name, ]
    
    print ids
    cols=['red', 'darkblue', 'darkgreen', 'gray', 'darkorgange', 'black']   

    # plot all the individual solutions    
    import pylab as p
    for ks, s in enumerate(s_list):
        times = s[:,0]
        for id in ids:
            # find in which place of the solution the component is encoded
            i_sel = position_in_list(selections, id)
            if i_sel < 0:
                raise Exception("{} not in selection".format(id))
            series = s[:,i_sel]
            name = selections[i_sel]
            p.plot(times, series, color=cols[ks], label=str(name))
            # p.legend()
    # adapt the axis
    p.xlim(xlim)
    #p.ylim(0, 0.4)
    p.show()

#########################################################################    
# Galactose Challenge
#########################################################################    
sbml_file = 'Galactose_v43_Nc20_galchallenge.xml'
r = load_model(sbml_file)
print r.model.items()

# set selection
sel = ['time']
sel += [ "".join(["[", item, "]"]) for item in r.model.getBoundarySpeciesIds()]
sel += [ "".join(["[", item, "]"]) for item in ['PV__alb', 'PV__gal', 'PV__galM', 'PV__h2oM', 'PV__rbcM', "PV__suc"]]
sel_dict = selection_dict(sel)

# sel += [ "".join(["[", item, "]"]) for item in r.model.getFloatingSpeciesIds()] 
# Store reactions
# sel += [item for item in rr.model.getReactionIds() if item.startswith('H')]

parameters = { 
        "gal_challenge" : 8.0,
    }
inits = {}
s = simulation(r, sel, parameters, inits)
plot(r)


#########################################################################    
# Multiple Indicator Dilution
#########################################################################  
import time
folder = '/home/mkoenig/multiscale-galactose-results/tmp_sbml/'
sbml_file = folder + 'Galactose_v79_Nc20_dilution_gauss.xml'
print sbml_file
r = load_model(sbml_file)
items = r.model.items()

# set selection
sel = ['time']
sel += [ "".join(["[", item, "]"]) for item in r.model.getBoundarySpeciesIds()]
sel += [ "".join(["[", item, "]"]) for item in ['PV__alb', 'PV__gal', 'PV__galM', 'PV__h2oM', 'PV__rbcM', "PV__suc"]]
sel += [ "".join(["[", item, "]"]) for item in r.model.getFloatingSpeciesIds() if item.startswith('H')]
sel += [item for item in r.model.getReactionIds() if item.startswith('H')]
sel += ["peak"]
sel_dict = selection_dict(sel)

# sel += [ "".join(["[", item, "]"]) for item in r.model.getFloatingSpeciesIds()] 
# sel += [item for item in rr.model.getReactionIds() if item.startswith('H')]

# set the boundary concentrations
# PP__gal = (0.28, 5, 12.5, 17.5) # [mM]

p_list = [
  #  { "[PP__gal]" : 0.28, "flow_sin" : 0.5*0.5*270E-6, "GLUT2_f" : 10.0, 'GALK_PA' :0.02, 'scale_f': 0.85*6.4e-15},
  #  { "[PP__gal]" : 12.5, "flow_sin" : 0.5*0.5*270E-6, "GLUT2_f" : 10.0, 'GALK_PA' :0.02, 'scale_f': 0.85*6.4e-15},
  #  { "[PP__gal]" : 17.5, "flow_sin" : 0.5*0.5*270E-6, "GLUT2_f" : 10.0, 'GALK_PA' :0.02, 'scale_f': 0.85*6.4e-15},

   { "[PP__gal]" : 0.28, "flow_sin" : 0.5*270E-6, "GLUT2_f" : 10.0, 'GALK_PA' :0.0, 'scale_f': 0.85*6.4e-15, 't_duration':0.5},
   { "[PP__gal]" : 0.28, "flow_sin" : 0.5*270E-6, "GLUT2_f" : 10.0, 'GALK_PA' :0.02, 'scale_f': 0.85*6.4e-15, 't_duration':1.0},
   
   # { "[PP__gal]" : 0.28, "flow_sin" : 0.5*270E-6, "GLUT2_f" : 2.0, 'GALK_PA' :0.0, 'scale_f': 0.85*6.4e-15},
   # { "[PP__gal]" : 0.28, "flow_sin" : 0.5*270E-6, "GLUT2_f" : 5.0, 'GALK_PA' :0.0, 'scale_f': 0.85*6.4e-15},
   # { "[PP__gal]" : 0.28, "flow_sin" : 0.5*270E-6, "GLUT2_f" : 10.0, 'GALK_PA' :0.0, 'scale_f': 0.85*6.4e-15},


   #  { "[PP__gal]" : 14.8, "flow_sin" : 0.35*270E-6, "GLUT2_f" : 10.0, 'y_cell' :7.58E-06 },
   # { "[PP__gal]" : 14.8, "flow_sin" : 0.35*270E-6, "GLUT2_f" : 10.0, 'y_cell' :10E-06},
   # { "[PP__gal]" : 14.8, "flow_sin" : 0.35*270E-6, "GLUT2_f" : 10.0, 'y_cell' :15E-06}
]



inits = {}

# s1 = simulation(r, sel, p1, inits)
s_list = [simulation(r, sel, p, inits, absTol=1E-8, relTol=1E-8) for p in p_list ]
dilution_plots(s_list, r.selections)

# s1 = s_list[1]
# import pylab as plt
# plt.plot(s1[:, sel_dict['time']], s1[:, sel_dict['peak']])
# plt.xlim([4995, 5010])
# plt.show()


# matplotlib.mlab.csv2rec
# TODO reading data with csv2rec('exampledata.txt', delimiter='\t')
dilution_plots_gal(s_list, r.selections, name='peak', xlim=[t_peak-5, t_peak+5])

dilution_plots_gal(s_list, r.selections, name='galM', xlim=[t_peak-10, t_peak+20])

dilution_plots_gal(s_list, r.selections, name='galM', xlim=[0, 20])

dilution_plots_gal(s_list, r.selections, name='gal')
dilution_plots_gal(s_list, r.selections, name='gal1pM')
dilution_plots_gal(s_list, r.selections, name='gal1p')
dilution_plots_gal(s_list, r.selections, name='galtol')
dilution_plots_gal(s_list, r.selections, name='GLUT2_GAL')
dilution_plots_gal(s_list, r.selections, name='GLUT2_GALM', xlim=[t_peak-1, t_peak+4])
dilution_plots_gal(s_list, r.selections, name='GALK')
dilution_plots_gal(s_list, r.selections, name='GALKM')

print sel


dilution_plots_gal(s_list, r.selections, name='gal1pM', xlim=[5000, 6000])
dilution_plots_gal(s_list, r.selections, name='gal1p', xlim=[5000, 6000])
# r.getInfo()


#########################################################################    
# Flux integration of curves
#########################################################################  
import time
folder = '/home/mkoenig/multiscale-galactose-results/tmp_sbml/'
# sbml_file = folder + 'Galactose_v67_Nc20_dilution_v02.xml'
sbml_file = folder + 'Galactose_v79_Nc20_dilution_gauss.xml'
print sbml_file
r = load_model(sbml_file)

# additional changes for fitting the dilution curves
# (now test the effects of changing variables in the model, i.e.
# To understand the response it is necessary to integrate over the variation
# in fluxes, i.e. simulation of the model for varying fluxes and than 
# plotting the combined result

import numpy as np
from scipy import stats # Import the scipy.stats module
import pylab as plt

# Plot the results
def flux_plots(f_list, selections, show=True):
    ''' Plot of the dilution curves '''
    compounds = ['gal', 'galM', 'rbcM', 'alb', 'suc', 'h2oM']
    ids = ['PV__{}'.format(id) for id in compounds]    
    cols = ['gray', 'black', 'red', 'darkgreen', 'darkorange', 'darkblue']
    import pylab as p    
    for k, id in enumerate(ids):
        print id
        for s in f_list:
            times = s[:,0]
            # find in which place of the solution the component is encoded
            i_sel = position_in_list(selections, '[{}]'.format(id))
            if i_sel < 0:
                raise Exception("{} not in selection".format(id))
            series = s[:,i_sel]
            name = selections[i_sel]
            p.plot(times, series, color=cols[k], label=str(name))

        p.xlim(t_peak-1, t_peak+30)
        #p.ylim(0, 0.4)
        p.show()

def flux_plot(f_list, selections, name, show=True):
    print '#'*80, '\n', name, '\n', '#'*80
    ids =  [item for item in selections if ( (item.startswith('[H') | item.startswith('H')) 
                                    & (item.endswith('__{}]'.format(name)) | item.endswith('__{}'.format(name))) )]
    if len(ids) == 0:
        ids = [name, ]
    print ids
    sel_dict = selection_dict(selections)    
    
    import pylab as p    
    for s in f_list:
        times = s[:,0]
        for id in ids:
            # find in which place of the solution the component is encoded
            i_sel = sel_dict.get(id, None)
            if not i_sel:
                raise Exception("{} not in selection".format(id))
            series = s[:,i_sel]
            p.plot(times, series, color='black')
    p.xlim(t_peak-1, t_peak+30)
    #p.ylim(0, 0.4)
    p.show()



def average_results(f_list, weights, ids, time, selections):
    from scipy import interpolate
    res = np.zeros(shape=(len(time), len(ids)))  # store the averaged results    
    for (k, id) in enumerate(ids):
        # create empty array
        mat = np.zeros(shape =(len(time), len(f_list)))
        # fill matrix        
        for ks, s in enumerate(f_list):
            x = s[:,0]
            # find in which place of the solution the component is encoded
            i_sel = position_in_list(selections, '[{}]'.format(id))
            if i_sel < 0:
                raise Exception("{} not in selection".format(id))
            y = s[:,i_sel]
            f = interpolate.interp1d(x=x, y=y)
            mat[:,ks] = f(time)
        # average the matrix
        av = np.average(mat, axis=1, weights=weights)
        res[:, k] = av
    
    return res

# Plot the results
def average_plots(time, av_mats):
    ''' Plot of the dilution curves '''
    compounds = ['gal', 'galM', 'rbcM', 'alb', 'suc', 'h2oM']
    ids = ['PV__{}'.format(id) for id in compounds]    
    cols = ['gray', 'black', 'red', 'darkgreen', 'darkorange', 'darkblue']
    
    import pylab as p  
    for av_mat in av_mats:
        for k, name in enumerate(ids):
            p.plot(time,av_mat[:,k] , color=cols[k], label=str(name))
    p.ylim(0, 0.25)
    p.xlim(t_peak, t_peak+25)
    p.show()

# Load the Goresky experimental data and plot with the curves
def load_dilution_data(fname):
    data = dict()
    # load all the lines
    f = open(fname, 'r')
    counter = 0
    for line in f.readlines():
        line = line.strip()
        tokens = line.split('\t')
        if (counter == 0):
            header = tokens
            print 'Header', header
            for h in header:
                data[h] = []
        else: 
            for k, h in enumerate(header):
                data[h].append(tokens[k])
        counter += 1
    return data

def plot_dilution_data(data):
    compounds = ['RBC', 'albumin', 'sucrose', 'water', 'galactose']
    colors = ['darkred', 'darkgreen', 'darkorange', 'darkblue', 'black']
    
    import pylab as p  
    for k in range(len(data['time'])):
        c = data['compound'][k]
        t = data['time'][k]
        outflow = data['outflow'][k]
        pos = position_in_list(compounds, c)
        if pos < 0:
            continue
        # plot data point        
        p.plot(t, outflow, 'o', color=colors[pos])               

    # p.ylim(0, 0.25)
    # p.xlim(t_peak, t_peak+25)
    p.show()      

def plot_data_with_sim(data, timepoints, av_mats, scale=1.0, time_shift=0.0):    
    import pylab as p  
    # experimental data    
    exp_compounds = ['RBC', 'albumin', 'sucrose', 'water', 'galactose']
    exp_colors = ['darkred', 'darkgreen', 'darkorange', 'darkblue', 'black']
    
    for k in range(len(data['time'])):
        c = data['compound'][k]
        t = data['time'][k]
        outflow = data['outflow'][k]
        pos = position_in_list(exp_compounds, c)
        if pos < 0:
            continue
        # plot data point        
        p.plot(t, outflow, 'o', color=exp_colors[pos])               

    # simulations
    compounds = ['gal', 'galM', 'rbcM', 'alb', 'suc', 'h2oM']
    ids = ['PV__{}'.format(id) for id in compounds]    
    cols = ['gray', 'black', 'red', 'darkgreen', 'darkorange', 'darkblue']

    for av_mat in av_mats:
        for k, name in enumerate(ids):
            p.plot([(t+time_shift-t_peak) for t in timepoints], scale*av_mat[:,k] , color=cols[k], label=str(name))
    # p.ylim(0, 0.25)
    p.ylim(0, 17)
    p.show()

def plot_gal_data_with_sim(data, timepoints, av_mats, scale=1.0, time_shift=0.0):    
    import pylab as p  
    # experimental data    
    exp_compounds = ['galactose']
    exp_colors = ['black']
    
    for k in range(len(data['time'])):
        c = data['compound'][k]
        if c not in exp_compounds:
            continue
        t = data['time'][k]
        outflow = data['outflow'][k]
        pos = position_in_list(exp_compounds, c)
        if pos < 0:
            continue
        # plot data point        
        p.plot(t, outflow, 'o', color=exp_colors[pos])               

    # simulations
    compounds = ['gal', 'galM', 'rbcM', 'alb', 'suc', 'h2oM']
    ids = ['PV__{}'.format(id) for id in compounds]    
    cols = ['gray', 'black', 'red', 'darkgreen', 'darkorange', 'darkblue']

    for av_mat in av_mats:
        for k, name in enumerate(ids):
            if name != "PV__galM":
                continue
            p.plot([(t+time_shift-t_peak) for t in timepoints], scale*av_mat[:,k] , color=cols[k], label=str(name))
    # p.ylim(0, 0.25)
    p.ylim(0, 4)
    p.show()

  

##  Distribution of fluxes  ##################################################
x = np.linspace(0.1, 1100, num=400) # values for x-axis
mu = 5.4572075437    # dtmp['meanlog']
sigma = 0.6178209697 # dtmp['sdlog']
pdf = stats.lognorm.pdf(x, sigma, loc=0, scale=np.exp(mu))
plt.figure(figsize=(12,4.5))
plt.plot(x, pdf)
flux1 = np.arange(start=0, stop=400, step=50)
flux2 = np.arange(start=400, stop=1200, step=50)

flux = np.concatenate((flux1, flux2), axis=0)
flux = np.sort(flux)
p_flux = stats.lognorm.pdf(flux, sigma, loc=0, scale=np.exp(mu))
plt.plot(flux, p_flux)

# Now use fluxes for calculation and probabilities for weighting
print flux
print p_flux # probability is caluclated based on original probability
len(flux)

##  Simulations for parameter fitting  ########################################

# general settings
inits = {}
sel = ['time']
sel += [ "".join(["[", item, "]"]) for item in ['PV__alb', 'PV__gal', 'PV__galM', 'PV__h2oM', 'PV__rbcM', "PV__suc"]]
sel += [ "".join(["[", item, "]"]) for item in r.model.getBoundarySpeciesIds()]
sel += [ "".join(["[", item, "]"]) for item in r.model.getFloatingSpeciesIds() if item.startswith('H')]
sel += [item for item in r.model.getReactionIds() if item.startswith('H')]


# define the parameters for the simulation
gal_p_list = []
# 2.58, 14.8, 19.8
#for gal in [0.28, 12.5, 17.5]:
for gal in [0.28]:
    p_list = []
    for f in flux:
        d = { 
              't_duration':1.0,
              "[PP__gal]" : gal, 
              "flow_sin" : f*1E-6 * 0.50,               
              #"y_dis" : 2.5E-6,
              #"y_cell" : 2*7.58E-6,
              #"L" : 500E-6,
              #"H2OT_f": 3.0,
              "GLUT2_f" : 10.0, 
              #"GLUT2_k_gal" : 27.8,
              "GALK_PA" :  0.03,
              "scale_f" : 0.84*6.4E-15} 
        p_list.append(d)
    gal_p_list.append(p_list)

gal_f_list = []
for p_list in gal_p_list:
    print ' * Simulation *'
    print p_list
    f_list = [simulation(r, sel, p, inits, absTol=1E-4, relTol=1E-4) for p in p_list ]
    gal_f_list.append(f_list)

# make the average
# make the integration of the results, i.e. the probability and flux weighted
# summation

Q_sinunit = np.pi * r.y_sin**2 * flux # [m³/s]
weights = p_flux * Q_sinunit
weights = weights/sum(weights)

#perfusion = r.Q_sinunit/r.Vol_sinunit * 60
# print perfusion

#plt.plot(flux, weights)
# plt.plot(flux, p_flux)
compounds = ['gal', 'galM', 'rbcM', 'alb', 'suc', 'h2oM']
ids = ['PV__{}'.format(id) for id in compounds]    
cols = ['gray', 'black', 'red', 'darkgreen', 'darkorange', 'darkblue']
timepoints=np.arange(t_peak-5, t_peak+35, 0.05)
av_mats = []
for f_list in gal_f_list:
    av_mats.append(average_results(f_list, weights, ids, timepoints, sel))
# plot single simulations & average results
flux_plots(f_list, sel)
# average_plots(timepoints, av_mats)

# load experimental data
exp_file = '/home/mkoenig/multiscale-galactose/results/dilution/Goresky_processed.csv'
exp_data = load_dilution_data(exp_file)
# plot_dilution_data(exp_data)


# rectangular peak
# plot_data_with_sim(exp_data, timepoints, av_mats, scale=20*4.3*15.16943, time_shift=1.3)
# plot_gal_data_with_sim(exp_data, timepoints, av_mats, scale=20*4.3*15.16943, time_shift=1.3)        

# gauss peak
plot_data_with_sim(exp_data, timepoints, av_mats, scale=4.1*15.16943, time_shift=1.4)
plot_gal_data_with_sim(exp_data, timepoints, av_mats, scale=4.1*15.16943, time_shift=1.4)        

print sel
flux_plot(f_list, name='GLUT2_GALM', selections=sel)
flux_plot(f_list, name='GALKM', selections=sel)
flux_plot(f_list, name='galM', selections=sel)

#### inhibition of GLUT2 

def GLUT2_inhibition(c,km):
    return 1.0/(1.0+2.0*c/km)    
    
c = np.array((2.58,14.8, 19.8))
GLUT2_inhibition(c, 27.8)
c = np.array((0.28,12.5, 17.5))
GLUT2_inhibition(c, 27.8)

