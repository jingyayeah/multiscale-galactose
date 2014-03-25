########################################
# startSimulation.sh                   #
########################################


# python path settings for django
export PYTHONPATH=$PYTHONPATH:/home/mkoenig/multiscale-galactose/python
export PYTHONPATH=$PYTHONPATH:/home/mkoenig/multiscale-galactose/python/mysite/

export DJANGO_SETTINGS_MODULE=mysite.settings

# pull the latest code from the repository
# TODO: remove password
cd ~/multiscale-galactose
git pull

# link folder to the server with database

# create the tmp folders for storing intermediate results
mkdir ~/multiscale-galactose-results/tmp_sbml
mkdir ~/multiscale-galactose-results/tmp_sim

# build latest CopasiModelSimulator
# TODO make ...


# run the simulations
cd ~/multiscale-galactose/python/SinusoidSimulator/core
python Simulator.py

# TODO how can I kill the whole process
#

