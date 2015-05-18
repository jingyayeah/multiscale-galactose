"""
Input and output functions for integration.

@author: mkoenig
@date: 2015-05-03
"""
# TODO: Decouple result file generation from database storage/interaction.

import os
import numpy as np
import h5py

from django.core.files import File
from django.utils import timezone
import config_files

from simapp.models import Result, SimulationStatus
from project_settings import SIM_DIR

from enum import Enum
class FileType(Enum):
    CSV = 0
    HDF5 = 1


# ---------------------------------------------------------------------------------------------------------------------
#   CSV
# ---------------------------------------------------------------------------------------------------------------------
def csv_file(sbml_id, sim):
    return os.path.join(SIM_DIR, str(sim.task), "{}_S{}_roadrunner.csv".format(sbml_id, sim.pk))


def save_csv(filepath, data, header, keep_tmp=False):
    """ The storage as CSV and conversion to Rdata format is expensive.
        Better solution is the storage as b
        Probably better to store as HDF5 file. For single odesim?
    """
    np.savetxt(filepath, data, header=",".join(header), delimiter=",", fmt='%.12E')

# ---------------------------------------------------------------------------------------------------------------------
#   HDF5
# ---------------------------------------------------------------------------------------------------------------------
def hdf5_file(sbml_id, sim):
    return os.path.join(SIM_DIR, str(sim.task), "{}_S{}_roadrunner.h5".format(sbml_id, sim.pk))
    

def save_hdf5(filepath, data, header, meta=None):
    """ Store numpy data as HDF5.
        Writing meta information, header/selection & distribution_data.
        /distribution_data
        /header
        /time
    """
    f = h5py.File(filepath, 'w')
    f.create_dataset('data', data=data, compression="gzip")
    f.create_dataset('header', data=header, compression="gzip", dtype="S10")
    # f.create_dataset('time', data=data[:, 0], compression="gzip")
    f.close()
    

def store_result_db(sim, filepath, ftype, keep_tmp=False):
    """ Stores a result file for the given simulation. """
    # TODO: store the file type.
    # TODO: add test
    f = open(filepath, 'r')
    myfile = File(f)
    tc, _ = Result.objects.get_or_create(simulation=sim)
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


def store_config_file(sim, folder):
    """ Store the config file in the database. """
    # TODO: refactor, this is not working any more
    fname = config_files.create_config_filename(sim, folder)
    config_file = config_files.create_config_file_for_simulation(sim, fname)
    f = open(config_file, 'r')
    sim.file = File(f)
    sim.save()
    return config_file