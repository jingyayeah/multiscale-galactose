"""
Minimal test case for JWS online.

@author: Matthias Koenig
@date: 2015-??-?? 
"""

import roadrunner

# equidistant time course for 20 [s]
rr = roadrunner.RoadRunner("jws_example.xml")
s = rr.simulate(0, 20, 100, plot=True)
