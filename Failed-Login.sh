#!/bin/bash
# Specifies the shell interpreter to use for this script (bash).

# Failed Login Detector
# Detects SSH brute-force attempts in auth.log (no time window)


# Configuration


AUTH_LOG="/var/log/auth.log"  # Path to the authentication log file (update to ./target_auth.log for testing).
ALERTS_DIR="./alerts"  # Directory where alert logs will be stored.
ALERTS_LOG="$ALERTS_DIR/alerts.log"  # Full path to the alert log file.
FAILED_LOGIN_THRESHOLD=5  # Threshold for failed login attempts to trigger an alert.

# Create alerts directory


mkdir -p "$ALERTS_DIR"  # Creates the alerts directory if it doesn't exist, ensuring logs can be written.
chmod 755 "$ALERTS_DIR"  # Sets permissions to allow read/write/execute for owner and read/execute for others.

# Check if log file exists


if [ ! -f "$AUTH_LOG" ]; then  # Checks if the specified auth log file exists.
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: Log file $AUTH_LOG not found" >> "$ALERTS_LOG"  # Logs an error to ALERTS_LOG if the file is missing.
    exit 1  # Exits the script with an error code if the log file is not found.
fi  # Ends the if condition for checking the log file.

# Count failed logins by IP


failed_logins=$(awk '/Failed password/ {print $9}' "$AUTH_LOG" | sort | uniq -c | awk -v thresh="$FAILED_LOGIN_THRESHOLD" '$1 >= thresh {print $0}')  # Extracts IPs with failed logins, counts occurrences, and filters those exceeding the threshold.

# Generate alerts

if [ -n "$failed_logins" ]; then  # Checks if there are any IPs with failed logins exceeding the threshold.
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] DEBUG: Found failed login attempts exceeding threshold" >> "$ALERTS_LOG"  # Logs a debug message indicating suspicious activity was found.
    while IFS= read -r line; do  # Loops through each line of filtered failed login data.
        count=$(echo "$line" | awk '{print $1}')  # Extracts the number of failed attempts from the line.
        ip=$(echo "$line" | awk '{print $2}')  # Extracts the IP address from the line.
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] ALERT: $count failed login attempts from $ip" >> "$ALERTS_LOG"  # Logs an alert with the count and IP to ALERTS_LOG.
    done <<< "$failed_logins"  # Feeds the failed_logins variable into the while loop.
else  # Begins the else block for when no suspicious activity is found.
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] DEBUG: No failed login attempts exceeding threshold" >> "$ALERTS_LOG"  # Logs a debug message indicating no suspicious activity was found.
fi  # Ends the if-else condition for alert generation.
