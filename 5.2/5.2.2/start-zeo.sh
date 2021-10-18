#!/bin/bash
set -e

# Create directories to be used by zeo
mkdir -p /data/filestorage /data/blobstorage /data/cache /data/log

/app/bin/runzeo -C etc/zeo.conf
