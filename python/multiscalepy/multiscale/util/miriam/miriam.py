"""
MIRIAM REST webservice information.

Lookup of uris and resources for MIRIAM resources. Mainly used in the context
of annotations of models and components.

http://www.ebi.ac.uk/miriamws/main/rest/

MIRIAM WebInterface
    /datatypes/: retrieves the list of all available datatypes
    /datatypes/$id: retrieves the datatype identified by $id (for example: MIR:00000008)
    /resolve/$urn: resolves the given MIRIAM URN (for example: urn:miriam:uniprot:P62158)
    /version: displays the current version of the services

The schema of the XML response is the same as the one used for the XML export of MIRIAM Resources,
and is available at: http://www.ebi.ac.uk/miriam/main/export/xml
"""

from __future__ import print_function
from xml.etree import ElementTree
import requests
import pickle


class Miriam(object):
    MIRIAM_REST = 'http://www.ebi.ac.uk/miriamws/main/rest/'

    def _version(self):
        """ Get the webservice version.
        :return: version of miriam interface
        """
        response = requests.get(self.MIRIAM_REST + 'version/')
        return response.text

    version = property(_version)

    def _datatypes(self):
        """ Gets the dictionary of Miriam data types.
            This dictionary is used for datatype lookup.
        """
        datatypes = dict()
        r = requests.get(self.MIRIAM_REST + 'datatypes/')
        doc = ElementTree.fromstring(r.text)
        # print pretty_xml(doc)
        for n in doc.findall('datatype'):
            dt_id = n.find('id').text
            name = n.find('name').text
            datatypes[dt_id] = name
        return datatypes

    datatypes = property(_datatypes)

    def _datatypes_json(self):
        """ Request the datatypes in JSON.
        :return:
        """
        headers = {'Accept': 'application/json'}
        r = requests.get(self.MIRIAM_REST + 'datatypes/',
                         headers=headers)
        json = r.json()
        return json

    def resources_for_datatypes(self, datatype_ids):
        """ Get resources for given datatypes """
        res_dict, uri_dict = dict(), dict()
        for datatype_id in datatype_ids:
            resources, uris = self.resources_for_datatype(datatype_id)
            res_dict[datatype_id] = resources
            for uri in uris:
                uri_dict[uri] = resources
        return res_dict, uri_dict

    def resources_for_datatype(self, datatype_id):
        """ Returns dictionary of resources for the given datatype. """
        r = requests.get(self.MIRIAM_REST + 'datatypes/' + datatype_id + '/')
        doc = ElementTree.fromstring(r.text)

        # print pretty_xml(doc)
        resources = []
        for n in doc.iter('resource'):
            resource = dict()
            resource['id'] = n.attrib['id']
            resource['dataEntry'] = n.find('dataEntry').text
            resources.append(resource)
        # select all uris of type URN
        uris = []
        for n in doc.iter('uri'):
            if n.attrib['type'] == 'URN':
                uris.append(n.text)
        return resources, uris

    def pickle_uris(self, file_path):
        """ Pickle all uris to file.
        :param file_path:
        :return:
        """
        _, uri_dict = self.resources_for_datatypes(self.datatypes.keys())
        with open(file_path, 'wb') as handle:
            pickle.dump(uri_dict, handle)

    def resolve_urn(self, urn, deprecated=True):
        """ Resolves the uris for the given urn.
        :param urn:
        :param deprecated:
        :return:
        """
        r = requests.get(self.MIRIAM_REST + 'resolve/' + urn + '/')
        doc = ElementTree.fromstring(r.text)
        # print(self.pretty_xml(doc))

        uris = []
        for n in doc.iter('uri'):
            if n.attrib['type'] == 'URL':
                if not deprecated and n.attrib.has_key('deprecated') and n.attrib['deprecated'] == 'true':
                    continue
                uris.append(n.text)
        return uris

    @staticmethod
    def pretty_xml(element):
        """ Return a pretty-printed XML string for the Element. """
        rough_string = ElementTree.tostring(element, 'utf-8')
        reparsed = minidom.parseString(rough_string)
        return reparsed.toprettyxml(indent="\t")


if __name__ == "__main__":
    print('* Testing MIRIAM *')
    m = Miriam()
    print(m.MIRIAM_REST)
    print('MIRIAM version:', m.version)
    print('MIRIAM datatyes:', m.datatypes)

    '''
    print(r)
    print('status code:', r.status_code)
    print('headers:', r.headers)
    print('encoding:', r.encoding)
    print('text:', r.text)
    '''

    uris2 = m.resolve_urn(urn='urn:miriam:uniprot:P62158', deprecated=False)
    print(uris2)

    print(m._datatypes_json())
