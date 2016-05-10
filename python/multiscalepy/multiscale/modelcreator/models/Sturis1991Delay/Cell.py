# -*- coding=utf-8 -*-
"""
Model of insulin and glucose system.
"""
from libsbml import UNIT_KIND_METRE, UNIT_KIND_SECOND, UNIT_KIND_LITRE
from libsbml import UNIT_KIND_GRAM, UNIT_KIND_KATAL, UNIT_KIND_DIMENSIONLESS
from libsbml import XMLNode
from ..templates import terms_of_use, mkoenig

##############################################################
mid = 'Sturis1991Delay'
version = 1
notes = XMLNode.convertStringToXMLNode("""
    <body xmlns='http://www.w3.org/1999/xhtml'>
    <h1>Tolic2000 - Sturis1991</h1>
    <h2>Description</h2>
    <p>
        This is a metabolic model of the insulin and glucose system in <a href="http://sbml.org">SBML</a> format.
    </p>
    <p>This model is described in the articles:</p>
    <div class="bibo:title">
        <a href="http://identifiers.org/pubmed/11082306" title="Access to this publication">Modeling the insulin-glucose feedback system: the significance of pulsatile insulin secretion.</a>
    </div>
    <div class="bibo:authorList">Tolić IM, Mosekilde E, Sturis J.</div>
    <div class="bibo:Journal">J Theor Biol. 2000 Dec 7;207(3):361-75.</div>
    <p>Abstract:</p>
    <div class="bibo:abstract">
    <p>A mathematical model of the insulin-glucose feedback regulation in man is used to examine the effects of an
    oscillatory supply of insulin compared to a constant supply at the same average rate. We show that interactions
    between the oscillatory insulin supply and the receptor dynamics can be of minute significance only. It is
    possible, however, to interpret seemingly conflicting results of clinical studies in terms of their different
    experimental conditions with respect to the hepatic glucose release. If this release is operating near an upper
    limit, an oscillatory insulin supply will be more efficient in lowering the blood glucose level than a constant
    supply. If the insulin level is high enough for the hepatic release of glucose to nearly vanish, the opposite
    effect is observed. For insulin concentrations close to the point of inflection of the insulin-glucose
    dose-response curve an oscillatory and a constant insulin infusion produce similar effects.</p>
    <div class="bibo:title">
        <a href="http://identifiers.org/pubmed/2035636" title="Access to this publication">Computer model for mechanisms underlying ultradian oscillations of insulin and glucose.</a>
    </div>
    <div class="bibo:authorList">Sturis, J. and Polonsky, K. S. and Mosekilde, E. and Van Cauter, E.</div>
    <div class="bibo:Journal">Am J Physiol. 1991 May;260(5 Pt 1):E801-9.</div>
    <p>Abstract:</p>
    <div class="bibo:abstract">
    <p>Oscillations in human insulin secretion have been observed in two distinct period ranges, 10-15 min (i.e. rapid)
    and 100-150 min (i.e., ultradian). The cause of the ultradian oscillations remains to be elucidated. To determine whether
    the oscillations could result from the feedback loops between insulin and glucose, a parsimonious mathematical model
    including the major mechanisms involved in glucose regulation was developed. This model comprises two major negative
    feedback loops describing the effects of insulin on glucose utilization and glucose production, respectively, and
    both loops include the stimulatory effect of glucose on insulin secretion. Model formulations and parameters are
    representative of results from published clinical investigations. The occurrence of sustained insulin and glucose
    oscillations was found to be dependent on two essential features: 1) a time delay of 30-45 min for the effect of
    insulin on glucose production and 2) a sluggish effect of insulin on glucose utilization, because insulin acts
    from a compartment remote from plasma. When these characteristics were incorporated in the model, numerical
    simulations mimicked all experimental findings so far observed for these ultradian oscillations, including 1)
    self-sustained oscillations during constant glucose infusion at various rates; 2) damped oscillations after
    meal or oral glucose ingestion; 3) increased amplitude of oscillation after increased stimulation of insulin
    secretion, without change in frequency; and 4) slight advance of the glucose oscillation compared with
    the insulin oscillation.</p>
    </div>
    """ + terms_of_use + """
    </body>
    """)

