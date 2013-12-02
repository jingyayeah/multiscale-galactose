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
from django.db.models import Count


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
    

    # Careful with creating objects again and again
    # Get the parameter collection which contains all the parameters in the list
    # Here every time a new Parameter collection is created
    pars = (('deficiency', 0, '-'),
            ('flow', 60E-6, 'm/s'),
            ('L',   500E-6, 'm'),)
    
    # [4]
    # Create the necessary parameter sets for the simulations
    # flow, L, y_sin, y_dis, y_cell, PP__gal
    # parameters are lists of triples
    
    # In the simulation definition the parameter sets have to be created.
    # for every parameterset a simulation is created
    ps = []
    for data in pars:
        name, value, unit = data
        p, created = Parameter.objects.get_or_create(name=name, value=value, unit=unit);
        if (created):
            print name, 'created'
            p.save()
        ps.append(p)
    
    # Get the pset for the parameters if it exists
    # This is necessary to have unique collections regarding the parameters
    # Reduce the queryset with filters until 

    # Annotate with count first and use than to filter    
    querySet = ParameterCollection.objects.annotate(num_parameters=Count('parameters')).filter(num_parameters__eq=len(ps))
    for p in ps:
        querySet = querySet.filter(parameters = p)
        
    if (len(querySet)>0):
        pset = querySet[0]
        print 'ParameterSet found already'
    else:
        pset = ParameterCollection();
        pset.save()
        for p in ps:
            pset.parameters.add(p)
        pset.save()
        print "ParameterSet created"
    
    # Simulation
    print task, task.id
    sim, created = Simulation.objects.get_or_create(task=task, 
                                                      parameters = pset,
                                                      status = UNASSIGNED)
    if (created):
        print "Simulation created"
        sim.save()


if __name__ == "__main__":
    createSimulationTask()