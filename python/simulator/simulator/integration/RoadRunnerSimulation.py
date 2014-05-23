'''
Created on May 20, 2014

@author: mkoenig
'''

import os
import sys
sys.path.append('/home/mkoenig/multiscale-galactose/python')
os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'
 
import time
import numpy
 
from sim.models import Simulation, Timecourse, ParameterCollection 
from sim.models import ROADRUNNER, DONE
from django.utils import timezone
from django.core.files import File

from core.ConfigFileFactory import create_config_file_in_folder

def do_simulation(sim, folder):
    sim.time_assign = timezone.now()
    sbml_file = str(sim.task.sbml_model.file.path)
    sbml_id = sim.task.sbml_model.sbml_id
    print sbml_file
    
    # create config file
    config_file = create_config_file_in_folder(sim, folder)
    print config_file
     
    #Store the config file in the database
    f = open(config_file, 'r')
    sim.file = File(f)
    sim.save()
         
    # Choose simulator
    simulator = sim.simulator
    if (simulator == ROADRUNNER):
        
        # read SBML
        rr = roadrunner.RoadRunner(sbml_file)
        
        # Do the selection once
        # TODO
        
        # set all parameters in the model
        pc = ParameterCollection.objects.get(pk=sim.parameters.pk)
        for p in pc.parameters.all():
            setattr(rr.model, p.name, p.value)
    
        # now do the full series of simulations for the model
        
    
        print 'simulate'
        start = time.clock()
        opts = sim.task.integration
        s = rr.simulate(opts.tstart, opts.tend, steps=opts.tsteps, 
                    absolute=opts.abs_tol, relative=opts.rel_tol, stiff=True)
        elapsed = (time.clock()- start)    
        print 'Time:', elapsed
        print(rr)

        # Store Timecourse Results
        # TODO: proper file format for analysis (header ?) -> use all ids of the sbml
        
        tc_file = "".join([folder, "/", sbml_id, "_Sim", str(sim.pk), '_roadrunner.csv'])
        numpy.savetxt(tc_file, s, header=", ".join(rr.selections), delimiter=",")
        
        # Store in database
        f = open(tc_file, 'r')
        myfile = File(f)
        tc, created = Timecourse.objects.get_or_create(simulation=sim)
        tc.file = myfile
        tc.save();
      
        # simulation finished (update simulation information and save)
        sim.time_sim = timezone.now()
        sim.status = DONE
        sim.save()

        print 'Total time:', sim.duration
    
if __name__ == "__main__":
    
    from core.Simulator import SIM_FOLDER
    import roadrunner
    print roadrunner.__version__
    
    sim = Simulation.objects.all()[0]
    #for sim in sims:
    do_simulation(sim, SIM_FOLDER)

    
    