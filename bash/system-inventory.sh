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

echo
echo "===== BOOT USAGE CHECK ====="

if mountpoint -q /boot 2>/dev/null; then
    BOOT_USE="$(df --output=pcent /boot 2>/dev/null | tail -1 | tr -dc '0-9')"

    if [[ -n "$BOOT_USE" ]]; then
        echo "/boot usage: ${BOOT_USE}%"

        if (( BOOT_USE >= 90 )); then
            echo "STATUS: CRITICAL - /boot is almost full."
        elif (( BOOT_USE >= 80 )); then
            echo "STATUS: WARNING - /boot usage is high."
        else
            echo "STATUS: OK"
        fi
    fi
else
    echo "/boot is not a separate mounted filesystem."
fi
