########################################
# startSimulation.sh                   #
########################################


# python path settings for django
export PYTHONPATH=$PYTHONPATH:/home/mkoenig/multiscale-galactose/python
export PYTHONPATH=$PYTHONPATH:/home/mkoenig/multiscale-galactose/python/mysite/

export DJANGO_SETTINGS_MODULE=mysite.settings

# pull the latest code from the repository
cd ~/multiscale-galactose
git pull

# link folder to the server with database
# TODO

# create the tmp folders for storing intermediate results
mkdir ~/multiscale-galactose-results/tmp_sbml
mkdir ~/multiscale-galactose-results/tmp_sim

# build latest CopasiModelSimulator
mkdir ~/multiscale-galactose/cpp/copasi/CopasiModelRunner/build
cd ~/multiscale-galactose/cpp/copasi/CopasiModelRunner/build
cmake ..
make


# run the simulations
cd ~/multiscale-galactose/python/SinusoidSimulator/core
python Simulator.py

# TODO how can I kill the whole process


