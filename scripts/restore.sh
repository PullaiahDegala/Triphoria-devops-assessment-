#!/bin/bash

set -e

if [ $# -eq 0 ]; then
    echo "Usage:"
    echo "./scripts/restore.sh backups/backup_file.sql"
    exit 1
fi

BACKUP_FILE=$1

if [ ! -f "$BACKUP_FILE" ]; then
    echo "Backup file not found!"
    exit 1
fi

echo "Dropping existing tables..."

docker exec assessment_pg psql \
    -U appuser \
    -d appdb \
    -c "DROP SCHEMA public CASCADE;
        CREATE SCHEMA public;"

echo "Restoring database..."

cat "$BACKUP_FILE" | docker exec -i assessment_pg psql \
    -U appuser \
    -d appdb

echo "-------------------------------------"
echo "Restore completed successfully"
echo "-------------------------------------"