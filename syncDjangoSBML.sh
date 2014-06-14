#!/bin/bash
############################################################
# Syncronizes the django sbml files to the target servers
#
# Local:  rsync [OPTION...] SRC... [DEST]
#
# @author: Matthias Koenig
# @date: 2014-05-13
############################################################
# SBMLDIR=~/multiscale-galactose-results/django/sbml
# IPS=(10.39.32.111 10.39.32.106 10.39.32.189 10.39.34.27)

# for i in ${IPS[@]}; do
#     echo "*** ${i} ***"    
#     scp -r ${SBMLDIR} mkoenig@${i}:~/multiscale-galactose-results/django/
# done


DATA=/home/mkoenig/multiscale-galactose-results/django/sbml/

# TARGETS=(10.39.34.27)
# TARGETS=(10.39.32.106 10.39.32.189 10.39.32.111 10.39.34.27)
TARGETS=(192.168.1.99 192.168.1.100)

# -r recursively
# -a archive option
# -v verbose
# -z compress during the transfer
# -X preserve extended attributes

for i in ${TARGETS[@]}; do
    echo "*** ${i} ***"
    rsync -rvz ${DATA} mkoenig@${i}:${DATA}
done
