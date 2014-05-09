#!/bin/bash
# Backup script for database
# use the pg_restore to get the information back into the system
# necessary to create the oids

DUMP_DIR="./database/dumps"
DBNAME="multiscale-galactose"

DATE=$(date +"%Y-%m-%d")
FILE="${DUMP_DIR}/${DATE}_${DBNAME}.sql"

echo "Backing up database $DBNAME to $FILE file, please wait..."
pg_dump --oids $DBNAME > $FILE

# copy to latest so it can be easily deployed
FILE_LATEST="${DUMP_DIR}/${DBNAME}_latest.sql"
cp ${FILE} ${FILE_LATEST}
