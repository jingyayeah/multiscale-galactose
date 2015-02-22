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
    
    
def get_dataframes(sim_ids):
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
    return(df_dict)


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
    task_id = 1    
    
    # select model variables to write into circos
    track_ids = create_track_ids_for_compound('galM', compartment="C")
    Ntracks = len(track_ids)    
    print track_ids
    
    # simulations to visualize
    # TODO: filter the panda DataFrame to the subset for visualization
    pars = read_parameters_for_task(task_id=task_id)
    sim_ids = pars['sim']
    print sim_ids
    Nsims = len(sim_ids)
    
    # timepoints to generate
    Ntimes = 41
    t_start = 5000
    t_end = 5020
    import numpy as np
    times = np.linspace(start=t_start, stop=t_end, num=Ntimes)
    times
    
    # get the panda DataFrames for all simulations
    df_dict = get_dataframes(sim_ids)

    # create empty matrix template    
    circos_mat = np.empty([Nsims, Ntracks, Ntimes])    
    
    # interpolate the data and fill the circos matrix
    from scipy import interpolate
    for ks, sid in enumerate(df_dict.keys()):
        df = df_dict[sid]

        for (kt, tid) in enumerate(track_ids):
            # check if tid in the results
            x = df['time']
            y = df[tid]
            f = interpolate.interp1d(x=x, y=y)
            circos_mat[ks, kt, :] = f(times)

    # average the matrix (TODO: for pv outflow concentration)
    # av = np.average(mat, axis=1, weights=weights)
 
    import pylab as p    
    for ks, sid in enumerate(sorted(df_dict.keys())):
        for kt, tid in enumerate(track_ids):
            p.plot(times, circos_mat[ks, kt,:])
            p.ylim=[0,0.4]
        p.show()
    
    # create the circos files
    folder = sim.PathSettings.MULTISCALE_GALACTOSE_RESULTS + '/circos/' + 'T{}'.format(task_id)
    print(folder)
    
    
    def create_karyotype_file(folder, sim_ids):
        '''
        Write the Karyotypes
        '''
        fname = folder + "/karyotype_galactose.txt"
        print fname
        k_f = open(fname , 'w')
        for k, sid in enumerate(sim_ids):
            k_f.write('chr - s{} {} 0 1 s{}\n'.format(sid, k, sid) )
        k_f.close()

    create_karyotype_file(folder, sim_ids)


    def create_plots_conf(time):
        pass

    def create_circos_conf(time):
        pass

    def create_colors():
        pass


    def create_circos_plot(time):
        pass    
    
    
    
    

