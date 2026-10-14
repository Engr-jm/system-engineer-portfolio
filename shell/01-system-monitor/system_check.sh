#!/bin/bash

echo "================================"
echo " Linux System Health Check"
echo "================================"

echo "[Hostname]"
hostname

echo
echo "[Check Time]"
date

echo
echo "[CPU Load Average]"
uptime

echo
echo "[CPU Usage]"

read -r _ u1 n1 s1 i1 w1 irq1 sirq1 st1 rest < /proc/stat
total1=$((u1+n1+s1+i1+w1+irq1+sirq1+st1))
idle1=$((i1+w1))

sleep 1

read -r _ u2 n2 s2 i2 w2 irq2 sirq2 st2 rest < /proc/stat
total2=$((u2+n2+s2+i2+w2+irq2+sirq2+st2))
idle2=$((i2+w2))

total_diff=$((total2-total1))
idle_diff=$((idle2-idle1))

if [ "$total_diff" -gt 0 ]; then
    cpu_usage=$((100*(total_diff-idle_diff)/total_diff))
    echo "CPU Usage: ${cpu_usage}%"
else
    echo "CPU Usage: Unable to calculate"
fi

echo
echo "[Memory Usage]"
free -h

echo
echo "[Disk Usage]"
df -hT /

echo
echo "[Disk Usage Alert]"

THRESHOLD=80

DISK_USAGE=$(df -P / | awk 'NR==2 {gsub("%", "", $5); print $5}')

if [ "$DISK_USAGE" -ge "$THRESHOLD" ]; then
    echo "WARNING: Disk usage is ${DISK_USAGE}%"
else
    echo "OK: Disk usage is ${DISK_USAGE}%"
fi

echo
echo "================================"
echo " Check Completed"
echo "================================"
