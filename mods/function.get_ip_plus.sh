#!/bin/bash
source /home/deploy/.is-ma/ups/config.sh

# Get 'ip_plus' (otherwise 'ip')
get_ip_plus() {
  # human friendly parameter
  ip=$1

  # find $ip_plus (example: 52.167.144.69 msn.com.) and
  # if not found an IP on whitelist.log, return $ip
  ip_plus=$ip
  if grep -q "^$ip " $IS_MA__UPS_PATH/logs/whitelist.log; then
    # find ip_plus and strip last '.'
    ip_plus=$(grep "^$ip " $IS_MA__UPS_PATH/logs/whitelist.log)
    ip_plus=$(echo $ip_plus | sed 's/\.$//')
  fi

  echo $ip_plus
}
