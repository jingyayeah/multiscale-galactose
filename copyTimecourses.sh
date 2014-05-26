#!/bin/bash
############################################################
# Syncronizes the timecourses to the data analysis server.
# - just Rsync the full folder
#
# TODO: call from the scripts
# @author: Matthias Koenig
# @date: 2014-05-13
############################################################

DATA=/home/mkoenig/multiscale-galactose-results/django/timecourse/

TARGET=10.39.34.27
IPS=(10.39.32.106 10.39.32.189 10.39.32.111)

# -r recursively
# -a archive option
# -v verbose
# -z compress during the transfer
# -X preserve extended attributes

for i in ${IPS[@]}; do
    echo "*** ${i} ***"
    rsync -ravzX --delete mkoenig@${i}:${DATA} mkoenig@${TARGET}:${DATA}
done




