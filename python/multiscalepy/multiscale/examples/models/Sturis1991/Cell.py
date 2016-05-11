# -*- coding=utf-8 -*-
"""
Model of insulin and glucose system.
"""
from libsbml import UNIT_KIND_METRE, UNIT_KIND_SECOND, UNIT_KIND_LITRE
from libsbml import UNIT_KIND_GRAM, UNIT_KIND_KATAL, UNIT_KIND_DIMENSIONLESS
from libsbml import XMLNode
from ..templates import terms_of_use, mkoenig

##############################################################
mid = 'Sturis1991'
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
    'f1': ('lambda(G, Rm, C1, Vg, a1, Rm/(1 dimensionless + exp((C1-G/Vg)/a1)) )', ),
    'f2': ('lambda(G, Ub, C2, Vg, Ub*(1 dimensionless - exp(-G/(C2*Vg)) ) )',),
    'f3': ('lambda(G, C3, Vg, G/(C3*Vg) )',),
    'f4': ('lambda(Ii, U0, Um, b, C4, Vi, E, ti, U0 + (Um - U0)/(1 dimensionless + exp(-b*ln(Ii/C4*(1 dimensionless/Vi + 1 dimensionless/(E*ti))))) )',),
    'f5': ('lambda(x3, Rg, a, Vp, C5, Rg/(1 dimensionless + exp(a*(x3/Vp - C5))) )',),
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
    'Vp': (3, UNIT_KIND_LITRE, True, '3.0 litre'),
    'Vi': (3, UNIT_KIND_LITRE, True, '11.0 litre'),
    'Vg': (3, UNIT_KIND_LITRE, True, '10.0 litre'),
})
names.update({
    'Vp': 'Vp distribution volume for insulin in plasma',
    'Vi': 'effective volume of intercellular space',
    'Vg': 'glucose space',
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
    'Ip': (90, 'mU', False),  # Ip(0) = 30[mU/l] => 90[mU] with Vp = 3[l] (Tolic2000, Fig.1)
    'Ii': (330, 'mU', False),  # Ii(0) = 30[mU/l] => 330[mU] with Vi = 11[l] (Tolic2000, Fig.1)
    'G': (12000, 'mg', False),  # G(0) = 120 [mg/dl] => 12000 with Vg = 10[l] (Tolic2000, Fig.1)

    'x1': (90, 'mU', False),  # x1(0) = x2(0) = x3(0) = Ip(0)
    'x2': (90, 'mU', False),
    'x3': (90, 'mU', False),

    'Gin': (216, 'mg_per_min', True),
    'E': (0.2, 'l_per_min', True),
    'tp': (6, 'min', True),
    'ti': (100, 'min', True),
    'td': (36, 'min', True),
    'Rm': (210, 'mU_per_min', True),
    'a1': (300, 'mg_per_l', True),
    'C1': (2000, 'mg_per_l', True),
    'Ub': (72, 'mg_per_min', True),
    'C2': (144, 'mg_per_l', True),
    'C3': (1000, 'mg_per_l', True),
    'U0': (40, 'mg_per_min', True),
    'Um': (940, 'mg_per_min', True),
    'b': (1.77, '-', True),
    'C4': (80, 'mU_per_l', True),
    'Rg': (180, 'mg_per_min', True),
    'a': (0.29, 'l_per_mU', True),
    'C5': (26, 'mU_per_l', True),
})
names.update({
    'G': 'amount of glucose in plasma and intracellular space',
    'Ip': 'amount of insulin in plasma',
    'Ii': 'amount of insulin in intracellular space',

    'x1': 'delay variable x1',
    'x2': 'delay variable x2',
    'x3': 'delay variable x3',
    'Gin': 'exogenous glucose supply',
    'E': 'insulin transfer rate between volumes E',
    'tp': 'exponential insulin degadation time plasma',
    'ti': 'exponential insulin degadation time intracellular space',
})

##############################################################
# Assignments
##############################################################
assignments.update({
    # id: ('value', 'unit')
})
names.update({
})

##############################################################
# Rules
##############################################################

rules.update({
    # id: ('value', 'unit')
})

# rate rules
'''
    'f1': ('lambda(G, Rm, C1, Vg, a1, Rm/(1 + exp((C1-G/Vg)/a1)) )', ),
    'f2': ('lambda(G, Ub, C2, Vg, Ub*(1 - exp(-G/(C2*Vg)) ) )',),
    'f3': ('lambda(G, C3, Vg, G/(C3*Vg) )',),
    'f4': ('lambda(Ii, U0, Um, b, C4, Vi, E, ti, U0 + (Um - U0)/(1 + exp(-b*ln(Ii/C4*(1/Vi + 1/(E*ti))))) )',),
    'f5': ('lambda(x3, Rg, a, Vp, C5, Rg/(1 + exp(a*(x3/Vp - C5))) )',),
'''
rate_rules.update({
    # id: ('value', 'unit')
    'Ip': ('f1(G, Rm, C1, Vg, a1) - E*(Ip/Vp - Ii/Vi) - Ip/tp', 'mU_per_min'),
    'Ii': ('E*(Ip/Vp - Ii/Vi)-Ii/ti', 'mU_per_min'),
    'G': ('Gin -f2(G, Ub, C2, Vg) - f3(G, C3, Vg)*f4(Ii, U0, Um, b, C4, Vi, E, ti) + f5(x3, Rg, a, Vp, C5)', 'mg_per_min'),
    'x1': ('3 dimensionless/td * (Ip-x1)', 'mU_per_min'),
    'x2': ('3 dimensionless/td * (x1-x2)', 'mU_per_min'),
    'x3': ('3 dimensionless/td * (x2-x3)', 'mU_per_min'),
})


##############################################################
# Reactions
##############################################################
import Reactions
reactions.extend([])
