#!/bin/bash
# Backup script for database

DBNAME="multiscale-galactose"
DATE=$(date +"%Y-%m-%d")
FILE="$DBNAME.$DATE.pg_dump"
echo "Backing up database $DBNAME to $FILE file, please wait..."
pg_dump $DBNAME > $FILE
