########################################
# startSimulation.sh                   #
########################################
# TODO: offline simulations without the pull from github.
# TODO: general settings for the path
# TODO: use options to not use all CPUS on target computer

# python path settings for django
export PYTHONPATH=$PYTHONPATH:/home/mkoenig/multiscale-galactose/python
export PYTHONPATH=$PYTHONPATH:/home/mkoenig/multiscale-galactose/python/mysite/
export DJANGO_SETTINGS_MODULE=mysite.settings

# pull the latest code from the repository
echo "###################################"
echo "# Pull git source code"
echo "###################################"
cd ~/multiscale-galactose
git config --global credential.helper 'cache --timeout 86400'
git pull

# link folder to the server with database
# TODO use proper variables $MULTISCALE_GALACTOSE

# create the tmp folders for storing intermediate results
echo "###################################"
echo "# Create tmp folders #"
echo "###################################"
mkdir ~/multiscale-galactose-results
mkdir ~/multiscale-galactose-results/tmp_sbml
mkdir ~/multiscale-galactose-results/tmp_sim
mkdir ~/multiscale-galactose-results/django
mkdir ~/multiscale-galactose-results/django/sbml
mkdir ~/multiscale-galactose-results/django/timecourse

# build latest CopasiModelSimulator
echo "###################################"
echo "# build copasi #"
echo "###################################"
# copy all the libraries to link
export COPASI_PROJECT=~/multiscale-galactose/cpp/copasi/CopasiModelRunner
cp ~/copasi/build_copasi/copasi/libCOPASISE.a $COPASI_PROJECT
cp ~/copasi/copasi-dependencies/bin/lib/*.a $COPASI_PROJECT
cp ~/copasi/copasi-dependencies/bin/lib/*.la $COPASI_PROJECT

rm -r ${COPASI_PROJECT}/Debug
rm -r ${COPASI_PROJECT}/build
mkdir ${COPASI_PROJECT}/build
cd ${COPASI_PROJECT}/build
cmake ..
make


echo "###################################"
echo "# run simulations #"
echo "###################################"
cd ~/multiscale-galactose/python/simulator/core
python Simulator.py


