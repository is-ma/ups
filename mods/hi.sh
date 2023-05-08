#!/bin/bash
source ~/.is-ma/ups/config.sh
source $IS_MA__UPS_PATH/mods/function.get_ups_access_log.sh
source $IS_MA__UPS_PATH/mods/ipplus/function.iptoplus.sh

# get appropiate ups_access.log
ups_access_log=$(get_ups_access_log $1)

sudo cat $ups_access_log | cut -d' ' -f3 | sort | uniq --count | sort -n | tail -n100 | while read -r line; do
  # get values
  ip_address=$(echo $line | awk '{print $2}')
  count=$(echo $line | awk '{print $1}')

  #  show ip_plus in results
  ipplus=$(iptoplus $ip_address)
  echo "$count $ipplus"
done
