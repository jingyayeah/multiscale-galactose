'''
Created on Nov 21, 2013

@author: mkoenig

Simulations in Cpp have to be called with
SBML file and the parameter settings files


'''
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
    model = SBMLModel(sbml_id='Galactose_Dilution_v3_Nc5_Nf5',
                      name='Galactose_Dilution',
                      version=3,
                      Nc=5,
                      Nf=5,
                      file=myfile)
    model.save()
    
    print 'name: ' + model.file.name
    print 'path: ' + model.file.path
    print 'url: '  + model.file.url
    
    

    # INTEGRATION
    integration = Integration(tstart=0.0, tend=200.0, tsteps=1000,
                              abs_tol=1E-6, rel_tol=1E-6)
    integration.save()
    
    task = Task(sbml_model=model, integration=integration)
    task.save()
    
    # SIMULATIONS
    # sim = Simulation(task=task, )
    
    # PARAMETERS
    # Create the necessary parameter sets for the simulations
    # flow, L, y_sin, y_dis, y_cell, PP__gal
    p = Parameter(name='flow', 60E-6)
    # pset = ParameterSet();
    
    




if __name__ == "__main__":
    
    
    createSimulationTask()