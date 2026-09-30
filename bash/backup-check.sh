#!/usr/bin/env bash
set -u
TARGET="${1:-/var/backups}"
if [[ ! -d "$TARGET" ]]; then echo "Directory not found: $TARGET"; exit 1; fi

echo "===== BACKUP CHECK ====="
echo "Directory: $TARGET"
echo "Newest files:"
find "$TARGET" -type f -printf '%T@ %TY-%Tm-%Td %TH:%TM:%TS %p
' 2>/dev/null | sort -nr | head -n 20 | cut -d' ' -f2-

echo "Total size:"
du -sh "$TARGET" 2>/dev/null || true

echo "Files older than 30 days:"
find "$TARGET" -type f -mtime +30 -print 2>/dev/null | head -n 50
