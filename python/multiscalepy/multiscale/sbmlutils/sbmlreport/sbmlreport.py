# -*- coding: utf-8 -*-
"""
Create Report from given SBML file.

The model report is implemented based on a standard template language,
which uses the SBML information to render the final document.

Currently the following templates are available:
<HTML>
- in addition to the created HTML, the necessary CSS and JS files are copied.

The basic steps of template creation are
- configure an Engine (jinja2)
- compile template
- render with SBML context
"""
# TODO: rate rules are not displayed correctly (they need dy/dt on the left side, compared to AssignmentRules)


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

# template location
TEMPLATE_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'templates')


def copy_directory(src, dest):
    """ Copy directory from source to destination.
    :param src:
    :type src:
    :param dest:
    :type dest:
    :return:
    :rtype:
    """

    # todo handle the rsync
    try:
        shutil.copytree(src, dest)
    # Directories are the same
    except shutil.Error as e:
        print('Directory not copied. Error: %s' % e)
    # Any error saying that the directory doesn't exist
    except OSError as e:
        print('Directory not copied. Error: %s' % e)


def create_sbml_report(sbml, out_dir, template='report.html'):
    """ Creates the SBML report in the out_dir

    :param doc:
    :type doc:
    :param out_dir:
    :type out_dir:
    :return:
    :rtype:
    """

    # write sbml
    doc = libsbml.readSBML(sbml)
    model = doc.getModel()
    mid = model.id
    f_sbml = os.path.join(out_dir, '{}.xml'.format(mid))
    libsbml.writeSBMLToFile(doc, f_sbml)

    # write html (unicode)
    html = create_html(doc, html_template=template)
    f_html = codecs.open(os.path.join(out_dir, '{}.html'.format(mid)),
                         encoding='utf-8', mode='w')
    f_html.write(html)
    f_html.close()

    # copy the additional files
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
        # math = ' = {}'.format(libsbml.formulaToString(assignment.getMath()))
        values[sid] = assignment
    # rules
    for rule in model.getListOfRules():
        sid = rule.getVariable()
        # math = ' = {}'.format(libsbml.formulaToString(rule.getMath()))
        values[sid] = rule
    return values

#################################################################################################
# Create report
#################################################################################################
# TODO: add test
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