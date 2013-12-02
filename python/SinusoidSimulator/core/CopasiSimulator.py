'''
Created on Dec 2, 2013

@author: mkoenig
'''
import Simulator
from sim.models import Parameter, Simulation, Timecourse
from django.core.files import File

def perform_copasi_simulation(sim):
    print 'Copasi simulation peformed for: sim.pk=', sim.pk
    
    # get the list of parameters
    print
    print 'parameters:'
    psquery = Parameter.objects.filter(parametercollection=sim.parameters.pk)
    for p in psquery:
        print p
    
    # get the integration settings
    print
    print 'integration settings'
    integration = sim.task.integration
    print integration.pk, integration.tstart, integration.tend
    
    # get the sbml (this is on the remote
    # server where the simulations are defined)
    print
    print 'sbml'
    sbml = sim.task.sbml_model
    print sbml.pk
    print sbml.file
    print sbml.file.path
    f = open(sbml.file.path, 'r')
    for line in f:
        print line
    
    
    
    
    
    # Here the result file is written
    # create timecourse file
    fname = 'timecourse.txt'
    f = open(fname, 'w')
    f.write("test timecourse");
    f.close();
    
    # save the file in the database
    f = open(fname, 'r')
    myfile = File(f)
    tc = Timecourse(simulation=sim, file=myfile)
    tc.save()
    
    # open the timecourse file from the database
    print 'name:', tc.file.name
    print 'url:', tc.file.url
    print 'path:', tc.file.path
    
    # open the file from the path
    print
    print 'File opened again'
    f = open(tc.file.path, 'r')
    for line in f:
        print line
    
    



if __name__ == "__main__":
    ip = Simulator.get_ip_address();
    sim = Simulator.assign_simulation(ip, 0)
    if (not sim):
        print 'No simulation could be assigned'
    else:
        perform_copasi_simulation(sim);
