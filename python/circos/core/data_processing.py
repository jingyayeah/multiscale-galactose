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
    time_folders = []
    # create for every time point all the track files
    for (ktime, tid) in enumerate(times):        
        time_folder = os.path.join(folder, '{:03d}'.format(ktime) )
        if not os.path.exists(time_folder):
            os.makedirs(time_folder)
        create_track_files(folder=time_folder, 
                   sim_ids=sim_ids, track_ids=track_ids, 
                   mat=circos_mat[:,:,ktime])
        time_folders.append(time_folder)
    return time_folders

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
    
    time_folders = create_all_track_files(sim_ids=sim_ids, track_ids=track_ids, times=times, 
                           circos_mat=circos_mat)
    time_folders
    track_ids
    times

    
    def create_plot_file(ktime, folder, time_folder, track_ids):
        ''' 
        Creates the circos plot file for a single timepoint.
        '''
        lines = []
        lines.append('<plots>')
        lines.append('type = heatmap')
        lines.append('min = 0')
        lines.append('max = 0.20')
        lines.append('spacing = 0.2r')
                
        # Create the plot tracks
        Ntracks = len(track_ids)
        upper = 0.98
        lower = 0.06
        dist = (upper-lower)/Ntracks
        for (k, track_id) in enumerate(track_ids):
            r1 = upper - k*dist
            r0 = upper - (k+1)*dist+0.005
            lines.append('<plot>')
            lines.append('file = {}/track_{:02}.txt'.format(time_folder, k))
            lines.append('r1 = {:1.4f}r'.format(r1))
            lines.append('r0 = {:1.4f}r'.format(r0))
            lines.append('</plot>')
        
        lines.append('</plots>')
        lines.append('')
        # write the file
        pfile = os.path.join(folder, 'plots_{:03}.conf'.format(ktime))
        f = open(pfile, 'w')
        f.write('\n'.join(lines))
        f.close()
        return pfile
    
    
    def create_all_plot_files(folder, time_folders, track_ids):
        plot_files = []
        for (ktime, tf) in enumerate(time_folders):
            pfile = create_plot_file(ktime, folder, time_folder=tf, track_ids=track_ids)
            plot_files.append(pfile)
        return plot_files
    
    def create_circos_file(ktime, folder):
        ''' 
        Creates the circos plot file for a single timepoint.
        '''
        lines = [
            'chromosomes_units = 1',
            'karyotype = karyotype_galactose.txt',
            '<<include ../ideogram.conf>>',
            '<<include ../ticks.conf>>',
            '<image>',
            '<<include etc/image.conf>> ',
            '</image>',
            '<<include etc/colors_fonts_patterns.conf>> ',
            '<<include etc/housekeeping.conf>>',
            '<<include plots_{:03d}.conf>>'.format(ktime, ktime),
        ]
        
        # write the file
        fname = os.path.join(folder, 'circos_{:03d}.conf'.format(ktime))
        f = open(fname, 'w')
        f.write('\n'.join(lines))
        f.close()
        return fname
    
    def create_all_circos_files(folder, time_folders):
        files = []
        for (ktime, tf) in enumerate(time_folders):
            cfile = create_circos_file(ktime, folder)
            files.append(cfile)
        return files

    create_all_circos_files(folder, time_folders)
    
    # Create the images
    from subprocess import call
    for (ktime, t) in enumerate(times):
        call(["ls", "-l"])
        
        

    





    def create_circos_conf(time):
        pass

    def create_colors():
        pass


    def create_circos_plot(time):
        pass    
    
    
    
    

