# coding: utf-8

from __future__ import print_function
import roadrunner
reload(roadrunner)
from roadrunner import SelectionRecord
print(roadrunner.__version__)

r = roadrunner.RoadRunner("test_3.xml")

# settings
absTol = 1E-6
relTol = 1E-6
absTol = absTol * min(r.model.getCompartmentVolumes())  # absTol relative to the amounts
integrator = r.getIntegrator()
integrator.setValue('stiff', True)
integrator.setValue('absolute_tolerance', absTol)
integrator.setValue('relative_tolerance', relTol)

# selection
r.selections = ['time'] +         ['[{}]'.format(sid) for sid in r.model.getFloatingSpeciesIds()] +         ['[{}]'.format(sid) for sid in r.model.getBoundarySpeciesIds()]
print(r.selections)

# reset model
# r.reset(SelectionRecord.ALL)

# storage for partial results
results = []
tends = [20, 30, 50]

# *** s1 ***
# simulate & store concentrations at end point
s1 = r.simulate(0, tends[0])

results.append(s1)
# print(s1)

