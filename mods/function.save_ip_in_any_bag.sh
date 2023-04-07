#!/bin/bash
# save IP in either whitelist or blacklist

save_ip_in_any_bag () {
  ip=$1

  # if IP is already in ANY bag, exit now
  if grep -q $ip $UFW_POLICE_PATH/logs/ip_whitelist.log; then 
    return 0
  fi
  if grep -q $ip $UFW_POLICE_PATH/logs/ip_blacklist.log; then
    return 0
  fi

  # legal crawler list
  crawler_dns=()
  crawler_dns+=("baidu.com.")
  crawler_dns+=("baidu.jp.")
  crawler_dns+=("msn.com.")
  crawler_dns+=("google.com.")
  crawler_dns+=("googlebot.com.")
  crawler_dns+=("yahoo.net.")
  crawler_dns+=("yandex.ru.")
  crawler_dns+=("yandex.net.")
  crawler_dns+=("yandex.com.")
  crawler_dns+=("dataforseo.com.")

  # let's find if the IP is a legal crawler
  dns_lookup=$(host $ip)

  # any IP is black until you show is white
  ip_status=black
  for (( i=0; i < ${#crawler_dns[@]}; i++ )) do
    if [[ $dns_lookup == *"${crawler_dns[i]}"* ]]; then 
      ip_status=white
      echo "$ip ${crawler_dns[i]}" >> $UFW_POLICE_PATH/logs/ip_whitelist.log
    fi
  done
  # still black? well, let's put that IP in the black list
  if [[ $ip_status == "black" ]]; then 
    echo "$ip" >> $UFW_POLICE_PATH/logs/ip_blacklist.log
  fi

  # useful to debug
  #echo "IP status: $ip_status"
  #echo "Host: $dns_lookup"
}
