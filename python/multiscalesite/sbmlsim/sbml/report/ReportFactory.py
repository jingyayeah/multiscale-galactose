'''
Create detailed HTML report from given SBML. 
The model is implemented via the Django template language for rendering
the actual SBML information.
Main rendered information are the listOf components of the SBML.

@author: Matthias Koenig
@date: 2015-04-20
'''

import path_settings

import libsbml
from django.http.response import HttpResponse
from django.shortcuts import get_object_or_404
from django.template import loader, RequestContext
from django.shortcuts import Http404
from sbmlsim.models import SBMLModel

def report(request, model_pk):
    '''
    Creates the report view for the given SBML model.
    SBML has to be in the database.
    '''    
    sbml_model = get_object_or_404(SBMLModel, pk=model_pk)
    sbml_path = sbml_model.file.path     # this is the absolute path in filesystem
    
    doc = libsbml.readSBMLFromFile(str(sbml_path))
    model = doc.getModel()
    if not model:
        print 'Model could not be read.'
        raise Http404
    
    # Create the value_dictionary
    values = createValueDictionary(model)
    
    
    # Render the template with the data
    template = loader.get_template('report/SBMLReport.html')
    context = RequestContext(request, {
        'sbml_model' : sbml_model,
        'model': model,
        'values': values, 
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


def createValueDictionary(model):
    values = dict()
    
    # parse all the initial assignments
    for assignment in model.getListOfInitialAssignments():
        sid = assignment.getId()
        math = ' = {}'.format(libsbml.formulaToString(assignment.getMath()))
        values[sid] = math
    # rules
    for rule in model.getListOfRules():
        sid = rule.getVariable()
        math = ' = {}'.format(libsbml.formulaToString(rule.getMath()))
        values[sid] = math
    return values

if __name__ == "__main__":

    model_pk = 24 
    sbml_model = get_object_or_404(SBMLModel, pk=model_pk)
    sbml_path = sbml_model.file.path
    doc = libsbml.readSBMLFromFile(str(sbml_path))
    model = doc.getModel()
    if not model:
        print 'Model could not be read.'
        raise Http404
    
    createValueDictionary(model)

    
    

