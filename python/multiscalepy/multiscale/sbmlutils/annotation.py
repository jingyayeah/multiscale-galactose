"""
Annotation of SBML models.

Handle the XML annotations and notes in SBML.
Annotate models from information in annotation csv files.
Thereby a model can be fully annotated from information
stored in a separate annotation store.
"""
# TODO: general logging for the whole system
# TODO: check annotations against the MIRIAM info (load miriam info)
# TODO: check how the meta id is generated & use general mechanism

from __future__ import print_function
import logging
import warnings

import csv
import re
import uuid
import datetime

from .validation import check

# create logger
logger = logging.getLogger('annotation')
logger.setLevel(logging.WARNING)
# create console handler and set level to debug
ch = logging.StreamHandler()
ch.setLevel(logging.WARNING)
# create formatter
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
# add formatter to ch
ch.setFormatter(formatter)
# add ch to logger
logger.addHandler(ch)


########################################################################
# Qualifier
########################################################################
# from libsbmlconstants
# TODO: use ModelQualifierType_toString
import libsbml

QualifierType = {
  0: "MODEL_QUALIFIER",
  1: "BIOLOGICAL_QUALIFIER",
  2: "UNKNOWN_QUALIFIER"
}

ModelQualifierType = {
    0: "BQM_IS",
    1: "BQM_IS_DESCRIBED_BY",
    2: "BQM_IS_DERIVED_FROM",
    3: "BQM_IS_INSTANCE_OF",
    4: "BQM_HAS_INSTANCE",
    5: "BQM_UNKNOWN",
}

BiologicalQualifierType = {
   0: "BQB_IS",
   1: "BQB_HAS_PART",
   2: "BQB_IS_PART_OF",
   3: "BQB_IS_VERSION_OF",
   4: "BQB_HAS_VERSION",
   5: "BQB_IS_HOMOLOG_TO",
   6: "BQB_IS_DESCRIBED_BY",
   7: "BQB_IS_ENCODED_BY",
   8: "BQB_ENCODES",
   9: "BQB_OCCURS_IN",
   10: "BQB_HAS_PROPERTY",
   11: "BQB_IS_PROPERTY_OF",
   12: "BQB_HAS_TAXON",
   13: "BQB_UNKNOWN",
}


########################################################################
# Model History
########################################################################

def set_model_history(model, creators):
    # TODO: check if history is existing and add info to the existing history
    if not model.isSetMetaId():
        model.setMetaId(create_meta_id())

    # set history
    h = _create_history(creators)
    check(model.setModelHistory(h), 'set model history')


def _create_history(creators):
    h = libsbml.ModelHistory()

    # add all creators
    for creator in creators.itervalues():
        c = libsbml.ModelCreator()
        c.setFamilyName(creator['FamilyName'])
        c.setGivenName(creator['GivenName'])
        c.setEmail(creator['Email'])
        c.setOrganization(creator['Organization'])
        check(h.addCreator(c), 'add creator')

    # create time is now
    date = date_now()
    check(h.setCreatedDate(date), 'set creation date')
    check(h.setModifiedDate(date), 'set creation date')
    return h


def date_now():
    time = datetime.datetime.now()
    timestr = time.strftime('%Y-%m-%dT%H:%M:%S')
    return libsbml.Date(timestr)


########################################################################
# Annotation
########################################################################
def create_meta_id():
    meta_id = uuid.uuid4()
    return 'meta_{}'.format(meta_id.hex)


class AnnotationException(Exception):
    pass


