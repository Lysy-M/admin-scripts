#!/usr/bin/env bash
set -u

TEST_HOST="${1:-1.1.1.1}"

echo "===== LINUX NETWORK DIAGNOSTICS ====="
echo "Test host: $TEST_HOST"

echo
echo "===== INTERFACES ====="
ip -brief addr 2>/dev/null || ip addr

echo
echo "===== ROUTES ====="
ip route 2>/dev/null || true

echo
echo "===== DNS ====="
if command -v resolvectl >/dev/null 2>&1; then
  resolvectl status 2>/dev/null | sed -n '1,120p'
else
  cat /etc/resolv.conf 2>/dev/null || true
fi

echo
echo "===== LISTENING PORTS ====="
ss -lntup 2>/dev/null | sed -n '1,80p' || true

echo
echo "===== CONNECTIVITY ====="
ping -c 2 -W 2 "$TEST_HOST" 2>/dev/null || echo "Ping failed or ICMP is blocked."
