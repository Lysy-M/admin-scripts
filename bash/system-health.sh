#!/usr/bin/env bash
set -u

echo "===== SYSTEM HEALTH ====="
date

echo "===== HOST ====="
hostnamectl 2>/dev/null || hostname

echo "===== UPTIME / LOAD ====="
uptime

echo "===== MEMORY ====="
free -h

echo "===== FILESYSTEM ====="
df -hT -x tmpfs -x devtmpfs

echo "===== FAILED SYSTEMD UNITS ====="
systemctl --failed --no-pager 2>/dev/null || true

echo "===== TOP CPU PROCESSES ====="
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 12

echo "===== TOP MEMORY PROCESSES ====="
ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 12

echo "===== TEMPERATURES ====="
if command -v sensors >/dev/null 2>&1; then sensors; else echo "lm-sensors not installed or unavailable."; fi
