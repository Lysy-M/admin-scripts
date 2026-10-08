#!/usr/bin/env bash
set -u

echo "===== SSH / SERVICE AUDIT ====="

echo
echo "===== SSH SERVICE ====="
for svc in ssh sshd; do
  if systemctl list-unit-files --type=service 2>/dev/null | grep -q "^${svc}\.service"; then
    systemctl status "$svc" --no-pager 2>/dev/null || true
  fi
done

echo
echo "===== SSH LISTENERS ====="
ss -lntp 2>/dev/null | grep -E ':(22)\b' || echo "No SSH listener on TCP/22 detected."

echo
echo "===== SSH EFFECTIVE CONFIG (SAFE FIELDS) ====="
if command -v sshd >/dev/null 2>&1; then
  sshd -T 2>/dev/null \
    | grep -E '^(port|listenaddress|passwordauthentication|pubkeyauthentication|permitrootlogin|maxauthtries|allowusers|allowgroups)\b' \
    || true
else
  echo "sshd command not found."
fi

echo
echo "===== FAILED SYSTEMD UNITS ====="
systemctl --failed --no-pager 2>/dev/null || true
