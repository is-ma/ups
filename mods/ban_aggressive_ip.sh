#!/bin/bash

# intro
# - this module will ban aggressive (many hits) black IPs

# get last minute number of hits and the IP address
hits=$(tail -n1 $IS_MA__UPS_PATH/logs/raw_minutero.log | cut -d' ' -f4)
ip=$(tail -n1 $IS_MA__UPS_PATH/logs/raw_minutero.log | cut -d' ' -f5)
now=$(tail -n1 $IS_MA__UPS_PATH/logs/raw_minutero.log | cut -c -14)

# if the IP is in blacklist.log
if grep -q "^$ip$" $IS_MA__UPS_PATH/logs/blacklist.log; then

  # ... if the IP is being aggressive
  if [ $hits -gt $IS_MA__MAX_REQ_MIN ]; then 

    # ... well, fire!
    sudo ufw insert 1 deny from $ip to any > /dev/null 2>&1
    echo "$now $hits $ip" >> $IS_MA__UPS_PATH/logs/banned_ips.log

  fi
fi
