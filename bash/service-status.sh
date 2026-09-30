#!/usr/bin/env bash
set -u
SERVICES=(ssh cron docker tailscaled zabbix-agent2 wazuh-agent)

echo "===== SERVICE STATUS ====="
for svc in "${SERVICES[@]}"; do
  printf "%-24s " "$svc"
  if systemctl list-unit-files --type=service 2>/dev/null | grep -q "^${svc}\.service"; then
    state="$(systemctl is-active "$svc" 2>/dev/null || true)"
    enabled="$(systemctl is-enabled "$svc" 2>/dev/null || true)"
    printf "active=%-10s enabled=%s
" "$state" "$enabled"
  else
    echo "not installed"
  fi
done
