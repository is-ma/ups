#!/bin/bash

# read configuration file
source /home/deploy/.is-ma/ups/config.sh

# date variables
today=$(date '+%d/%b/%Y')  # executes from logrotate before 00:00
#yesterday=$(date --date='1 day ago' '+%d/%b/%Y')  # executes from logrotate at 00:00
abbrev_day=$(date --date='1 day ago' '+%a')

# other variables
total_hits=$(sudo cat $IS_MA__WEBLOG_PATH | wc -l)
uniq_ip_count=$(sudo cat $IS_MA__WEBLOG_PATH | awk '{print $3}' | sort -nu | wc -l)

# add a new record to $IS_MA__UPS_PATH/logs/daily.log
printf "%8d %6d %s %s\n" $total_hits $uniq_ip_count $yesterday $abbrev_day >> $IS_MA__UPS_PATH/logs/daily.log
