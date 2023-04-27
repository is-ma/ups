#!/bin/bash
source ~/.is-ma/ups/config.sh
source $IS_MA__UPS_PATH/mods/function.get_ip_plus.sh

# - beautifyraw_minutero.log with minutero.log
# - show the verified DNS sign in the log

# example: 20230402 09:59 87 10 52.167.144.69
last_log=$(tail -n1 $IS_MA__UPS_PATH/logs/raw_minutero.log)

# ip -> ip_plus
ip=$(echo $last_log | awk '{print $5}')
ip_plus=$(get_ip_plus $ip)

new_log=$(echo $last_log | sed "s/$ip/$ip_plus/")
echo $new_log | \
  awk '{
   if( $NF == 5 )
     printf "%s %s %5d %4d  %s\n",$1,$2,$3,$4,$5;
   else
     printf "%s %s %5d %4d  %s %s\n",$1,$2,$3,$4,$5,$6;
  }' >> $IS_MA__UPS_PATH/logs/minutero.log
