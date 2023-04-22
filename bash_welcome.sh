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
hits=$(sudo cat $IS_MA__WEBLOG_PATH | wc -l)
uniq_ip_count=$(sudo cat $IS_MA__WEBLOG_PATH | awk '{print $3}' | sort -nu | wc -l)
today=$(date '+%d/%b/%Y')
abbrev_day=$(date '+%a')
printf "%8d %6d %s %s\n" $hits $uniq_ip_count $today $abbrev_day

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
