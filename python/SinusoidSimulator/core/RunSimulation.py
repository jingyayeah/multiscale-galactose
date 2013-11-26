'''
Created on Nov 21, 2013

@author: mkoenig

Simulations in Cpp have to be called with
SBML file and the parameter settings files


'''
import sys
import os
sys.path.append('/home/mkoenig/multiscale-galactose/python')
os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'

from simulation.models import * 
from django.core.files import File


def createSimulationTask():
    # TODO: overwrite the model constructor, so that only the 
    # file can be given.
    # All the derived fields should be created automatically
    # from the SBML file name.

    # Get the SBML file to store in the database
    # Create a Python file object using open()
    f = open('../examples/Galactose_Dilution_v3_Nc5_Nf5.xml', 'r')
    myfile = File(f)
    
    # Create the model Galactose_Dilution_v3_Nc5_Nf5.xml
    
    model, created = SBMLModel.objects.get_or_create(sbml_id='Galactose_Dilution_v3_Nc5_Nf5')
    if (created):
        model.name = 'Galactose_Dilution'
        model.version = 3
        model.nc = 5
        model.nf = 5
        model.file = myfile
        model.save()
    print 'name: ' + model.file.name
    print 'path: ' + model.file.path
    print 'url: '  + model.file.url
    f.close()
    
    # INTEGRATION
    integration, created = Integration.objects.get_or_create(tstart=0.0, tend=200.0, tsteps=1000,
                              abs_tol=1E-6, rel_tol=1E-6)
    integration.save()
    if (created):
        print ('integration created');
    
    # task = Task(sbml_model=model, integration=integration)
    # task.save()
    
    # SIMULATIONS
    # sim = Simulation(task=task, )
    
    # PARAMETERS
    # Create the necessary parameter sets for the simulations
    # flow, L, y_sin, y_dis, y_cell, PP__gal
    p1, created = Parameter.objects.get_or_create(name='flow', value=60E-6, unit="m/s");
    p1.save()
    if (created):
        print ('p1 created');
    p2, created = Parameter.objects.get_or_create(name='L', value=500E-6, unit="m");
    p2.save()
    if (created):
        print ('p2 created');
    
    # Careful with creating objects again and again
    pset = ParameterCollection();
    pset.save()
    pset.parameters.add(p1);
    pset.parameters.add(p2);
    


if __name__ == "__main__":
    createSimulationTask()