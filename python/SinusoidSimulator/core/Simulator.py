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
from sim.models import Integration, Core, Simulation, UNASSIGNED, ASSIGNED, DONE,\
    ParameterCollection
from random import randrange

from django.utils import timezone

from subprocess import call
import shlex
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


def create_config_file(sim):
    '''
    Necessary to generate the Config file consisting of the parameters
    and the integration settings.
    
    ############################
    [Simulation]
    sbml = Dilution
    timecoure_id = tc1234
    pars_id = pars1234
    timestamp = 2014-03-27

    [Timecourse]
    t0 = 0.0
    dur = 100.0
    steps = 1000
    rTol = 1E-6
    aTol = 1E-6

    [Parameters]
    flow_sin = 60E-6
    PP__gal = 0.00012
    ############################
    '''
    # Create config file
    folder = "/home/mkoenig/multiscale-galactose-results/"
    sbml_id = sim.task.sbml_model.sbml_id
    filename = folder + sbml_id + "_Sim" + str(sim.pk) + '_config.ini'
    f = open(filename, 'w')
    f.write('[Simulation]\n')
    f.write('Simulation = {}\n'.format(sim.pk) )
    f.write("Task = {}\n".format(sim.task.pk) )
    f.write("SBML = {}\n".format(sim.task.sbml_model.pk))
    f.write("ParameterCollection = {}\n".format(sim.parameters.pk))
    f.write("sbml = {}\n".format(sim.task.sbml_model.sbml_id))
    f.write("\n")
    f.write("[Timecourse]\n")
    f.write("t0 = {}\n".format(sim.task.integration.tstart))
    f.write("dur = {}\n".format(sim.task.integration.tend))
    f.write("steps = {}\n".format(sim.task.integration.tsteps))
    f.write("rTol = {}\n".format(sim.task.integration.rel_tol))
    f.write("aTol = {}\n".format(sim.task.integration.abs_tol))
    f.write("\n")
    f.write("[Parameters]\n")
    pc = ParameterCollection.objects.get(pk=sim.parameters.pk)
    for p in pc.parameters.all():
        f.write("{} = {}\n".format(p.name, p.value) )
    
    f.close()
    return filename

def perform_simulation(sim):
    '''
    Here the integration is performed.
    '''    
    folder = "/home/mkoenig/multiscale-galactose-results/"
    config_file = create_config_file(sim)
    sbml_file = folder + sim.task.sbml_model.sbml_id + ".xml"
    
    print sim.task.pk
    print sim.task.sbml_model.sbml_id
    
    
    # time.sleep(8 + randrange(10))
    
    # run an operating system command
        
    # subprocess opens new process
    # Check on which core it is running
    # Make sure all the cores are really used
    # call(["ls", "-l"])
    folder = "/home/mkoenig/multiscale-galactose/cpp/copasi/CopasiModelRunner/Debug/"
    copasi = "CopasiModelRunner"
    call_command = folder + copasi + " -s " + sbml_file + " -p " + config_file;
    print call_command
    call(shlex.split(call_command))
            
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
    # TODO: adapt for ips
    # ip = get_ip_address('eth0')
    ip = "127.0.0.1"
    
    while(True):
        # use global lock for proper printing
        # Without using the lock output from the 
        # different processes is liable to get all mixed up.
        lock.acquire()
        print 'sim ->', ip, 'cpu:', cpu
        lock.release()
        
        sim = assign_simulation(ip, cpu)
        if (sim):
            perform_simulation(sim)
        else:
            print "no more simulations";
            time.sleep(20)
            


if __name__ == "__main__":
    '''
    Work with the exit codes to start new processes.
    If processes have terminated restart one of the processes.
    '''
    # reset everything to undone
    #for sim in Simulation.objects.all():
    #    sim.status = UNASSIGNED
    #    sim.save()
    # print('All Simulations unassigned')
    
    
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
    