"""
Single RoadRunner simulation of Van der Pol oscillator.
"""

import roadrunner

rr = roadrunner.RoadRunner('van_der_pol.xml')
rr.simulate(start=0, end=100, varSteps=True, stiff=True, plot=True)
rr.simulate(0, 100, varSteps=True, stiff=True, plot=True)

# unused arguments should raise a warning !
rr.simulate(start=0, duration=100, variableStep=True, stiff=True, plot=True)