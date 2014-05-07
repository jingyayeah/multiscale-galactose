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
from libsbml import SBMLDocument, ListOfUnitDefinitions, ListOf, UnitDefinition
sys.path.append('/home/mkoenig/multiscale-galactose/python')
os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'

from sim.models import SBMLModel
from django.http.response import HttpResponse
from django.shortcuts import get_object_or_404
from django.template import loader, RequestContext
import libsbml


def report(request, model_pk):
    '''
    Writes a detailed SBML report for the given database object.
        TODO: convert the full java template to python
        TODO: update the report CSS
        TODO: backup solution to query via the id vs. pk
        TODO: how to call functions from within the Django template
        
        TODO: write some additional methods for the SBase to display the annotations.
        
    '''
    # Get the database model
    sbmlmodel = get_object_or_404(SBMLModel, pk=model_pk)
    
    # sbml_file = sbmlmodel.file.url # this is the local link
    sbml_path = sbmlmodel.file.path # this is the absolute path in filesystem
    # print sbml_file
    
    # Read the sbml model with libSBML
    # doc = libsbml.readSBMLFromFile(sbml_file)
    doc = libsbml.readSBMLFromFile(str(sbml_path))
    model = doc.getModel()
    
    # Render the template with the data
    template = loader.get_template('report/SBMLReport.html')
    context = RequestContext(request, {
        'sbmlmodel' : sbmlmodel,
        'model': model,
        'units' : model.getListOfUnitDefinitions(),
        'units_size' : model.getListOfUnitDefinitions().size(),
        'compartments' : model.getListOfCompartments(),
        'compartments_size' : model.getListOfCompartments().size(),
        'functions' : model.getListOfFunctionDefinitions(),
        'functions_size' : model.getListOfFunctionDefinitions().size(),
        'parameters' : model.getListOfParameters(),
        'parameters_size' : model.getListOfParameters().size(),
        'rules' : model.getListOfRules(),
        'rules_size' : model.getListOfRules().size(),
        'assignments' : model.getListOfInitialAssignments(),
        'assignments_size' : model.getListOfInitialAssignments().size(),
        'species' : model.getListOfSpecies(),
        'species_size' : model.getListOfSpecies().size,
        'reactions' : model.getListOfReactions(),
        'reactions_size' : model.getListOfReactions().size(),
        'constraints' : model.getListOfConstraints(),
        'constraints_size' : model.getListOfConstraints().size(),
        'events' : model.getListOfEvents(),
        'events_size' : model.getListOfEvents().size(),
    })
    return HttpResponse(template.render(context))

def test():
    ListOfUnitDefinitions.size()
    
    
    