class ModelAnnotation(object):
    """ Class for single annotation, i.e. a single annotation line from a annotation file. """
    _keys = ['pattern', 'sbml_type', 'annotation_type', 'value', 'qualifier', 'collection', 'name']

    _sbml_types = frozenset(["document", "model", "reaction", "transporter", "species",
                             "compartment", "parameter", "rule"])

    _annotation_types = frozenset(["RDF", "Formula", "Charge"])

    _collections = [
        ["biomodels.sbo", "Systems Biology Ontology", "^SBO:\d{7}$"],
        ["bto", "Brenda Tissue Ontology", "^BTO:\d{7}$"],
        ["chebi", "ChEBI", "^CHEBI:\d+$"],
        ["ec-code", "Enzyme Nomenclature", "^\d+\.-\.-\.-|\d+\.\d+\.-\.-|\d+\.\d+\.\d+\.-|\d+\.\d+\.\d+\.(n)?\d+$"],
        ["fma", "Foundational Model of Anatomy Ontology", "^FMA:\d+$"],
        ["go", "Gene Ontology", "^GO:\d{7}$"],
        ["kegg.compound", "KEGG Compound", "^C\d+$"],
        ["kegg.pathway", "KEGG Pathway", "^\w{2,4}\d{5}$"],
        ["kegg.reaction", "KEGG Reaction", "^R\d+$"],
        ["omim", "OMIM", "^[*#+%^]?\d{6}$"],
        ["pubmed", "PubMed", "^\d+$"],
        ["pw", "Pathway Ontology", "^PW:\d{7}$"],
        ["reactome", "Reactome", "(^(REACTOME:)?R-[A-Z]{3}-[0-9]+(-[0-9]+)?$)|(^REACT_\d+$)"],
        ["rhea", "Rhea", "^\d{5}$"],
        ["sabiork.kineticrecord", "SABIO-RK Kinetic Record", "^\d+$"],
        ["smpdb", "Small Molecule Pathway Database", "^SMP\d{5}$"],
        ["taxonomy", "Taxonomy", "^\d+$"],
        ["tcdb", "Transport Classification Database", "^\d+\.[A-Z]\.\d+\.\d+\.\d+$"],
        ["uberon", "UBERON", "^UBERON\:\d+$"],
        ["uniprot", "UniProt Knowledgebase", "^([A-N,R-Z][0-9]([A-Z][A-Z, 0-9][A-Z, 0-9][0-9]){1,2})|([O,P,Q][0-9][A-Z, 0-9][A-Z, 0-9][A-Z, 0-9][0-9])(\.\d+)?$"],
    ]

    def __init__(self, d):
        self.d = d
        for k in self._keys:
            setattr(self, k, d[k])
        self.check()

    def check(self):
        """ Checks if the annotation is valid. """
        if self.annotation_type not in self._annotation_types:
            warnings.warn("annotation_type not supported: {}, {}".format(self.annotation_type,
                                                                         self.d))
        if self.sbml_type not in self._sbml_types:
            warnings.warn("sbml_type not supported: {}, {}".format(self.sbml_type, self.d))

        # TODO: check against MIRIAM dictionary and patterns

    def __str__(self):
        return str(self.d)
        # print (("{:<20}"*len(self._keys)).format([getattr(self, k) for k in self._keys]))


