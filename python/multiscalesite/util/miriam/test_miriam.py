"""

@author: mkoenig
@date: 2015-??-?? 
"""

import unittest
import requests
from util.miriam import miriam


class MyTestCase(unittest.TestCase):
    def setUp(self):
        pass

    def tearDown(self):
        pass

    def test(self):
        # TODO: refactor in proper tests
        url = "http://www.ebi.ac.uk/miriamws/main/rest/"
        r = requests.get(url)
        print r
        print r.status_code
        print r.headers
        print r.headers['content-type']
        print r.encoding
        print r.text
        print '#'*60

        # Get the json
        url = 'http://www.ebi.ac.uk/miriamws/main/rest/datatypes/'
        headers = {'Accept': 'application/json'}
        r = requests.get(url, headers=headers)
        print r
        print r.headers['content-type']
        print r.text
        print r.json()

if __name__ == '__main__':
    unittest.main()

    # Get resources for datatype
    resources, uris = miriam.get_miriam_resources_for_datatype('MIR:00000352')
    print resources
    print uris

    # Get all datatypes
    datatypes = miriam.get_datatypes()
    print '#'*60
    for key, value in datatypes.iteritems():
        print key, ' : ', value
    print '#'*60

    ids = datatypes.keys()[0:5]
    res_dict, uri_dict = miriam.get_miriam_resources_for_datatypes(ids, debug=True)
    for key, value in res_dict.iteritems():
        print key, ':', value
    print '#'*60
    for key, value in uri_dict.iteritems():
        print key, ':', value

    print '#'*60
    # Store everything in simple NOSQL database / pickle
    filename = 'data/miriam.pickle'
    miriam.create_miriam_urn_pickle(filename)
