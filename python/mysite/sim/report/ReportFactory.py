'''
The Report factory generates the SBML report based on the underlying SBML
using the Django template language. 
The original prototype was developed in Java with JSBML based on a 
different template language but the underlying idea of rendering the
template with the given SBML structure remains the same.


@author: Matthias Koenig
@date: 2014-05-07
'''

import os
import sys
sys.path.append('/home/mkoenig/multiscale-galactose/python')
os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'

from django.http.response import HttpResponse
from django.template import loader, Context
import libsbml


def createSBMLReport(sbml_file, report_file):
    '''
    Creates the SBML report by rendering a Django view.
    '''
    # TODO: convert the full java template to python
    # TODO: update the report CSS
    # TODO: create a proper database view
    
    
    # Read the sbml data structure
    print sbml_file
    doc = libsbml.readSBMLFromFile(sbml_file)
    model = doc.getModel()
    print model.getId()
    
    lofFD = model.getListOfFunctionDefinitions()
    print lofFD
    print lofFD.size()
    
    # TODO: pack the Django model in additon to provide full access
    #        to the database information
    
    # All python objects can be packed in the HTML context
    template = loader.get_template('report/SBMLReport.html')
    context = Context({
        'model': model,
        'unitDefinitions' : model.getListOfUnitDefinitions(),
        'compartments' : model.getListOfCompartments(),
        'functions' : model.getListOfFunctionDefinitions(),
        'parameters' : model.getListOfParameters(),
        'rules' : model.getListOfRules(),
        'assignments' : model.getListOfInitialAssignments(),
        'species' : model.getListOfSpecies(),
        'reactions' : model.getListOfReactions(),
        'constraints' : model.getListOfConstraints(),
        'events' : model.getListOfEvents(),
    })
    # Render the html template with the sbml context
    rtemp = template.render(context)
    
    # Write the HTML report
    f = open(report_file, "w")
    f.write(rtemp)
    
    


if __name__ == "__main__":
    sbml_file = "/home/mkoenig/multiscale-galactose-results/tmp_sbml/Galactose_v14_Nc1_Nf1.xml"
    report_file = "/home/mkoenig/tmp/test.html"
    createSBMLReport(sbml_file, report_file)
    print "DONE"
