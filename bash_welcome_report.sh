#!/bin/bash

# read configuration file
source /home/deploy/.is-ma/ups/config.sh

# show complete daily report (daily unique IPs count)
echo ""
echo "cat $UFW_POLICE_PATH/logs/daily_unique_ips_report.log"
cat $UFW_POLICE_PATH/logs/daily_unique_ips_report.log

# and also TODAY unique IPs (using same code we use in once_a_day.sh)
echo "Today unique IPs (until now)"
sudo cat $WEBLOG_PATH | cut -d: -f1 | sort -nu | cut -d[ -f2 | sort | uniq --count | sort -r

echo ""
echo "Today top IP hits (from $UFW_POLICE_PATH/logs/report_plus.log):"
grep $(date +"%Y%m%d") $UFW_POLICE_PATH/logs/report_plus.log | awk '{print $4,"--",$0}' | sort -nr | head

echo ""
echo "Banned IPs (from $UFW_POLICE_PATH/logs/banned_ips.log):"
cat $UFW_POLICE_PATH/logs/banned_ips.log

echo ""
echo 'df -h | grep -E "Use%|vda1"'
df -h | grep -Ee "Use%|vda1"

echo ""
