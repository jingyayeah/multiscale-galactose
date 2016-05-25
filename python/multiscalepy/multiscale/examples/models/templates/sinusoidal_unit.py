"""
Template for the creation of sinusoidal unit models.

Cellular models are integrated into the sinusoidal template with the
SBML comp extension.

The core idea is to have a modular model structure which allows the easy integration
of various single hepatocyte models.

Important features:
- important is a fast turnover between changes and simulations. 
  Currently this is quit cumbersome and necessary to write down the full network.
- single cell models as well as the full sinusoidal architecture have to be generated 
  at once.
"""
from libsbml import XMLNode
import sbmlutils.modelcreator.modelcreator as mc
from sbmlutils.modelcreator import templates


mid = 'sinusoidal_unit'
version = 1
creators = templates.creators

notes = XMLNode.convertStringToXMLNode("""
    <body xmlns='http://www.w3.org/1999/xhtml'>
    <h1>Koenig Sinusoidal Unit Model</h1>
    <h2>Description</h2>
    <p>This is the template model of the sinusodial unit in
    <a href="http://sbml.org" target="_blank" title="Access the definition of the SBML file format.">SBML</a>&#160;format.
    </p>
    """ + templates.terms_of_use + """
    </body>
    """)


parameters = [
    # geometry
    mc.Parameter('L', 500E-6, 'm', name='sinusoidal length'),
    mc.Parameter('y_sin', 4.4E-6, 'm', name='sinusoidal radius'),
    mc.Parameter('y_end', 0.165E-6, 'm', name='endothelial cell thickness'),
    mc.Parameter('y_dis', 2.3E-6, 'm', name='width space of Disse'),
    mc.Parameter('y_cell', 9.40E-6, 'm', name='width hepatocyte'),

    # fenestraetion
    mc.Parameter('N_fen',  10E12, 'per_m2', name='fenestrations per area'),
    mc.Parameter('r_fen', 53.5E-9, 'm', name='fenestration radius'),

    # scaling and fractions
    mc.Parameter('rho_liv', 1.25E3, 'kg_per_m3', name='liver density'),
    mc.Parameter('f_tissue', 0.8, '-', name='parenchymal fraction of liver'),
    # mc.Parameter('f_cyto', 0.4, '-', name='cytosolic fraction of hepatocyte'),
]

'''
names['Pa_per_mmHg'] = 'conversion factor between Pa and mmHg'
names['scale_f'] = 'metabolic scaling factor'
names['REF_P'] = 'reference protein amount'
names['deficiency'] = 'type of galactosemia'
names['gal_challenge'] = 'galactose challenge periportal'
'''

rules = [
    mc.Rule('x_cell', 'L/Nc', 'm', name='length cell compartment'),
    mc.Rule('x_sin',  'x_cell', 'm', name='length sinusoidal compartment'),
    mc.Rule('A_sin', 'pi*y_sin^2',  'm2', name='cross section sinusoid'),
    mc.Rule('A_dis', 'pi*(y_sin+y_end+y_dis)^2 - pi*(y_sin+y_end)^2',  'm2', name='cross section space of Disse'),
    mc.Rule('A_sindis', '2 dimensionless *pi*y_sin*x_sin',  'm2', name='exchange area between sinusoid and Disse'),
    mc.Rule('A_sinunit', 'pi*(y_sin+y_end+y_dis+y_cell)^2',  'm2', name='cross section sinusoidal unit'),
    mc.Rule('Vol_sin', 'A_sin*x_sin',  'm3', name='volume sinusoidal compartment'),
    mc.Rule('Vol_dis', 'A_dis*x_sin',  'm3', name='volume Disse compartment'),
    mc.Rule('Vol_cell', 'pi*x_cell*( (y_sin+y_end+y_dis+y_cell)^2-(y_sin+y_end+y_dis)^2 )', 'm3', name='volume cell compartment'),
    # mc.Rule('Vol_cyto', 'f_cyto*Vol_cell',  'm3', name='volume cytosol'),
    mc.Rule('Vol_pp', 'Vol_sin', 'm3', name='volume periportal'),
    mc.Rule('Vol_pv', 'Vol_sin', 'm3', name='volume perivenious'),
    mc.Rule('Vol_sinunit', 'L*pi*(y_sin+y_end+y_dis+y_cell)^2', 'm3', name='total volume sinusoidal unit'),
    mc.Rule('f_sin',  'Vol_sin/(A_sinunit*x_sin)', '-', name='sinusoidal fraction of volume'),
    mc.Rule('f_dis', 'Vol_dis/(A_sinunit*x_sin)', '-', name='Disse fraction of volume'),
    mc.Rule('f_cell', 'Vol_cell/(A_sinunit*x_sin)', '-', name='cell fraction of volume'),

    mc.Rule('f_fen', 'N_fen*pi*(r_fen)^2', '-', name='fenestration porosity'),
            # ('m_liv', 'rho_liv * Vol_liv', 'kg'),
            # ('q_liv' , 'Q_liv/m_liv', 'm3_per_skg'),
]
