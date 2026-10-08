#!/usr/bin/env bash
set -u

echo "===== SYSTEM INVENTORY ====="
date

echo
echo "===== HOST / OS ====="
hostnamectl 2>/dev/null || hostname
if [[ -r /etc/os-release ]]; then
  cat /etc/os-release
fi

echo
echo "===== KERNEL ====="
uname -a

echo
echo "===== CPU ====="
lscpu 2>/dev/null | sed -n '1,30p' || true

echo
echo "===== MEMORY ====="
free -h

echo
echo "===== STORAGE ====="
lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINTS 2>/dev/null || true
df -hT -x tmpfs -x devtmpfs 2>/dev/null

echo
echo "===== NETWORK ====="
ip -brief addr 2>/dev/null || true
