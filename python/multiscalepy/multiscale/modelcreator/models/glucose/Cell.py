# -*- coding=utf-8 -*-
"""
Hepatic glucose model (Koenig 2012).

Definition of units is done by defining the main_units of the model in
addition with the definition of the individual units of the model.

"""
from libsbml import *
from Reactions import *
from ..templates import terms_of_use, mkoenig

##############################################################
mid = 'Hepatic_glucose'
version = 1
notes = XMLNode.convertStringToXMLNode("""
    <body xmlns='http://www.w3.org/1999/xhtml'>
    <h1>Koenig Human Glucose Metabolism</h1>
    <h2>Description</h2>
    <p>
        This is a metabolism model of Human glucose metabolism in <a href="http://sbml.org">SBML</a> format.
    </p>
    """ + terms_of_use + """
    </body>
    """)
creators = mkoenig
main_units = {
    'time': 's',
    'extent': 'mmol',
    'substance': 'mmol',
    'length': 'm',
    'area': 'm2',
    'volume': 'litre',
}
units = dict()
compartments = dict()
species = dict()
parameters = dict()
names = dict()
assignments = dict()
rules = dict()
reactions = []

#########################################################################
# Units
##########################################################################
# units (kind, exponent, scale=0, multiplier=1.0)
units.update({
    's': [(UNIT_KIND_SECOND, 1.0)],
    'kg': [(UNIT_KIND_KILOGRAM, 1.0)],
    'm': [(UNIT_KIND_METRE, 1.0)],
    'm2': [(UNIT_KIND_METRE, 2.0)],
    'litre': [(UNIT_KIND_LITRE, 1.0)],
    'per_s': [('s', -1.0)],
    'min': [('s', 1.0, 0, 60)],
    's_per_min': [('s', 1.0),
                  ('min', -1.0)],
    'mmol': [(UNIT_KIND_MOLE, 1.0, -3, 1.0)],
    'mM': [(UNIT_KIND_MOLE, 1.0),
           (UNIT_KIND_METRE, -3.0)],
    'mMmM': [('mM', 2.0)],
    'mmol_per_s': [('mmol', 1.0),
                   (UNIT_KIND_SECOND, -1.0)],
    'pmol': [(UNIT_KIND_MOLE, 1.0, -12, 1.0)],
    'pmol_per_l': [('pmol', 1.0),
                   ('litre', -1.0)],
    'mumol_per_min_kg': [(UNIT_KIND_MOLE, 1.0, -6, 1.0),
                         ('min', -1.0), ('kg', -1.0)],
    's_per_min_kg': [('s', 1.0),
                     ('min', -1.0), ('kg', -1.0)],
})

##############################################################
# Functions
##############################################################
# TODO:

##############################################################
# Compartments
##############################################################
compartments.update({
    # id : ('spatialDimension', 'unit', 'constant', 'assignment')
    'extern': (3, 'litre', False, 'V_ext'),
    'cyto': (3, 'litre', False, 'V_cyto'),
    'mito': (3, 'litre', False, 'V_mito'),
    'pm': (2, 'm2', True, '1.0'),
    'mm': (2, 'm2', True, '1.0'),
})
names.update({
    'ext': 'blood',
    'cyto': 'cytosol',
    'mito': 'mitochondrion',
    'pm': 'plasma membrane',
    'mm': 'mitochondrial membrane',
})

