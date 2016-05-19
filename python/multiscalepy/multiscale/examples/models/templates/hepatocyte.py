"""
Hepatocyte template model.
"""
import sbmlutils.modelcreator.modelcreator as mc

mid = 'hepatocyte'
version = 2

compartments = [
    mc.Compartment('e', 'Vol_e', 'm3', constant=False, name='external'),
    mc.Compartment('h', 'Vol_h', 'm3', constant=False, name='hepatocyte'),
    mc.Compartment('c', 'Vol_c', 'm3', constant=False, name='cytosol'),
    mc.Compartment('pm', 'A_m', 'm2', constant=False, spatialDimension=2, name='plasma membrane')
]

parameters = [
    mc.Parameter('f_met', 0.31, 'per_m3', constant=True, name='metabolic scaling factor'),
    mc.Parameter('y_cell', 9.40E-6, 'm', constant=True, name='width hepatocyte'),
    mc.Parameter('x_cell', 25E-6, 'm', constant=True, name='length hepatocyte'),
    mc.Parameter('f_tissue', 0.8, '-', constant=True, name='parenchymal fraction of liver'),
    mc.Parameter('f_cyto', 0.4, '-', constant=True, name='cytosolic fraction of hepatocyte'),
]

assignments = [
    mc.Assignment('Vol_h', 'x_cell*x_cell*y_cell', 'm3', name='volume hepatocyte'),
    mc.Assignment('Vol_e', 'Vol_h', 'm3', name='volume cytosol'),
    mc.Assignment('Vol_c', 'f_cyto*Vol_h', 'm3', name='volume external compartment'),
    mc.Assignment('A_m', 'x_cell*x_cell', 'm2', name='area plasma membrane'),
]
