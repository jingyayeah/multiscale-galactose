"""
Plot helpers for the visualization of multiscale liver models.
One of the main challenges is the managing of the multiple cell
instances from periportal to perivenious and the visualisation
of sinusoid, space of Disse and the hepatocyte concentrations.

In this module general plot helpers for the analysis are defined.


"""
# TODO: refactor in class
# TODO: provide general plots depending on ResultType
#  and subclasses for the individual models.

from __future__ import print_function

import matplotlib.pylab as plt
import pandas as pd

from multiscale.modelcreator.utils import naming
from multiscale.simulate.analysis.galactose import get_ids_from_selection


def print_plot_heading(text):
    print('#'*80)
    print('Dilution curves')
    print('#'*80)

def position_in_list(list, y):
    for k, x in enumerate(list):
        if x == y:
            return k
    return -1


PPPV_COLOR = {
    'gal': 'gray',
    'galM': 'black',
    'rbcM': 'red',
    'alb': 'darkgreen',
    'suc': 'darkorange',
    'h2oM': 'darkblue'
}

def pppv_plot(s_list, xlim=[PEAK_TIME-5, PEAK_TIME+30], ylim=None):
    """ Plot of the periportal and perivenious components of the dilution curves. """
    ids = []
    cols = []
    for key, color in PPPV_COLOR.iteritems():
        ids.append('[{}]'.format(naming.getPPSpeciesId(key)))
        cols.append('black')
        ids.append('[{}]'.format(naming.getPVSpeciesId(key)))
        cols.append(color)
    print(ids)

    # p.figure(1, figsize=(9,6))
    for s in s_list:
        times = s['time']
        for k, sid in enumerate(ids):
            plt.plot(times, s[sid], color=cols[k], label=sid)
            # p.legend()
    plt.title('Dilution curves PP & PV')
    plt.xlabel('time [s]')
    plt.ylabel('concentration [mM]')

    # adapt the axis
    if xlim:
        plt.xlim(xlim)
    if ylim:
        plt.ylim(ylim)

    plt.show()


# ----------------------------------------------------------------------
# Dilution plots
# ----------------------------------------------------------------------
PEAK_TIME = 5000

def dilution_plot_pppv(s_list, show=True,
                       xlim=[PEAK_TIME-5, PEAK_TIME+30], ylim=[0, 0.5]):
    """ Plot of the periportal and perivenious components of the dilution curves. """
    print_plot_heading('PPPV dilution curves')

    compounds = ['gal', 'galM', 'rbcM', 'alb', 'suc', 'h2oM']
    ccols = ['gray', 'black', 'red', 'darkgreen', 'darkorange', 'darkblue']

    pp_ids = ['[PP__{}]'.format(sid) for sid in compounds]
    pv_ids = ['[PV__{}]'.format(sid) for sid in compounds]
    ids = pp_ids + pv_ids
    cols = ccols + ccols
    print(ids)

    # p.figure(1, figsize=(9,6))
    for s in s_list:
        times = s['time']
        for k, sid in enumerate(ids):
            plt.plot(times, s[sid], color=cols[k], label=sid)
            # p.legend()
    plt.title('Dilution curves PP & PV')
    plt.xlabel('time [s]')
    plt.ylabel('concentration [mM]')
    font = {'family' : 'monospace',
        'weight' : 'bold',
        'size'   : '12'}
    plt.rc('font', **font)  # pass in the font dict as kwargs

    # adapt the axis
    if xlim:
        plt.xlim(xlim)
    if ylim:
        plt.ylim(ylim)

    # p.savefig('plots/dilution_plot_pppv.png', dpi=200)
    if show:
        plt.show()

def dilution_plot_by_name(s_list, selections, name, xlim=[PEAK_TIME-5, PEAK_TIME+30], comp_type='H'):
    """ Plot of the dilution curves. """
    # TODO: problems if not enough colors are provided.
    print_plot_heading(name)
    ids = get_ids_from_selection(name, selections, comp_type=comp_type)
    cols = ['red', 'darkblue', 'darkgreen', 'gray', 'darkorgange', 'black']
    print(ids)

    # p.figure(1, figsize=(9,6))
    for ks, s in enumerate(s_list):
        times = s['time']
        for sid in ids:
            plt.plot(times, s[sid], color=cols[ks], label=sid)
    plt.xlim(xlim)
    plt.title(name)
    plt.xlabel('time [s]')
    plt.ylabel(name)

    #p.ylim(0, 0.4)
    # plt.savefig('plots/{}.png'.format(name))
    plt.show()

def load_dilution_data(fname):
    """ Read experimental dilution data.
        Load the Goresky experimental distribution_data and plot with the curves.
    """
    return pd.read_csv(fname, sep="\t")


def plot_dilution_data(data, xlim=[-5, 30]):
    """ Plot the loaded dilution data. """
    compounds = ['RBC', 'albumin', 'sucrose', 'water', 'galactose']
    colors = ['darkred', 'darkgreen', 'darkorange', 'darkblue', 'black']

    for key, color in zip(compounds, colors):
        print(key, ':', color)
        d = data[data['compound'] == key]
        plt.plot(d['time'], d['outflow'], 'o', color=color)
        plt.xlim(xlim)


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

# ----------------------------------------------------------------------
# General plots
# ----------------------------------------------------------------------
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
    print_plot_heading(name)
    ids = get_ids_from_selection(name, selections=selections, comp_type=comp_type)
    print(ids)

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



