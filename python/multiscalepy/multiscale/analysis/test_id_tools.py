import unittest

import tellurium as te
import os
from id_tools import *

from multiscale.examples.models.clearance import clearance
from multiscale.simulate import roadrunner_tools as rt
sbml_path = os.path.join(clearance.base_dir, 'results', 'sinusoidal_flow_Nc5_v3.xml')


class IdResolverTestCase(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        r = rt.MyRunner(sbml_path)
        cls.Nc = r['Nc']
        r.select_concentrations()
        cls.r = r

    def test_resolver(self):
        resolver = IdResolver(selections=self.__class__.r.timeCourseSelections, Nc=self.__class__.Nc)
        sin_ids = resolver.sinusoidal_ids('S')
        self.assertEqual(self.__class__.Nc, len(sin_ids))

        disse_ids = resolver.disse_ids('S')
        self.assertEqual(self.__class__.Nc, len(disse_ids))

        pp_id = resolver.pp_id('S')
        self.assertEqual(pp_id, '[PP__S]')

        pv_id = resolver.pv_id('S')
        self.assertEqual(pv_id, '[PV__S]')

        print(sin_ids)
        print(disse_ids)
        print(pp_id)
        print(pv_id)

        print(resolver.find_indices(sin_ids))
        print(resolver.find_indices(disse_ids))
        print(resolver.find_indices([pp_id] + sin_ids + [pv_id]))

        self.assertEqual(True, False)


if __name__ == '__main__':
    unittest.main()
