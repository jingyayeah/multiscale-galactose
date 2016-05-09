# -*- coding=utf-8 -*-
"""
PKPD example model
"""
from libsbml import UNIT_KIND_METRE, UNIT_KIND_SECOND, UNIT_KIND_LITRE
from libsbml import UNIT_KIND_GRAM, UNIT_KIND_KATAL, UNIT_KIND_DIMENSIONLESS
from libsbml import XMLNode
from ..templates import terms_of_use, mkoenig

##############################################################
mid = 'Jones2013'
version = 1
notes = XMLNode.convertStringToXMLNode("""
    <body xmlns='http://www.w3.org/1999/xhtml'>
    <h1>Jones2013</h1>
    <h2>Description</h2>
    <p>
        This is a PKPD model in <a href="http://sbml.org">SBML</a> format.
    </p>
    <p>This model is described in the supplement of the article:</p>
    <div class="bibo:title">
        <a href="http://identifiers.org/pubmed/23945604" title="Access to this publication">Basic Concepts in Physiologically Based Pharmacokinetic Modeling in Drug Discovery and Development.</a>
    </div>
    <div class="bibo:authorList">HM Jones and K Rowland-Yeo</div>
    <div class="bibo:Journal">CPT Pharmacometrics Syst Pharmacol. 2013 Aug 14;2:e63. doi: 10.1038/psp.2013.41.</div>
    <p>Abstract:</p>
    <div class="bibo:abstract">
    <p></p>
    <div class="bibo:title">
        <a href="http://identifiers.org/pubmed/2035636" title="Access to this publication">Basic Concepts in Physiologically Based Pharmacokinetic Modeling in Drug Discovery and Development.</a>
    </div>
    """ + terms_of_use + """
    </body>
    """)

creators = mkoenig
main_units = {
    'time': 'h',
    'extent': 'mg',
    'substance': 'mg',
    'length': 'm',
    'area': 'm2',
    'volume': UNIT_KIND_LITRE,
}
units = dict()
functions = dict()
compartments = dict()
species = dict()
parameters = dict()
names = dict()
assignments = dict()
rules = dict()
rate_rules = dict()
reactions = []

#########################################################################
# Units
##########################################################################
# units (kind, exponent, scale=0, multiplier=1.0)
units.update({
    'h': [(UNIT_KIND_SECOND, 1.0, 0, 3600)],

    'm': [(UNIT_KIND_METRE, 1.0)],
    'm2': [(UNIT_KIND_METRE, 2.0)],

    'mg': [(UNIT_KIND_GRAM, 1.0, -3, 1.0)],
    'mg_per_min': [(UNIT_KIND_GRAM, 1.0, -3, 1.0),
                   (UNIT_KIND_SECOND, -1.0, 0, 60)],
    'mg_per_l': [(UNIT_KIND_GRAM, 1.0, -3, 1.0),
                   (UNIT_KIND_LITRE, -1.0, 0, 1.0)],

    'kg'
    'litre_per_kg'

    'mU': [(UNIT_KIND_KATAL, 1.0, -12, 16.67)],
    'mU_per_min': [(UNIT_KIND_KATAL, 1.0, -12, 16.67),
                   (UNIT_KIND_SECOND, -1.0, 0, 60)],
    'mU_per_l': [(UNIT_KIND_KATAL, 1.0, -12, 16.67),
                 (UNIT_KIND_LITRE, -1.0, 0, 1.0)],
    'l_per_mU': [(UNIT_KIND_LITRE, 1.0, 0, 1.0),
                 (UNIT_KIND_KATAL, -1.0, -12, 16.67)],

    'l_per_min': [(UNIT_KIND_LITRE, 1.0),
                  (UNIT_KIND_SECOND, -1.0, 0, 60)],

})

##############################################################
# Functions
##############################################################
functions.update({
    # id : ('assignment')
})
names.update({
})

