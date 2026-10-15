#!/bin/bash

SOURCE_DIR="/home/admin/shell-lab/04-backup-automation"
BACKUP_DIR="${SOURCE_DIR}/backups"
BACKUP_DATE=$(date +%Y%m%d-%H%M%S)
BACKUP_FILE="backup-${BACKUP_DATE}.tar.gz"
BACKUP_PATH="${BACKUP_DIR}/${BACKUP_FILE}"

mkdir -p "$BACKUP_DIR" || exit 1

echo "Backup started: $(date)"

if tar -czvf "$BACKUP_PATH" -C "$SOURCE_DIR" testdata; then
    echo "Backup SUCCESS"
    echo "Backup file: $BACKUP_PATH"
else
    echo "Backup FAILED"
    exit 1
fi
