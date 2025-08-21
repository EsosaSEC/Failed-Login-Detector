
# FAILED LOGIN DETECTOR

A bash script to detect SSH brute-force attempts by analyzing failed login attempts in `/var/log/auth.log`. Alerts are generated for IPs exceeding a threshold (default: 5 attempts).

 ## Usage
 1. Update `AUTH_LOG` in the script to your log file path (e.g., `/var/log/auth.log` or a copied log).
 2. Run:
    ```bash
    sudo ./failed_login.sh
    ```
 3. Check alerts in `./alerts/alerts.log`.

 ## Dependencies
 - `awk`, `grep`, `sort`, `uniq` (standard on Linux).

 ## Example Alert
 ```
 [2025-08-18 13:23:00] ALERT: 6 failed login attempts from 127.0.0.1
 ```

 ## Notes
 - Fully standalone with no external configuration dependencies.
 - Threshold adjustable via `FAILED_LOGIN_THRESHOLD` in the script.

 ## Author
 ESOSA OKONEDO
