'''
Created on May 20, 2014

@author: mkoenig
'''

import os
import sys
sys.path.append('/home/mkoenig/multiscale-galactose/python')
os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'
 
from sim.models import Simulation
from ODE_Integration import integrate

if __name__ == "__main__":    
    from simulation.Simulator import SIM_FOLDER
    import roadrunner
    print roadrunner.__version__
    
    sims = Simulation.objects.all()[0],
    #for sim in sims:
    integrate(sims, SIM_FOLDER)

    
    