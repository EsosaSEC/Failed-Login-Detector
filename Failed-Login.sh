#!/bin/bash

# Failed login monitor for brute-force attempts (no time window)
source ./config.sh

# Check if log file exists
if [ ! -f "$AUTH_LOG" ]; then
    echo "Error: Log file $AUTH_LOG not found"
    exit 1
fi

# Count failed logins by IP
failed_logins=$(awk '/Failed password/ {print $9}' "$AUTH_LOG" | sort | uniq -c | awk -v thresh="$FAILED_LOGIN_THRESHOLD" '$1 >= thresh {print $0}')

# Generate alerts
if [ -n "$failed_logins" ]; then
    while IFS= read -r line; do
        count=$(echo "$line" | awk '{print $1}')
        ip=$(echo "$line" | awk '{print $2}')
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] ALERT: $count failed login attempts from $ip" >> "$ALERTS_LOG"
    done <<< "$failed_logins"
fi

