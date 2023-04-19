#!/bin/bash

# intro
# - beautifyraw_minutero.log with minutero.log
# - show the verified DNS sign in the log

# example: 20230402 09:59 87 10 52.167.144.69
last_log=$(tail -n1 $IS_MA__UPS_PATH/logs/raw_minutero.log)

# get last IP, we will change it whith $ip_plus in the new log
ip=$(echo $last_log | awk '{print $5}')

# now get the $ip_plus (example: 52.167.144.69 msn.com.) and
# if not found an IP on whitelist.log, at least will be $ip
ip_plus=$ip
if grep -q "^$ip " $IS_MA__UPS_PATH/logs/whitelist.log; then
  ip_plus=$(grep "^$ip " $IS_MA__UPS_PATH/logs/whitelist.log)
fi

# let's replace $ip with $ip_plus, delete last (.) and log!
new_log=$(echo $last_log | sed "s/$ip/$ip_plus/")
new_log=$(echo $new_log | sed 's/\.$//')
echo $new_log | \
  awk '{
   if( $NF == 5 )
     printf "%s %s %4d %4d  %s\n",$1,$2,$3,$4,$5;
   else
     printf "%s %s %4d %4d  %s %s\n",$1,$2,$3,$4,$5,$6;
  }' >> $IS_MA__UPS_PATH/logs/minutero.log