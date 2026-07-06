#!/bin/bash

set -e

BACKUP_DIR="./backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/backup_${TIMESTAMP}.sql"

mkdir -p "$BACKUP_DIR"

echo "Creating database backup..."

docker exec assessment_pg pg_dump \
    -U appuser \
    -d appdb \
    --clean \
    --if-exists \
    > "$BACKUP_FILE"

echo "-------------------------------------"
echo "Backup completed successfully"
echo "File: $BACKUP_FILE"
echo "-------------------------------------"