##############################################################
# Compartments
##############################################################
compartments.update({
    # id : ('spatialDimension', 'unit', 'constant', 'assignment')
    'Vad': (3, UNIT_KIND_LITRE, True, '0 litre'),
    'Vbo': (3, UNIT_KIND_LITRE, True, '0 litre'),
    'Vbr': (3, UNIT_KIND_LITRE, True, '0 litre'),
    'Vgu': (3, UNIT_KIND_LITRE, True, '0 litre'),
    'Vhe': (3, UNIT_KIND_LITRE, True, '0 litre'),
    'Vki': (3, UNIT_KIND_LITRE, True, '0 litre'),
    'Vli': (3, UNIT_KIND_LITRE, True, '0 litre'),
    'Vlu': (3, UNIT_KIND_LITRE, True, '0 litre'),
    'Vmu': (3, UNIT_KIND_LITRE, True, '0 litre'),
    'Vsk': (3, UNIT_KIND_LITRE, True, '0 litre'),
    'Vsp': (3, UNIT_KIND_LITRE, True, '0 litre'),
    'Vte': (3, UNIT_KIND_LITRE, True, '0 litre'),
    'Vve': (3, UNIT_KIND_LITRE, True, '0 litre'),
    'Var': (3, UNIT_KIND_LITRE, True, '0 litre'),
    'Vpl': (3, UNIT_KIND_LITRE, True, '0 litre'),
    'Vrb': (3, UNIT_KIND_LITRE, True, '0 litre'),
    'Vre': (3, UNIT_KIND_LITRE, True, '0 litre'),
    'Vplas_ven': (3, UNIT_KIND_LITRE, True, '0 litre'),
    'Vplas_art': (3, UNIT_KIND_LITRE, True, '0 litre'),
})

names.update({
    'Vad': 'adipose',
    'Vbo': 'bone',
    'Vbr': 'brain',
    'Vgu': 'gut',
    'Vhe': 'heart',
    'Vki': 'kidney',
    'Vli': 'liver',
    'Vlu': 'lung',
    'Vmu': 'muscle',
    'Vsk': 'skin',
    'Vsp': 'spleen',
    'Vte': 'testes',
    'Vve': 'venous blood',
    'Var': 'arterial blood',
    'Vpl': 'plasma',
    'Vrb': 'erythrocytes',
    'Vre': 'rest of body',
    'Vplas_ven': 'venous_plasma',
    'Vplas_art': 'arterial_plasma',
})

##############################################################
# Species
##############################################################
species.update({
    # id : ('compartment', 'value', 'unit', 'boundaryCondition')
})
names.update({

})

