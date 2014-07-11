'''
Running & viusalizing a single simulation from the database 
with roadrunner from within spyder.

Analysis can be done in any programme reading the csv information.

@author: Matthias Koenig
@date:   2014-07-11
'''

import sim.PathSettings
from sim.models import Simulation
from simulation.integration import ode_integration
from simulation import Simulator

import roadrunner

def plot1(ids, result):
    """
    Plot some trajectories.
    """
    import pylab as p
    
    if result is None:
        raise Exception("no simulation result")

    time = result[:,0]
    
    # filter the ids
    # ids = [id for id in ids if id.contains('PV')]
    print ids    
    for i in range(1, len(ids)):
        series = result[:,i]
        name = ids[i]
        p.plot(time, series, label=str(name))
        p.legend()




if __name__ == "__main__":
    
    # define simulation to run    
    sim_pk = 101
    if not sim_pk:
        sims = Simulation.objects.all()[0],
    else:
        sims = Simulation.objects.filter(pk=sim_pk)
    print sims

    # simulate
    import roadrunner
    print roadrunner.__version__
    
    # create the results folder for the simulation
    Simulator.create_simulation_directory_for_task(sims[0].task)

    #for sim in sims:
    integrator = sims[0].task.integrator
    print integrator
    
    if integrator != 'ROADRUNNER':
        exit()
    
    rr = ode_integration.integrate_roadrunner(sims) 
    
    
    # plot the interesting results
        
    
    print rr.selections
    ids = rr.selections
    results = rr.getSimulationData()
    
    plot1(ids, results)    
    
    # rr.plot()
        
        
    


    
    