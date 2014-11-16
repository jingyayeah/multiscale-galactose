#!/bin/bash
############################################################
# Update/install required things
#
# @author: Matthias Koenig
# @date: 2014-11-16
############################################################
# install dependencies
sudo apt-get install python-dev libpq-dev python-rpy2 
sudo apt-get install llvm python-numpy python-scipy


# django
cd ~/Downloads
wget --output-document ~/Downloads/Django_1.7.1.tar.gz https://www.djangoproject.com/download/1.7.1/tarball/
tar xzvf ~/Downloads/Django-1.7.1.tar.gz
cd ~/Downloads/Django-1.7.1
sudo python setup.py install

# psycopg2
cd ~/Downloads
wget --output-document ~/Downloads/psycopg2-2.5.4.tar.gz https://pypi.python.org/packages/source/p/psycopg2/psycopg2-2.5.4.tar.gz
tar xzvf ~/Downloads/psycopg2-2.5.4.tar.gz
cd ~/Downloads/psycopg2-2.5.4/
sudo python setup.py install

