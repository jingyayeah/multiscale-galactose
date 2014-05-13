#!/bin/bash
############################################################
# Copies all SBML files to the specified servers
#
# @author: Matthias Koenig
# @date: 2014-05-13
############################################################
SBMLDIR=~/multiscale-galactose-results/django/sbml
IPS=(10.39.32.111 10.39.32.106 10.39.32.189 10.39.34.27)

for i in ${IPS[@]}; do
    echo "*** ${i} ***"    
    scp -r ${SBMLDIR} mkoenig@${i}:~/multiscale-galactose-results/django/
done


