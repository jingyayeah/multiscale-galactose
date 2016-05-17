# -*- coding=utf-8 -*-
"""
PKPD example model
"""
from libsbml import UNIT_KIND_METRE, UNIT_KIND_SECOND, UNIT_KIND_LITRE, UNIT_KIND_GRAM
from libsbml import XMLNode
from sbmlutils.modelcreator import templates
import sbmlutils.modelcreator.modelcreator as mc

##############################################################
mid = 'pkpd'
version = 2
notes = XMLNode.convertStringToXMLNode("""
    <body xmlns='http://www.w3.org/1999/xhtml'>
    <h1>Minimal PKPD model for liver clearance.</h1>
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
    """ + templates.terms_of_use + """
    </body>
    """)

creators = templates.creators
main_units = {
    'time': 'h',
    'extent': 'mg',
    'substance': 'mg',
    'length': 'm',
    'area': 'm2',
    'volume': UNIT_KIND_LITRE,
}

#########################################################################
# Units
##########################################################################
# units (kind, exponent, scale=0, multiplier=1.0)
units = [
    mc.Unit('h', [(UNIT_KIND_SECOND, 1.0, 0, 3600)]),
    mc.Unit('kg', [(UNIT_KIND_GRAM, 1.0, 3, 1.0)]),
    mc.Unit('m', [(UNIT_KIND_METRE, 1.0)]),
    mc.Unit('m2', [(UNIT_KIND_METRE, 2.0)]),
    mc.Unit('per_h', [(UNIT_KIND_SECOND, -1.0, 0, 3600)]),

    mc.Unit('mg', [(UNIT_KIND_GRAM, 1.0, -3, 1.0)]),
    mc.Unit('mg_per_litre', [(UNIT_KIND_GRAM, 1.0, -3, 1.0),
                   (UNIT_KIND_LITRE, -1.0, 0, 1.0)]),
    mc.Unit('mg_per_g', [(UNIT_KIND_GRAM, 1.0, -3, 1.0),
                     (UNIT_KIND_GRAM, -1.0, 0, 1.0)]),
    mc.Unit('mg_per_h', [(UNIT_KIND_GRAM, 1.0, -3, 1.0),
                 (UNIT_KIND_SECOND, -1.0, 0, 3600)]),

    mc.Unit('litre_per_h', [(UNIT_KIND_LITRE, 1.0, 0, 1.0),
                     (UNIT_KIND_SECOND, -1.0, 0, 3600)]),
    mc.Unit('litre_per_kg', [(UNIT_KIND_LITRE, 1.0, 0, 1.0),
                     (UNIT_KIND_GRAM, -1.0, 3, 1.0)]),
    mc.Unit('mulitre_per_min_mg', [(UNIT_KIND_LITRE, 1.0, -6, 1.0),
                           (UNIT_KIND_SECOND, -1.0, 0, 60), (UNIT_KIND_GRAM, -1.0, -3, 1.0)]),

    mc.Unit('ml_per_s', [(UNIT_KIND_LITRE, 1.0, -3, 1.0),
                         (UNIT_KIND_SECOND, -1.0, 0, 1)]),

    mc.Unit('s_per_h', [(UNIT_KIND_SECOND, 1.0, 0, 1.0),
                (UNIT_KIND_SECOND, -1.0, 0, 3600)]),
    mc.Unit('min_per_h', [(UNIT_KIND_SECOND, 1.0, 0, 60),
                  (UNIT_KIND_SECOND, -1.0, 0, 3600)]),

    mc.Unit('ml_per_litre', [(UNIT_KIND_LITRE, 1.0, -3, 1.0),
                     (UNIT_KIND_LITRE, -1.0, 0, 1)]),
    mc.Unit('mulitre_per_g', [(UNIT_KIND_LITRE, 1.0, -6, 1.0),
                      (UNIT_KIND_GRAM, -1.0, 0, 1)]),
]

