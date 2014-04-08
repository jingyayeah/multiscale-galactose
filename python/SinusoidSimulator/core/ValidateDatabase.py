'''
Created on Mar 25, 2014

@author: Matthias Koenig

    # TODO: Somehow the database has to be checked for consistency.
    # Perform db validation routines and cleanup on the database.
    
    
    # remove all simulations
    # print "Deleting all simulations !!!"
    # Simulation.objects.all().delete()
    
    TODO: 
    check for Simulations which have status assigned, but never finished.
    
    TODO: 
    Check for timecourses which point to unassigned & assigned simulations
    and remove these files.    
    
    TODO: 
    validate the database content. Is everything consistent, are all the files
    accessible. Run control checks.
    
    TODO: 
    clean cores which did not listen for some time.
    
'''

import sys
import os
sys.path.append('/home/mkoenig/multiscale-galactose/python')
os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'
from datetime import timedelta
from django.utils import timezone
from django.core.exceptions import ObjectDoesNotExist
from sim.models import Simulation, Timecourse, UNASSIGNED, ASSIGNED


def handleUnfinishedSimulations():
    '''
    Gets assigned simulations which did not finish for a long time.
    '''
    # get all assigned simulations
    assigned = Simulation.objects.filter(status=ASSIGNED)
    for sim in assigned:
        t_assign = sim.time_assign
        if (timezone.now() >= t_assign + timedelta(minutes=3)):
            print "Simulation assigned for long: ", sim.pk
            print t_assign
            print timezone.now()
            unassignSimulation(sim)

def unassignAllSimulation():
    for sim in Simulation.objects.all():
        unassignSimulation(sim);

def unassignSimulation(sim):
    '''
    Removes the corresponding Timecourse if exists and resets the
    Simulation to unassigned.
    '''
    # remove the timecourse if exists
    try:
        tc = Timecourse.objects.get(simulation=sim)
        # TODO: delete the coresponding local file
        tc.delete();
        print "Timecourse for simulation removed"
    except ObjectDoesNotExist:
        print "No timecourse for simulation available."
    
    # reset the simulation
    sim.status = UNASSIGNED
    sim.core = None
    sim.file = None
    sim.time_assign = None
    sim.save();
    print "Simulation reset: ", sim
    
if __name__ == "__main__":
    handleUnfinishedSimulations();
    
    # ! CAREFUL !
    # unassignAllSimulation()
    
    # ! CAREFUL !
    # unassignAllSimulation()
    
    