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


@author: Matthias Koenig
@date:   2014-07-11
'''

import datetime
import time

import sim.PathSettings
from sim.models import Simulation

def create_config_file_for_simulation(sim, fname):
    ''' Creates a config file for the simulation in ini format.'''
    task = sim.task
    timestamp = datetime.datetime.fromtimestamp(time.time()).strftime('%Y-%m-%d %H:%M:%S')
    
    # create the config sections
    lines = []
    lines += ['[Simulation]\n']
    lines += ["sbml = {}\n".format(task.sbml_model.sbml_id)]
    lines += ["author = Matthias Koenig\n"]
    lines += ["time = {}\n".format(timestamp)]
    lines += ['Simulation = {}\n'.format(sim.pk)]
    lines += ["Task = {}\n".format(task.pk)]
    lines += ["SBML = {}\n".format(task.sbml_model.pk)]
    lines += ["\n"]
    
    lines += ["[Timecourse]\n"]
    lines += ["t0 = {}\n".format(task.tstart)]
    lines += ["dur = {}\n".format(task.tend)]
    lines += ["steps = {}\n".format(task.steps)]
    lines += ["rTol = {}\n".format(task.relTol)]
    lines += ["aTol = {}\n".format(task.absTol)]
    lines += ["\n"]
    
    lines += "[Parameters]\n"
    for p in sim.parameters.all():
        lines += ["{} = {}\n".format(p.name, p.value)]
    lines += ["\n"]
    
    lines += "[Settings]\n"
    for s in task.integration.settings.all():
        lines += ["{} = {}\n".format(s.name, s.value)]
    
    # write the file
    with open(fname, 'w') as f:
        f.writelines(lines)
    f.close()
    return fname

def create_config_filename(sim, folder):
    sbml_id = sim.task.sbml_model.sbml_id
    return ''.join([folder, "/", sbml_id, "_Sim", str(sim.pk), '_config.ini'])

################################################################################
if __name__ == "__main__":
    from sim.PathSettings import SIM_DIR
    
    sim = Simulation.objects.all()[0];
    fname = create_config_filename(sim, SIM_DIR) 
    create_config_file_for_simulation(sim, fname)
    print fname
    