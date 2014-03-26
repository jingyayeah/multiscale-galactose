'''
Created on Nov 26, 2013

@author: Matthias Koenig

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

In general only the database information about the files, i.e. 
location on the local filesystem is stored. Problems can arise depending
on which computer generates the files locally. This has to be synchronized.


TODO: handle errors in the integration (ERROR code and storage
of problems for debugging)
TODO: all simulations have to be performed against the same version
be sure that the version
TODO: Make sure the cpp is recompiled (use make file)
TODO: handle all Folders by setting $MULTISCALE_GALACTOSE variable.

'''

SIM_FOLDER = "/home/mkoenig/multiscale-galactose-results/tmp_sim"
COPASI = "/home/mkoenig/multiscale-galactose/cpp/copasi/CopasiModelRunner/build/CopasiModelRunner"  

import os
import sys
sys.path.append('/home/mkoenig/multiscale-galactose/python')
os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'
import time
import multiprocessing
from subprocess import call
import shlex
import socket
import fcntl
import struct
import random

from django.utils import timezone
from django.core.files import File
from ConfigFileFactory import create_config_file_in_folder
from sim.models import Core, Simulation, UNASSIGNED, ASSIGNED, DONE, Timecourse


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
        core.save()
    else:
        core = Core(ip=ip, cpu=cpu, time=timezone.now())
        core.save()
    return core


def assign_simulation(ip, cpu):
    ''' 
    Gets an unassigned simulation and assignes the core to it.
    Returns None if no simulation could be assigned 
    TODO: bug multiple cores can get the same unassigned simulation.
          better handling via getting a random simulation from the unassigned ones.
    '''
    unassigned = Simulation.objects.filter(status=UNASSIGNED);
    if (unassigned.exists()):
        # Get random unassigned simulation, removes double assignment as
        # good as possible
        # problematic, because the length can change of unassigned.
        # count = unassigned.count()
        # sim = unassigned[random.randint(0,count)]
        
        # is only save on single computer via logging assignment
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
    

def perform_simulation(sim, folder):
    '''
    Run ODE integration for the simulation.
    '''    
    # TODO: here problems could occur with the local filesystem storage
    #       of the SBML files.
    sbml_file = sim.task.sbml_model.file.path
    sbml_id = sim.task.sbml_model.sbml_id
    timecourse_file = folder + "/" + sbml_id + "_Sim" + str(sim.pk) + '_copasi.csv'
    
    #Store the config file in the database
    config_file = create_config_file_in_folder(sim, folder)
    f = open(config_file, 'r')
    sim.file = File(f)
    sim.save()
    
    # run an operating system command
    # call(["ls", "-l"])
    call_command = COPASI + " -s " + sbml_file + " -c " + config_file + " -t " + timecourse_file;
    print call_command
    call(shlex.split(call_command))
    
    # Store Timecourse Results
    f = open(timecourse_file, 'r')
    myfile = File(f)
    tc, created = Timecourse.objects.get_or_create(simulation=sim)
    if (not created):
        print 'Timecourse already exists and is overwritten!'
    tc.file = myfile
    tc.save();
    
    # simulation finished (update simulation information and save)
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
    info('function worker')
    try:
        ip = get_ip_address('eth0')
    except IOError:
        ip = "127.0.0.1"
        print "No 'eth0 found, using 127.0.0.1"
    
    while(True):
        # use global lock for proper printing
        # Without using the lock output from the 
        # different processes is liable to get all mixed up.
        
        # assign the simulations within a lock to fix the 
        # multiple assignment bug, i.e. exactly one core should be able to
        # get one unassigned simulation
        lock.acquire()
        # ! this could brake the simulations if many cores try to assign simulations
        # depends on assign time vs. simulation time
        # TODO check.
        print 'sim ->', ip, 'cpu:', cpu
        sim = assign_simulation(ip, cpu)
        lock.release()
        
        if (sim):
            # TODO: error management and error handling
            perform_simulation(sim, SIM_FOLDER)
        
        else:
            print "no more simulations";
            time.sleep(20)

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
    