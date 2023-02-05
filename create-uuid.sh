#!/bin/bash

if [ -f /boot/theairtraffic-config.txt ]; then
    UUID_FILE="/boot/theairtraffic-uuid"
else
    mkdir -p /usr/local/share/theairtraffic
    UUID_FILE="/usr/local/share/theairtraffic/theairtraffic-uuid"
    # move old file position
    if [ -f /boot/theairtraffic-uuid ]; then
        mv -f /boot/theairtraffic-uuid $UUID_FILE
    fi
fi

function generateUUID() {
    rm -f $UUID_FILE
    sleep 0.$RANDOM; sleep 0.$RANDOM
    UUID=$(cat /proc/sys/kernel/random/uuid)
    echo New UUID: $UUID
    echo $UUID > $UUID_FILE
}

# Check for a (valid) UUID...
if [ -f $UUID_FILE ]; then
    UUID=$(cat $UUID_FILE)
    if ! [[ $UUID =~ ^\{?[A-F0-9a-f]{8}-[A-F0-9a-f]{4}-[A-F0-9a-f]{4}-[A-F0-9a-f]{4}-[A-F0-9a-f]{12}\}?$ ]]; then
        # Data in UUID file is invalid.  Regenerate it!
        echo "WARNING: Data in UUID file was invalid.  Regenerating UUID."
        generateUUID
    else
        echo "Using existing valid UUID ($UUID) from $UUID_FILE"
    fi
else
    # not found generate uuid and save it
    echo "WARNING: No UUID file found, generating new UUID..."
    generateUUID
fi

exit 0
