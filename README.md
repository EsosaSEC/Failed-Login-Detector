# Failed Login Detector

A bash script to detect SSH brute-force attempts by analyzing failed login attempts in `/var/log/auth.log`. Alerts are generated for IPs exceeding a threshold (default: 5 attempts) and written to an alert log.

## Usage
1. Use this [`configuration file`](https://github.com/EsosaSEC/Configuration-file/blob/main/config.sh) file and ensure `ALERTS_LOG` and `AUTH_LOG` are defined in the file, and are in the same directory.
2. Run:
   ```bash
   sudo ./failed_login.sh
   ```
3. Check alerts in the specified log file (e.g., alerts/alerts.log) as described in the configuration file.

## Dependencies
- awk, grep, sort, uniq (standard on Linux).
- /var/log/auth.log or equivalent.
- [config.sh](https://github.com/EsosaSEC/Configuration-file/blob/main/config.sh)

## Example Alert
```bash
[2025-07-11 11:17:00] ALERT: 6 failed login attempts from 127.0.0.1
```
