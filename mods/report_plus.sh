#!/bin/bash

# intro
# - beautify report.log with report_plus.log
# - show the verified DNS sign in the log

# example: 20230402 09:59 87 10 52.167.144.69
last_log=$(tail -n1 $UFW_POLICE_PATH/logs/report.log)

# get last IP, we will change it whith $ip_plus in the new log
ip=$(echo $last_log | awk '{print $5}')

# now get the $ip_plus (example: 52.167.144.69 msn.com.) and
# if not found an IP on ip_whitelist.log, at least will be $ip
ip_plus=$ip
if grep -q "^$ip " $UFW_POLICE_PATH/logs/ip_whitelist.log; then
  ip_plus=$(grep "^$ip " $UFW_POLICE_PATH/logs/ip_whitelist.log)
fi

# let's replace $ip with $ip_plus, delete last (.) and log!
new_log=$(echo $last_log | sed "s/$ip/$ip_plus/")
new_log=$(echo $new_log | sed 's/\.$//')
echo $new_log >> $UFW_POLICE_PATH/logs/report_plus.log

