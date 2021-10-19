#!/bin/bash
set -e

# Create directories to be used by zeo
mkdir -p /data/filestorage /data/blobstorage /data/cache /data/log

# MAIN ZEO Vars
[ -z ${ZEO_READ_ONLY+x} ] && export ZEO_READ_ONLY=false
[ -z ${ZEO_INVALIDATION_QUEUE_SIZE+x} ] && export ZEO_INVALIDATION_QUEUE_SIZE=100
[ -z ${ZEO_PACK_KEEP_OLD+x} ] && export ZEO_PACK_KEEP_OLD=true
[ -z ${ZEO_PORT+x} ] && export ZEO_PORT=8100

echo "Starting ZEO on port ${ZEO_PORT}"
/app/bin/runzeo -C etc/zeo.conf
