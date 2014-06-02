'''
Created on Jun 2, 2014

@author: mkoenig
'''

import sys
import os
sys.path.append('/home/mkoenig/multiscale-galactose/python')
os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'

SBML_FOLDER = "/home/mkoenig/multiscale-galactose-results/tmp_sbml/"
from sim.models import SBMLModel
from ModelAnnotation import annotateModel
    
 
###############################################################################
if __name__ == "__main__":

    f_sbml = 'examples/Koenig2014_demo_kinetic_v7.xml'
    f_annotations = 'examples/Koenig2014_demo_kinetic_v7_annotations.csv'
    f_sbml_annotated = SBML_FOLDER + 'Koenig2014_demo_kinetic_v7_annotated.xml'
    annotateModel(f_sbml, f_annotations, f_sbml_annotated)
    
    
    sbml_id = "Koenig2014_demo_kinetic_v7_annotated"
    model = SBMLModel.create(sbml_id, SBML_FOLDER);
    model.save();

###############################################################################