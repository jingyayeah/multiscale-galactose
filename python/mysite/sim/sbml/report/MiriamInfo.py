'''
Created on May 26, 2014

@author: mkoenig

Get the additional information via a MIRIAM Rest Web Service.

sudo apt-get install python-simplejson
https://pypi.python.org/pypi/siesta


    /datatypes/: retrieves the list of all available datatypes
    /datatypes/$id: retrieves the datatype identified by $id (for example: MIR:00000008)
    /resolve/$urn: resolves the given MIRIAM URN (for example: urn:miriam:uniprot:P62158)
    /version: displays the current version of the services


api = API('http://myrestful/api/v1')
      
# GET /resource
api.resource.get()
# GET /resource (with accept header = application/json)
api.resource.get(format='json')
# GET /resource?attr=value
api.resource.get(attr=value)
      
# POST /resource
api.resource.post(attr=value, attr2=value2, ...)
# GET /resource/id/resource_collection
api.resoure(id).resource_collection().get()

'''


from siesta import API


api = API('http://www.ebi.ac.uk/miriam/main/export/')
res, response = api.resource.get(format='json')
print res.get()
print response





