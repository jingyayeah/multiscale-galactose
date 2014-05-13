#!/bin/bash
############################################################
# Copy timecourses from servers to proper data directory
# for preprocessing.
#
# TODO: automatize the full preprocessing step
# TODO: generate parameter file
#
# @author: Matthias Koenig
# @date: 2014-05-13
############################################################

DATE=2014-05-12
STYPE=Galactose

IPS=(10.39.32.106 10.39.32.189 10.39.34.27)
DATA_DIR=~/multiscale-galactose-results/${DATE}_${STYPE}
mkdir $DATA_DIR 
mkdir $DATA_DIR/data
cd $DATA_DIR/data

for i in ${IPS[@]}; do
    echo "*** ${i} ***"
    
    scp mkoenig@${i}:~/multiscale-galactose-results/django/timecourse/$DATE/*.* .
done






