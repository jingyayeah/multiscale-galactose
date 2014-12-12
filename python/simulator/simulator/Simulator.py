#!/usr/bin/python
'''
Module for running/starting simulations.
Starts processes on the cpus which listen for available simulations.
The simulation settings and parameters determine the actual simulation.
The simulator supports parallalization by putting different simulations
on different CPUs. 

-------------------------------------------------------------------------------------
How multiprocessing works, in a nutshell:

    Process() spawns (fork or similar on Unix-like systems) a copy of the 
    original program.
    The copy communicates with the original to figure out that 
        (a) it's a copy and 
        (b) it should go off and invoke the target= function (see below).
    At this point, the original and copy are now different and independent, 
    and can run simultaneously.

Since these are independent processes, they now have independent Global Interpreter Locks 
(in CPython) so both can use up to 100% of a CPU on a multi-cpu box, as long as they don't 
contend for other lower-level (OS) resources. That's the "multiprocessing" part.
-------------------------------------------------------------------------------------

@author: Matthias Koenig
@date: 2014-07-08
'''

import sim.PathSettings
from sim.PathSettings import SIM_DIR

import os
import time
import multiprocessing
import socket
import fcntl
import struct

from django.utils import timezone
from django.db import transaction

from sim.models import Task, Core, Simulation
from sim.models import UNASSIGNED, ASSIGNED
from integration import ode_integration


def worker(cpu, lock, Nsim):
    ''' Creates a worker for the cpu which listens for available simulations. '''
    ip = get_ip_address()
    core, _ = Core.objects.get_or_create(ip=ip, cpu=cpu)
    
    while(True):    
        # update core time
        time_now = timezone.now()
        core.time = time_now 
        core.save()
    
        # Assign simulations within a multiprocessing lock
        lock.acquire()
        task, sims = assign_simulations(core, Nsim)
        lock.release()
        
        # Perform ODE integration
        if (sims):
            print '{:<20} <{}> {}'.format(core, task, sims)
            ode_integration.integrate(sims, task.integrator)
        else:
            print '{:<20} <No Simulations>'.format(core)
            time.sleep(10)


def assign_simulations(core, Nsim=1):
    ''' 
    Assigns simulation(s) to core.
    Returns None if no simulation(s) could be assigned. 
    The assignment has to be synchronized between the different cores.
    Use lock to handle the different cores on one cpu.    
    '''
    # get distinct tasks sorted by priority which have unassigned simulations 
    task_query = Task.objects.filter(simulation__status=UNASSIGNED).distinct('pk', 'priority').order_by('-priority')
    if (task_query.exists()):
        task = task_query[0]
        # this is on the cpu lock (working)
        create_simulation_directory_for_task(task)
        
        # select the simulations for update with locking the rows
        # this is in the database lock
        with transaction.commit_manually():
            sims = Simulation.objects.select_for_update().filter(task=task, status=UNASSIGNED)[0:Nsim]
            
            for sim in sims:
                sim.time_assign = timezone.now()
                sim.core = core
                sim.status = ASSIGNED
                sim.save();
            transaction.commit()
            
        return task, sims
    else:
        return None, None


def create_simulation_directory_for_task(task):
    ''' Create the folder to store simulation files. '''    
    directory = SIM_DIR + "/" + str(task)
    if not os.path.exists(directory):
        os.makedirs(directory)


def get_ip_address(ifname='eth0'):
    ''' Returns the IP adress for the given computer. '''
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        ip = socket.inet_ntoa(fcntl.ioctl(
                                          s.fileno(),
                                          0x8915,  # SIOCGIFADDR
                                          struct.pack('256s', ifname[:15])
                                          )[20:24])
    except IOError:
        ip = "127.0.0.1"
        print "No 'eth0 found, using 127.0.0.1"
    return ip

    
def info(title):
    print title
    print 'module name:', __name__
    if hasattr(os, 'getppid'):  # only available on Unix
        print 'parent process:', os.getppid()
    print 'process id:', os.getpid()

#####################################################################################

if __name__ == "__main__":     
    '''
    Starting the simulation on the local computer.
    Call with --cpu option if not using 100% resources    
    '''
    from optparse import OptionParser
    import math
    parser = OptionParser()
    parser.add_option("-c", "--cpu", dest="cpu_load",
                  help="CPU load between 0 and 1, i.e. 0.5 uses half the cpus")
    (options, args) = parser.parse_args()
    
    print '#'*60
    print '# Simulator '
    print '#'*60
    cpus = multiprocessing.cpu_count()
    print 'CPUs: ', cpus 
    if (options.cpu_load):
        cpus = int(math.floor(float(options.cpu_load)*cpus))
    print 'Used CPUs: ', cpus
    print '#'*60
    
    Nsim = 20;
    
    # Lock for syncronization between processes (but locks)
    lock = multiprocessing.Lock()
    # start processes on every cpu
    procs = []
    for cpu in range(cpus):
        p = multiprocessing.Process(target=worker, args=(cpu, lock, Nsim))
        procs.append(p)
        p.start()
    