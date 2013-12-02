'''
Created on Nov 26, 2013

@author: mkoenig

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


Database things and setup handled by Django.

'''

import os
import sys
sys.path.append('/home/mkoenig/multiscale-galactose/python')
os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'

import time
import multiprocessing
from sim.models import Integration, Core, Simulation, UNASSIGNED, ASSIGNED, DONE
from random import randrange

from django.utils import timezone

from subprocess import call
import socket
import fcntl
import struct

def get_ip_address(ifname='eth0'):
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    return socket.inet_ntoa(fcntl.ioctl(
        s.fileno(),
        0x8915,  # SIOCGIFADDR
        struct.pack('256s', ifname[:15])
    )[20:24])
    
def get_core_by_ip_and_cpu(ip, cpu):
    core_qset = Core.objects.filter(ip=ip, cpu=cpu)
    if (core_qset.exists()):
        core = core_qset[0]
        core.time = timezone.now()
    else:
        core = Core(ip=ip, cpu=cpu, time=timezone.now())
        core.save()
    return core

def assign_simulation(ip, cpu):
    ''' Gets an unassigned simulation and assignes it to the core. '''
    unassigned = Simulation.objects.filter(status=UNASSIGNED);
    if (unassigned.exists()):
        # Get the first unassigned simulation
        sim = unassigned[0]
            
        # Get the core and update the status for the core
        core = get_core_by_ip_and_cpu(ip, cpu)
            
        sim.time_assign = timezone.now()
        sim.core = core
        sim.status = ASSIGNED
        sim.save();
        return sim
    else:
        return None

def perform_simulation(sim):
    time.sleep(8 + randrange(10))
    # run an operating system command
        
    # subprocess opens new process
    # Check on which core it is running
    # Make sure all the cores are really used
    # call(["ls", "-l"])
    call(["../testscript"])
            
    # simulation finished
    sim.time_sim = timezone.now()
    sim.status = DONE
    sim.save()

def info(title):
    print title
    print 'module name:', __name__
    if hasattr(os, 'getppid'):  # only available on Unix
        print 'parent process:', os.getppid()
    print 'process id:', os.getpid()

def worker(cpu, lock):
    # Get the integration information
    # integration = Integration.objects.all()[:1]
    info('function worker')
    ip = get_ip_address('eth0')
    
    while(True):
        # use global lock for proper printing
        # Without using the lock output from the 
        # different processes is liable to get all mixed up.
        lock.acquire()
        print 'sim ->', ip, 'cpu:', cpu
        lock.release()
        
        sim = assign_simulation(ip, cpu)
        perform_simulation(sim)


if __name__ == "__main__":
    '''
    Work with the exit codes to start new processes.
    If processes have terminated restart one of the processes.
    '''
    # run the process on all cpus
    cpus = multiprocessing.cpu_count()
    print 'Number of CPU: ', cpus 
    
    # Lock for syncronization between processes (but locks)
    lock = multiprocessing.Lock()
    
    # start processes on every cpu
    procs = []
    for cpu in range(cpus):
        p = multiprocessing.Process(target=worker, args=(cpu, lock))
        procs.append(p)
        p.start()
    
    # wait for all the worker processes to finish
    # for p in procs:
    #     p.join()
    