creators = mkoenig
main_units = {
    'time': 'min',
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
    'min': [(UNIT_KIND_SECOND, 1.0, 0, 60)],

    'm': [(UNIT_KIND_METRE, 1.0)],
    'm2': [(UNIT_KIND_METRE, 2.0)],

    'mg': [(UNIT_KIND_GRAM, 1.0, -3, 1.0)],
    'mg_per_min': [(UNIT_KIND_GRAM, 1.0, -3, 1.0),
                   (UNIT_KIND_SECOND, -1.0, 0, 60)],
    'mg_per_l': [(UNIT_KIND_GRAM, 1.0, -3, 1.0),
                   (UNIT_KIND_LITRE, -1.0, 0, 1.0)],

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
    'f1': ('lambda(G, Rm, C1, V3, a1, Rm/(1 dimensionless + exp((C1-G/V3)/a1)) )', ),
    'f2': ('lambda(G, Ub, C2, V3, Ub*(1 dimensionless - exp(-G/(C2*V3)) ) )',),
    'f3': ('lambda(G, C3, V3, G/(C3*V3) )',),

    'f4': ('lambda(I, U0, Um, V1, U0 + Um/(1 dimensionless + exp(-1.772*log(I/V1) + 7.76 dimensionless)) )',),

    'f5': ('lambda(I, Rg, a, V1, C5, Rg/(1 dimensionless + exp(a*(I/V1 - C5))) )',),
})
names.update({
    'f1': 'pancreatic insulin production',
    'f2': 'insulin-independent glucose utilization',
    'f3': 'glucose utilization',
    'f4': 'insulin-dependent glucose utilization',
    'f5': 'influence of insulin on HGP',
})

##############################################################
# Compartments
##############################################################
compartments.update({
    # id : ('spatialDimension', 'unit', 'constant', 'assignment')
    'V1': (3, UNIT_KIND_LITRE, True, '3.0 litre'),
    'V3': (3, UNIT_KIND_LITRE, True, '10.0 litre'),
})
names.update({
    'V1': 'Vp distribution volume for insulin in plasma',
    'V3': 'glucose space',
})

##############################################################
# Parameters
##############################################################
parameters.update({
    # id: ('value', 'unit', 'constant')
    'I': (90, 'mU', False),  # Ip(0) = 30[mU/l] => 90[mU] with Vp = 3[l] (Tolic2000, Fig.1)
    'G': (12000, 'mg', False),  # G(0) = 120 [mg/dl] => 12000 with Vg = 10[l] (Tolic2000, Fig.1)

    'Eg': (216, 'mg_per_min', True),
    'tau2': (10, 'min', True),

    # f1
    'Rm': (210, 'mU_per_min', True),
    'C1': (2000, 'mg_per_l', True),
    'a1': (300, 'mg_per_l', True),

    # f2
    'Ub': (72, 'mg_per_min', True),
    'C2': (144, 'mg_per_l', True),

    # f3
    'C3': (1000, 'mg_per_l', True),  # 100 ?

    # f4
    'U0': (4, 'mg_per_min', True),
    'Um': (90, 'mg_per_min', True),
    'b': (1.77, '-', True),
    'C4': (80, 'mU_per_l', True),

    # f5
    'Rg': (180, 'mg_per_min', True),
    'a': (0.29, 'l_per_mU', True),
    'C5': (26, 'mU_per_l', True),


    't1': (100, 'min', True),
    'td': (36, 'min', True),
})
names.update({
    'G': 'amount of glucose',
    'I': 'amount of insulin',

    'Eg': 'exogenous glucose supply',
    't1': 'exponential insulin degradation time',
})

##############################################################
# Rules
##############################################################
rules.update({
    # id: ('value', 'unit')
})

rate_rules.update({
    # id: ('value', 'unit')
    'I': ('f1(G, Rm, C1, V3, a1) - I/t1', 'mU_per_min'),
    'G': ('Eg + f5( delay(I, tau2), Rg, a, V1, C5) - f2(G, Ub, C2, V3) - f3(G, C3, V3)*f4(I, U0, Um, V1)', 'mg_per_min'),
    # delay x, y
    # The value of x at y time units in the past.
})