##############################################################
# Compartments
##############################################################
compartments = [
    mc.Compartment('Vre', value=1, unit=UNIT_KIND_LITRE, constant=False, name='rest of body'),

    mc.Compartment('Vgu', value=1, unit=UNIT_KIND_LITRE, constant=False, name='gut'),
    mc.Compartment('Vki', value=1, unit=UNIT_KIND_LITRE, constant=False, name='kidney'),
    mc.Compartment('Vli', value=1, unit=UNIT_KIND_LITRE, constant=False, name='liver'),
    mc.Compartment('Vlu', value=1, unit=UNIT_KIND_LITRE, constant=False, name='lung'),
    mc.Compartment('Vsp', value=1, unit=UNIT_KIND_LITRE, constant=False, name='spleen'),

    mc.Compartment('Vve', value=1, unit=UNIT_KIND_LITRE, constant=False, name='venous blood'),
    mc.Compartment('Var', value=1, unit=UNIT_KIND_LITRE, constant=False, name='arterial blood'),
    mc.Compartment('Vpl', value=1, unit=UNIT_KIND_LITRE, constant=False, name='plasma'),
    mc.Compartment('Vplas_ven', value=1, unit=UNIT_KIND_LITRE, constant=False, name='venous plasma'),
    mc.Compartment('Vplas_art', value=1, unit=UNIT_KIND_LITRE, constant=False, name='arterial plasma'),
]

##############################################################
# Parameters
##############################################################
parameters = [
    # in vitro binding data
    mc.Parameter('fup', 1, '-', constant=True, name='fraction unbound in plasma'),
    mc.Parameter('BP', 1, '-', constant=True, name='blood to plasma ratio'),
    mc.Parameter('fumic', 1, '-', constant=True, name='fraction unbound in microsomes'),

    # clearances
    mc.Parameter('HLM_CLint', 10, 'mulitre_per_min_mg', constant=True, name= 'HLM CLint apparent [mul/min/mg]'),
    mc.Parameter('CLrenal', 0, 'litre_per_h', constant=True, name='CLint renal [L/hr]'),
    mc.Parameter('MPPGL', 45, 'mg_per_g', constant=True, name='mg microsomal protein per g liver'),

    # absorption
    mc.Parameter('Ka', 1, 'per_h', constant=True, name='Ka [1/hr] absorption'),
    mc.Parameter('F', 1, '-', constant=True, name='fraction absorbed'),

    # dosing
    mc.Parameter('Ave', 0, 'mg', constant=False),
    mc.Parameter('D', 0, 'mg', constant=False, name='oral dose [mg]'),
    mc.Parameter('DCL', 0, 'mg', constant=False),
    mc.Parameter('IVDOSE', 0, 'mg', constant=True, name='IV bolus dose [mg]'),
    mc.Parameter('PODOSE', 100, 'mg', constant=True, name='oral bolus dose [mg]'),

    # whole body data
    mc.Parameter('BW', 70, 'kg', constant=True, name='body weight'),
    mc.Parameter('CO', 108.33, 'ml_per_s', constant=True, name='cardiac output [ml/s]'),
    mc.Parameter('QC', 108.33*1000*60*60, 'litre_per_h', constant=False, name='cardiac output [L/hr]'),

    # fractional tissue volumes
    mc.Parameter('FVre', 0.9049, 'litre_per_kg', constant=True, name='rest of body fractional tissue volume'),

    mc.Parameter('FVgu', 0.0171, 'litre_per_kg', constant=True, name='gut fractional tissue volume'),
    mc.Parameter('FVki', 0.0044, 'litre_per_kg', constant=True, name='kidney fractional tissue volume'),
    mc.Parameter('FVli', 0.021, 'litre_per_kg', constant=True, name='liver fractional tissue volume'),
    mc.Parameter('FVlu', 0.0076, 'litre_per_kg', constant=True, name='lung fractional tissue volume'),
    mc.Parameter('FVsp', 0.0026, 'litre_per_kg', constant=True, name='spleen fractional tissue volume'),
    mc.Parameter('FVve', 0.0514, 'litre_per_kg', constant=True, name='venous fractional tissue volume'),
    mc.Parameter('FVar', 0.0257, 'litre_per_kg', constant=True, name='arterial fractional tissue volume'),
    mc.Parameter('FVpl', 0.0424, 'litre_per_kg', constant=True, name='plasma fractional tissue volume'),


    # fractional tissue blood flows
    mc.Parameter('FQgu', 0.146462, '-', constant=True, name='gut fractional tissue blood flow'),
    mc.Parameter('FQki', 0.19, '-', constant=True, name='kidney fractional tissue blood flow'),
    mc.Parameter('FQh', 0.215385, '-', constant=True, name='hepatic (venous side) fractional tissue blood flow'),
    mc.Parameter('FQlu', 1, '-', constant=True, name='lung fractional tissue blood flow'),
    mc.Parameter('FQsp', 0.017231, '-', constant=True, name='spleen fractional tissue blood flow'),
    mc.Parameter('FQre', 0.594615, '-', constant=True, name='rest of body fractional tissue blood flow'),

    # tissue to plasma partition coefficients
    mc.Parameter('Kpgu', 1, '-', constant=True, name='gut tissue plasma partition coefficient'),
    mc.Parameter('Kpki', 1, '-', constant=True, name='kidney tissue plasma partition coefficient'),
    mc.Parameter('Kpli', 1, '-', constant=True, name='liver tissue plasma partition coefficient'),
    mc.Parameter('Kplu', 1, '-', constant=True, name='lung tissue plasma partition coefficient'),
    mc.Parameter('Kpsp', 1, '-', constant=True, name='spleen tissue plasma partition coefficient'),
    mc.Parameter('Kpre', 1, '-', constant=True, name='rest tissue plasma partition coefficient'),

    # amounts
    mc.Parameter('Agu', 0, 'mg', constant=False),
    mc.Parameter('Aki', 0, 'mg', constant=False),
    mc.Parameter('Ali', 0, 'mg', constant=False),
    mc.Parameter('Alu', 0, 'mg', constant=False),
    mc.Parameter('Asp', 0, 'mg', constant=False),
    mc.Parameter('Are', 0, 'mg', constant=False),
    mc.Parameter('Aar', 0, 'mg', constant=False),
]


