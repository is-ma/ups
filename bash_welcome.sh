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
echo "Last banned (from $IS_MA__UPS_PATH/logs/banned_ips.log):"
tail -n10 $IS_MA__UPS_PATH/logs/banned_ips.log

echo ""
echo 'df -h | grep -E "Use%|vda1"'
df -h | grep -Ee "Use%|vda1"

echo ""
