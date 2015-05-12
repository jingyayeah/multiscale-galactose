"""
Testing the SBML report.

@author: mkoenig
@date: 2015-??-?? 
"""

# TODO: use the django test case

import unittest
from simapp.sbml.report import create_value_dictionary
from django.shortcuts import Http404


class MyTestCase(unittest.TestCase):
    def setUp(self):
        pass

    def tearDown(self):
        pass

    def test_something(self):
        self.assertEqual(True, False)

    def test(self):
        # TODO: implement
        raise NotImplemented
        model_pk = 24
        sbml_model = get_object_or_404(CompModel, pk=model_pk)
        sbml_path = sbml_model.file.path
        doc = libsbml.readSBMLFromFile(str(sbml_path))
        model = doc.getModel()
        if not model:
            print 'Model could not be read.'
            raise Http404
    create_value_dictionary(model)

if __name__ == '__main__':
    unittest.main()