##############################################################
# Species
##############################################################
species.update({
    # id : ('compartment', 'value', 'unit', 'boundaryCondition')
    'atp': ('cyto', 2.8000, 'mM', True),
    'adp': ('cyto', 0.8000, 'mM', True),
    'amp': ('cyto', 0.1600, 'mM', True),
    'utp': ('cyto', 0.2700, 'mM', False),
    'udp': ('cyto', 0.0900, 'mM', False),
    'gtp': ('cyto', 0.2900, 'mM', False),
    'gdp': ('cyto', 0.1000, 'mM', False),
    'nad': ('cyto', 1.2200, 'mM', True),
    'nadh': ('cyto', 0.56E-3, 'mM', True),
    'phos': ('cyto', 5.0000, 'mM', True),
    'pp': ('cyto', 0.0080, 'mM', False),
    'co2': ('cyto', 5.0000, 'mM', True),
    'h2o': ('cyto', 0.0, 'mM', True),
    'h': ('cyto', 0.0, 'mM', True),
    
    'glc1p': ('cyto', 0.0120, 'mM', False),
    'udpglc': ('cyto', 0.3800, 'mM', False),
    'glyglc': ('cyto', 250.0000, 'mM', False),
    'glc': ('cyto', 5.0000, 'mM', False),
    'glc6p': ('cyto', 0.1200, 'mM', False),
    'fru6p': ('cyto', 0.0500, 'mM', False),
    'fru16bp': ('cyto', 0.0200, 'mM', False),
    'fru26bp': ('cyto', 0.0040, 'mM', False),
    'grap': ('cyto', 0.1000, 'mM', False),
    'dhap': ('cyto', 0.0300, 'mM', False),
    'bpg13': ('cyto', 0.3000, 'mM', False),
    'pg3': ('cyto', 0.2700, 'mM', False),
    'pg2': ('cyto', 0.0300, 'mM', False),
    'pep': ('cyto', 0.1500, 'mM', False),
    'pyr': ('cyto', 0.1000, 'mM', False),
    'oaa': ('cyto', 0.0100, 'mM', False),
    'lac': ('cyto', 0.5000, 'mM', False),

    'glc_ext': ('cyto', 3.0000, 'mM', True),
    'lac_ext': ('cyto', 1.2000, 'mM', True),

    'co2_mito': ('cyto', 5.0000, 'mM', True),
    'phos_mito': ('cyto', 5.0000, 'mM', True),
    'oaa_mito': ('cyto', 0.0100, 'mM', False),
    'pep_mito': ('cyto', 0.1500, 'mM', False),
    'acoa_mito': ('cyto', 0.0400, 'mM', True),
    'pyr_mito': ('cyto', 0.1000, 'mM', False),
    'cit_mito': ('cyto', 0.3200, 'mM', True),

    'atp_mito': ('cyto', 2.8000, 'mM', True),
    'adp_mito': ('cyto', 0.8000, 'mM', True),
    'gtp_mito': ('cyto', 0.2900, 'mM', False),
    'gdp_mito': ('cyto', 0.1000, 'mM', False),
    'coa_mito': ('cyto', 0.0550, 'mM', True),
    'nadh_mito': ('cyto', 0.2400, 'mM', True),
    'nad_mito': ('cyto', 0.9800, 'mM', True),
    'h2o_mito': ('cyto', 0.0, 'mM', True),
    'h_mito': ('cyto', 0.0, 'mM', True),
})
names.update({
    'atp': 'ATP',
    'adp': 'ADP',
    'amp': 'AMP',
    'utp': 'UTP',
    'udp': 'UDP',
    'gtp': 'GTP',
    'gdp': 'GDP',
    'nad': 'NAD+',
    'nadh': 'NADH',
    'phos': 'phosphate',
    'pp': 'pyrophosphate',
    'co2': 'CO2',
    'h2o': 'H2O',
    'h': 'H+',

    'glc1p': 'glucose-1 phosphate',
    'udpglc': 'UDP-glucose',
    'glyglc': 'glycogen',
    'glc': 'glucose',
    'glc6p': 'glucose-6 phosphate',
    'fru6p': 'fructose-6 phosphate',
    'fru16bp': 'fructose-1,6 bisphosphate',
    'fru26bp': 'fructose-2,6 bisphosphate',
    'grap': 'glyceraldehyde 3-phosphate',
    'dhap': 'dihydroxyacetone phosphate',
    'bpg13': '1,3-bisphospho-glycerate',
    'pg3': '3-phosphoglycerate',
    'pg2': '2-phosphoglycerate',
    'pep': 'phosphoenolpyruvate',
    'pyr': 'pyruvate',
    'oaa': 'oxaloacetate',
    'lac': 'lactate',

    'glc_ext': 'glucose',
    'lac_ext': 'lactate',

    'co2_mito': 'CO2',
    'phos_mito': 'phosphate',
    'oaa_mito': ' oxaloacetate',
    'pep_mito': 'phosphoenolpyruvate',
    'acoa_mito': 'acetyl-coenzyme A',
    'pyr_mito': 'pyruvate',
    'cit_mito': 'citrate',

    'atp_mito': 'ATP',
    'adp_mito': 'ADP',
    'gtp_mito': 'GTP',
    'gdp_mito': 'GDP',
    'coa_mito': 'coenzyme A',
    'nadh_mito': 'NADH',
    'nad_mito': 'NAD+',
    'h2o_mito': 'H20',
    'h_mito': 'H+',
})

