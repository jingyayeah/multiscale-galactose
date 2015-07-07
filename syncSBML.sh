#!/bin/bash
############################################################
# Syncronizes the tmp_sbml files to the target servers
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


DATA=/home/mkoenig/multiscale-galactose-results/tmp_sbml/

# TARGETS=(10.39.34.27)
TARGETS=(10.39.32.106 10.39.32.189 10.39.32.111 10.39.34.27 10.39.32.236)

# -r recursively
# -a archive option
# -v verbose
# -z compress during the transfer
# -X preserve extended attributes

for i in ${TARGETS[@]}; do
    echo "*** ${i} ***"
    rsync -rvz ${DATA} mkoenig@${i}:${DATA}
done


