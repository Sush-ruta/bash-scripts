#!/bin/bash

# Check if yandex-disk is installed
if ! command -v yandex-disk &> /dev/null; then
    echo "yandex-disk is not installed. Aborting."
    exit 1
fi

# Stop the yandex-disk daemon
echo "Stopping yandex-disk daemon..."
yandex-disk stop

# Restart the yandex-disk daemon
echo "Starting yandex-disk daemon..."
yandex-disk start

# Sync with the cloud
echo "Syncing with the cloud..."
yandex-disk sync
