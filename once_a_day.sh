#!/bin/bash

# read configuration file
source /home/deploy/.is-ma/ups/config.sh
source $IS_MA__UPS_PATH/mods/function.get_ups_access_log.sh

# get yesterday's access log
today=$(date '+%Y%m%d') #yyyymmdd
IS_MA__UPS_ACCESS_LOG=$(get_ups_access_log $today)

# other variables
friendly_yesterday=$(date --date='1 day ago' '+%d/%b/%Y %a')
total_hits=$(sudo cat $IS_MA__UPS_ACCESS_LOG | wc -l)
uniq_ip_count=$(sudo cat $IS_MA__UPS_ACCESS_LOG | awk '{print $3}' | sort -nu | wc -l)

# add a new record to $IS_MA__UPS_PATH/logs/daily.log
printf "%8d %6d %s %s\n" $total_hits $uniq_ip_count $friendly_yesterday >> $IS_MA__UPS_PATH/logs/daily.log
