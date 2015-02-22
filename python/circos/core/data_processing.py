'''
Create the circos file formats for visualization.
Takes a list of simulations and repacks the contents of the 
CSV solutions in circos file formats.

I.e. create all the tracks for every timepoint.

@author: Matthias Koenig
@date: 2015-02-22

TODO: calculate the flow weighted PV concentration from all samples
'''

import sim.PathSettings
from sim.PathSettings import SIM_DIR
import sim.analysis.ParameterFiles as pf
from sim.models import Task

sim_ids = [] # simulations
pars = []    # parameters of the simulations


# for every timepoint all the circos tracks have to be generated

# definition of the chromosomes


def read_parameters_for_task(task_id):
    '''
    TODO: use panda for data analysis. 
    Everything else is a waste of time.
    '''
    task = Task.objects.get(pk=task_id)
    
    data = pf.createParameterInfoForTask(task)
    return data

    # Here is time to use pandas



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
    

if __name__ == '__main__':
    track_ids = create_track_ids_for_compound('galM', compartment="H")
    print track_ids
    
    # get a subset of simulation ids
    pars = read_parameters_for_task(task_id=1)
    sim_ids = pars['sim']
    print sim_ids
    
    # which timepoints to generate
    t_start = 5000
    t_end = 5020
    import numpy as np
    times = np.linspace(start=t_start, stop=t_end, num=21)
    
    
    # get the csv files
    
    # open csv and interpolate the time points
    

