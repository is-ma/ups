#!/bin/bash

# read configuration file
source /home/deploy/.is-ma/ups/config.sh

# add a new record to $IS_MA__UPS_PATH/logs/daily.log
sudo cat $IS_MA__WEBLOG_PATH | cut -d: -f1 | sort -nu | cut -d[ -f2 | sort | uniq --count | sort -r >> $IS_MA__UPS_PATH/logs/daily.log
