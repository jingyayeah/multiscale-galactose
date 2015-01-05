'''
Created on Dec 19, 2014

@author: mkoenig
'''
from roadrunner_tools import selection_dict, position_in_list
import matplotlib

    
def plot_all(r, show=True):
    '''
        Plot all timecourses in the last roadrunner integration.
    '''
    import pylab as p
    s = r.getSimulationData()
    if s is None:
        raise Exception("no simulation result")
    
    times = s[:,0]

    selections = r.selections
    for i in range(1, len(selections)):
        series = s[:,i]
        name = selections[i]
        p.plot(times, series, label=str(name))
        p.legend()
    if show:
        p.show()



def flux_plots(f_list, selections, xlim=None, ylim=None):
    ''' 
        Plot of the perivenious dilution curves. 
    '''
    compounds = ['gal', 'galM', 'rbcM', 'alb', 'suc', 'h2oM']
    ids = ['[PV__{}]'.format(id) for id in compounds]    
    cols = ['gray', 'black', 'red', 'darkgreen', 'darkorange', 'darkblue']
    
    sel_dict = selection_dict(selections)
    
    import pylab as p    
    for k, sid in enumerate(ids):
        print sid
        for s in f_list:
            times = s[:,0]
            # find in which place of the solution the component is encoded
            index = sel_dict.get(sid, None)
            if not sid:
                raise Exception("{} not in selection".format(id))
            series = s[:, index]
            name = selections[index]
            p.plot(times, series, color=cols[k], label=str(name))
        if xlim:
            p.xlim(xlim)
        if ylim:
            p.ylim(ylim)
        p.show()

def flux_plot(f_list, selections, name, xlim=None, ylim=None):
    '''
        Plot a component of the flux curves.
    '''
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
    if xlim:
        p.xlim(xlim)
    if ylim:
        p.ylim(ylim)
    p.show()


def average_plots(time, av_mats, xlim=None, ylim=None):
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
    p.show()


