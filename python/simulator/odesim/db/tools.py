"""
Helper functions for the interaction with the django database layer.
This module is used to create models, simulations and tasks in the database.

A task is a set of simulations with given integration settings, i.e. the
individual simulations of one task are comparable between each other.
All simulations belonging to the same task run with the same model
and the same settings.
Tasks have a priority which determines the order of execution,
tasks with higher priority are performed first.

If possible all interactions with the django database layer should
go via this intermediate module.

@author: Matthias Koenig
@date: 2015-05-06
"""
from __future__ import print_function
from simapp.db.api import create_parameter, create_simulation
from simapp.db.api import get_parameters_for_simulation, get_simulations_for_task
from django.db import transaction

from odesim.dist.samples import SampleParameter, Sample

import warnings

@depre
def get_samples_for_task(task):
    """ Returns all samples for simulations for given task. """
    warnings.warn("deprecated", DeprecationWarning)

    sims = get_simulations_for_task()
    return [get_sample_from_simulation(sim) for sim in sims]



def get_sample_from_simulation(simulation):
    """
    Reads the sample structure from the database, namely the
    parameters set for a odesim.
    Important to reuse the samples of a given task for another task.
    """
    parameters = get_parameters_for_simulation(simulation)
    s = Sample()
    for p in pars:
        s.add_parameter(SampleParameter.from_parameter(p))
    return s


@transaction.atomic
def create_simulations_for_samples(task, samples):
    """ Creates all simulations for given samples.
    Does not check if the simulation already exists.
    - creates the Parameters
    - creates empty odesim and adds the parameters.
    Function does not check if the odesim with given parameters
    already exists.
    """
    sims = []
    for sample in samples:
        
        parameters = []
        for sp in sample.parameters:
            # This takes forever to check if parameter already in db
            # How to improve this part ?
            create_parameter(name=sp.key, value=sp.value, unit=sp.unit, ptype=sp.parameter_type);
            parameters.append(p)
        
        # sim = sims_list[k]
        sim = create_simulation(task, parameters)
        
        sims.append(sim)
        print(sim)
        
    return sims
