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

from sim.models import * 
from django.core.files import File
from django.core.exceptions import ObjectDoesNotExist


def createSimulationTask():
    # TODO: overwrite the model constructor, so that only the 
    # file can be given.
    # All the derived fields should be created automatically
    # from the SBML file name.

    # Get the SBML file to store in the database
    # Create a Python file object using open()
    f = open('../examples/Galactose_Dilution_v3_Nc5_Nf5.xml', 'r')
    myfile = File(f)
    
    # [1] Create the SBMLmodel
    # Create the model Galactose_Dilution_v3_Nc5_Nf5.xml
    try:
        model = SBMLModel.objects.get(sbml_id='Galactose_Dilution_v3_Nc5_Nf5')
    except ObjectDoesNotExist:
        print 'model created'
        model = SBMLModel(sbml_id='Galactose_Dilution_v3_Nc5_Nf5',
                          name='Galactose_Dilution',
                          version=3,
                          nc = 5,
                          nf = 5,
                          file = myfile)
        model.save()
    print 'name: ' + model.file.name
    print 'path: ' + model.file.path
    print 'url: '  + model.file.url
    f.close()
    
    # [2] Create integration
    integration, created = Integration.objects.get_or_create(tstart=0.0, tend=200.0, tsteps=1000,
                              abs_tol=1E-6, rel_tol=1E-6)
    
    if (created):
        print ('integration created')
        integration.save()
    
    # [3] Create task 
    task, created = Task.objects.get_or_create(sbml_model=model, integration=integration)
    if (created):
        print ("task created")
        task.save()

    
    # [4]
    # Create the necessary parameter sets for the simulations
    # flow, L, y_sin, y_dis, y_cell, PP__gal
    p1, created = Parameter.objects.get_or_create(name='flow', value=60E-6, unit="m/s");
    if (created):
        print ('p1 created');
        p1.save()
    p2, created = Parameter.objects.get_or_create(name='L', value=500E-6, unit="m");
    if (created):
        print ('p2 created');
        p2.save()
    
    # Careful with creating objects again and again
    # Get the parameter collection which contains all the parameters in the list
    pset = ParameterCollection();
    pset.save()
    pset.parameters.add(p1);
    pset.parameters.add(p2);
    
    
    # SIMULATIONS
    # sim = Simulation(task=task, )



if __name__ == "__main__":
    createSimulationTask()