##############################################################
# Assignments
##############################################################
assignments = [
    # id: ('value', 'unit')
    mc.Assignment('Ave', 'IVDOSE', 'mg'),
    mc.Assignment('D', 'PODOSE', 'mg'),
]

##############################################################
# Rules
##############################################################
rules = [

    # concentrations
    mc.Rule('Cgu', 'Agu/Vgu', 'mg_per_litre', name='C [mg/l] gut'),
    mc.Rule('Cki', 'Aki/Vki', 'mg_per_litre', name='C [mg/l] kidney'),
    mc.Rule('Cli', 'Ali/Vli', 'mg_per_litre', name='C [mg/l] liver'),
    mc.Rule('Clu', 'Alu/Vlu', 'mg_per_litre', name='C [mg/l] lung'),
    mc.Rule('Csp', 'Asp/Vsp', 'mg_per_litre', name='C [mg/l] spleen'),
    mc.Rule('Cre', 'Are/Vre', 'mg_per_litre', name='C [mg/l] rest of body'),

    mc.Rule('Cve', 'Ave/Vve', 'mg_per_litre', name='C [mg/l] venous blood'),
    mc.Rule('Car', 'Aar/Var', 'mg_per_litre', name='C [mg/l] arterial blood'),

    # free concentrations
    mc.Rule('Cpl_ve', 'Cve/BP', 'mg_per_litre'),
    mc.Rule('Cli_free', 'Cli*fup', 'mg_per_litre', name='free liver concentration'),
    mc.Rule('Cki_free', 'Cki*fup', 'mg_per_litre', name='free kidney concentration'),

    # clearance
    mc.Rule('CLmet', '(HLM_CLint/fumic) * MPPGL * Vli * 60 min_per_h / 1000 mulitre_per_g', 'litre_per_h', name='CLint scaled [l/hr]'),

    # volumes
    mc.Rule('Vgu', 'BW*FVgu', UNIT_KIND_LITRE),
    mc.Rule('Vki', 'BW*FVki', UNIT_KIND_LITRE),
    mc.Rule('Vli', 'BW*FVli', UNIT_KIND_LITRE),
    mc.Rule('Vlu', 'BW*FVlu', UNIT_KIND_LITRE),
    mc.Rule('Vsp', 'BW*FVsp', UNIT_KIND_LITRE),
    mc.Rule('Vve', 'BW*FVve', UNIT_KIND_LITRE),
    mc.Rule('Var', 'BW*FVar', UNIT_KIND_LITRE),
    mc.Rule('Vpl', 'BW*FVpl', UNIT_KIND_LITRE),
    mc.Rule('Vre', 'BW*FVre', UNIT_KIND_LITRE),
    mc.Rule('Vplas_ven', 'Vpl*Vve/(Vve + Var)', UNIT_KIND_LITRE),
    mc.Rule('Vplas_art', 'Vpl*Var/(Vve + Var)', UNIT_KIND_LITRE),

    # blood flows
    mc.Rule('QC', 'CO/1000 ml_per_litre * 3600 s_per_h', 'litre_per_h'),
    mc.Rule('Qgu', 'QC*FQgu', 'litre_per_h', name='gut blood flow'),
    mc.Rule('Qki', 'QC*FQki', 'litre_per_h', name='kidney blood flow'),
    mc.Rule('Qh', 'QC*FQh', 'litre_per_h', name='hepatic (venous side) blood flow'),
    mc.Rule('Qha', 'Qh - Qgu - Qsp', 'litre_per_h', name='hepatic artery blood flow'),
    mc.Rule('Qlu', 'QC*FQlu', 'litre_per_h', name='lung blood flow'),
    mc.Rule('Qsp', 'QC*FQsp', 'litre_per_h', name='spleen blood flow'),
    mc.Rule('Qre', 'QC*FQre', 'litre_per_h', name='rest of body blood flow'),

    # rates
    mc.Rule('Absorption', 'Ka*D*F', 'mg_per_h'),
    mc.Rule('Venous', 'Qki*(Cki/Kpki*BP) + Qh*(Cli/Kpli*BP) + Qre*(Cre/Kpre*BP)', 'mg_per_h'),

    # total substance
    mc.Rule('Abody', 'Aar + Agu + Aki + Ali + Alu + Asp + Are + Ave', 'mg')
]

