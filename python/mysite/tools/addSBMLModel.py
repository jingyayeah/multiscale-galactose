'''
Add SBML models to django database.
Mainly for reports.

@author: mkoenig
Created on Apr 15, 2015
'''



import sys
sys.path.append('/home/mkoenig/multiscale-galactose/python')
import os
os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'
from sim.models import SBMLModel

filename = "/home/mkoenig/multiscale-galactose/sbml/Conversion_Factors/test.xml"

model = SBMLModel.create_from_file(filename)
model.save();
