#!/bin/bash


if JOURNAL_LOG=$(sudo journalctl -b -p err --no-pager); then
echo "Log read success"
else
    echo "Log read failed"
exit 1

fi

ERROR_LOG=$(printf '%s\n' "$JOURNAL_LOG" | grep "portfolio-lab");

if [ -n "$ERROR_LOG" ]; then
ERROR_COUNT=$(printf '%s\n' "$ERROR_LOG" | wc -l)

echo "WARNING: Error found"
echo "Error count: $ERROR_COUNT"
echo "$ERROR_LOG"
else
echo "OK: NO error"
fi
