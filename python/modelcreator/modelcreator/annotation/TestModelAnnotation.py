'''

TODO: Some problems with the ModelQualifiers in anntotations

Created on Jun 2, 2014

@author: mkoenig
'''

import sys
import os
sys.path.append('/home/mkoenig/multiscale-galactose/python')
os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'

SBML_FOLDER = "/home/mkoenig/multiscale-galactose-results/tmp_sbml"
from simapp.models import CompModel
from modelcreator.annotation.ModelAnnotation import annotateModel
    
 
###############################################################################
if __name__ == "__main__":

    # DEMO #
    sbml_id = "Koenig2014_demo_kinetic_v7_annotated"
    f_sbml = 'examples/Koenig2014_demo_kinetic_v7.xml'
    f_annotations = 'examples/Koenig2014_demo_kinetic_v7_annotations.csv'
    f_sbml_annotated = SBML_FOLDER + '/' + sbml_id + '.xml'
    annotateModel(f_sbml, f_annotations, f_sbml_annotated)
    
    
    model = CompModel.create(sbml_id, SBML_FOLDER);
    model.save();
    
    # GALACTOSE #
    sbml_id = 'Galactose_v20_Nc1_Nf1'
    f_sbml = 'examples/' + sbml_id + '.xml'
    f_annotations = 'examples/Galactose_annotations.csv'
    f_sbml_annotated = SBML_FOLDER + '/' + sbml_id + '_annotated_v7.xml'
    annotateModel(f_sbml, f_annotations, f_sbml_annotated)
    
    
    model = CompModel.create(sbml_id + '_annotated_v7', SBML_FOLDER);
    model.save();
    
###############################################################################