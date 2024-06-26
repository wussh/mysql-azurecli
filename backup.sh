#!/bin/bash
set -e
TIMESTAMP=$(date +%F_%T)
BACKUP_FILE="/backup/mysql-backup-$TIMESTAMP.sql.gz"
echo "Backing up MySQL database..."
mysqldump -u ${MYSQL_USER} -p${MYSQL_PASSWORD} --all-databases | gzip > $BACKUP_FILE
echo "Backup completed. Uploading to Azure Blob Storage..."
az storage blob upload --account-name ${AZURE_ACCOUNT_NAME} --account-key ${AZURE_ACCOUNT_KEY} --container-name ${AZURE_CONTAINER_NAME} --file $BACKUP_FILE --name mysql-backup-$TIMESTAMP.sql.gz
echo "Upload completed."