'''
Created on May 21, 2014

@author: mkoenig
'''
import sys
import time
import traceback
from subprocess import call
import shlex

from django.core.files import File
from core.ConfigFileFactory import create_config_file_in_folder

from django.utils import timezone
from sim.models import Timecourse, ParameterCollection
from sim.models import DONE, ERROR, COPASI, ROADRUNNER

import numpy
import roadrunner
COPASI_EXEC = "/home/mkoenig/multiscale-galactose/cpp/copasi/CopasiModelRunner/build/CopasiModelRunner"

def integrate(sim, folder, simulator):
    ''' 
    Run ODE integration for the simulation. 
    Error handling is done via try/except 
    Cores are not hanging, but simulations are put into an ERROR state.
    Mainly problems if files are not available.
    '''
    try:
        sbml_file = str(sim.task.sbml_model.file.path)
        sbml_id = sim.task.sbml_model.sbml_id
        config_file = create_config_file_in_folder(sim, folder)
    
        #Store the config file in the database
        f = open(config_file, 'r')
        sim.file = File(f)
        sim.save()
        
        if (simulator == COPASI):
            tc_file = "".join([folder, "/", sbml_id, "_Sim", str(sim.pk), '_copasi.csv'])
            # run an operating system command
            # call(["ls", "-l"])
            call_command = COPASI_EXEC + " -s " + sbml_file + " -c " + config_file + " -t " + tc_file;
            print call_command
            call(shlex.split(call_command))
    
        elif (simulator == ROADRUNNER):
            tc_file = "".join([folder, "/", sbml_id, "_Sim", str(sim.pk), '_roadrunner.csv'])
            # read SBML
            rr = roadrunner.RoadRunner(sbml_file)
        
            # set all parameters in the model
            pc = ParameterCollection.objects.get(pk=sim.parameters.pk)
            for p in pc.parameters.all():
                setattr(rr.model, p.name, p.value)
    
            opts = sim.task.integration
            start = time.clock()
            s = rr.simulate(opts.tstart, opts.tend, steps=opts.tsteps, 
                    absolute=opts.abs_tol, relative=opts.rel_tol, stiff=True)
            elapsed = (time.clock()- start)    
            print 'Time:', elapsed
        
            # Store Timecourse Results
            # TODO: proper file format for analysis (header ?)
            numpy.savetxt(tc_file, s, header=", ".join(rr.selections), delimiter=",")
        
    
        # Store Timecourse Results
        f = open(tc_file, 'r')
        myfile = File(f)
        tc, created = Timecourse.objects.get_or_create(simulation=sim)
        tc.file = myfile
        tc.save();
    
        # simulation finished (update simulation information and save)
        sim.time_sim = timezone.now()
        sim.status = DONE
        sim.save()
    except Exception:
        print "Exception in multiscale-galactose:"
        print '-'*60
        traceback.print_exc(file=sys.stdout)
        print '-'*60
        sim.status = ERROR
        sim.save()
        
if __name__ == "__main__":
    from core.Simulator import SIM_FOLDER
    from sim.models import Simulation, Task
    print roadrunner.__version__
    
    task = Tas
    sim = Simulation.objects.filter()[0]
    #for sim in sims:
    integrate(sim, SIM_FOLDER, simulator=ROADRUNNER)
    integrate(sim, SIM_FOLDER, simulator=COPASI)