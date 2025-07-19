#!/bin/bash

set -e

if [[ "$OSTYPE" == "darwin"* ]]; then
    hw_id=$(system_profiler SPHardwareDataType | grep "Hardware UUID" | awk '{print $3}' | cut -c1-8)
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    hw_id=$(sudo dmidecode -s system-uuid | cut -c1-8)
else
    echo "Unsupported OS"
    exit 1
fi

ssh-keygen -t ed25519 -f ~/.ssh/"$hw_id" -C "${hw_id}"

cat ~/.ssh/"$hw_id".pub