class ModelAnnotator(object):
    """ Helper class for annotating SBML models."""
    def __init__(self, doc, annotations):
        self.doc = doc
        self.model = doc.getModel()
        self.annotations = annotations
        self.id_dict = self.get_ids_from_model()

    def get_ids_from_model(self):
        """ Create ids dictionary from the model. """
        # TODO: generic generation
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

        lof = self.model.getListOfRules()
        if lof:
            id_dict['rule'] = [item.getId() for item in lof]

        lof = self.model.getListOfEvents()
        if lof:
            id_dict['event'] = [item.getId() for item in lof]
            
        return id_dict

    def annotate_model(self):
        """ Annotates the model with the given annotations. """
        for a in self.annotations:
            pattern = a.pattern
            if a.sbml_type == "document":
                elements = [self.doc]
            else:
                # lookup of allowed ids for given sbmlutils type
                ids = self.id_dict[a.sbml_type]
                # find the subset of ids matching the pattern
                pattern_ids = self.__class__.get_matching_ids(ids, pattern)
                elements = self.__class__.elements_from_ids(self.model, pattern_ids)
            self.annotate_components(elements, a)


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

    @staticmethod
    def elements_from_ids(model, sbml_ids):
        elements = []
        for sid in sbml_ids:
            e = model.getElementBySId(sid)
            if e is None:
                if sid == model.getId():
                    e = model
                else:
                    print('Element could not be found: {}'.format(sid))
                    continue
            elements.append(e)
        return elements

    def annotate_components(self, elements, a):
        """ Annotate components. """
        for e in elements:

            if a.annotation_type == 'RDF':
                self.__class__.add_rdf_to_element(e, a.qualifier, a.collection, a.value)
                # write SBO terms based on the SBO RDF
                if a.collection == 'biomodels.sbo':
                    e.setSBOTerm(a.value)

            elif a.annotation_type in ['Formula', 'Charge']:
                # via fbc species plugin, so check that species first
                if a.sbml_type != 'species':
                    warnings.warn("Chemical formula or Charge can only be set on species.")
                else:
                    s = self.model.getSpecies(e.getId())
                    splugin = s.getPlugin("fbc")
                    if a.annotation_type == 'Formula':
                        splugin.setChemicalFormula(a.value)
                    else:
                        splugin.setCharge(int(a.value))
            else:
                raise AnnotationException('Annotation type not supported: {}'.format(a.annotation_type))

    @classmethod
    def add_rdf_to_element(cls, element, qualifier, collection, entity):
        cv = libsbml.CVTerm()

        # set correct type of qualifier
        if qualifier.startswith('BQB'):
            cv.setQualifierType(libsbml.BIOLOGICAL_QUALIFIER)
            sbml_qualifier = cls.get_SBMLQualifier(qualifier)
            cv.setBiologicalQualifierType(sbml_qualifier)
        elif qualifier.startswith('BQM'):
            cv.setQualifierType(libsbml.MODEL_QUALIFIER)
            sbml_qualifier = cls.get_SBMLQualifier(qualifier)
            cv.setModelQualifierType(sbml_qualifier)
        else:
            raise AnnotationException('Unsupported qualifier: {}'.format(qualifier))
        # Use the identifiers.org solution
        resource = ''.join(['http://identifiers.org/', collection, '/', entity])
        cv.addResource(resource)

        # meta id has to be set
        if not element.isSetMetaId():
            meta_id = create_meta_id()
            element.setMetaId(meta_id)

        success = element.addCVTerm(cv)

        if success != 0:
            print("Warning, RDF not written: ", success)
            print(libsbml.OperationReturnValue_toString(success))
            print(element, qualifier, collection, entity)


    @staticmethod
    def get_SBMLQualifier(qualifier_str):
        """ Lookup of SBMLQualifier for given qualifier string. """
        if qualifier_str not in libsbml.__dict__:
            raise AnnotationException('Qualifier not found: {}'.format(qualifier_str))
        return libsbml.__dict__.get(qualifier_str)


    @staticmethod
    def annotations_from_file(csvfile, delimiter='\t'):
        """ Read annotations from csv in annotation data structure. """
        res = []
        f = open(csvfile, 'rb')
        reader = csv.reader(f, delimiter=delimiter, quoting=csv.QUOTE_NONE)

        # first line is headers line
        headers = reader.next()
        logger.info('Headers: {}'.format(headers))

        # read entries
        for row in reader:
            # skip empty lines
            if not ''.join(row).strip():
                continue
            # skip comments
            if row[0].startswith('#'):
                continue

            entry = dict(zip(headers, [item.strip() for item in row]))
            a = ModelAnnotation(entry)
            res.append(a)
            logger.info(str(a))

        return res


def annotate_sbml_file(f_sbml, f_annotations, f_sbml_annotated, suffix="annotated"):
    """
    Annotate a given SBML file with the provided annotations.

    :param f_sbml: SBML to annotation
    :param f_annotations: csv file with annotations
    :param f_sbml_annotated: annotated file
    """
    # read SBML model
    doc = libsbml.readSBML(f_sbml)

    # read annotations
    annotations = ModelAnnotator.annotations_from_file(f_annotations)

    # annotate the model
    annotator = ModelAnnotator(doc, annotations)
    annotator.annotate_model()

    # Update id
    # TODO: necessary ? File name does not have to be model id
    # Handle this better
    model = doc.getModel()
    if model:
        mid = "{}_{}".format(model.getId(), suffix)
        model.setId(mid)

    # Save
    libsbml.writeSBMLToFile(doc, f_sbml_annotated)
