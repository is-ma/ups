#!/bin/bash

# read configuration file
source /home/deploy/.is-ma/ups/config.sh

# variables
hits=$(sudo cat $IS_MA__WEBLOG_PATH | wc -l)
uniq_ip_count=$(sudo cat $IS_MA__WEBLOG_PATH | awk '{print $3}' | sort -nu | wc -l)
yesterday=$(date --date='1 day ago' '+%d/%b/%Y')  # executes from logrotate at 00:00
abbrev_day=$(date --date='1 day ago' '+%a')

# add a new record to $IS_MA__UPS_PATH/logs/daily.log
printf "%8d %6d %s %s\n" $hits $uniq_ip_count $yesterday $abbrev_day >> $IS_MA__UPS_PATH/logs/daily.log
