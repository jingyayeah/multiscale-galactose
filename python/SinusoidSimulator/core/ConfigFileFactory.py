'''
Created on Mar 21, 2014
@author: Matthias Koenig

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
'''
import os
import sys
sys.path.append('/home/mkoenig/multiscale-galactose/python')
os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'

import datetime
import time
from sim.models import ParameterCollection, Simulation

def create_config_file_in_folder(sim, folder):
    '''
    Writes the different sections in the config file.
    Takes information from the given sim objects and 
    the linked tables in the database.
    '''
    sbml_id = sim.task.sbml_model.sbml_id
    filename = folder + "/" + sbml_id + "_Sim" + str(sim.pk) + '_config.ini'
    f = open(filename, 'w')
    
    timestamp = datetime.datetime.fromtimestamp(time.time()).strftime('%Y-%m-%d %H:%M:%S')
    
    f.write('[Simulation]\n')
    f.write("sbml = {}\n".format(sim.task.sbml_model.sbml_id))
    f.write("author = Matthias Koenig\n")
    f.write("time = {}\n".format(timestamp))
    f.write('Simulation = {}\n'.format(sim.pk) )
    f.write("Task = {}\n".format(sim.task.pk) )
    f.write("SBML = {}\n".format(sim.task.sbml_model.pk))
    f.write("ParameterCollection = {}\n".format(sim.parameters.pk))
    f.write("\n")
    
    f.write("[Timecourse]\n")
    f.write("t0 = {}\n".format(sim.task.integration.tstart))
    f.write("dur = {}\n".format(sim.task.integration.tend))
    f.write("steps = {}\n".format(sim.task.integration.tsteps))
    f.write("rTol = {}\n".format(sim.task.integration.rel_tol))
    f.write("aTol = {}\n".format(sim.task.integration.abs_tol))
    f.write("\n")
    
    f.write("[Parameters]\n")
    pc = ParameterCollection.objects.get(pk=sim.parameters.pk)
    for p in pc.parameters.all():
        f.write("{} = {}\n".format(p.name, p.value) )
    
    f.close()
    return filename


if __name__ == "__main__":
    '''
    Test the creation of config files for defined simulations.
    '''
    folder = "/home/mkoenig/multiscale-galactose-results/test"
    # Get a simulation and write the respective config file
    sim = Simulation.objects.get(pk=312);
    create_config_file_in_folder(sim, folder)    
    
    
