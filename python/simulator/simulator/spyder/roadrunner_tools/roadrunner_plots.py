'''
Created on Dec 19, 2014

@author: mkoenig
'''
from roadrunner_tools import position_in_list, get_ids_from_selection

#########################################################################    
# General plots
######################################################################### 
def plot_all(r, show=True):
    '''
        Plot all timecourses in the last roadrunner integration.
    '''
    import pylab as p
    s = r.getSimulationData()
    if s is None:
        raise Exception("no simulation result")
    
    times = s['time']
    selections = r.selections
    for i in range(1, len(selections)):
        series = s[:,i]
        name = selections[i]
        p.plot(times, series, label=str(name))
        p.legend()
    if show:
        p.show()


#########################################################################    
# Plots showing flux dependency
######################################################################### 
def flux_plot(f_list, selections, name, xlim=None, ylim=None, comp_type='H'):
    '''
    Plot a component of the flux curves.
    '''
    print '#'*80, '\n', name, '\n', '#'*80
    ids = get_ids_from_selection(name, selections=selections, comp_type=comp_type)
    print ids
    
    import pylab as p    
    for s in f_list:
        times = s['time']
        for sid in ids:
            p.plot(times, s[sid], color='black')
    if xlim:
        p.xlim(xlim)
    if ylim:
        p.ylim(ylim)
    p.xlabel('time [s]')
    p.ylabel(name)    
    p.show()


def flux_plots(f_list, selections, xlim=None, ylim=None, show=True):
    ''' 
    Plot perivenious dilution curves.
    '''
    compounds = ['gal', 'galM', 'rbcM', 'alb', 'suc', 'h2oM']
    ids = ['[PV__{}]'.format(id) for id in compounds]    
    cols = ['gray', 'black', 'red', 'darkgreen', 'darkorange', 'darkblue']
    
    import pylab as p    
    for k, sid in enumerate(ids):
        print sid
        for s in f_list:
            p.plot(s['time'], s[sid], color=cols[k], label=sid)
        if xlim:
            p.xlim(xlim)
        if ylim:
            p.ylim(ylim)
        p.xlabel('time [s]')
        p.ylabel(sid) 
        p.savefig('flux_plots/flux_{}.png'.format(sid), dpi=200)
        if show:
            p.show()


def average_plots(time, av_mats, xlim=None, ylim=None, show=True):
    ''' 
        Plot of the averate dilution curves 
    '''
    compounds = ['gal', 'galM', 'rbcM', 'alb', 'suc', 'h2oM']
    ids = ['PV__{}'.format(id) for id in compounds]    
    cols = ['gray', 'black', 'red', 'darkgreen', 'darkorange', 'darkblue']
    
    import pylab as p  
    for av_mat in av_mats:
        for k, name in enumerate(ids):
            p.plot(time,av_mat[:,k] , color=cols[k], label=str(name))
    if xlim:
        p.xlim(xlim)
    if ylim:
        p.ylim(ylim)
    p.xlabel('time [s]')
    p.ylabel('outflow fraction') 
    p.savefig('flux_plots/average_plots.png', dpi=200)
    if show:
        p.show()

# Load the Goresky experimental data and plot with the curves
# TODO reading data with csv2rec('exampledata.txt', delimiter='\t')
# matplotlib.mlab.csv2rec
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
    # plot every single point
    for k in range(len(data['time'])):
        c = data['compound'][k]
        t = data['time'][k]
        outflow = data['outflow'][k]
        pos = position_in_list(compounds, c)
        if pos < 0:
            print 'Compound not found:', c
            continue
        # plot data point        
        p.plot(t, outflow, 'o', color=colors[pos])               
    p.show()      

def plot_data_with_sim(data, timepoints, av_mats, scale=1.0, time_shift=0.0, t_peak=5000):    
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
    p.xlabel('time [s]')
    p.ylabel('outflow fraction') 
    p.savefig('flux_plots/dilution_01.png', dpi=200)    
    
    p.show()

def plot_gal_data_with_sim(data, timepoints, av_mats, scale=1.0, time_shift=0.0, t_peak=5000):    
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
    p.xlabel('time [s]')
    p.ylabel('outflow fraction') 
    p.savefig('flux_plots/dilution_02.png', dpi=200)        
    
    p.show()


