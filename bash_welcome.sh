#!/bin/bash

# read configuration file
source /home/deploy/.is-ma/ups/config.sh

# show UPS alias and utilities
source $IS_MA__UPS_PATH/mods/aliases.sh

# show complete daily report (daily unique IPs count)
echo "tail $IS_MA__UPS_PATH/logs/daily.log"
tail $IS_MA__UPS_PATH/logs/daily.log

# and also TODAY unique IPs (using same code we use in once_a_day.sh)
echo "Today (until now)"
sudo cat $IS_MA__WEBLOG_PATH | cut -d: -f1 | sort -nu | cut -d[ -f2 | sort | uniq --count | sort -r

echo ""
echo "Today top IP hits/min (from $IS_MA__UPS_PATH/logs/minutero.log):"
grep $(date +"%Y%m%d") $IS_MA__UPS_PATH/logs/minutero.log | awk '{print $4,"--",$0}' | sort -nr | head -n3

echo ""
echo "Banned IPs (from $IS_MA__UPS_PATH/logs/banned_ips.log):"
tail -n3 $IS_MA__UPS_PATH/logs/banned_ips.log

echo ""
echo 'df -h | grep -E "Use%|vda1"'
df -h | grep -Ee "Use%|vda1"

echo ""
