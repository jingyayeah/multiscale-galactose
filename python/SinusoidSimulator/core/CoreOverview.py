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
from simulation.models import Integration, Core
from random import randrange

from django.utils import timezone

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

def info(title):
    print title
    print 'module name:', __name__
    if hasattr(os, 'getppid'):  # only available on Unix
        print 'parent process:', os.getppid()
    print 'process id:', os.getpid()

def worker(cpu):
    # Get the integration information
    # integration = Integration.objects.all()[:1]
    info('function worker')
    ip = get_ip_address('eth0')
    
    while(True):
        print 'sim ->', ip, 'cpu:', cpu
        # [1] get data from the database
        if (Integration.objects.count()>0):
            for i in Integration.objects.all()[:1]:
                print i.__unicode__()
                  
        
        # [2] do simulation
        time.sleep(5 + randrange(10))
        
        # [3] store in database
        core_qset = Core.objects.filter(ip=ip, cpu=cpu)
        if (len(core_qset) > 0):
            core = core_qset[0]
            core.time = timezone.now();
        else:
            core = Core(ip=ip, cpu=cpu, time=timezone.now())
        core.save()
        

if __name__ == "__main__":
    # run the process on all cpus
    cpus = multiprocessing.cpu_count()
    print 'Number of CPU: ', cpus 
    
    # start processes on every cpu
    procs = []
    for i in range(cpus):
        p = multiprocessing.Process(target=worker, args=(i+1, ))
        procs.append(p)
        p.start()
    
    # wait for all the worker processes to finish
    for p in procs:
        p.join()
    