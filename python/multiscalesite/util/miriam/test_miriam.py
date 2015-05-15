"""
Testing the MIRIAM webservices to access MIRIAM annotation information.
Requires web access to pass the test.

@author: mkoenig
@date: 2015-??-?? 
"""
#TODO: test for web access before running tests (internet dependency)
# Make some ping test or similar.# .

from __future__ import print_function
import unittest
import requests
from util.miriam import miriam


class MiriamTestCase(unittest.TestCase):
    def setUp(self):
        pass

    def tearDown(self):
        pass

    def test_version(self):
        r = miriam.
        self.assertEqual(True, False)

    def test_status(self):
        """ Test the status of the MIRIAM webservice. """
        url = "http://www.ebi.ac.uk/miriamws/main/rest/"
        r = requests.get(url)
        print(r)
        self.assertEqual(r.status_code, None)
        print(r.headers)
        self.assertEqual(r.headers['content-type'], None)

        self.assertEqual(r.encoding, None)
        self.assertContains(r.text, None)

    def test_datatypes_json(self):
        """ Get the MIRIAM datatypes in JSON. """
        url = 'http://www.ebi.ac.uk/miriamws/main/rest/datatypes/'
        headers = {'Accept': 'application/json'}
        r = requests.get(url, headers=headers)
        print(r)
        self.assertEqual(r.headers['content-type'], None)
        self.assertContains(r.text, None)
        json = r.json()
        print(json)
        self.assertContains(json, None)

    def test_resource(self):
        """  Get resources for datatype. """
        resources, uris = miriam.get_miriam_resources_for_datatype('MIR:00000352')
        print(resources)
        print(uris)
        self.assertContains(resources, None)
        self.assertEqual(uris)

    def test_all_datatypes(self):
        """ Get all datatypes """
        data_types = miriam.get_datatypes()
        for key, value in data_types.iteritems():
            print(key, ' : ', value)
        self.assertContains(data_types, None)

        ids = data_types.keys()[0:5]
        resources, uris = miriam.get_miriam_resources_for_datatypes(ids, debug=True)
        # test the resources
        for key, value in resources.iteritems():
            print(key, ':', value)
        # test the uris
        for key, value in uris.iteritems():
            print(key, ':', value)

    def test_data_storage(self):
        # TODO: Where is the data passed ?
        # Store everything in simple NOSQL database / pickle
        filename = 'data/miriam.pickle'
        miriam.create_miriam_urn_pickle(filename)
        self.assertEqual(True, False)



if __name__ == "__main__":
    unittest.TestSuite.run()