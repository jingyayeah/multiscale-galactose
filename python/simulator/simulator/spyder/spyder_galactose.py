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
        
    print '*** simulate ***'    
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
    p.xlim(t_peak-1, t_peak+30)
    p.ylim(0, 0.4)
    p.show()
    
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
    p.xlim(t_peak-1, t_peak+30)
    p.ylim(0, 0.06)
    p.show()

def dilution_plots_gal(s_list, selections, name, xlim=[t_peak-1, t_peak+30]):
    ''' Plot of the dilution curves '''
    print '#'*80    
    print name
    print '#'*80
    ids =  [item[1:(len(item)-1)] for item in selections if (item.startswith('[H') & item.endswith('__{}]'.format(name)))]
    print ids
    cols=['red', 'darkblue', 'darkgreen']   

    # plot all the individual solutions    
    import pylab as p
    for ks, s in enumerate(s_list):
        times = s[:,0]
        for id in ids:
            # find in which place of the solution the component is encoded
            i_sel = position_in_list(selections, '[{}]'.format(id))
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
folder = '/home/mkoenig/multiscale-galactose-results/tmp_sbml/'
sbml_file = folder + 'Galactose_v56_Nc20_dilution.xml'
print sbml_file
r = load_model(sbml_file)
items = r.model.items()

# set selection
sel = ['time']
sel += [ "".join(["[", item, "]"]) for item in r.model.getBoundarySpeciesIds()]
sel += [ "".join(["[", item, "]"]) for item in ['PV__alb', 'PV__gal', 'PV__galM', 'PV__h2oM', 'PV__rbcM', "PV__suc"]]
sel += [ "".join(["[", item, "]"]) for item in r.model.getFloatingSpeciesIds() if item.startswith('H')]
# sel += [ "".join(["[", item, "]"]) for item in r.model.getFloatingSpeciesIds()] 
# Store reactions
# sel += [item for item in rr.model.getReactionIds() if item.startswith('H')]


# set the boundary concentrations
# PP__gal = (0.28, 5, 12.5, 17.5) # [mM]
# { "[PP__gal]" : 0.28,  "scale_f" : 1.2*5.3e-15,  "flow_sin" : 180E-6, "GLUT2_f" : 4.0 },
#p_list = [
#    { "[PP__gal]" : 0.28, "flow_sin" : 0.35*270E-6, "GLUT2_f" : 25.0},
#    { "[PP__gal]" : 12.5, "flow_sin" : 0.35*270E-6, "GLUT2_f" : 25.0},
#    { "[PP__gal]" : 17.5, "flow_sin" : 0.35*270E-6, "GLUT2_f" : 25.0}
#]
p_list = [
    { "[PP__gal]" : 2.58, "flow_sin" : 0.35*270E-6, "GLUT2_f" : 20.0},
    { "[PP__gal]" : 14.8, "flow_sin" : 0.35*270E-6, "GLUT2_f" : 20.0},
    { "[PP__gal]" : 19.8, "flow_sin" : 0.35*270E-6, "GLUT2_f" : 20.0}
]


inits = {}

# s1 = simulation(r, sel, p1, inits)
s_list = [simulation(r, sel, p, inits, absTol=1E-4, relTol=1E-4) for p in p_list ]
dilution_plots(s_list, r.selections)
dilution_plots_gal(s_list, r.selections, name='galM')
dilution_plots_gal(s_list, r.selections, name='gal1pM')

dilution_plots_gal(s_list, r.selections, name='gal1pM', xlim=[5000, 6000])
dilution_plots_gal(s_list, r.selections, name='gal1p', xlim=[5000, 6000])

r.getInfo()

s = r.getSimulationData()
import pylab as p
test = s[:,len(r.selections)-5]
times = s[:,0]
p.plot(time, test)
del(times)


#########################################################################    
# Flux integration of curves
#########################################################################  
folder = '/home/mkoenig/multiscale-galactose-results/tmp_sbml/'
sbml_file = folder + 'Galactose_v56_Nc20_dilution.xml'
print sbml_file
r = load_model(sbml_file)



# additional changes for fitting the dilution curves
# (now test the effects of changing variables in the model, i.e.
# To understand the response it is necessary to integrate over the variation
# in fluxes, i.e. simulation of the model for varying fluxes and than 
# plotting the combined result
import numpy as np
from scipy import stats # Import the scipy.stats module
import pylab as p

x = np.linspace(0.1, 1100, num=400) # values for x-axis
mu = 5.4572075437    # dtmp['meanlog']
sigma = 0.6178209697 # dtmp['sdlog']
pdf = stats.lognorm.pdf(x, sigma, loc=0, scale=np.exp(mu))
p.figure(figsize=(12,4.5))
p.plot(x, pdf)
flux1 = np.arange(start=0, stop=1100, step=100)
flux2 = np.arange(start=50, stop=300, step=100)
flux = np.concatenate((flux1, flux2), axis=0)
flux = np.sort(flux)
p_flux = stats.lognorm.pdf(flux, sigma, loc=0, scale=np.exp(mu))
p.plot(flux, p_flux)

# Now fluxes and probability weights exist
print flux
print p_flux

# Crete the parameters for the simulation
p_list = []
for f in flux:
    d = dict()
    d["[PP__gal]"] = 2.58
    d["flow_sin"] = f*1E-6
    p_list.append(d)
print p_list
inits = {}
sel = ['time']
sel += [ "".join(["[", item, "]"]) for item in ['PV__alb', 'PV__gal', 'PV__galM', 'PV__h2oM', 'PV__rbcM', "PV__suc"]]
f_list = [simulation(r, sel, p, inits, absTol=1E-4, relTol=1E-4) for p in p_list ]

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

flux_plots(f_list, sel)

# make the integration of the results, i.e. the probability and flux weighted
# summation
y_sin = 4.4E-6 # [m] 
Q_sinunit = np.pi * y_sin**2 * flux # [m³/s]
weights = p_flux * Q_sinunit
weights = weights/sum(weights)
import pylab as plt
plt.plot(flux, weights)
plt.plot(flux, p_flux)

# 
data = np.arange(6).reshape((3,2))
print data
#array([[0, 1],
#       [2, 3],
#       [4, 5]])
np.average(data, axis=1, weights=[1./4, 3./4])
# array([ 0.75,  2.75,  4.75])

# necessary to interpolate the timecourses before averaging
tmp = f_list[0]


from scipy import interpolate


x = tmp[:,0]
y = tmp[:,5]
f = interpolate.interp1d(x=x, y=y)
xnew = np.arange(4995, 5030, 0.05)
ynew = f(xnew)
plt.plot(x,y, 'o', xnew, ynew, '-')
plt.xlim(4995, 5030)


def average_results(f_list, weights, ids):
    alist = [] # store the averaged results    
    for k, id in enumerate(ids):
        print id
        # create empty array
        res = np.zeros()        
        
        for s in f_list:
            times = s[:,0]
            # find in which place of the solution the component is encoded
            i_sel = position_in_list(selections, '[{}]'.format(id))
            if i_sel < 0:
                raise Exception("{} not in selection".format(id))
            series = s[:,i_sel]
            name = selections[i_sel]
            p.plot(times, series, color=cols[k], label=str(name))
    
    plt.plot(tmp[:,0], tmp[:,1])

# make the average
compounds = ['gal', 'galM', 'rbcM', 'alb', 'suc', 'h2oM']
ids = ['PV__{}'.format(id) for id in compounds]    
cols = ['gray', 'black', 'red', 'darkgreen', 'darkorange', 'darkblue']
alist = average_results(f_list, weights, ids)
    


