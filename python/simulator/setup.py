"""Setup module for odesim.

See:
https://packaging.python.org/en/latest/distributing.html
https://github.com/pypa/sampleproject

source distribution generation via
python setup.py sdist
"""

# Always prefer setuptools over distutils
from setuptools import setup, find_packages
import codecs # To use a consistent encoding
import os

here = os.path.abspath(os.path.dirname(__file__))

# get the version
import re
VERSIONFILE = "odesim/_version.py"
verstrline = codecs.open(VERSIONFILE, "rt").read()
VSRE = r"^__version__ = ['\"]([^'\"]*)['\"]"
mo = re.search(VSRE, verstrline, re.M)
if mo:
    verstr = mo.group(1)
else:
    raise RuntimeError("Unable to find version string in %s." % (VERSIONFILE,))


# Get the long description from the relevant file
with open(os.path.join(here, 'DESCRIPTION.rst'), encoding='utf-8') as f:
    long_description = f.read()

setup(
    name='libsbgnpy',

    # Versions should comply with PEP440.  For a discussion on single-sourcing
    # the version across setup.py and the project code, see
    # https://packaging.python.org/en/latest/single_source_version.html
    version=verstr,

    description='simulation util',
    long_description=long_description,

    # The project's main homepage.
    url='https://github.com/matthiaskoenig/multiscale-galactose',

    # Author details
    author='Matthias Koenig',
    author_email='konigmatt@googlemails.com',

    # Choose your license
    license='MIT',

    # See https://pypi.python.org/pypi?%3Aaction=list_classifiers
    classifiers=[
        # How mature is this project? Common values are
        #   3 - Alpha
        #   4 - Beta
        #   5 - Production/Stable
        'Development Status :: 4 - Beta',

        # Indicate who your project is intended for
        'Intended Audience :: Science/Research',

        # Pick your license as you wish (should match "license" above)
        'License :: OSI Approved :: MIT License',

        # Specify the Python versions you support here. In particular, ensure
        # that you indicate whether you support Python 2, Python 3 or both.
        'Programming Language :: Python :: 2',
        'Programming Language :: Python :: 2.6',
        'Programming Language :: Python :: 2.7',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.2',
        'Programming Language :: Python :: 3.3',
        'Programming Language :: Python :: 3.4',
    ],

    # What does your project relate to?
    keywords='roadrunner',

    # You can just specify the packages manually here if your project is
    # simple. Or you can use find_packages().
    # exclude=['contrib', 'docs', 'examples*']
    packages=find_packages(),

    # List run-time dependencies here.  These will be installed by pip when
    # your project is installed. For an analysis of "install_requires" vs pip's
    # requirements files see:
    # https://packaging.python.org/en/latest/requirements.html
    install_requires=[],

    # List additional groups of dependencies here (e.g. development
    # dependencies). You can install these using the following syntax,
    # for example:
    # $ pip install -e .[dev,test]
    # extras_require={
    #     'dev': ['check-manifest'],
    #    'test': ['coverage'],
    # },

    # If there are distribution_data files included in your packages that need to be
    # installed, specify them here.  If using Python 2.6 or less, then these
    # have to be included in MANIFEST.in as well.
    # package_data={
    #    'sample': ['package_data.dat'],
    # },
    
    # include the package distribution_data (SBGN, XSD)
    include_package_data=True,

    # Prevent the package manager to install a python egg, 
    # instead you'll get a real directory with files in it.
    zip_safe=False,

)
