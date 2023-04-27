#!/bin/bash
source ~/.is-ma/ups/config.sh

# Find last minute IPs offenders using IS_MA__UPS__XPLOIT_DIC regular expressions

# - will find last minute xploiters
# - will exclude whitelisted IPs
# - will ban those IPs
# - will report those IPs (logs/banned_ips.log)
# - report style: 20230426 15:33:50 207.46.13.218 /41080-club-herbalife

one_min_ago=$(date --date='1 minute ago' '+%Y%m%d %H:%M')
# if IP behaves aggressively a minute ago
# use this format first (as line) to filter URLs: 20230426 15:33:50 /41080-club-herbalife 207.46.13.218
sudo tail -n2000 $IS_MA__WEBLOG_PATH | grep "$one_min_ago" | awk '{print $4,$5,$2,$3}' | egrep -i "$IS_MA__XPLOIT_DIC" | while read -r line; do

  ip=$(echo $line | awk '{print $4}')

  # and if IP is already blocked
  if egrep -q " $ip$" $IS_MA__UPS_PATH/logs/banned_ips.log; then
    :  # command that does nothing
    #echo "DEBUG: IP was found on /logs/banned_ips.log" >> $IS_MA__UPS_PATH/logs/banned_ips.log
  else
    # if IP is in logs/whitelist.log
    if egrep -q "^$ip " $IS_MA__UPS_PATH/logs/whitelist.log; then
      # only log, never ban
      echo "$line #WhitelistedNotBanned" >> $IS_MA__UPS_PATH/logs/banned_ips.log
    else
      # log & ban
      echo "$line" >> $IS_MA__UPS_PATH/logs/banned_ips.log
      sudo ufw insert 1 deny from $ip to any > /dev/null 2>&1
    fi

  fi
done
