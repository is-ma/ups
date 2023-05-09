#!/bin/bash
source ~/.is-ma/ups/config.sh

# intro
# - this module will ban aggressive (many hits) black IPs

# get last minute number of hits and the IP address
hits=$(tail -n1 $IS_MA__UPS_PATH/logs/minutero.log | awk '{print $4}')
ip=$(tail -n1 $IS_MA__UPS_PATH/logs/minutero.log | awk '{print $5}')
domain=$(tail -n1 $IS_MA__UPS_PATH/logs/minutero.log | awk '{print $6}')
now=$(tail -n1 $IS_MA__UPS_PATH/logs/minutero.log | cut -c -17)

# if domain is in the friendly_crawlers.conf, quit
if grep -q " $domain$" $IS_MA__UPS_PATH/mods/ipplus/friendly_crawlers.conf; then 
  : # friendly traffic: do nothing
else
  # mmm... is this IP being aggressive?
  if [ $hits -gt $IS_MA__MAX_REQ_MIN ]; then 
    # ... well, fire!
    sudo ufw insert 1 deny from $ip to any > /dev/null 2>&1
    echo "$now $hits $ip" >> $IS_MA__UPS_PATH/logs/banned_ips.log
  fi
fi
