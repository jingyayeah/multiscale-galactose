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
import os
import numpy as np
from pandas import Series, DataFrame
import pandas as pd
import sim.analysis.ParameterFiles as pf
from sim.models import Task, Timecourse

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
    
    
def read_dataframes(sim_ids):
    '''
    Reads the CSV data into Panda DataFrames.
    '''
    df_dict = {}
    for sid in sim_ids:
        tc = Timecourse.objects.get(simulation=sid)
        # unzip the tar.gz (make csv available)
        if not os.path.exists(tc.file.path):
            tc.unzip()
        # read the file
        df = pd.io.parsers.read_csv(tc.file.path, sep=',', header=0)
        # rename the columns    
        rdict = renaming_dict(df.columns)
        df = df.rename(columns=rdict)
        # store the DataFrame
        df_dict[sid] = df
    return df_dict
    
def renaming_dict(old_names):
    '''
    Renaming mapping for the names of the CSV.
    '''
    # create replacement dict    
    names = dict()
    for name in old_names:
        s = name.replace('[', '')
        s = s.replace(']', '')
        s = s.replace('#', '')
        s = s.strip()
        names[unicode(name)] = s
    return names

def create_circos_mat(track_ids, times, df_dict):
    '''
    Creates the circos matrix from the read data frames.
    '''
    Nsims = len(df_dict.keys())
    Ntracks = len(track_ids)
    Ntimes = len(times)    
    # create empty matrix template    
    circos_mat = np.empty([Nsims, Ntracks, Ntimes])    
    
    # interpolate the data and fill the circos matrix
    from scipy import interpolate
    for (ks, sid) in enumerate(df_dict.keys()):
        df = df_dict[sid]

        for (kt, tid) in enumerate(track_ids):
            # check if tid in the results
            x = df['time']
            y = df[tid]
            # there are problems in the interpolation with the timepoints
            
            f = interpolate.interp1d(x=x, y=y)
            circos_mat[ks, kt, :] = f(times)
    return circos_mat

def create_karyotype_file(folder, sim_ids):
    '''
    Write the Karyotypes.
    The karyotype file defines the axis.
    chr - ID LABEL START END COLOR
    '''
    fname = os.path.join(folder, "karyotype_galactose.txt")
    print fname
    f = open(fname , 'w')
    for k, sid in enumerate(sim_ids):
        f.write('chr - s{} {} 0 1 grey\n'.format(sid, sid) )
    f.close()
    return None
    
def create_track_files(folder, sim_ids, track_ids, mat):
    '''
    Creates all the track files for a single timepoint.
    chr start end value options
    '''
    for (kt, tid) in enumerate(track_ids):
        fname = os.path.join(folder, 'track_{:02d}.txt'.format(kt))
        print fname
        f = open(fname, 'w')
        for ks, sid in enumerate(sim_ids):
            s = 's{} 0 1 {:f}\n'.format(sid, mat[ks, kt])
            f.write(s)
        f.close()
    return None

def create_all_track_files(sim_ids, track_ids, times, circos_mat):
    # create for every time point all the track files
    for (ktime, tid) in enumerate(times):        
        tfolder = os.path.join(folder, '{:03d}'.format(ktime) )
        if not os.path.exists(tfolder):
            os.makedirs(tfolder)
        create_track_files(folder=tfolder, 
                   sim_ids=sim_ids, track_ids=track_ids, 
                   mat=circos_mat[:,:,ktime])
    return None

############################################################################
if __name__ == '__main__':
    ''' 
    Creating the data matrix for the circos visualization.
    The resulting matrix has the dimensions
    [Nsims, Ntracks, Ntimes]    
    '''
    task_id = 1  
    folder = os.path.join(sim.PathSettings.MULTISCALE_GALACTOSE_RESULTS, 'circos', 'T{}'.format(task_id))
    if not os.path.exists(folder):
        os.makedirs(folder)
    print folder
    
    # select model variables to write into circos
    track_ids = create_track_ids_for_compound('galM', compartment="C")
    Ntracks = len(track_ids)    
    print track_ids
    
    # simulations to visualize
    # TODO: filter the panda DataFrame to the subset for visualization
    pars = read_parameters_for_task(task_id=task_id)
    print(pars)
    sim_ids = pars['sim']
    print sim_ids
    Nsims = len(sim_ids)
    
    # timepoints to generate
    Ntimes = 43
    t_start = 4999 
    t_end = 5020
    tol = 1E-6
    times = np.linspace(start=t_start, stop=t_end, num=Ntimes) + tol
    times
    
    # get the panda DataFrames for all simulations
    df_dict = read_dataframes(sim_ids)
    
    # fill the circos matrix
    circos_mat = create_circos_mat(track_ids, times, df_dict)

    # average the matrix (TODO: for pv outflow concentration)
    # av = np.average(mat, axis=1, weights=weights) 
    import pylab as p    
    for (ks, sid) in enumerate(sorted(df_dict.keys())):
        for kt, tid in enumerate(track_ids):
            p.plot(times, circos_mat[ks, kt,:])
            p.ylim=[0,0.4]
        p.show()
     
    
    # create the circos files
    create_karyotype_file(folder, sim_ids)
    
    create_all_track_files(sim_ids=sim_ids, track_ids=track_ids, times=times, 
                           circos_mat=circos_mat)
    track_ids
    times

    
    def create_plot_file(time):
        ''' 
        Creates the circos plot file for a single timepoint.
        '''
        pass
    
    
    def create_all_plot_files(times, track_ids)

    def create_circos_conf(time):
        pass

    def create_colors():
        pass


    def create_circos_plot(time):
        pass    
    
    
    
    

