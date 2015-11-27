"""
Annotation of SBML models.

Handle the XML annotations and notes in SBML.
Annotate models from information in external files.
Thereby a model can be fully annotated from information
stored in a separate annotation store.
"""

from __future__ import print_function
import libsbml
import re
import uuid
import datetime

def create_meta_id(sid):
    """ Create meta id.
        Uniqueness not tested.
    """
    return 'meta_{}'.format(sid)


class AnnotationException(Exception):
    pass


class ModelAnnotation(object):
    """ Storage of single model annotation information."""

    def __init__(self, d):
        self.id = d['id']
        self.sbml_type = d['sbml_type']
        self.annotation_type = d['annotation_type']
        self.qualifier = d['qualifier']
        self.collection = d['collection']
        self.entity = d['entity']
    
    def print_annotation(self):
        print ("{:<20}"*6).format(self.id, self.sbml_type, self.annotation_type,
                                  self.qualifier, self.collection, self.entity)


class ModelAnnotator(object):
    """ Helper class for annotating SBML models."""
    def __init__(self, model, annotations):
        self.model = model
        self.annotations = annotations
        self.id_dict = self.get_ids_from_model()
        
    def get_ids_from_model(self):
        """ Create ids dictionary for the model."""
        id_dict = dict()
        id_dict['model'] = [self.model.getId()]
        
        lof = self.model.getListOfCompartments()
        if lof:
            id_dict['compartment'] = [item.getId() for item in lof]
    
        lof = self.model.getListOfSpecies()
        if lof:
            id_dict['species'] = [item.getId() for item in lof]
            
        lof = self.model.getListOfParameters()
        if lof:
            id_dict['parameter'] = [item.getId() for item in lof]
            
        lof = self.model.getListOfReactions()
        if lof:
            id_dict['reaction'] = [item.getId() for item in lof]

        lof = self.model.getListOfEvents()
        if lof:
            id_dict['event'] = [item.getId() for item in lof]
            
        return id_dict

    def create_history(self, family_name, given_name, email, organization):
        h = libsbml.ModelHistory()
        c = libsbml.ModelCreator()
        c.setFamilyName(family_name)
        c.setGivenName(given_name)
        c.setEmail(email)
        c.setOrganization(organization)
        h.addCreator(c)
        date_str = str(datetime.datetime.now())
        date = libsbml.Date(date_str)
        
        h.setCreatedDate(date)
        h.setModifiedDate(date)
        self.model.setModelHistory(h)

    def annotate_model(self):
        """ Annotates the model with the given annotations. """
        for a in self.annotations:
            pattern = a.id
            ids = self.id_dict[a.sbml_type]
            sbml_ids = self.__class__.get_matching_ids(ids, pattern)
            self.annotate_components(sbml_ids, a)

    def annotate_components(self, sbml_ids, a):
        """ Annotate components. """
        for sid in sbml_ids:
            element = self.model.getElementBySId(sid)
            if element is None:
                if sid == self.model.getId():
                    element = self.model
                else:
                    print('Element could not be found: {}'.format(sid))
                    continue
            
            if a.annotation_type == 'SBO':
                print('SBO:', a.entity, sid, element)
                if a.entity.startswith('SBO'):
                    element.setSBOTerm(a.entity) 
                else:
                    element.setSBOTerm(int(a.entity))
            elif a.annotation_type == 'RDF':
                self.__class__.add_rdf_to_element(element, a.qualifier, a.collection, a.entity)
                print('RDF:', sid, element)
            else:
                raise AnnotationException('Annotation type not supported: {}'.format(a.annotation_type))
        print()

    @classmethod
    def add_rdf_to_element(cls, element, qualifier, collection, entity):
        cv = libsbml.CVTerm()

        if qualifier.startswith('BQB'):
            cv.setQualifierType(libsbml.BIOLOGICAL_QUALIFIER)
            sbml_qualifier = cls.get_SBMLQualifier_from_string(qualifier)
            cv.setBiologicalQualifierType(sbml_qualifier)
        elif qualifier.startswith('BQM'):
            cv.setQualifierType(libsbml.MODEL_QUALIFIER)
            sbml_qualifier = cls.get_SBMLQualifier_from_string(qualifier)
            cv.setModelQualifierType(sbml_qualifier)
        else:
            raise AnnotationException('Unsupported qualifier: {}'.format(qualifier))
        # Use the identifiers.org solution
        resource = ''.join(['http://identifiers.org/', collection, '/', entity])
        cv.addResource(resource)

        # meta id has to be set
        if not element.isSetMetaId():
            meta_id = cls.create_meta_id()
            element.setMetaId(meta_id)

        cv.setQualifierType(libsbml.BIOLOGICAL_QUALIFIER)
        success = element.addCVTerm(cv)

        if success != 0:
            print("Warning, RDF not written: ", success)
            print(libsbml.OperationReturnValue_toString(success))

    @staticmethod
    def get_SBMLQualifier_from_string(qualifier_str):
        if qualifier_str not in libsbml.__dict__:
            raise AnnotationException('Qualifier is not found: {}'.format(qualifier_str))
        return libsbml.__dict__.get(qualifier_str)

    @staticmethod
    def create_meta_id():
        meta_id = uuid.uuid4()
        return 'meta_{}'.format(meta_id.hex)

    @staticmethod
    def annotations_from_file(filename, sep='\t'):
        """ Read annotations in annotation data structure. """
        res = []
        count = 0
        with open(filename, 'r') as f:
            for line in f:
                if count == 0:
                    header = line.split(sep)
                    header = [item.strip() for item in header]
                else:
                    items = line.split(sep)
                    if len(items) != len(header):
                        raise AnnotationException('Wrong number of items')
                    elif items[0].startswith('#') | len(items[0]) == 0:
                        continue
                    else:
                        d = dict()
                        for k in xrange(len(items)):
                            d[header[k]] = items[k].strip()
                        a = ModelAnnotation(d)
                        if a:
                            res.append(a)
                count += 1
        f.close()
        return res

    @staticmethod
    def get_matching_ids(ids, pattern):
        """ Finds the model ids based on the regular expression pattern. """
        match_ids = []
        for string in ids:
            match = re.match(pattern, string)
            if match:
                # print 'Match: ', pattern, '<->', string
                match_ids.append(string)
        return match_ids


def annotate_sbml_file(f_sbml, f_annotations, f_sbml_annotated,
                       family_name, given_name, email, organization, suffix="annotated"):
    # read SBML model
    doc = libsbml.readSBML(f_sbml)
    model = doc.getModel()

    # annotate
    annotations = ModelAnnotator.annotations_from_file(f_annotations)

    annotator = ModelAnnotator(model, annotations)
    annotator.annotate_model()
    annotator.create_history(family_name, given_name, email, organization)
    
    # Update id
    mid = "{}_{}".format(model.getId(), suffix)
    model.setId(mid)
    
    # Save
    libsbml.writeSBMLToFile(doc, f_sbml_annotated)
