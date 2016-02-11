# -*- coding: utf-8 -*-
"""
Create detailed HTML report from given SBML.

The model report is implemented based on the django template language, which
 is used to render the SBML information.

Necessary to create the html and copy the additional css and js files.

*.html
    css
    js

# Configure an Engine, compile template, render with context

"""
from __future__ import print_function, division


import os
import shutil
from jinja2 import Environment, FileSystemLoader
import libsbml

TEMPLATE_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'templates')


# TODO: rate rules are not displayed correctly (they need dy/dt on the left side, compared to AssignmentRules)
# TODO: hasOnlySubstanceUnits missing in species table


def create_sbml_report(doc, out_dir, html_template='test_template.html'):
    """ Creates the SBML report in the out_dir

    :param doc:
    :type doc:
    :param out_dir:
    :type out_dir:
    :return:
    :rtype:
    """

    # write sbml
    print(type(doc))
    model = doc.getModel()
    print(type(model))
    mid = model.id
    f_sbml = os.path.join(out_dir, '{}.xml'.format(mid))
    libsbml.writeSBMLToFile(doc, f_sbml)

    # write the html
    html = create_html(doc, html_template=html_template)
    f_html = open(os.path.join(out_dir, '{}.html'.format(mid)), 'w')

    f_html.write(html)
    f_html.close()

    # copy the additional files
    # shutil.copy2(os.path.join(TEMPLATE_DIR, '_report'), os.path.join(out_dir, '_report'))


def create_html(doc, html_template='test_template.html'):
    """Create HTML from SBML.

    :param doc:
    :type doc:
    :param html_template:
    :type html_template:
    :return:
    :rtype:
    """
    model = doc.getModel()
    values = create_value_dictionary(model)

    j2_env = Environment(loader=FileSystemLoader(TEMPLATE_DIR), trim_blocks=True)
    template = j2_env.get_template('test_template.html')

    # Context
    c = { 'doc': doc,
        'model': model,
        'values': values,
        'units': model.getListOfUnitDefinitions(),
        'units_size': model.getListOfUnitDefinitions().size(),
        'compartments': model.getListOfCompartments(),
        'compartments_size': model.getListOfCompartments().size(),
        'functions': model.getListOfFunctionDefinitions(),
        'functions_size': model.getListOfFunctionDefinitions().size(),
        'parameters': model.getListOfParameters(),
        'parameters_size': model.getListOfParameters().size(),
        'rules': model.getListOfRules(),
        'rules_size': model.getListOfRules().size(),
        'assignments': model.getListOfInitialAssignments(),
        'assignments_size': model.getListOfInitialAssignments().size(),
        'species': model.getListOfSpecies(),
        'species_size': model.getListOfSpecies().size,
        'reactions': model.getListOfReactions(),
        'reactions_size': model.getListOfReactions().size(),
        'constraints': model.getListOfConstraints(),
        'constraints_size': model.getListOfConstraints().size(),
        'events': model.getListOfEvents(),
        'events_size': model.getListOfEvents().size(),
    }
    return template.render(c)


def create_value_dictionary(model):
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


if __name__ == '__main__':

    # import tellurium as te
    #
    # r = te.loada("""
    # model test
    #     J0: S1 -> S2; k1*S1;
    #     S1 = 10.0; S2 = 0; k1=1.0;
    # end
    # """)
    import antimony
    antimony.loadAntimonyString("""
    model test
        J0: S1 -> S2; k1*S1;
        S1 = 10.0; S2 = 0; k1=1.0;
    end
    """)
    # doc = libsbml.readSBMLFromString(r.getSBML())

    sbml_str = antimony.getSBMLString('test')
    print(sbml_str)
    doc = libsbml.readSBMLFromString(sbml_str)

    html = create_html(doc)
    print(html)

    create_sbml_report(doc, out_dir='/home/mkoenig/tmp/sbmlreport/')


