'''
Main module to run simulations.
This module takes car of starting the intergration processes on the available
processors.

In general only the database information about the files, i.e. 
location on the local filesystem is stored. Problems can arise depending
on which computer generates the files locally. This has to be synchronized.

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

TODO: handle all Folders by setting $MULTISCALE_GALACTOSE variable and bash variables
TODO: support simulation priorities.
'''

from integration import ODE_Integration
SIM_FOLDER = "/home/mkoenig/multiscale-galactose-results/tmp_sim" 


import os
import sys
sys.path.append('/home/mkoenig/multiscale-galactose/python')
os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'

import time
import multiprocessing

import socket
import fcntl
import struct

from django.utils import timezone
from sim.models import Core, Simulation
from sim.models import UNASSIGNED, ASSIGNED


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


def assign_simulation(core):
    ''' 
    Gets an unassigned simulation and assigns the core to it.
    Returns None if no simulation could be assigned 
    Is performed in a lock so that multiple cores do not get the same unassigned simulation.
    TODO: order by task priority
    '''
    unassigned = Simulation.objects.filter(status=UNASSIGNED).order_by('time_create');
    if (unassigned.exists()):
        # assign the first unassigned simulation
        sim = unassigned[0]
        sim.time_assign = timezone.now()
        sim.core = core
        sim.status = ASSIGNED
        sim.save();
        return sim
    else:
        return None
    

def perform_simulation(sim, folder):
    ODE_Integration.integrate(sim, folder, simulator=sim.simulator)

def info(title):
    print title
    print 'module name:', __name__
    if hasattr(os, 'getppid'):  # only available on Unix
        print 'parent process:', os.getppid()
    print 'process id:', os.getpid()

def worker(cpu, lock):
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
        sim = assign_simulation(core)
        lock.release()
        
        if (sim):
            perform_simulation(sim, SIM_FOLDER)
        else:
            print core, "... no unassigned simulations ...";
            time.sleep(20)

if __name__ == "__main__":     
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
    
    # Lock for syncronization between processes (but locks)
    lock = multiprocessing.Lock()
    # start processes on every cpu
    procs = []
    for cpu in range(cpus):
        p = multiprocessing.Process(target=worker, args=(cpu, lock))
        procs.append(p)
        p.start()
    