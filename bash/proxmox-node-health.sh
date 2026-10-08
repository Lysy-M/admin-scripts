#!/usr/bin/env bash
set -u

echo "===== PROXMOX NODE HEALTH ====="
date
echo

if ! command -v pveversion >/dev/null 2>&1; then
  echo "ERROR: This script must be run on a Proxmox VE node (pveversion not found)."
  exit 1
fi

echo "===== VERSION ====="
pveversion -v | sed -n '1,20p'

echo
echo "===== CLUSTER ====="
if command -v pvecm >/dev/null 2>&1; then
  pvecm status 2>/dev/null || echo "Cluster status unavailable or node is standalone."
fi

echo
echo "===== NODE ====="
hostnamectl 2>/dev/null || hostname
uptime

echo
echo "===== STORAGE ====="
pvesm status 2>/dev/null || true

echo
echo "===== VM / CT STATUS ====="
qm list 2>/dev/null || true
pct list 2>/dev/null || true

echo
echo "===== FAILED SYSTEMD UNITS ====="
systemctl --failed --no-pager 2>/dev/null || true

echo
echo "===== FILESYSTEM ====="
df -hT -x tmpfs -x devtmpfs

echo
echo "===== MEMORY ====="
free -h
