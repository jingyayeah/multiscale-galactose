"""
Test annotation functions and annotating of SBML models.
"""

from __future__ import print_function, division

import os
import tempfile
import unittest
import libsbml

from multiscale.examples import testdata
from multiscale.sbmlutils.annotation import *


class TestAnnotation(unittest.TestCase):

    def test_model_annotation(self):
        """
        Check the annotation data structure.
        """
        d = {'pattern': 'test_pattern',
             'sbml_type': 'reaction',
             'annotation_type': 'RDF',
             'value': 'test_value',
             'qualifier': 'test_qualifier',
             'collection': 'test_collection',
             'name': 'test_name'}
        ma = ModelAnnotation(d)
        self.assertEqual('test_pattern', ma.pattern)
        self.assertEqual('reaction', ma.sbml_type)
        self.assertEqual('RDF', ma.annotation_type)
        self.assertEqual('test_value', ma.value)
        self.assertEqual('test_qualifier', ma.qualifier)
        self.assertEqual('test_collection', ma.collection)
        self.assertEqual('test_name', ma.name)

    def test_model_annotator(self):
        doc = libsbml.SBMLDocument(3, 1)
        model = doc.createModel()
        annotations = []
        annotator = ModelAnnotator(model, annotations)
        self.assertEqual(model, annotator.model)
        self.assertEqual(annotations, annotator.annotations)
        annotator.annotate_model()

    def test_set_model_history(self):
        creators = {'Test' :
                        {'FamilyName': 'Koenig',
                         'GivenName': 'Matthias',
                         'Email': 'konigmatt@googlemail.com',
                         'Organization': 'Test organisation'}}
        sbmlns = libSBMLNamespaces(3, 1)
        doc = SBMLDocument(sbmlns)
        model = doc.createModel()
        set_model_history(model, creators)
        h = model.getModelHistory()
        self.assertIsNotNone(h)
        self.assertEqual(1, h.getNumCreators())
        c = h.getCreator(0)
        self.assertEqual('Koenig', c.getFamilyName())
        self.assertEqual('Matthias', c.getGivenName())
        self.assertEqual('konigmatt@googlemail.com', c.getEmail())
        self.assertEqual('Test organisation', c.getOrganization())

    def test_demo_annotation(self):
        """ Annotate the demo network. """
        f_tmp = tempfile.NamedTemporaryFile()
        annotate_sbml_file(testdata.demo_sbml, testdata.demo_annotations, f_sbml_annotated=f_tmp.name)
        f_tmp.flush()

        # TODO: check that the annotations were written via libsbml
        sbmlns = SBMLNamespaces(3, 1)
        doc =
        model = doc.createModel()

        h = model.getModelHistory()
        self.assertIsNotNone(h)
        self.assertEqual(1, h.getNumCreators())
        c = h.getCreator(0)
        self.assertEqual('Koenig', c.getFamilyName())
        self.assertEqual('Matthias', c.getGivenName())
        self.assertEqual('konigmatt@googlemail.com', c.getEmail())
        self.assertEqual('Test organisation', c.getOrganization())



    def test_galactose_annotation(self):
        """ Annotate the galactose network. """
        f_tmp = tempfile.NamedTemporaryFile()
        annotate_sbml_file(testdata.galactose_singlecell_sbml, testdata.galactose_annotations,
                           f_sbml_annotated=f_tmp.name)
        f_tmp.flush()

if __name__ == "__main__":
    unittest.main()
