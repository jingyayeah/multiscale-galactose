#!/usr/bin/python
'''
Main module to run simulations.
Manages the assigning of simulation to available CPUs and the 
integration process. Depending on the simulation definition different
ODE integrators will be used.

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
@date: 2013-11-06

TODO: support simulation priorities; use the simulation priorities !!!
TODO: provide a set of simulations from the task view
'''

import os
import sys
sys.path.append("/".join([os.getenv('MULTISCALE_GALACTOSE'), 'python']))
os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'

SIM_FOLDER = "/".join([os.getenv('MULTISCALE_GALACTOSE_RESULTS'), 'tmp_sim'])

import time
import multiprocessing
import socket
import fcntl
import struct

from django.utils import timezone
from sim.models import Core, Simulation
from sim.models import UNASSIGNED, ASSIGNED
from integration import ODE_Integration


def get_ip_address(ifname='eth0'):
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    return socket.inet_ntoa(fcntl.ioctl(
        s.fileno(),
        0x8915,  # SIOCGIFADDR
        struct.pack('256s', ifname[:15])
    )[20:24])

    
def get_core_by_ip_and_cpu(ip, cpu):
    '''
    Gets the core from the ip and cpu information and updates the time.
    The time is the last time the core was requested, i.e. it was tried to use
    the core for simulations.
    '''
    core_qset = Core.objects.filter(ip=ip, cpu=cpu)
    if (core_qset.exists()):
        core = core_qset[0]
        core.time = timezone.now()
        core.save()
    else:
        core = Core(ip=ip, cpu=cpu, time=timezone.now())
        core.save()
    return core

def assign_simulations(core, Nsim=1):
    ''' 
    Gets an unassigned simulation and assigns the core to it.
    Returns None if no simulation could be assigned 
    Is performed in a lock so that multiple cores do not get the same unassigned simulation.
    '''
    # Get a task with unassigned simulations
    unassigned_query = Simulation.objects.filter(status=UNASSIGNED);
    if (unassigned_query.exists()):
        # all simulations have to belong to same task
        unassigned = Simulation.objects.filter(task=unassigned_query[0].task, status=UNASSIGNED);
        if (Nsim == 1):
            # assign the first unassigned simulation
            sims = [unassigned[0],]
        else:            
            Nsim = min(Nsim, unassigned.count())
            sims = unassigned[0:Nsim]
        # set the assignment status
        assign_and_save_in_bulk(sims, core)
        return sims
    else:
        return None

from django.db.transaction import commit_on_success
@commit_on_success
def assign_and_save_in_bulk(simulations, core):
    ''' Huge speed increase doing in bulk. '''
    core.time = timezone.now()
    core.save()
    for sim in simulations:
        sim.time_assign = timezone.now()
        sim.core = core
        sim.status = ASSIGNED
        sim.save();


def info(title):
    print title
    print 'module name:', __name__
    if hasattr(os, 'getppid'):  # only available on Unix
        print 'parent process:', os.getppid()
    print 'process id:', os.getpid()

def worker(cpu, lock, Nsim):
    info('function worker')
    try:
        ip = get_ip_address('eth0')
    except IOError:
        ip = "127.0.0.1"
        print "No 'eth0 found, using 127.0.0.1"
    
    while(True):
        # Update the time for the core
        core = get_core_by_ip_and_cpu(ip, cpu)
        
        # Assign simulation
        lock.acquire()
        # assign the simulations within a lock so every simulation is only assigned
        # to one core (otherwise multiple assignment bugs will arise)
        sims = assign_simulations(core, Nsim)
        lock.release()
        print core, ' -> ', sims
        if (sims):
            integration = sims[0].task.integration
            ODE_Integration.integrate(sims, integration.integrator)
        else:
            print core, "... no unassigned simulations ...";
            time.sleep(10)

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
    