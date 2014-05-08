#!/bin/bash
# Backup script for database

DUMP_DIR="./database/dumps"
DBNAME="multiscale-galactose"

DATE=$(date +"%Y-%m-%d")
FILE="${DUMP_DIR}/${DATE}_${DBNAME}.pg_dump"

echo "Backing up database $DBNAME to $FILE file, please wait..."
pg_dump $DBNAME > $FILE

# copy to latest so it can be easily deployed
FILE_LATEST="${DUMP_DIR}/${DBNAME}_latest.dmp"
cp ${FILE} ${FILE_LATEST}
