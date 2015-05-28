"""
General plot functionality for RoadRunner simulations.
"""
# TODO: refactor in class
# TODO: provide general plots depending on ResultType
#  and subclasses for the individual models.

from __future__ import print_function

import matplotlib.pylab as plt


def plot_all(r, show=True):
    """ Plot all timecourses in the last roadrunner integration. """
    s = r.getSimulationData()
    if s is None:
        raise Exception("no simulation result in roadrunner")
    
    times = s['time']
    selections = r.selections
    for i in range(1, len(selections)):
        series = s[:,i]
        name = selections[i]
        plt.plot(times, series, label=str(name))
        plt.legend()
    if show:
        plt.show()


def flux_plot(f_list, selections, name, xlim=None, ylim=None, comp_type='H'):
    """ Plot a component of the flux curves. """
    print '#'*80, '\n', name, '\n', '#'*80
    ids = get_ids_from_selection(name, selections=selections, comp_type=comp_type)
    print ids

    for s in f_list:
        times = s['time']
        for sid in ids:
            plt.plot(times, s[sid], color='black')
    if xlim:
        plt.xlim(xlim)
    if ylim:
        plt.ylim(ylim)
    plt.xlabel('time [s]')
    plt.ylabel(name)
    plt.show()


def flux_plots(f_list, selections, xlim=None, ylim=None, show=True):
    """ Plot perivenious dilution curves. """
    # TODO: check: is this really doing what ist says?
    compounds = ['gal', 'galM', 'rbcM', 'alb', 'suc', 'h2oM']
    ids = ['[PV__{}]'.format(id) for id in compounds]    
    cols = ['gray', 'black', 'red', 'darkgreen', 'darkorange', 'darkblue']

    for k, sid in enumerate(ids):
        print(sid)
        for s in f_list:
            plt.plot(s['time'], s[sid], color=cols[k], label=sid)
        if xlim:
            plt.xlim(xlim)
        if ylim:
            plt.ylim(ylim)
        plt.xlabel('time [s]')
        plt.ylabel(sid)
        plt.savefig('flux_plots/flux_{}.png'.format(sid), dpi=200)
        if show:
            plt.show()


def average_plots(time, av_mats, xlim=None, ylim=None, show=True):
    """ Plot of the average dilution curves. """
    compounds = ['gal', 'galM', 'rbcM', 'alb', 'suc', 'h2oM']
    ids = ['PV__{}'.format(id) for id in compounds]    
    cols = ['gray', 'black', 'red', 'darkgreen', 'darkorange', 'darkblue']

    for av_mat in av_mats:
        for k, name in enumerate(ids):
            plt.plot(time,av_mat[:,k] , color=cols[k], label=str(name))
    if xlim:
        plt.xlim(xlim)
    if ylim:
        plt.ylim(ylim)
    plt.xlabel('time [s]')
    plt.ylabel('outflow fraction')
    plt.savefig('flux_plots/average_plots.png', dpi=200)
    if show:
        plt.show()


def load_dilution_data(fname):
    """ Read experimental dilution data.
    Load the Goresky experimental distribution_data and plot with the curves.
    """
    # TODO: reading distribution_data with csv2rec('exampledata.txt', delimiter='\t')
    # matplotlib.mlab.csv2rec
    data = dict()
    # load all the lines
    f = open(fname, 'r')
    counter = 0
    for line in f.readlines():
        line = line.strip()
        tokens = line.split('\t')
        if counter == 0:
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

    # plot every single point
    for k in range(len(data['time'])):
        c = data['compound'][k]
        t = data['time'][k]
        outflow = data['outflow'][k]
        pos = position_in_list(compounds, c)
        if pos < 0:
            print 'Compound not found:', c
            continue
        # plot distribution_data point
        plt.plot(t, outflow, 'o', color=colors[pos])
    plt.show()


def plot_data_with_sim(data, timepoints, av_mats, scale=1.0, time_shift=0.0, t_peak=5000):
    # experimental distribution_data
    exp_compounds = ['RBC', 'albumin', 'sucrose', 'water', 'galactose']
    exp_colors = ['darkred', 'darkgreen', 'darkorange', 'darkblue', 'black']
    
    for k in range(len(data['time'])):
        c = data['compound'][k]
        t = data['time'][k]
        outflow = data['outflow'][k]
        pos = position_in_list(exp_compounds, c)
        if pos < 0:
            continue
        # plot distribution_data point
        plt.plot(t, outflow, 'o', color=exp_colors[pos])

    # simulations
    compounds = ['gal', 'galM', 'rbcM', 'alb', 'suc', 'h2oM']
    ids = ['PV__{}'.format(id) for id in compounds]    
    cols = ['gray', 'black', 'red', 'darkgreen', 'darkorange', 'darkblue']

    for av_mat in av_mats:
        for k, name in enumerate(ids):
            plt.plot([(t+time_shift-t_peak) for t in timepoints], scale*av_mat[:,k] , color=cols[k], label=str(name))
    # p.ylim(0, 0.25)
    plt.ylim(0, 17)
    plt.xlabel('time [s]')
    plt.ylabel('outflow fraction')
    plt.savefig('flux_plots/dilution_01.png', dpi=200)
    
    plt.show()


def plot_gal_data_with_sim(data, timepoints, av_mats, scale=1.0, time_shift=0.0, t_peak=5000):
    # experimental distribution_data
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
        # plot distribution_data point
        plt.plot(t, outflow, 'o', color=exp_colors[pos])

    # simulations
    compounds = ['gal', 'galM', 'rbcM', 'alb', 'suc', 'h2oM']
    ids = ['PV__{}'.format(id) for id in compounds]    
    cols = ['gray', 'black', 'red', 'darkgreen', 'darkorange', 'darkblue']

    for av_mat in av_mats:
        for k, name in enumerate(ids):
            if name != "PV__galM":
                continue
            plt.plot([(t+time_shift-t_peak) for t in timepoints], scale*av_mat[:,k] , color=cols[k], label=str(name))
    # p.ylim(0, 0.25)
    plt.ylim(0, 4)
    plt.xlabel('time [s]')
    plt.ylabel('outflow fraction')
    plt.savefig('flux_plots/dilution_02.png', dpi=200)
    
    plt.show()


