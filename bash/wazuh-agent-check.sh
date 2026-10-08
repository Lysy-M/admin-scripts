#!/usr/bin/env bash
set -u

SERVICE="${1:-wazuh-agent}"

echo "===== WAZUH AGENT DIAGNOSTICS ====="
echo "Service: $SERVICE"
echo

echo "===== SERVICE ====="
systemctl status "$SERVICE" --no-pager 2>/dev/null || true

echo
echo "===== ENABLED / ACTIVE ====="
printf "enabled: "
systemctl is-enabled "$SERVICE" 2>/dev/null || true
printf "active:  "
systemctl is-active "$SERVICE" 2>/dev/null || true

echo
echo "===== PROCESS ====="
pgrep -a wazuh 2>/dev/null || echo "No Wazuh process detected."

echo
echo "===== RECENT LOGS ====="
journalctl -u "$SERVICE" -n 30 --no-pager 2>/dev/null || true

if [[ -r /var/ossec/logs/ossec.log ]]; then
  echo
  echo "===== /var/ossec/logs/ossec.log ====="
  tail -n 30 /var/ossec/logs/ossec.log
fi
