#!/bin/bash

# read configuration file
source /home/deploy/.ufw_police/config.sh

# add a new record to $UFW_POLICE_PATH/logs/daily_unique_ips_report.log
sudo cat $WEBLOG_PATH | cut -d: -f1 | sort -nu | cut -d[ -f2 | sort | uniq --count | sort -r >> $UFW_POLICE_PATH/logs/daily_unique_ips_report.log