##############################################################
# Parameters
##############################################################
parameters.update({
    # id: ('value', 'unit', 'constant')
    'V_cyto': (1.0, 'litre', True),
    'f_ext': (10.0, 'dimensionless', True),
    'V_cyto': (0.2, 'dimensionless', True),
    'Vliver': (1.5, 'litre', True),
    'fliver': (0.583333333333334, 'dimensionless', True),
    'bodyweight': (70, 'kg', True),
    'sec_per_min': (60, 's_per_min', True),

    # hormonal regulation
    'x_ins1': (818.9, 'pmol_per_l', True),
    'x_ins2': (0, 'pmol_per_l', True),
    'x_ins3': (8.6, 'mM', True),
    'x_ins4': (4.2, 'dimensionless', True),

    'x_glu1': (190, 'pmol_per_l', True),
    'x_glu2': (37.9, 'pmol_per_l', True),
    'x_glu3': (3.01, 'mM', True),
    'x_glu4': (6.40, 'dimensionless', True),

    'x_epi1': (6090, 'pmol_per_l', True),
    'x_epi2': (100, 'pmol_per_l', True),
    'x_epi3': (3.10, 'mM', True),
    'x_epi4': (8.40, 'dimensionless', True),

    'K_val': (0.1, 'dimensionless', True),
    'epi_f': (0.8, 'dimensionless', True),

})
names.update({
    'V_cyto': 'cytosolic volume',
    'f_ext': 'external volume factor',
    'f_mito': 'mitochondrial volume factor',
    'Vliver': 'liver volume',
    'fliver': 'parenchymal fraction liver',
    'bodyweight': 'bodyweight',
    'sec_per_min': 'conversion',
})

##############################################################
# Assignments
##############################################################
assignments.update({
    # id: ('value', 'unit')
    'V_ext': ('f_ext * V_cyto', 'litre'),
    'V_mito': ('f_mito * V_cyto', 'litre'),
    'conversion_factor': ('fliver*Vliver/V_cyto*sec_per_min * 1E3 dimensionless/bodyweight', 's_per_min_kg'),

    # scaling factors
    'scale': ('1 dimensionless /60 dimensionless', 'dimensionless'),
    'scale_gly': ('scale', 'dimensionless'),
    'scale_glyglc': ('scale', 'dimensionless'),
})
names.update({
    'V_mito': 'mitochondrial volume',
    'V_ext': 'external volume',
})

##############################################################
# Rules
##############################################################
rules.update({
    # id: ('value', 'unit')
    # hormonal regulation
    'ins': ('x_ins2 + (x_ins1-x_ins2) * glc_ext^x_ins4/(glc_ext^x_ins4 + x_ins3^x_ins4)', 'pmol_per_l'),
    'ins_norm': ('maximum(0.0 pmol_per_l, ins-x_ins2)', 'pmol_per_l'),
    'glu': ('', 'pmol_per_l'),
    'glu_norm': ('', 'pmol_per_l'),

  glu := x_glu2 + (x_glu1-x_glu2)*(1 dimensionless - glc_ext^x_glu4/(glc_ext^x_glu4 + x_glu3^x_glu4));
  glu_norm := maximum(0.0 pmol_per_l, glu-x_glu2);
  glu has pmol_per_l;
  glu_norm has pmol_per_l;

  epi := x_epi2 + (x_epi1-x_epi2) * (1 dimensionless - glc_ext^x_epi4/(glc_ext^x_epi4 + x_epi3^x_epi4));
  epi_norm := maximum(0.0 pmol_per_l, epi-x_epi2);
  epi has pmol_per_l;
  epi_norm has pmol_per_l;

K_ins = (x_ins1-x_ins2) * K_val;
  K_glu = (x_glu1-x_glu2) * K_val;
  K_epi = (x_epi1-x_epi2) * K_val;
  K_ins has pmol_per_l;
  K_glu has pmol_per_l;
  K_epi has pmol_per_l;
  gamma := 0.5 dimensionless * (1 dimensionless - ins_norm/(ins_norm+K_ins) + maximum(glu_norm/(glu_norm+K_glu), epi_f*epi_norm/(epi_norm+K_epi)) );
  gamma has dimensionless;


    # balance rules
    'nadh_tot': ('nadh + nad', 'mM'),
    'atp_tot': ('atp + adp + amp', 'mM'),
    'utp_tot': ('utp + udp + udpglc', 'mM'),
    'gtp_tot': ('gtp + gdp', 'mM'),
    'nadh_mito_tot': ('nadh_mito + nad_mito', 'mM'),
    'atp_mito_tot': ('atp_mito + adp_mito', 'mM'),
    'gtp_mito_tot': ('gtp_mito + gdp_mito', 'mM'),

})
names.update({
    'nadp_bal': 'NADP balance',
    'adp_bal': 'ADP balance',
    'udp_bal': 'UDP balance',
    'phos_bal': 'Phosphate balance',
})


##############################################################
# Reactions
##############################################################
reactions.extend([

])
