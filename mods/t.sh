#!/bin/bash

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
    sudo cat /var/log/nginx/ups_access.log | cut -d' ' -f1 | sort | uniq --count | sort -n
  elif [ "$mainmenuinput" = "u" ]; then
    sudo cat /var/log/nginx/ups_access.log | cut -d' ' -f2 | sort | uniq --count | sort -n | tail -n100
  elif [ "$mainmenuinput" = "i" ]; then
    sudo cat /var/log/nginx/ups_access.log | cut -d' ' -f3 | sort | uniq --count | sort -n | tail -n100
  elif [ "$mainmenuinput" = "h" ]; then
    sudo cat /var/log/nginx/ups_access.log | cut -d' ' -f4,5 | cut -c1-11 | uniq --count
  elif [ "$mainmenuinput" = "c" ]; then
    sudo cat /var/log/nginx/ups_access.log | cut -d' ' -f6 | sort | uniq --count | sort -n
  elif [ "$mainmenuinput" = "t" ]; then
    sudo cat /var/log/nginx/ups_access.log | cut -d' ' -f7 | sort -nr | uniq --count
  elif [ "$mainmenuinput" = "b" ]; then
    sudo cat /var/log/nginx/ups_access.log | cut -d' ' -f8 | sort | uniq --count | sort -n
  elif [ "$mainmenuinput" = "s" ]; then
    sudo cat /var/log/nginx/ups_access.log | cut -d' ' -f9 | sort | uniq --count | sort -n
  elif [ "$mainmenuinput" = "d" ]; then
    sudo cat /var/log/nginx/ups_access.log | cut -d' ' -f10 | sort | uniq --count | sort -n
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