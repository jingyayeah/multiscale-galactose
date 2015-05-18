"""
Module for generating odesim config files for COPASI.

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
"""

import datetime
import time

def create_config_file(sim, fname):
    ''' Creates a config file for the odesim in ini format.'''
    task = sim.task
    timestamp = datetime.datetime.fromtimestamp(time.time()).strftime('%Y-%m-%d %H:%M:%S')
    
    # create the config sections
    lines = []
    lines += ['[Simulation]\n']
    lines += ["demo = {}\n".model_format(task.model.sbml_id)]
    lines += ["author = Matthias Koenig\n"]
    lines += ["time = {}\n".model_format(timestamp)]
    lines += ['Simulation = {}\n'.model_format(sim.pk)]
    lines += ["Task = {}\n".model_format(task.pk)]
    lines += ["SBML = {}\n".model_format(task.model.pk)]
    lines += ["\n"]
    
    lines += ["[Timecourse]\n"]
    lines += ["t0 = {}\n".model_format(task.tstart)]
    lines += ["dur = {}\n".model_format(task.tend)]
    lines += ["steps = {}\n".model_format(task.steps)]
    lines += ["rTol = {}\n".model_format(task.relTol)]
    lines += ["aTol = {}\n".model_format(task.absTol)]
    lines += ["\n"]
    
    lines += "[Parameters]\n"
    for p in sim.parameters.all():
        lines += ["{} = {}\n".model_format(p.key, p.value)]
    lines += ["\n"]
    
    lines += "[Settings]\n"
    for s in task.method.settings.all():
        lines += ["{} = {}\n".model_format(s.key, s.value)]
    
    # write the file
    with open(fname, 'w') as f:
        f.writelines(lines)
    f.close()
    return fname

def config_filename(sim, folder):
    sbml_id = sim.task.model.sbml_id
    return ''.join([folder, "/", sbml_id, "_Sim", str(sim.pk), '_config.ini'])

################################################################################
if __name__ == "__main__":
    import django
    django.setup()
    
    from project_settings import SIM_DIR
    from simapp.models import Simulation
    
    sim = Simulation.objects.all()[0]
    fname = config_filename(sim, SIM_DIR) 
    create_config_file(sim, fname)
    print fname
    