'''
Create the circos file formats for visualization.
Takes a list of simulations and repacks the contents of the 
CSV solutions in circos file formats.

I.e. create all the tracks for every timepoint.

@author: Matthias Koenig
@date: 2015-02-22

TODO: calculate the flow weighted PV concentration from all samples
# Average via probability and flux weighted summation
# Use the information from the parameters
Q_sinunit = np.pi * r.y_sin**2 * flow_sin # [m3/s]
'''

import sim.PathSettings
from pandas import Series, DataFrame
import pandas as pd
import sim.analysis.ParameterFiles as pf
from sim.models import Task, Simulation, Timecourse

sim_ids = [] # simulations
pars = []    # parameters of the simulations


# for every timepoint all the circos tracks have to be generated

# definition of the chromosomes


def read_parameters_for_task(task_id):
    '''
    Reads the parameters into a pandas DataFrame
    '''
    task = Task.objects.get(pk=task_id)
    data = pf.createParameterInfoForTask(task)
    pars = DataFrame(data)
    return pars


def create_track_ids_for_compound(cid='galM', compartment='C', Nc=20):
    ''' 
    Definition of track ids from outside to center. 
    '''
    # PP
    ids = ['PP__{}'.format(cid)]    
    # Hepatocytes
    nids = [('{}{:02d}__{}'.format(compartment, k, cid)) for k in range(1,Nc+1)]
    ids.extend(nids)
    # PV 
    ids.extend(['PV__{}'.format(cid)])
    return ids
    
    
def interpolate_csv(f_list, weights, ids, time, selections):
    
    from scipy import interpolate
    sel_dict = selection_dict(selections)
    
    res = np.zeros(shape=(len(time), len(ids)))  # store the averaged results    
    for (k, sid) in enumerate(ids):
        # create empty array
        mat = np.zeros(shape =(len(time), len(f_list)))
        # fill matrix        
        for ks, s in enumerate(f_list):
            x = s[:,0]
            # find in which place of the solution the component is encoded
            index = sel_dict.get(sid, None)
            if not index:
                raise Exception("{} not in selection".format(sid))
            y = s[:,index]
            f = interpolate.interp1d(x=x, y=y)
            mat[:,ks] = f(time)
        # average the matrix
        av = np.average(mat, axis=1, weights=weights)
        res[:, k] = av
    return res

def renaming_dict(old_names):
    # create replacement dict    
    names = dict()
    for name in old_names:
        s = name.replace('[', '')
        s = s.replace(']', '')
        s = s.replace('#', '')
        s = s.strip()
        names[unicode(name)] = s
    return names

if __name__ == '__main__':
    ''' 
    Creating the data matrix for the circos visualization.
    The resulting matrix has the dimensions
    [Nsims, Ntracks, Ntimes]    
    '''
    
    track_ids = create_track_ids_for_compound('galM', compartment="H")
    print track_ids
    Ntracks = len(track_ids)    
    
    # get a subset of simulation ids
    # TODO: filter the panda DataFrame to the subset for visualization
    pars = read_parameters_for_task(task_id=1)
    sim_ids = pars['sim']
    print sim_ids
    Nsims = len(sim_ids)
    
    # which timepoints to generate
    Ntimes = 21
    t_start = 5000
    t_end = 5020
    import numpy as np
    times = np.linspace(start=t_start, stop=t_end, num=Ntimes)
    times
    
    # get the csv files
    for sid in sim_ids:
        tc = Timecourse.objects.get(simulation=sid)
        print tc.file.path
        # load the file and interpolate
    # unzp the file        
    
    # read the file
    df = pandas.io.parsers.read_csv(tc.file.path, sep=',', header=0)
    # rename the columns    
    rdict = renaming_dict(df.columns)
    df = df.rename(columns=rdict)
    
    
    

    
    
    
    

    help(pandas.io.parsers.read_csv)
        
    data = np.empty()
    # open csv and interpolate the time points
    # i.e. fill the matrix
    