rate_rules = [
    mc.RateRule('Agu', 'Absorption + Qgu*(Car - Cgu/Kpgu*BP)', 'mg_per_h'),
    mc.RateRule('Aki', 'Qki*(Car - Cki/Kpki*BP) - CLrenal*Cki_free', 'mg_per_h'),
    mc.RateRule('Ali', 'Qha*Car + Qgu*(Cgu/Kpgu*BP) + Qsp*(Csp/Kpsp*BP) - Qh*(Cli/Kpli*BP) - Cli_free*CLmet', 'mg_per_h'),
    mc.RateRule('Alu', 'Qlu*Cve - Qlu*(Clu/Kplu*BP)', 'mg_per_h'),
    mc.RateRule('Asp', 'Qsp*(Car - Csp/Kpsp*BP)', 'mg_per_h'),
    mc.RateRule('Ave', 'Venous - Qlu*Cve', 'mg_per_h'),
    mc.RateRule('Aar', 'Qlu*(Clu/Kplu*BP) - Qlu*Car', 'mg_per_h'),
    mc.RateRule('Are', 'Qre*(Car - Cre/Kpre*BP)', 'mg_per_h'),
    mc.RateRule('D', '-Absorption', 'mg_per_h'),
    mc.RateRule('DCL', 'CLrenal*Cki_free + Cli_free*CLmet', 'mg_per_h'),
]
