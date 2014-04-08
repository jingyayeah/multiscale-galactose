########################################
# startSimulation.sh                   #
########################################
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
# TODO

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
COPASI_PROJECT=~/multiscale-galactose/cpp/copasi/CopasiModelRunner
cp ~/copasi/build_copasi/copasi/libCOPASISE.a $COPASI_PROJECT
cp ~/copasi/copasi-dependencies/bin/lib/*.a $COPASI_PROJECT
cp ~/copasi/copasi-dependencies/bin/lib/*.la $COPASI_PROJECT


rm -r ~/multiscale-galactose/cpp/copasi/CopasiModelRunner/Debug
rm -r ~/multiscale-galactose/cpp/copasi/CopasiModelRunner/build
mkdir ~/multiscale-galactose/cpp/copasi/CopasiModelRunner/build
cd ~/multiscale-galactose/cpp/copasi/CopasiModelRunner/build
cmake ..
make

echo "###################################"
echo "# run simulations #"
echo "###################################"
cd ~/multiscale-galactose/python/SinusoidSimulator/core
python Simulator.py


