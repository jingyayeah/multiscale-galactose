import unittest


class MyTestCase(unittest.TestCase):
    def test_something(self):

        # TODO: test for model creator test that all the information is written in the test model

        h = model.getModelHistory()
        self.assertIsNotNone(h)
        self.assertEqual(1, h.getNumCreators())
        c = h.getCreator(0)
        self.assertEqual('Koenig', c.getFamilyName())
        self.assertEqual('Matthias', c.getGivenName())
        self.assertEqual('konigmatt@googlemail.com', c.getEmail())
        self.assertEqual('Test organisation', c.getOrganization())

        self.assertEqual(True, False)


if __name__ == '__main__':
    unittest.main()