##############################################################
# Parameters
##############################################################
parameters.update({
    # id: ('value', 'unit', 'constant')

    # in vitro binding data
    'fup': (1, '-', True),
    'BP': (1, '-', True),
    'fumic': (1, '-', True),

    # clearances
    'HLM_CLint': (10, 'mulitre_per_min_mg', True),
    'CLrenal': (0, 'litre_per_hr', True),

    # absorption
    'Ka': (1, 'per_hr', True),
    'F': (1, '-', True),

    # dosing
    'IVDOSE': (0, 'mg', True),
    'PODOSE': (100, 'mg', True),

    # whole body data
    'BW': (70, 'kg', True),
    'CO': (108.33, 'ml_per_s', True),
    'QC': (108.33*1000*60*60, 'litre_per_hr', True),

    # fractional tissue volumes
    'FVad': (0.213, 'litre_per_kg', True),
    'FVbo': (0.085629, 'litre_per_kg', True),
    'FVbr': (0.02, 'litre_per_kg', True),
    'FVgu': (0.0171, 'litre_per_kg', True),
    'FVhe': (0.0047, 'litre_per_kg', True),
    'FVki': (0.0044, 'litre_per_kg', True),
    'FVli': (0.021, 'litre_per_kg', True),
    'FVlu': (0.0076, 'litre_per_kg', True),
    'FVmu': (0.4, 'litre_per_kg', True),
    'FVsk': (0.0371, 'litre_per_kg', True),
    'FVsp': (0.0026, 'litre_per_kg', True),
    'FVte': (0.01, 'litre_per_kg', True),
    'FVve': (0.0514, 'litre_per_kg', True),
    'FVar': (0.0257, 'litre_per_kg', True),
    'FVpl': (0.0424, 'litre_per_kg', True),
    'FVrb': (0.0347, 'litre_per_kg', True),
    'FVre': (0.099771, 'litre_per_kg', True),

    # fractional tissue blood flows
    'FQad': (0.05, 'litre_per_hr_kg', True),
    'FQbo': (0.05, 'litre_per_hr_kg', True),
    'FQbr': (0.12, 'litre_per_hr_kg', True),
    'FQgu': (0.146462, 'litre_per_hr_kg', True),
    'FQhe': (0.04, 'litre_per_hr_kg', True),
    'FQki': (0.19, 'litre_per_hr_kg', True),
    'FQh': (0.215385, 'litre_per_hr_kg', True),
    'FQlu': (1, 'litre_per_hr_kg', True),
    'FQmu': (0.17, 'litre_per_hr_kg', True),
    'FQsk': (0.05, 'litre_per_hr_kg', True),
    'FQsp': (0.017231, 'litre_per_hr_kg', True),
    'FQte': (0.01076, 'litre_per_hr_kg', True),
    'FQre': (0.103855, 'litre_per_hr_kg', True),

    # tissue to plasma partition coefficients
    'Kpad': (1, '-', True),
    'Kpbo': (1, '-', True),
    'Kpbr': (1, '-', True),
    'Kpgu': (1, '-', True),
    'Kphe': (1, '-', True),
    'Kpki': (1, '-', True),
    'Kpli': (1, '-', True),
    'Kplu': (1, '-', True),
    'Kpmu': (1, '-', True),
    'Kpsk': (1, '-', True),
    'Kpsp': (1, '-', True),
    'Kpte': (1, '-', True),
    'Kpre': (1, '-', True),

})
names.update({
    'fup': 'fraction unbound in plasma',
    'BP': 'blood to plasma ratio',
    'fumic': 'fraction unbound in microsomes',

    'HLM_CLint': 'HLM CLint apparent [µl/min/mg]',
    'CLrenal': 'CLint renal [L/hr]',

    'Ka': 'Ka [1/hr] absorption',
    'F': 'fraction absorbed',

    'IVDOSE': 'IV Bolus Dose [mg]',
    'PODOSE': 'Oral Bolus Dose [mg]',

    'BW': 'body weight',
    'CO': 'cardiac output [ml/s]',
    'QC': 'cardiac output [L/hr]',

    'FVad': 'adipose fractional tissue volume',
    'FVbo': 'bone fractional tissue volume',
    'FVbr': 'brain fractional tissue volume',
    'FVgu': 'gut fractional tissue volume',
    'FVhe': 'heart fractional tissue volume',
    'FVki': 'kidney fractional tissue volume',
    'FVli': 'liver fractional tissue volume',
    'FVlu': 'lung fractional tissue volume',
    'FVmu': 'muscle fractional tissue volume',
    'FVsk': 'skin fractional tissue volume',
    'FVsp': 'spleen fractional tissue volume',
    'FVte': 'testes fractional tissue volume',
    'FVve': 'venous fractional tissue volume',
    'FVar': 'arterial fractional tissue volume',
    'FVpl': 'plasma fractional tissue volume',
    'FVrb': 'erythrocytes fractional tissue volume',
    'FVre': 'rest of body fractional tissue volume',

    'FQad': 'adipose fractional tissue blood flow',
    'FQbo': 'bone fractional tissue blood flow',
    'FQbr': 'brain fractional tissue blood flow',
    'FQgu': 'gut fractional tissue blood flow',
    'FQhe': 'heart fractional tissue blood flow',
    'FQki': 'kidney fractional tissue blood flow',
    'FQh': 'hepatic (venous side) fractional tissue blood flow',
    'FQlu': 'lung fractional tissue blood flow',
    'FQmu': 'muscle fractional tissue blood flow',
    'FQsk': 'skin fractional tissue blood flow',
    'FQsp': 'spleen fractional tissue blood flow',
    'FQte': 'testes fractional tissue blood flow',
    'FQre': 'rest of body fractional tissue blood flow',

    'Kpad': 'adipose tissue plasma partition coefficient',
    'Kpbo': 'bone tissue plasma partition coefficient',
    'Kpbr': 'brain tissue plasma partition coefficient',
    'Kpgu': 'gut tissue plasma partition coefficient',
    'Kphe': 'heart tissue plasma partition coefficient',
    'Kpki': 'kidney tissue plasma partition coefficient',
    'Kpli': 'liver tissue plasma partition coefficient',
    'Kplu': 'lung tissue plasma partition coefficient',
    'Kpmu': 'muscle tissue plasma partition coefficient',
    'Kpsk': 'skin tissue plasma partition coefficient',
    'Kpsp': 'spleen tissue plasma partition coefficient',
    'Kpte': 'testes tissue plasma partition coefficient',
    'Kpre': 'rest of body tissue plasma partition coefficient',
})

