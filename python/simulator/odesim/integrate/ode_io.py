'''
Input and output functions for integration.

TODO: Decouple result file generation from database storage/interaction.

@author: Matthias Koenig
@date: 2015-05-03
'''

import os
import numpy as np
import h5py

from django.core.files import File
from django.utils import timezone

from sbmlsim.models import Timecourse, DONE

import config_files

from project_settings import SIM_DIR 

from enum import Enum
class FileType(Enum):
    CSV = 1
    HDF5 = 2

def storeConfigFile(sim, folder):
    ''' Store the config file in the database. '''
    fname = config_files.create_config_filename(sim, folder)
    config_file = config_files.create_config_file_for_simulation(sim, fname)
    f = open(config_file, 'r')
    sim.file = File(f)
    sim.save()
    return config_file;


def csv_file(sbml_id, sim):
    return "".join([SIM_DIR, "/", str(sim.task), '/', sbml_id, "_Sim", str(sim.pk), '_roadrunner.csv'])


def store_timecourse_csv(filepath, data, header, keep_tmp=False):
    ''' The storage as CSV and conversion to Rdata format is expensive.
        Better solution is the storage as b
        Probably better to store as HDF5 file. For single odesim?
        
    '''
    np.savetxt(filepath, data, header=",".join(header), delimiter=",", fmt='%.12E')


def hdf5_file(sbml_id, sim):
    return "".join([SIM_DIR, "/", str(sim.task), '/', sbml_id, "_Sim", str(sim.pk), '_roadrunner.h5'])
    
    
def store_timecourse_hdf5(filepath, data, header, meta=None):
    ''' Store the odesim file as HDF5.
        Writing meta information, header/selection & data.
        /data
        /header
        /time
    '''
    f = h5py.File(filepath, 'w')
    f.create_dataset('data', data=data, compression="gzip")
    f.create_dataset('header', data=header, compression="gzip", dtype="S10")
    f.create_dataset('time', data=data[:,0], compression="gzip")
    f.close()
    

def store_timecourse_db(sim, filepath, ftype, keep_tmp=False):
    ''' Store the actual timecourse file in the database. 
        TODO: store the filetype.
    '''
    f = open(filepath, 'r')
    myfile = File(f)
    tc, _ = Timecourse.objects.get_or_create(simulation=sim)
    tc.file = myfile
    tc.save()
    
    
    if ftype == FileType.CSV:
        # zip csv
        tc.zip()
        # convert to Rdata for faster loading
        tc.rdata()
        if (keep_tmp==False):
            # remove the original csv file now
            myfile.close()
            f.close()
            os.remove(filepath)
        # remove the db csv (only compressed file kept)
        os.remove(tc.file.path)
    
    
    # odesim finished (update odesim status)
    sim.time_sim = timezone.now()
    sim.status = DONE
    sim.save()