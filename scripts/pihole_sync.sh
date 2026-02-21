#!/bin/bash

# This is an extra script to sync the pihole container with the remote server
# It has been replaced by the Nebula Sync Implementation

CONFIG="${CONFIG}"
SRC="${CONFIG}/pihole"
DST_USER="${USER}"
DST_HOST="${DST_HOST}"
DST_DIR="${CONFIG}/pihole"
REMOTE="${DST_USER}@${DST_HOST}:${DST_DIR}"
HASH_FILE="${CONFIG}/pihole/.pihole_sync_hash"
LOG_FILE="${CONFIG}/pihole/pihole_sync.log"
CONTAINER_NAME="pihole"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Function to log
log() {
    echo "[$TIMESTAMP] $1" >> "$LOG_FILE"
}

# Generate hash of the current directory, excluding log files and temporary files
CURRENT_HASH=$(find "$SRC" -type f ! -name "*.log" ! -name "*.db-wal" ! -name "*.db-shm" ! -name ".pihole_sync_hash" -exec md5sum {} \; 2>/dev/null | sort | md5sum | awk '{print $1}')

# Read previous hash
LAST_HASH=""
if [ -f "$HASH_FILE" ]; then
    LAST_HASH=$(cat "$HASH_FILE")
fi

#   If hashes are different, sync and restart
if [ "$CURRENT_HASH" != "$LAST_HASH" ]; then
    log "Changes detected. Starting rsync..."

    # Fix logrotate permissions
    sudo setfacl -R -m u:"${USER}":rwx "${CONFIG}"

    # Executes rsync
    rsync -avz --delete -e ssh "$SRC" "$REMOTE" >> "$LOG_FILE" 2>&1
    RSYNC_EXIT=$?

    if [ $RSYNC_EXIT -eq 0 ]; then
        echo "$CURRENT_HASH" > "$HASH_FILE"
        log "Rsync completed successfully."

        # Restart container remotely
        ssh "$DST_USER@$DST_HOST" "/usr/bin/docker restart $CONTAINER_NAME" >> "$LOG_FILE" 2>&1
        if [ $? -eq 0 ]; then
            log "Container $CONTAINER_NAME restarted successfully on $DST_HOST."
        else
            log "Failed to restart container on $DST_HOST!"
        fi
    else
        log "Rsync failed (code $RSYNC_EXIT). Aborting restart."
    fi
else
    log "No changes detected. No action taken."
fi
