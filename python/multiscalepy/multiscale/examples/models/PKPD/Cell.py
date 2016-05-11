# -*- coding=utf-8 -*-
"""
PKPD example model
"""
from libsbml import UNIT_KIND_METRE, UNIT_KIND_SECOND, UNIT_KIND_LITRE, UNIT_KIND_GRAM
from libsbml import XMLNode
from ..templates import terms_of_use, mkoenig

##############################################################
mid = 'PKPD model'
version = 1
notes = XMLNode.convertStringToXMLNode("""
    <body xmlns='http://www.w3.org/1999/xhtml'>
    <h1>Jones2013 - PKPD</h1>
    <h2>Description</h2>
    <p>
        This model is an example physiologically based pharmakokinetic model (PKPD) encoded in <a href="http://sbml.org">SBML</a> format.
        <img src="Jones2013_PKPD.png"></img><br />
        The model is available in the supplement of the article:
    </p>
    <div class="bibo:title">
        <a href="http://identifiers.org/pubmed/23945604" title="Access to this publication">Basic Concepts in Physiologically Based Pharmacokinetic Modeling in Drug Discovery and Development.</a>
    </div>
    <div class="bibo:authorList">HM Jones and K Rowland-Yeo</div>
    <div class="bibo:Journal">CPT Pharmacometrics Syst Pharmacol. 2013 Aug 14;2:e63. doi: 10.1038/psp.2013.41.</div>
    <p></p>
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
    'kg': [(UNIT_KIND_GRAM, 1.0, 3, 1.0)],
    'm': [(UNIT_KIND_METRE, 1.0)],
    'm2': [(UNIT_KIND_METRE, 2.0)],

    'per_h': [(UNIT_KIND_SECOND, -1.0, 0, 3600)],

    'mg': [(UNIT_KIND_GRAM, 1.0, -3, 1.0)],
    'mg_per_litre': [(UNIT_KIND_GRAM, 1.0, -3, 1.0),
                   (UNIT_KIND_LITRE, -1.0, 0, 1.0)],
    'mg_per_g': [(UNIT_KIND_GRAM, 1.0, -3, 1.0),
                     (UNIT_KIND_GRAM, -1.0, 0, 1.0)],
    'mg_per_h': [(UNIT_KIND_GRAM, 1.0, -3, 1.0),
                 (UNIT_KIND_SECOND, -1.0, 0, 3600)],

    'litre_per_h': [(UNIT_KIND_LITRE, 1.0, 0, 1.0),
                     (UNIT_KIND_SECOND, -1.0, 0, 3600)],
    'litre_per_kg': [(UNIT_KIND_LITRE, 1.0, 0, 1.0),
                     (UNIT_KIND_GRAM, -1.0, 3, 1.0)],
    'mulitre_per_min_mg': [(UNIT_KIND_LITRE, 1.0, -6, 1.0),
                           (UNIT_KIND_SECOND, -1.0, 0, 60), (UNIT_KIND_GRAM, -1.0, -3, 1.0)],
    'ml_per_s': [(UNIT_KIND_LITRE, 1.0, -3, 1.0),
                 (UNIT_KIND_SECOND, -1.0, 0, 1)],

    # conversion factors
    's_per_h': [(UNIT_KIND_SECOND, 1.0, 0, 1.0),
                (UNIT_KIND_SECOND, -1.0, 0, 3600)],
    'min_per_h': [(UNIT_KIND_SECOND, 1.0, 0, 60),
                  (UNIT_KIND_SECOND, -1.0, 0, 3600)],

    'ml_per_litre': [(UNIT_KIND_LITRE, 1.0, -3, 1.0),
                     (UNIT_KIND_LITRE, -1.0, 0, 1)],
    'mulitre_per_g': [(UNIT_KIND_LITRE, 1.0, -6, 1.0),
                      (UNIT_KIND_GRAM, -1.0, 0, 1)],

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
    'Vad': (3, UNIT_KIND_LITRE, False, 1),
    'Vbo': (3, UNIT_KIND_LITRE, False, 1),
    'Vbr': (3, UNIT_KIND_LITRE, False, 1),
    'Vgu': (3, UNIT_KIND_LITRE, False, 1),
    'Vhe': (3, UNIT_KIND_LITRE, False, 1),
    'Vki': (3, UNIT_KIND_LITRE, False, 1),
    'Vli': (3, UNIT_KIND_LITRE, False, 1),
    'Vlu': (3, UNIT_KIND_LITRE, False, 1),
    'Vmu': (3, UNIT_KIND_LITRE, False, 1),
    'Vsk': (3, UNIT_KIND_LITRE, False, 1),
    'Vsp': (3, UNIT_KIND_LITRE, False, 1),
    'Vte': (3, UNIT_KIND_LITRE, False, 1),
    'Vve': (3, UNIT_KIND_LITRE, False, 1),
    'Var': (3, UNIT_KIND_LITRE, False, 1),
    'Vpl': (3, UNIT_KIND_LITRE, False, 1),
    'Vrb': (3, UNIT_KIND_LITRE, False, 1),
    'Vre': (3, UNIT_KIND_LITRE, False, 1),
    'Vplas_ven': (3, UNIT_KIND_LITRE, False, 1),
    'Vplas_art': (3, UNIT_KIND_LITRE, False, 1),
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
    'Cad': ('Vad', 0, 'mg_per_litre', False),
    'Cbo': ('Vbo', 0, 'mg_per_litre', False),
    'Cbr': ('Vbr', 0, 'mg_per_litre', False),
    'Cgu': ('Vgu', 0, 'mg_per_litre', False),
    'Che': ('Vhe', 0, 'mg_per_litre', False),
    'Cki': ('Vki', 0, 'mg_per_litre', False),
    'Cli': ('Vli', 0, 'mg_per_litre', False),
    'Clu': ('Vlu', 0, 'mg_per_litre', False),
    'Cmu': ('Vmu', 0, 'mg_per_litre', False),
    'Csk': ('Vsk', 0, 'mg_per_litre', False),
    'Csp': ('Vsp', 0, 'mg_per_litre', False),
    'Cte': ('Vte', 0, 'mg_per_litre', False),
    'Cve': ('Vve', 0, 'mg_per_litre', False),
    'Car': ('Var', 0, 'mg_per_litre', False),
    'Cre': ('Vre', 0, 'mg_per_litre', False),
})

names.update({
    'Cad': 'C [mg/l] adipose',
    'Cbo': 'C [mg/l] bone',
    'Cbr': 'C [mg/l] brain',
    'Cgu': 'C [mg/l] gut',
    'Che': 'C [mg/l] heart',
    'Cki': 'C [mg/l] kidney',
    'Cli': 'C [mg/l] liver',
    'Clu': 'C [mg/l] lung',
    'Cmu': 'C [mg/l] muscle',
    'Csk': 'C [mg/l] skin',
    'Csp': 'C [mg/l] spleen',
    'Cte': 'C [mg/l] testes',
    'Cve': 'C [mg/l] venous blood',
    'Car': 'C [mg/l] arterial blood',
    'Cre': 'C [mg/l] rest of body',
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
    'CLrenal': (0, 'litre_per_h', True),
    'MPPGL': (45, 'mg_per_g', True),

    # absorption
    'Ka': (1, 'per_h', True),
    'F': (1, '-', True),

    # dosing
    'Ave': (0, 'mg', False),
    'D': (0, 'mg', False),
    'DCL': (0, 'mg', False),
    'IVDOSE': (0, 'mg', True),
    'PODOSE': (100, 'mg', True),

    # whole body data
    'BW': (70, 'kg', True),
    'CO': (108.33, 'ml_per_s', True),
    'QC': (108.33*1000*60*60, 'litre_per_h', False),

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
    'FQad': (0.05, '-', True),
    'FQbo': (0.05, '-', True),
    'FQbr': (0.12, '-', True),
    'FQgu': (0.146462, '-', True),
    'FQhe': (0.04, '-', True),
    'FQki': (0.19, '-', True),
    'FQh': (0.215385, '-', True),
    'FQlu': (1, '-', True),
    'FQmu': (0.17, '-', True),
    'FQsk': (0.05, '-', True),
    'FQsp': (0.017231, '-', True),
    'FQte': (0.01076, '-', True),
    'FQre': (0.103855, '-', True),

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

    # amounts
    'Aad': (0, 'mg', False),
    'Abo': (0, 'mg', False),
    'Abr': (0, 'mg', False),
    'Agu': (0, 'mg', False),
    'Ahe': (0, 'mg', False),
    'Aki': (0, 'mg', False),
    'Ali': (0, 'mg', False),
    'Alu': (0, 'mg', False),
    'Amu': (0, 'mg', False),
    'Ask': (0, 'mg', False),
    'Asp': (0, 'mg', False),
    'Ate': (0, 'mg', False),
    'Aar': (0, 'mg', False),
    'Are': (0, 'mg', False),
})
names.update({
    'fup': 'fraction unbound in plasma',
    'BP': 'blood to plasma ratio',
    'fumic': 'fraction unbound in microsomes',

    'HLM_CLint': 'HLM CLint apparent [mul/min/mg]',
    'CLrenal': 'CLint renal [L/hr]',

    'Ka': 'Ka [1/hr] absorption',
    'F': 'fraction absorbed',
    'MPPGL': 'mg microsomal protein per g liver',

    'IVDOSE': 'IV bolus dose [mg]',
    'PODOSE': 'oral bolus dose [mg]',
    'D': 'oral dose [mg]',

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
    'Ave': ('IVDOSE', 'mg'),
    'D': ('PODOSE', 'mg'),
})

##############################################################
# Rules
##############################################################

rules.update({
    # id: ('value', 'unit')

    # free concentrations
    'Cpl_ve': ('Cve/BP', 'mg_per_litre'),
    'Cli_free': ('Cli*fup', 'mg_per_litre'),
    'Cki_free': ('Cki*fup', 'mg_per_litre'),

    # clearance
    'CLmet': ('(HLM_CLint/fumic) * MPPGL * Vli * 60 min_per_h / 1000 mulitre_per_g', 'litre_per_h'),

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
    'QC': ('CO/1000 ml_per_litre * 3600 s_per_h', 'litre_per_h'),
    'Qad': ('QC*FQad', 'litre_per_h'),
    'Qbo': ('QC*FQbo', 'litre_per_h'),
    'Qbr': ('QC*FQbr', 'litre_per_h'),
    'Qgu': ('QC*FQgu', 'litre_per_h'),
    'Qhe': ('QC*FQhe', 'litre_per_h'),
    'Qki': ('QC*FQki', 'litre_per_h'),
    'Qh': ('QC*FQh', 'litre_per_h'),
    'Qha': ('Qh - Qgu - Qsp', 'litre_per_h'),
    'Qlu': ('QC*FQlu', 'litre_per_h'),
    'Qmu': ('QC*FQmu', 'litre_per_h'),
    'Qsk': ('QC*FQsk', 'litre_per_h'),
    'Qsp': ('QC*FQsp', 'litre_per_h'),
    'Qte': ('QC*FQte', 'litre_per_h'),
    'Qre': ('QC*FQre', 'litre_per_h'),

    # rates
    'Absorption': ('Ka*D*F', 'mg_per_h'),
    'Venous': ('Qad*(Cad/Kpad*BP) + Qbo*(Cbo/Kpbo*BP) + Qbr*(Cbr/Kpbr*BP) + '
               'Qhe*(Che/Kphe*BP) + Qki*(Cki/Kpki*BP) + Qh*(Cli/Kpli*BP) + '
               'Qmu*(Cmu/Kpmu*BP) + Qsk*(Csk/Kpsk*BP) + Qte*(Cte/Kpte*BP) + '
               'Qre*(Cre/Kpre*BP)', 'mg_per_h'),

    # total substance
    'Abody': ('Aad + Aar + Abo + Abr + Agu + Ahe + Aki + Ali + Alu + Amu + Ask + Asp + Ate + Are + Ave ', 'mg')

})
names.update({
    'Cli_free': 'free liver concentration',
    'Cki_free': 'free kidney concentration',

    'CLmet': 'CLint scaled [l/hr]',

    'Qad': 'adipose blood flow',
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
    'Aad': ('Qad * (Car - Cad/Kpad*BP)', 'mg_per_h'),
    'Abo': ('Qbo * (Car - Cbo/Kpbo*BP)', 'mg_per_h'),
    'Abr': ('Qbr * (Car - Cbr/Kpbr*BP)', 'mg_per_h'),
    'Agu': ('Absorption + Qgu*(Car - Cgu/Kpgu*BP)', 'mg_per_h'),
    'Ahe': ('Qhe*(Car - Che/Kphe*BP)', 'mg_per_h'),
    'Aki': ('Qki*(Car - Cki/Kpki*BP) - CLrenal*Cki_free', 'mg_per_h'),
    'Ali': ('Qha*Car + Qgu*(Cgu/Kpgu*BP) + Qsp*(Csp/Kpsp*BP) - Qh*(Cli/Kpli*BP) - Cli_free*CLmet', 'mg_per_h'),
    'Alu': ('Qlu*Cve - Qlu*(Clu/Kplu*BP)', 'mg_per_h'),
    'Amu': ('Qmu*(Car - Cmu/Kpmu*BP)', 'mg_per_h'),
    'Ask': ('Qsk*(Car - Csk/Kpsk*BP)', 'mg_per_h'),
    'Asp': ('Qsp*(Car - Csp/Kpsp*BP)', 'mg_per_h'),
    'Ate': ('Qte*(Car - Cte/Kpte*BP)', 'mg_per_h'),
    'Ave': ('Venous - Qlu*Cve', 'mg_per_h'),
    'Aar': ('Qlu*(Clu/Kplu*BP) - Qlu*Car', 'mg_per_h'),
    'Are': ('Qre*(Car - Cre/Kpre*BP)', 'mg_per_h'),

    'D': ('-Absorption', 'mg_per_h'),
    'DCL': ('CLrenal*Cki_free + Cli_free*CLmet', 'mg_per_h'),
})


##############################################################
# Reactions
##############################################################
from Reactions import AR2AD, AD2VE
# reactions.extend([AR2AD, AD2VE])
