'''
Here the actual ode integration is performed for the given simulations.

@author: mkoenig
@date: 2014-05-11

TODO: simulate bunch of simulations with the same model.
'''
import sys
import time
import traceback
from subprocess import call
import shlex

from django.core.files import File
from ConfigFileFactory import create_config_file_in_folder

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
            '''
            Here the complete RoadRunner simulation logic is performed.
            Make sure the model is not reloaded
            '''
            # read SBML
            rr = roadrunner.RoadRunner(sbml_file)
        
            # set the selection
            sel = ['time']
            sel += [ "".join(["[", item, "]"]) for item in rr.model.getBoundarySpeciesIds()]
            sel += [ "".join(["[", item, "]"]) for item in rr.model.getFloatingSpeciesIds()] 
            sel += rr.model.getReactionIds()
            
            rr.selections = sel
            header = ",".join(sel)
        
            from sim.models import GLOBAL_PARAMETER, BOUNDERY_INIT, FLOATING_INIT
        
            # set all parameters in the model and store the changes for revert
            changes = dict()
            pc = ParameterCollection.objects.get(pk=sim.parameters.pk)
            for p in pc.parameters.all():
                name = p.name
                if (p.ptype == GLOBAL_PARAMETER):
                    pass
                elif (p.ptype == BOUNDERY_INIT):
                    name = "".join(['[', name, ']'])
                elif (p.ptype == FLOATING_INIT):
                    name = "".join(['init([', name, '])'])
                name = str(name)
                
                # now set the value for the correct name
                print name
                changes[name] = rr.model[name]
                rr.model[name] = p.value

            # use the integration settings (adapt absTol to amounts)
            odeset = sim.task.integration
            absTol = odeset.abs_tol * min(rr.model.getCompartmentVolumes())
                       
            start = time.clock()
            s = rr.simulate(odeset.tstart, odeset.tend, 
                    absolute=absTol, relative=odeset.rel_tol, variableStep=True, stiff=True)
            elapsed = (time.clock()- start)    
            print 'Time:', elapsed
        
            # Store Timecourse Results
            tc_file = "".join([folder, "/", sbml_id, "_Sim", str(sim.pk), '_roadrunner.csv'])
            numpy.savetxt(tc_file, s, header=header, delimiter=",", fmt='%.6E')

            # reset
            rr.reset()
            for key, value in changes.iteritems():
                rr.model[key] = value    
        
    
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
    
    sim = Simulation.objects.filter(task__pk=1)[0]
    #for sim in sims:
    integrate(sim, SIM_FOLDER, simulator=ROADRUNNER)
    integrate(sim, SIM_FOLDER, simulator=COPASI)