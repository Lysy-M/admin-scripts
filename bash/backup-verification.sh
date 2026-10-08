#!/usr/bin/env bash
set -u

TARGET="${1:-/var/backups}"
MAX_AGE_HOURS="${2:-48}"

if [[ ! -d "$TARGET" ]]; then
  echo "ERROR: Backup directory not found: $TARGET"
  exit 1
fi

echo "===== BACKUP VERIFICATION ====="
echo "Directory: $TARGET"
echo "Expected newest file age <= ${MAX_AGE_HOURS}h"

newest_epoch="$(find "$TARGET" -type f -printf '%T@\n' 2>/dev/null | sort -nr | head -n1 | cut -d. -f1)"

if [[ -z "${newest_epoch:-}" ]]; then
  echo "ERROR: No backup files found."
  exit 2
fi

now_epoch="$(date +%s)"
age_hours="$(( (now_epoch - newest_epoch) / 3600 ))"

echo "Newest backup age: ${age_hours}h"
if (( age_hours <= MAX_AGE_HOURS )); then
  echo "RESULT: OK"
  rc=0
else
  echo "RESULT: WARNING - newest backup is older than expected"
  rc=3
fi

echo
echo "===== NEWEST FILES ====="
find "$TARGET" -type f -printf '%T@ %TY-%Tm-%Td %TH:%TM:%TS %s %p\n' 2>/dev/null \
  | sort -nr | head -n 20 | cut -d' ' -f2-

echo
echo "===== TOTAL SIZE ====="
du -sh "$TARGET" 2>/dev/null || true

exit "$rc"
