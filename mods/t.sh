#!/bin/bash
source ~/.is-ma/ups/config.sh
source $IS_MA__UPS_PATH/mods/function.get_ups_access_log.sh
source $IS_MA__UPS_PATH/mods/function.save_ip_in_any_bag.sh
source $IS_MA__UPS_PATH/mods/function.get_ip_plus.sh

# get appropiate ups_access.log
ups_access_log=$(get_ups_access_log $1)
echo $ups_access_log

# Top NGINX ups_access.log stats
mainmenu () {
  echo ""
  echo "Top NGINX ups_access.log stats"
  echo "------------------------------"
  echo "Press 'm': GET             | request_method"
  echo "Press 'u': /robots.txt     | request_uri"
  echo "Press 'i': 66.249.66.38    | remote_addr" 
  echo "Press 'h': 20230421 15     | yyyymmdd hh"
  echo "Press 'c': 200             | status"
  echo "Press 't': 0.063           | request_time"
  echo "Press 'b': 5831            | body_bytes_sent"
  echo "Press 's': https           | scheme"
  echo "Press 'd': mydomain.com    | host"
  echo "Press 'r': '-'             | http_referer"
  echo "Press 'a': 'Mozilla/5.0'   | http_user_agent" 
  echo ""
  echo "Press 'q' to exit the script." echo ""
  read -n 1 -p "Input Selection: " mainmenuinput
  clear
  echo ""
  echo "------------------------------"

  if [ "$mainmenuinput" = "m" ]; then
    sudo cat $ups_access_log | cut -d' ' -f1 | sort | uniq --count | sort -n
  elif [ "$mainmenuinput" = "u" ]; then
    sudo cat $ups_access_log | cut -d' ' -f2 | sort | uniq --count | sort -n | tail -n100
  elif [ "$mainmenuinput" = "i" ]; then
    sudo cat $ups_access_log | cut -d' ' -f3 | sort | uniq --count | sort -n | tail -n100 | while read -r line; do
      # get values
      ip_address=$(echo $line | awk '{print $2}')
      count=$(echo $line | awk '{print $1}')

      # move ip_address to either whitelist or blacklist
      save_ip_in_any_bag $ip_address

      #  show ip_plus in results
      ip_plus=$(get_ip_plus $ip)
      echo $line | sed "s/$ip/$ip_plus/"
    done
  elif [ "$mainmenuinput" = "h" ]; then
    sudo cat $ups_access_log | cut -d' ' -f4,5 | cut -c1-11 | uniq --count
  elif [ "$mainmenuinput" = "c" ]; then
    sudo cat $ups_access_log | cut -d' ' -f6 | sort | uniq --count | sort -n
  elif [ "$mainmenuinput" = "t" ]; then
    sudo cat $ups_access_log | cut -d' ' -f7 | sort -nr | uniq --count
  elif [ "$mainmenuinput" = "b" ]; then
    sudo cat $ups_access_log | cut -d' ' -f8 | sort | uniq --count | sort -n
  elif [ "$mainmenuinput" = "s" ]; then
    sudo cat $ups_access_log | cut -d' ' -f9 | sort | uniq --count | sort -n
  elif [ "$mainmenuinput" = "d" ]; then
    sudo cat $ups_access_log | cut -d' ' -f10 | sort | uniq --count | sort -n
  elif [ "$mainmenuinput" = "r" ]; then
    sudo cat $ups_access_log | cut -d\| -f2 | sort | uniq --count | sort -n | tail -n100
  elif [ "$mainmenuinput" = "a" ]; then
    sudo cat $ups_access_log | cut -d\| -f3 | sort | uniq --count | sort -n | tail -n100
  elif [ "$mainmenuinput" = "q" ];then
    echo ""
    return 0
  elif [ "$mainmenuinput" = "Q" ];then
    echo ""
    return 0
  fi
  mainmenu
}

# This builds the main menu and routs the user to the function selected.
mainmenu
