# Failed Login Detector

A bash script to detect SSH brute-force attempts by analyzing failed login attempts in `/var/log/auth.log`. Alerts are generated for IPs exceeding a threshold (default: 5 attempts) and written to an alert log.

## Usage
1. Ensure `config.sh` is in the same directory as `ALERTS_LOG` and `AUTH_LOG` defined.
2. Run:
   ```bash
   sudo ./failed_login.sh
   ```
3. Check alerts in the specified log file (e.g., alerts/alerts.log) as described in the configuration file.

## Dependencies
- awk, grep, sort, uniq (standard on Linux).
- /var/log/auth.log or equivalent.
- config.sh

## Example Alert
```bash
[2025-07-11 11:17:00] ALERT: 6 failed login attempts from 127.0.0.1
```
