# -*- coding: utf-8 -*-
"""
Create detailed HTML report from given SBML.

The model report is implemented based on the django template language, which
 is used to render the SBML information.

Necessary to create the html and copy the additional css and js files.

*.html
    css
    js

Configure an Engine, compile template, render with context

Reusable template code, code separation & reduction of duplicate code is achieved via
- template inheritance
- template macros
- ? how to call functions ?


"""
from __future__ import print_function, division

import codecs
import os
import shutil
import sys

import libsbml
from jinja2 import Environment, FileSystemLoader

import sbmlfilters

# Change default encoding to UTF-8
# We need to reload sys module first, because setdefaultencoding is available only at startup time
reload(sys)
sys.setdefaultencoding('utf-8')

# where are the templates
TEMPLATE_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'templates')

# TODO: rate rules are not displayed correctly (they need dy/dt on the left side, compared to AssignmentRules)
# TODO: hasOnlySubstanceUnits missing in species table

def copy_directory(src, dest):
    try:
        shutil.copytree(src, dest)
    # Directories are the same
    except shutil.Error as e:
        print('Directory not copied. Error: %s' % e)
    # Any error saying that the directory doesn't exist
    except OSError as e:
        print('Directory not copied. Error: %s' % e)


def create_sbml_report(doc, out_dir, html_template='report_base.html'):
    """ Creates the SBML report in the out_dir

    :param doc:
    :type doc:
    :param out_dir:
    :type out_dir:
    :return:
    :rtype:
    """
    # write sbml
    model = doc.getModel()
    mid = model.id
    f_sbml = os.path.join(out_dir, '{}.xml'.format(mid))
    libsbml.writeSBMLToFile(doc, f_sbml)

    # write html (unicode)
    html = create_html(doc, html_template=html_template)
    f_html = codecs.open(os.path.join(out_dir, '{}.html'.format(mid)),
                         encoding='utf-8', mode='w')
    f_html.write(html)
    f_html.close()

    # copy the additional files
    # todo handle the rsync
    copy_directory(os.path.join(TEMPLATE_DIR, '_report'), os.path.join(out_dir, '_report'))


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

    # template environment
    env = Environment(loader=FileSystemLoader(TEMPLATE_DIR),
                         extensions=['jinja2.ext.autoescape'],
                         trim_blocks=True,
                         lstrip_blocks=True)
    # additional SBML filters
    for key in sbmlfilters.filters:
        env.filters[key] = getattr(sbmlfilters, key)

    template = env.get_template(html_template)

    # Context
    c = {
        'doc': doc,
        'model': model,
        'values': values,
        'units': model.getListOfUnitDefinitions(),
        'compartments': model.getListOfCompartments(),
        'functions': model.getListOfFunctionDefinitions(),
        'parameters': model.getListOfParameters(),
        'rules': model.getListOfRules(),
        'assignments': model.getListOfInitialAssignments(),
        'species': model.getListOfSpecies(),
        'reactions': model.getListOfReactions(),
        'constraints': model.getListOfConstraints(),
        'events': model.getListOfEvents(),
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

#################################################################################################
# Create report
#################################################################################################
if __name__ == '__main__':

    import antimony
    antimony.loadAntimonyString("""
    model test
        J0: S1 -> S2; k1*S1;
        S1 = 10.0; S2 = 0; k1=1.0;
    end
    """)
    """
    sbml_str = antimony.getSBMLString('test')
    doc = libsbml.readSBMLFromString(sbml_str)

    create_sbml_report(doc,
                       out_dir='/home/mkoenig/tmp/sbmlreport/',
                       html_template='report.html')

    doc = libsbml.readSBMLFromFile('/home/mkoenig/git/multiscale-galactose/python/multiscalepy/multiscale/examples/models/demo/Koenig_demo_10_annotated.xml')
    create_sbml_report(doc,
                       out_dir='/home/mkoenig/tmp/sbmlreport/',
                       html_template='report.html')

    doc = libsbml.readSBMLFromFile('/home/mkoenig/git/multiscale-galactose/python/multiscalepy/multiscale/examples/models/galactose/galactose_30_annotated.xml')
    create_sbml_report(doc,
                       out_dir='/home/mkoenig/tmp/sbmlreport/',
                       html_template='report.html')
    """

    # glucose model
    glucose_dir = '/home/mkoenig/git/multiscale-galactose/python/multiscalepy/multiscale/examples/models/glucose/'
    sbml_path = os.path.join(glucose_dir, 'Hepatic_glucose_1.xml')
    doc = libsbml.readSBMLFromFile(sbml_path)
    create_sbml_report(doc,
                       out_dir=glucose_dir,
                       html_template='report.html')