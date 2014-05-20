'''
Created on May 20, 2014

@author: mkoenig
'''

import os
import sys
sys.path.append('/home/mkoenig/multiscale-galactose/python')
os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'
 
import time
 
from sim.models import Simulation, Timecourse, ParameterCollection 
from sim.models import ROADRUNNER, DONE
from django.utils import timezone
from django.core.files import File

from core.ConfigFileFactory import create_config_file_in_folder

def do_simulation(sim, folder):
    sbml_file = str(sim.task.sbml_model.file.path)
    sbml_id = sim.task.sbml_model.sbml_id
    config_file = create_config_file_in_folder(sim, folder)
     
    #Store the config file in the database
    f = open(config_file, 'r')
    sim.file = File(f)
    sim.save()
         
    # Choose simulator
    simulator = sim.simulator
     
    if (simulator == ROADRUNNER):
        print roadrunner.__version__
        rr = roadrunner.RoadRunner(sbml_file)
        
        rr.model
        
        # make the changes to the model
        pc = ParameterCollection.objects.get(pk=sim.parameters.pk)
        for p in pc.parameters.all():
            print p.name, '=', p.value
            # sel = rr.createSelection(p.name)
            setattr(rr.model, p.name, p.value)
            print getattr(rr.model, p.name)
    
        print 'simulate'
        start = time.clock()
        opts = sim.task.integration
        s = rr.simulate(opts.tstart, opts.tend, steps=opts.tsteps, 
                    absolute=opts.abs_tol, relative=opts.rel_tol, stiff=True)
        elapsed = (time.clock()- start)    
        print 'Time:', elapsed
         
        # Store Timecourse Results    
        import numpy as n
        timecourse_file = folder + "/" + sbml_id + "_Sim" + str(sim.pk) + '_roadrunner.csv'
        n.savetxt(timecourse_file, s, header=", ".join(rr.selections))
            
        f = open(timecourse_file, 'r')
        myfile = File(f)
        tc, created = Timecourse.objects.get_or_create(simulation=sim)
        if (not created):
            print 'Timecourse already exists and is overwritten!'
        tc.file = myfile
        tc.save();
      
        # simulation finished (update simulation information and save)
        sim.time_sim = timezone.now()
        sim.status = DONE
        sim.save()

    
if __name__ == "__main__":
    from core.Simulator import SIM_FOLDER
    import roadrunner
    print roadrunner.__version__
    
    sims = Simulation.objects.all()[0:2]
    for sim in sims:
        do_simulation(sim, SIM_FOLDER)

    
    