##############################################################
# Assignments
##############################################################
assignments.update({
    # id: ('value', 'unit')

})

##############################################################
# Rules
##############################################################

rules.update({
    # id: ('value', 'unit')

    'CO': ('CO/1000*60*60', 'litre_per_hr'),

    # volumes
    'Vad': ('BW*FVad', UNIT_KIND_LITRE),
    'Vbo': ('BW*FVbo', UNIT_KIND_LITRE),
    'Vbr': ('BW*FVbr', UNIT_KIND_LITRE),
    'Vgu': ('BW*FVgu', UNIT_KIND_LITRE),
    'Vhe': ('BW*FVhe', UNIT_KIND_LITRE),
    'Vki': ('BW*FVki', UNIT_KIND_LITRE),
    'Vli': ('BW*FVli', UNIT_KIND_LITRE),
    'Vlu': ('BW*FVlu', UNIT_KIND_LITRE),
    'Vmu': ('BW*FVmu', UNIT_KIND_LITRE),
    'Vsk': ('BW*FVsk', UNIT_KIND_LITRE),
    'Vsp': ('BW*FVsp', UNIT_KIND_LITRE),
    'Vte': ('BW*FVte', UNIT_KIND_LITRE),
    'Vve': ('BW*FVve', UNIT_KIND_LITRE),
    'Var': ('BW*FVar', UNIT_KIND_LITRE),
    'Vpl': ('BW*FVpl', UNIT_KIND_LITRE),
    'Vrb': ('BW*FVrb', UNIT_KIND_LITRE),
    'Vre': ('BW*FVre', UNIT_KIND_LITRE),
    'Vplas_ven': ('Vpl*Vve/(Vve + Var)', UNIT_KIND_LITRE),
    'Vplas_art': ('Vpl*Var/(Vve + Var)', UNIT_KIND_LITRE),

    # blood flows
    'Qad': ('QC*FQad', 'litre_per_hr'),
    'Qbo': ('QC*FQbo', 'litre_per_hr'),
    'Qbr': ('QC*FQbr', 'litre_per_hr'),
    'Qgu': ('QC*FQgu', 'litre_per_hr'),
    'Qhe': ('QC*FQhe', 'litre_per_hr'),
    'Qki': ('QC*FQki', 'litre_per_hr'),
    'Qh': ('QC*FQh', 'litre_per_hr'),
    'Qha': ('Qh - Qgu - Qsp', 'litre_per_hr'),
    'Qlu': ('QC*FQlu', 'litre_per_hr'),
    'Qmu': ('QC*FQmu', 'litre_per_hr'),
    'Qsk': ('QC*FQsk', 'litre_per_hr'),
    'Qsp': ('QC*FQsp', 'litre_per_hr'),
    'Qte': ('QC*FQte', 'litre_per_hr'),
    'Qre': ('QC*FQre', 'litre_per_hr'),
})
names.update({
    'Qad' : 'adipose blood flow',
    'Qbo': 'bone blood flow',
    'Qbr': 'brain blood flow',
    'Qgu': 'gut blood flow',
    'Qhe': 'heart blood flow',
    'Qki': 'kidney blood flow',
    'Qh': 'hepatic (venous side) blood flow',
    'Qha': 'hepatic artery blood flow',
    'Qlu': 'lung blood flow',
    'Qmu': 'muscle blood flow',
    'Qsk': 'skin blood flow',
    'Qsp': 'spleen blood flow',
    'Qte': 'testes blood flow',
    'Qre': 'rest of body blood flow',
})

rate_rules.update({

})


##############################################################
# Reactions
##############################################################
import Reactions
reactions.extend([])
