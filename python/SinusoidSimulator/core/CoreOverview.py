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
'''

import os
import sys
sys.path.append('/home/mkoenig/multiscale-galactose/python')
os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'

import time
import multiprocessing
from simulation.models import Integration 

database = "events";
computer = "10.39.32.111"

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
    while(True):
        print 'sim ->', computer, 'cpu:', cpu
        time.sleep(5)
        

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
    