"""
Annotation of SBML models.

Handle the XML annotations and notes for SBML and SEDML.
A general problem is annotate all the objects in the SBML and SEDML file.

Provide an easy format to handle the problem.

define annotation for XPath (RDF or SBO)
get SBase(s) for XPath, i.e. get all the sbml ids related to the XPath and get the SBase objects via the ids
write annotations to SBase objects
Do the same for notes.


@author: Matthias Koenig
@date: 2014-05-30
"""
import libsbml
import uuid
import datetime


class ModelAnnotation(object):
    
    def __init__(self, d):
        self.id = d['id'];
        self.sbml_type = d['sbml_type'];
        self.annotation_type = d['annotation_type'];
        self.qualifier = d['qualifier'];
        self.collection = d['collection'];
        self.entity = d['entity'];
    
    def printAnnotation(self):
        print ("{:<20}"*6).model_format(self.id, self.sbml_type, self.annotation_type, 
                                  self.qualifier, self.collection, self.entity)


class ModelAnnotator(object):
    
    def __init__(self, model, annotations):
        self.model = model
        self.annotations = annotations
        self.id_dict = self.getIdsFromModel()
        
    def getIdsFromModel(self):
        '''
        Creates the ids dictionary for the model for easy retrieval.
        '''
        id_dict = dict()
        id_dict['model'] = [ self.model.getId() ]
        
        lof = self.model.getListOfCompartments()
        if (lof):
            id_dict['compartment'] = [item.getId() for item in lof]
    
        lof = self.model.getListOfSpecies()
        if (lof):
            id_dict['species'] = [item.getId() for item in lof]
            
        lof = self.model.getListOfParameters()
        if (lof):
            id_dict['parameter'] = [item.getId() for item in lof]
            
        lof = self.model.getListOfReactions()
        if (lof):
            id_dict['reaction'] = [item.getId() for item in lof]

        lof = self.model.getListOfEvents()
        if (lof):
            id_dict['event'] = [item.getId() for item in lof]
            
        return id_dict

    def createHistory(self):
        '''
        Write the model history.
        '''
        h = libsbml.ModelHistory();
        c = libsbml.ModelCreator();
        c.setFamilyName("Koenig");
        c.setGivenName("Matthias");
        c.setEmail("konigmatt@googlemail.com");
        c.setOrganization("Charite Berlin");
        h.addCreator(c);
        date_str = str(datetime.datetime.now())
        date = libsbml.Date(date_str)
        
        h.setCreatedDate(date);
        h.setModifiedDate(date);
        self.model.setModelHistory(h);

    def annotateModel(self):
        '''
        Annotates the model with the given annotations.
        '''
        for a in self.annotations:
            pattern = a.id
            ids = self.id_dict[a.sbml_type]
            mids = getMatchingIds(ids, pattern)
            self.annotateComponents(mids, a)

    def annotateComponents(self, mids, a):
        '''Annotate components. '''
        for mid in mids:
            element = self.model.getElementBySId(mid)
            if (element == None):
                if (mid == self.model.getId()):
                    element = self.model
                else:
                    print "Element could not be found"
                    continue
            
            if (a.annotation_type == 'SBO'):
                print 'SBO:', a.entity, mid, element
                if a.entity.startswith('SBO'):
                    element.setSBOTerm(a.entity) 
                else:
                    element.setSBOTerm(int(a.entity))
            elif (a.annotation_type == 'RDF'):
                addRDFAnnotationToElement(element, a.qualifier, a.collection, a.entity)
                print 'RDF:', mid, element
            else:
                print 'Annotation type not supported: ', a.annotation_type
        print ''

def addRDFAnnotationToElement(element, qualifier, collection, entity):
    cv = libsbml.CVTerm()

    if (qualifier.startswith('BQB')):
        cv.setQualifierType(libsbml.BIOLOGICAL_QUALIFIER);
        sbml_qualifier = getSBMLQualifier(qualifier)
        cv.setBiologicalQualifierType(sbml_qualifier)
    elif (qualifier.startswith('BQM')):
        cv.setQualifierType(libsbml.MODEL_QUALIFIER);
        sbml_qualifier = getSBMLQualifier(qualifier)
        cv.setModelQualifierType(sbml_qualifier)
    else:
        print "Unsupported qualifier:", qualifier
    # Use the identifiers.org solution
    resource = ''.join(['http://identifiers.org/', collection, '/', entity])
    cv.addResource(resource)
    
    # meta id has to be set
    if not element.isSetMetaId():
        meta_id = createMetaId()
        element.setMetaId(meta_id)

    cv.setQualifierType(libsbml.BIOLOGICAL_QUALIFIER);
    success = element.addCVTerm(cv);
        
    if (success != 0):
        print "Warning, RDF not written: ", success
        print libsbml.OperationReturnValue_toString(success)
   


     
def getSBMLQualifier(string):
    return libsbml.__dict__.get(string)


def createMetaId():
    meta_id = uuid.uuid4()
    return 'mid_' + str(meta_id.hex)

def readAnnotationsFromFile(filename, sep='\t'):
    ''' Reads the annotations into an iteratable annotation data structure. '''
    res = []
    count = 0;
    with open(filename, 'r') as f:
        for line in f:
            if (count == 0):
                header = line.split(sep)
                header = [item.strip() for item in header]
            else:
                items = line.split(sep)
                if len(items) != len(header):
                    print 'wrong number of items'
                    continue
                elif (items[0].startswith('#') | len(items[0]) == 0):
                    continue
                else:
                    d = dict()
                    for k in xrange(len(items)):
                        d[header[k]] = items[k].strip()
                    a = ModelAnnotation(d)
                    if a:
                        res.append(a)    
            count = count + 1
    f.close()
    return res

def getMatchingIds(ids, pattern):
    '''
    Finds the model ids based on the regular expression pattern
    and the sbml_type.
    '''    
    import re
    mids = []
    for string in ids:
        match = re.match(pattern, string)
        if (match):
            # print 'Match: ', pattern, '<->', string
            mids.append(string)
    return mids

def annotateModel(f_sbml, f_annotations, f_sbml_annotated):
    # read SBML model
    doc = libsbml.readSBML(f_sbml)
    model = doc.getModel()
    
    # Read annotation file
    annotations = readAnnotationsFromFile(f_annotations)
    print '*' * 120
    print ' Annotations'
    print '*' * 120
    for a in annotations:
        a.printAnnotation()
    print '*'*120
    
    # Annotate
    ar = ModelAnnotator(model, annotations)
    ar.annotateModel()
    ar.createHistory()
    
    # Update id
    mid = model.getId() + "_annotated"
    model.setId(mid)
    
    # Save
    print doc
    print f_sbml_annotated
    libsbml.writeSBMLToFile(doc, f_sbml_annotated)


    

###############################################################################
if __name__ == "__main__":

    f_sbml = 'examples/Koenig2014_demo_kinetic_v7.xml'
    f_annotations = 'examples/Koenig2014_demo_kinetic_v7_annotations.csv'
    f_sbml_annotated = 'examples/Koenig2014_demo_kinetic_v7_annotated.xml'
    annotateModel(f_sbml, f_annotations, f_sbml_annotated)
###############################################################################