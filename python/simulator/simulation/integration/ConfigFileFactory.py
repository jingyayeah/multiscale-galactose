'''
Module for generating simulation config files for COPASI.

Config files are stored in ini format with different sections.
The set parameters are handeled in the [Parameters] section, 
the Integration settings in the [Timecourse] section. Additional
information is stored in the [Simulation] section.
    
    ############################
    [Simulation]
    sbml = Dilution
    timecoure_id = tc1234
    pars_id = pars1234
    timestamp = 2014-03-27

    [Timecourse]
    t0 = 0.0
    dur = 100.0
    steps = 1000
    rTol = 1E-6
    aTol = 1E-6

    [Parameters]
    flow_sin = 60E-6
    PP__gal = 0.00012
    ############################
    
Created on Mar 21, 2014
@author: Matthias Koenig
'''

import os
import sys
sys.path.append('/home/mkoenig/multiscale-galactose/python')
os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'

import datetime
import time
from sim.models import Simulation

def create_config_file_in_folder(sim, folder):
    '''
    Writes the different sections in the config file.
    Takes information from the given sim objects and 
    the linked tables in the database.
    '''
    sbml_id = sim.task.sbml_model.sbml_id
    task = sim.task
    integration = sim.task.integration

    timestamp = datetime.datetime.fromtimestamp(time.time()).strftime('%Y-%m-%d %H:%M:%S')
    lines = []
    lines += ['[Simulation]\n']
    lines += ["sbml = {}\n".format(task.sbml_model.sbml_id)]
    lines += ["author = Matthias Koenig\n"]
    lines += ["time = {}\n".format(timestamp)]
    lines += ['Simulation = {}\n'.format(sim.pk)]
    lines += ["Task = {}\n".format(task.pk)]
    lines += ["SBML = {}\n".format(task.sbml_model.pk)]
    lines += ["ParameterCollection = {}\n".format(sim.parameters.pk)]
    lines += ["\n"]
    
    lines += ["[Timecourse]\n"]
    lines += ["t0 = {}\n".format(integration.tstart)]
    lines += ["dur = {}\n".format(integration.tend)]
    lines += ["steps = {}\n".format(integration.tsteps)]
    lines += ["rTol = {}\n".format(integration.rel_tol)]
    lines += ["aTol = {}\n".format(integration.abs_tol)]
    lines += ["\n"]
    
    lines += "[Parameters]\n"
    for p in sim.parameters.all():
        lines += ["{} = {}\n".format(p.name, p.value)]
    
    filename = ''.join([folder, "/", sbml_id, "_Sim", str(sim.pk), '_config.ini'])
    with open(filename, 'w') as f:
        f.writelines(lines)
    f.close()
    return filename


if __name__ == "__main__":
    ''' Test the creation of config files for defined simulations. '''
    from simulator.Simulator import SIM_FOLDER
    
    # Get a simulation and write the respective config file
    sim = Simulation.objects.all()[0];
    create_config_file_in_folder(sim, SIM_FOLDER)    
    