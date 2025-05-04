#!/bin/bash

set -e

source .env

echo "Dumping Observium database to file..."
mysqldump -u observium --databases observium --no-tablespaces --add-drop-table --extended-insert | gzip > observium-database-$(date '+%Y-%m-%d').sql.gz

echo "Compressing RRD data..."
tar zcf observium-rrd-$(date '+%Y-%m-%d').tar.gz /opt/observium/rrd

echo "Removing backup files older than 28 days..."
find . -ctime +28 -name "*.gz" -print -delete
