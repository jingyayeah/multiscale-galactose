"""
Galactose model for inclusion into sinusoidal unit.
The metabolic models are specified in a generic format which is than
included in the tissue scale model.

Generic generation of the species depending on the compartment they
are localized in.
e__x : extracellular compartment (Disse)
h__x : hepatocyte compartment (total internal cell volume)
c__x : cytosolic compartment (fraction of hepatocyte which is cytosol)


TODO: how to handle the versions and names of the multiple submodels ?
TODO: add the model description & history to the model

"""
from Reactions import *

##############################################################
mid = 'galactose'
version = 1
notes = """
Galactose model for inclusion into sinusoidal unit.
The metabolic models are specified in a generic format which is than
included in the tissue scale model.

    <body>
    <h1>Koenig Human Galactose Metabolism</h1>
    <h2>Description</h2>
    <p>This is a metabolism model of Human galactose metabolsim in
        <a href="http://sbml.org" target="_blank" title="Access the definition of the SBML file format.">SBML</a>&#160;format.</p>

      <div class="dc:provenance">The content of this model has been carefully created in a manual research effort. This file has been exported from the software
      <a href="http://dx.doi.org/10.1186/1752-0509-7-74" title="Access publication about COBRApy." target="_blank">COBRApy</a>&#160;and further processed with a
      <a href="http://dx.doi.org/10.1093/bioinformatics/btv341" title="Access publication about JSBML." target="_blank">JSBML</a>-based in-house application.</div>
      <div class="dc:publisher">This file has been produced by the
      <a href="http://systemsbiology.ucsd.edu" title="Website of the Systems Biology Research Group" target="_blank">Systems Biology Research Group</a>&#160;and is currently hosted on
      <a href="http://dx.doi.org/10.1186/1471-2105-11-213" title="Access publication about BiGG knowledgebase." target="_blank">BiGG knowledgebase</a>&#160;and identified by:
      <a href="http://identifiers.org/bigg.model/e_coli_core" title="Access to this model via BiGG knowledgebase." target="_blank">e_coli_core</a>.</div>

    <h2>Terms of use</h2>
      <div class="dc:rightsHolder">Copyright © 2015 Matthias Koenig.</div>
      <div class="dc:license">
      <p>Redistribution and use of any part of this model, with or without modification, are permitted provided that the following conditions are met:
        <ol>
          <li>Redistributions of this SBML file must retain the above copyright notice, this list of conditions and the following disclaimer.</li>
          <li>Redistributions in a different form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided
          with the distribution.</li>
        </ol>This model is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.</p>
        <p>For specific licensing terms about this particular model and regulations of commercial use, see
        <a href="http://identifiers.org/bigg.model/e_coli_core" title="Access to this model via BiGG knowledgebase." target="_blank">this model in BiGG database</a>.</p>
      </div>
      <h2>References</h2>When using content from BiGG database in your research works, please cite
      <dl>
        <dt>Schellenberger, J., Park, J. O., Conrad, T. C., and Palsson, B. Ø. (2010).
        <dd>
        <a href="http://dx.doi.org/10.1186/1471-2105-11-213" target="_blank" title="Access publication about: BiGG knowledgebase">BiGG: a Biochemical Genetic and Genomic knowledgebase of large scale
        metabolic reconstructions</a>,
        <i>BMC Bioinformatics</i>, 11:213.</dd></dt>
      </dl>

    </body>
</notes>
"""
history = ""
units = dict()
compartments = dict()
species = dict()
parameters = dict()
names = dict()
assignments = dict()
rules = dict()
reactions = []

##############################################################
# Compartments
##############################################################
compartments.update({
    # id : ('spatialDimension', 'unit', 'constant', 'assignment')
    'e': (3, 'm3', False, 'Vol_e'),
    'h': (3, 'm3', False, 'Vol_h'),
    'c': (3, 'm3', False, 'Vol_c'),
})
names.update({
    'e': 'external',
    'h': 'hepatocyte',
    'c': 'cytosol'
})

