#!/bin/bash
############################################################
# Backup script for database
# use the pg_restore to get the information back into the system
# necessary to create the oids
#
# This script is run in a cron job every night.
# 0 2 * * * ${MULTISCALE_GALACTOSE}/backupDatabase.sh
#
# DBNAME="multiscale-galactose" is available shell variable.
#
# @author: Matthias Koenig
# @date: 2014-05-26
############################################################

DUMP_DIR="${MULTISCALE_GALACTOSE}/database/dumps"
DATE=$(date +"%Y-%m-%d")

FILE="${DUMP_DIR}/${DATE}_${DBNAME}.sql"
FILE_LATEST="${DUMP_DIR}/${DBNAME}_latest.sql"

echo "#################################"
echo "#       Database Backup         #"
echo "#################################"
echo "'$DBNAME' -> $FILE"
echo "'$DBNAME' -> $FILE_LATEST"
pg_dump --oids $DBNAME > $FILE
cp ${FILE} ${FILE_LATEST}
echo "#################################"

############################################################
