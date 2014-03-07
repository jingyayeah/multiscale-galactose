# python path settings for django
export PYTHONPATH=$PYTHONPATH:/home/mkoenig/multiscale-galactose/python
export PYTHONPATH=$PYTHONPATH:/home/mkoenig/multiscale-galactose/python/mysite/

export DJANGO_SETTINGS_MODULE=mysite.settings

cd ~/multiscale-galactose
git pull

cd ~/multiscale-galactose/python/SinusoidSimulator/core
python Simulator.py
