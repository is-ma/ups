#!/bin/bash
source ~/.is-ma/ups/config.sh
source $IS_MA__UPS_PATH/mods/ipplus/function.iptoplus.sh

# Find last minute aggressive unfriendly crawlers

# This script will find last minute aggressive unfriendly crawlers,
# will ban those IPs, will report those IPs (logs/banned_ips.log),
# and use report style: 20230426 15:33:50 207.46.13.218 199

one_min_ago=$(date --date='1 minute ago' '+%Y%m%d %H:%M')
# if IP behaves aggressively a minute ago
sudo tail -n2000 $IS_MA__WEBLOG_PATH | grep "$one_min_ago" | awk '{print $3}' | sort | uniq -c | sort -nr | while read -r line; do

  # split $line '4 52.6.243.18'
  hits=$(echo $line | awk '{print $1}')
  ip=$(echo $line | awk '{print $2}')

  # mmm... is this IP being aggressive?
  if [ $hits -gt $IS_MA__MAX_REQ_MIN ]; then

    # and if IP is already blocked
    if egrep -q " $ip " $IS_MA__UPS_PATH/logs/banned_ips.log; then
      :  # command that does nothing
      #echo "DEBUG: IP was found on /logs/banned_ips.log" >> $IS_MA__UPS_PATH/logs/banned_ips.log
    else

      # iptoplus($ip): 167.172.74.244 ---
      dnsdomain=$( iptoplus $ip | awk '{print $2}' )  # ---
      if grep -q " $dnsdomain$" $IS_MA__UPS_PATH/mods/ipplus/friendly_crawlers.conf; then
        # friendly: only log, never ban
        echo "$one_min_ago:00 $ip $hits #WhitelistedNotBanned" >> $IS_MA__UPS_PATH/logs/banned_ips.log
      else
        # unfriendly: log & ban -> 20230509 11:39:05 /wp-login.php 87.116.133.201
        echo "$one_min_ago:00 $ip [$dnsdomain, $hits]" >> $IS_MA__UPS_PATH/logs/banned_ips.log
        sudo ufw insert 1 deny from $ip to any > /dev/null 2>&1
      fi

    fi
  fi
done
