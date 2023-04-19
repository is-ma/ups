#!/bin/bash

# intro
# - generates logs/raw_minutero.log
# - populates IP white and black bags

# include
source $IS_MA__UPS_PATH/mods/function.save_ip_in_any_bag.sh

# get last minute number of hits and the exact hour:minute 
one_min_ago=$(date --date='1 minute ago' '+%H:%M')
sudo tail -n2000 $IS_MA__WEBLOG_PATH | cut -d: -f2,3 | uniq --count | grep $one_min_ago > /tmp/last_min_hits.txt
hits=$(cat /tmp/last_min_hits.txt | awk '{print $1}')
hour_min=$(cat /tmp/last_min_hits.txt | awk '{print $2}')
today=$(date +"%Y%m%d")

# get last minute more active IP and how many times it hits
sudo tail -n2000 $IS_MA__WEBLOG_PATH | grep -e ":$hour_min:[0-9][0-9] " | cut -d' ' -f1 | sort | uniq --count | sort -nr | head -n1 > /tmp/top_ip_hits.txt
ip_address=$(cat /tmp/top_ip_hits.txt | awk '{print $2}')
ip_hits=$(cat /tmp/top_ip_hits.txt | awk '{print $1}')

# new function: save ip in any bag
save_ip_in_any_bag $ip_address

# let's log!
echo "$today $hour_min $hits $ip_hits $ip_address" >> $IS_MA__UPS_PATH/logs/raw_minutero.log
