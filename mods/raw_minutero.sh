#!/bin/bash

# intro
# - generates logs/raw_minutero.log
# - populates IP white and black bags

# include
source $IS_MA__UPS_PATH/mods/function.save_ip_in_any_bag.sh

# ups_access.log format
# request_method=$1
# request_uri=$2
# remote_addr=$3
# yyyymmdd=$4
# hhmmss=$5
# status=$6
# request_time=$7
# body_bytes_sent=$8
# scheme=$9
# host=$10
# http_referer=$11i
# http_user_agent=$12

# get last minute number of hits and the exact hour:minute 
one_min_ago=$(date --date='1 minute ago' '+%Y%m%d %H:%M')
hits=$(sudo tail -n2000 $IS_MA__WEBLOG_PATH | grep "$one_min_ago" | wc -l)

# get last minute more active IP and how many times it hits
sudo tail -n2000 $IS_MA__WEBLOG_PATH | grep "$one_min_ago" | awk '{print $3}' | sort -n | uniq --count | sort -nr | head -n1 > /tmp/top_ip_hits.txt
ip_hits=$(cat /tmp/top_ip_hits.txt | awk '{print $1}')
ip_address=$(cat /tmp/top_ip_hits.txt | awk '{print $2}')

# new function: save ip in any bag
save_ip_in_any_bag $ip_address

# let's log!
echo "$one_min_ago $hits $ip_hits $ip_address" >> $IS_MA__UPS_PATH/logs/raw_minutero.log
