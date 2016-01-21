"""
Testing MIRIAM web services.

Used for reading the miriam resources and uris for given annotations.
Tests require connectivity for success.
"""
from __future__ import print_function
import unittest
import miriam


class MiriamTestCase(unittest.TestCase):
    def setUp(self):
        self.m = miriam.Miriam()

    def tearDown(self):
        self.m = None

    def test_version(self):
        self.assertEqual(self.m.version, "20100729")

    def test_datatypes_json(self):
        """ Get the MIRIAM datatypes in JSON. """
        json = self.m._datatypes_json()
        self.assertTrue('datatype' in json)

    def test_all_datatypes(self):
        """ Get all datatypes """
        data_types = self.m.datatypes
        self.assertTrue('MIR:00000352' in data_types)
        self.assertTrue('MIR:00000268' in data_types)
        self.assertFalse('MIR:999999999' in data_types)

    def test_resource(self):
        """  Get resources for datatype. """
        resources, uris = self.m.resources_for_datatype('MIR:00000352')
        self.assertEqual('MIR:00100449', resources[0]['id'])
        self.assertEqual('urn:miriam:unite', uris[0])

    def test_resources(self):
        ids = ['MIR:00000352', 'MIR:00000268']
        resources, uris = self.m.resources_for_datatypes(ids)
        self.assertTrue('MIR:00000352' in resources)
        self.assertTrue('urn:miriam:unite' in uris)
        self.assertTrue('MIR:00000268' in resources)
        self.assertTrue('urn:miriam:phenolexplorer' in uris)

    def test_resolve_uri(self):
        uris = self.m.resolve_urn(urn='urn:miriam:uniprot:P62158')
        # print(uris)
        self.assertTrue('http://www.ebi.uniprot.org/entry/P62158' in uris)


if __name__ == "__main__":
    unittest.TestSuite.run()