##############################################################
# Species
##############################################################
species.update({
    # id : ('compartment', 'value', 'unit')
    'e__gal':       ('e', 0.00012, 'mM'),
    'e__galM':      ('e', 0.0, 'mM'),
    'e__h2oM':      ('e', 0.0, 'mM'),
    'h__h2oM':      ('h', 0.0, 'mM'),
    'c__gal':       ('c', 0.00012, 'mM'),
    'c__galM':      ('c', 0.0, 'mM'),
    'c__glc1p':     ('c', 0.012, 'mM'),
    'c__glc1pM':    ('c', 0.0, 'mM'),
    'c__glc6p':     ('c', 0.12, 'mM'),
    'c__glc6pM':    ('c', 0.0, 'mM'),
    'c__gal1p':     ('c', 0.001, 'mM'),
    'c__gal1pM':    ('c', 0.0, 'mM'),
    'c__udpglc':    ('c', 0.34, 'mM'),
    'c__udpglcM':   ('c', 0.0, 'mM'),
    'c__udpgal':    ('c', 0.11, 'mM'),
    'c__udpgalM':   ('c', 0.0, 'mM'),
    'c__galtol':    ('c', 0.001, 'mM'),
    'c__galtolM':   ('c', 0.0, 'mM'),
    
    'c__atp':       ('c', 2.7, 'mM'),
    'c__adp':       ('c', 1.2, 'mM'),
    'c__utp':       ('c', 0.27, 'mM'),
    'c__udp':       ('c', 0.09, 'mM'),
    'c__phos':      ('c', 5.0, 'mM'),
    'c__ppi':       ('c', 0.008, 'mM'),
    'c__nadp':      ('c', 0.1, 'mM'),
    'c__nadph':     ('c', 0.1, 'mM')
})
names.update({
    'rbcM': 'red blood cells M*',
    'suc': 'sucrose',
    'alb': 'albumin',
    'h2oM': 'water M*',
    'glc': 'D-glucose',
    'gal': 'D-galactose',
    'galM': 'D-galactose M*',
    'glc1p': 'D-glucose 1-phophate',
    'glc1pM': 'D-glucose 1-phophate M*',
    'glc6p': 'D-glucose 6-phosphate',
    'glc6pM': 'D-glucose 6-phosphate M*',
    'gal1p': 'D-galactose 1-phosphate',
    'gal1pM': 'D-galactose 1-phosphate M*',
    'udpglc': 'UDP-D-glucose',
    'udpglcM': 'UDP-D-glucose M*',
    'udpgal': 'UDP-D-galactose',
    'udpgalM': 'UDP-D-galactose M*',
    'galtol': 'D-galactitol',
    'galtolM': 'D-galactitol M*',
    'atp': 'ATP',
    'adp': 'ADP',
    'utp': 'UTP',
    'udp': 'UDP',
    'phos': 'phosphate',
    'ppi': 'pyrophosphate',
    'nadp': 'NADP',
    'nadph': 'NADPH',
})

##############################################################
# Parameters
##############################################################
parameters.update({
    # id: ('value', 'unit', 'constant')
    'scale_f':      (0.31, 'per_m3', True),
    'REF_P':        (1.0, 'mM', True),
    'deficiency':   (0, '-', True),
    'y_cell':       (9.40E-6, 'm', True),
    'x_cell':       (25E-6, 'm', True),
    'f_tissue':     (0.8, '-', True),
    'f_cyto':       (0.4, '-', True),
    'Nf':           (1, '-', True),
})
names.update({
    'scale_f': 'metabolic scaling factor',
    'REF_P': 'reference protein amount',
    'deficiency': 'type of galactosemia',
    'y_cell': 'width hepatocyte',
    'x_cell': 'length hepatocyte',
    'f_tissue': 'parenchymal fraction of liver',
    'f_cyto': 'cytosolic fraction of hepatocyte'
})

##############################################################
# Assignments
##############################################################
assignments.update({
    # id: ('assignment', 'unit')
    'Vol_h': ('x_cell*x_cell*y_cell', 'm3'),
    'Vol_e': ('Vol_h', 'm3'),
    'Vol_c': ('f_cyto*Vol_h', 'm3'),
})
names.update({
    'Vol_h': 'volume hepatocyte',
    'Vol_c': 'volume cytosol',
    'Vol_e': 'volume external compartment',
})

##############################################################
# Rules
##############################################################
rules.update({
    # id: ('rule', 'unit')
    'c__scale': ('scale_f * Vol_h', '-'),
            
    'e__gal_tot': ('e__gal + e__galM', 'mM'),
    'c__gal_tot': ('c__gal + c__galM', 'mM'),
    'c__glc1p_tot': ('c__glc1p + c__glc1pM', 'mM'),
    'c__glc6p_tot': ('c__glc6p + c__glc6pM', 'mM'),
    'c__gal1p_tot': ('c__gal1p + c__gal1pM', 'mM'),
    'c__udpglc_tot': ('c__udpglc + c__udpglcM', 'mM'),
    'c__udpgal_tot': ('c__udpgal + c__udpgalM', 'mM'),
    'c__galtol_tot': ('c__galtol + c__galtolM', 'mM'),
            
    'c__nadp_bal': ('c__nadp + c__nadph', 'mM'),
    'c__adp_bal': ('c__atp + c__adp', 'mM'),
    'c__udp_bal': ('c__utp + c__udp + c__udpglc + c__udpgal + c__udpglcM + c__udpgalM', 'mM'),
    'c__phos_bal': ('3 dimensionless *c__atp + 2 dimensionless *c__adp + 3 dimensionless *c__utp + 2 dimensionless *c__udp' +
                    '+ c__phos + 2 dimensionless *c__ppi + c__glc1p + c__glc6p + c__gal1p + 2 dimensionless*c__udpglc + 2 dimensionless *c__udpgal' +
                    '+ c__glc1pM + c__glc6pM + c__gal1pM + 2 dimensionless*c__udpglcM + 2 dimensionless *c__udpgalM', 'mM'),
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
    GALK, GALKM,
    IMP, IMPM,
    ATPS,
    ALDR, ALDRM,
    NADPR,
    GALT, GALTM1, GALTM2, GALTM3,
    GALE, GALEM,
    UGP, UGPM,
    UGALP, UGALPM,
    PPASE,
    NDKU,
    PGM1, PGM1M,
    GLY, GLYM,
    GTFGAL, GTFGALM,
    GTFGLC, GTFGLCM,
    H2OTM, GLUT2_GAL, GLUT2_GALM
])

