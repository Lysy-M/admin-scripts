#!/usr/bin/env bash
set -u

SERVICE="${1:-zabbix-agent2}"

echo "===== ZABBIX AGENT DIAGNOSTICS ====="
echo "Service: $SERVICE"
echo

if ! command -v systemctl >/dev/null 2>&1; then
  echo "ERROR: systemctl not available."
  exit 1
fi

echo "===== SERVICE ====="
systemctl status "$SERVICE" --no-pager 2>/dev/null || true

echo
echo "===== ENABLED / ACTIVE ====="
printf "enabled: "
systemctl is-enabled "$SERVICE" 2>/dev/null || true
printf "active:  "
systemctl is-active "$SERVICE" 2>/dev/null || true

echo
echo "===== LISTENING PORTS ====="
ss -lntup 2>/dev/null | grep -E ':(10050|10051)\b' || echo "No Zabbix ports detected."

echo
echo "===== RECENT LOGS ====="
journalctl -u "$SERVICE" -n 30 --no-pager 2>/dev/null || true
