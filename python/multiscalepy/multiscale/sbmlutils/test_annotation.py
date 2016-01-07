"""
Test the annotations
TODO: update the annoation tests.

"""

from __future__ import print_function

import os
import tempfile
import unittest

import libsbml

from multiscale.examples.testdata import test_dir
from multiscale.sbmlutils.annotation import annotate_sbml_file, ModelAnnotation, ModelAnnotator


class TestAnnotation(unittest.TestCase):

    def test_model_annotation(self):
        d = {'id': 'test_id',
             'sbml_type': 'test_type',
             'annotation_type': 'test_annotation',
             'qualifier': 'test_qualifier',
             'collection': 'test_collection',
             'entity': 'test_entity'}
        ma = ModelAnnotation(d)
        self.assertEqual('test_id', ma.id)
        self.assertEqual('test_type', ma.sbml_type)
        self.assertEqual('test_annotation', ma.annotation_type)
        self.assertEqual('test_qualifier', ma.qualifier)
        self.assertEqual('test_collection', ma.collection)
        self.assertEqual('test_entity', ma.entity)

    def test_model_annotator(self):
        doc = libsbml.SBMLDocument(3, 1)
        model = doc.createModel()
        annotations = []
        annotator = ModelAnnotator(model, annotations)
        self.assertEqual(model, annotator.model)
        self.assertEqual(annotations, annotator.annotations)
        annotator.annotate_model()

    def test_new(self):
        import os
        from multiscale.multiscale_settings import MULTISCALE_GALACTOSE

        f_sbml = os.path.join(MULTISCALE_GALACTOSE, 'sbmlutils', 'demo', 'demo_9.xml')
        f_sbml_annotated = os.path.join(MULTISCALE_GALACTOSE, 'sbmlutils', 'demo', 'demo_9_annotated.xml')
        f_annotations = os.path.join(MULTISCALE_GALACTOSE, 'sbmlutils', 'demo', 'demo_annotations.csv')

        # annotate
        print('Annotate:', f_sbml)
        annotate_sbml_file(f_sbml, f_annotations, f_sbml_annotated)
        print(f_sbml_annotated)

    def test_model_history(self):
        # TODO: test for model history
        # family_name="Koenig", given_name="Matthias", email="konigmatt@googlemail.com",
        # organization="Test organisation"
        self.assertEquals(True, False)

    def test_demo(self):
        f_sbml = os.path.join(test_dir, 'annotation', 'Koenig2014_demo_kinetic_v7.xml')
        f_annotations = os.path.join(test_dir, 'annotation', 'Koenig2014_demo_kinetic_v7_annotations.csv')

        f_tmp = tempfile.NamedTemporaryFile()
        annotate_sbml_file(f_sbml, f_annotations, f_sbml_annotated=f_tmp.name)

    def test_galactose(self):
        f_sbml = os.path.join(test_dir, 'annotation', 'Galactose_v20_Nc1_Nf1.xml')
        f_annotations = os.path.join(test_dir, 'annotation', 'Galactose_annotations.csv')
        f_tmp = tempfile.NamedTemporaryFile()
        annotate_sbml_file(f_sbml, f_annotations, f_sbml_annotated=f_tmp.name)

if __name__ == "__main__":
    unittest.main()


"""
# TODO: write as test
if __name__ == "__main__":
    doc = readSBMLFromFile("/home/mkoenig/multiscale-galactose/sbmlutils/galactose/galactose_28_annotated.xml")
    model = doc.getModel()
    print(model.getId())
    h = model.getModelHistory()
    for c in h.getListCreators():
        print c
        print c.getFamilyName()
"""