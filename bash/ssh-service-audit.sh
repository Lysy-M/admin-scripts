#!/usr/bin/env bash
set -u

echo "===== SSH / SERVICE AUDIT ====="

echo
echo "===== SSH SERVICE ====="

SSH_SERVICE=""

for svc in ssh sshd; do
    if systemctl list-unit-files --type=service 2>/dev/null \
        | grep -q "^${svc}\.service"; then
        SSH_SERVICE="$svc"
        break
    fi
done

if [[ -n "$SSH_SERVICE" ]]; then
    systemctl status "$SSH_SERVICE" --no-pager 2>/dev/null || true
else
    echo "SSH service not detected."
fi

echo
echo "===== SSH LISTENERS ====="
ss -lntp 2>/dev/null \
    | grep -E ':(22)\b' \
    || echo "No SSH listener on TCP/22 detected."

echo
echo "===== SSH EFFECTIVE CONFIG ====="

if command -v sshd >/dev/null 2>&1; then
    SSH_CONFIG="$(sshd -T 2>/dev/null || true)"

    if [[ -n "$SSH_CONFIG" ]]; then
        printf '%s\n' "$SSH_CONFIG" \
            | grep -E '^(port|listenaddress|passwordauthentication|pubkeyauthentication|permitrootlogin|maxauthtries|allowusers|allowgroups)\b' \
            || true
    else
        echo "Effective sshd configuration unavailable without elevated privileges or complete server configuration."
    fi
else
    echo "sshd command not found."
fi

echo
echo "===== FAILED SYSTEMD UNITS ====="
systemctl --failed --no-pager 2>/dev/null || true
