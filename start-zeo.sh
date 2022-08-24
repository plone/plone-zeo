#!/bin/bash
set -e

DIRS=("/data/filestorage" "/data/blobstorage" "/data/cache" "/data/log" "/app/var")

# Create directories to be used by zeo
for DIR in "${DIRS[@]}"; do
    if [[ ! -d "${DIR}" ]]; then
        echo "Creating directories under ${DIR}"
        mkdir -p "${DIR}"
    fi
done

# MAIN ZEO Vars
[ -z ${ZEO_READ_ONLY+x} ] && export ZEO_READ_ONLY=false
[ -z ${ZEO_INVALIDATION_QUEUE_SIZE+x} ] && export ZEO_INVALIDATION_QUEUE_SIZE=100
[ -z ${ZEO_PACK_KEEP_OLD+x} ] && export ZEO_PACK_KEEP_OLD=true
[ -z ${ZEO_PORT+x} ] && export ZEO_PORT=8100

echo "======================================================================================="
echo "Starting ZEO on port ${ZEO_PORT}"
echo "======================================================================================="
/app/bin/runzeo -C etc/zeo.conf
