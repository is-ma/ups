#!/bin/bash

# intro
# - this module will ban aggressive (many hits) black IPs

# get last minute number of hits and the IP address
hits=$(tail -n1 $UFW_POLICE_PATH/logs/report.log | cut -d' ' -f4)
ip=$(tail -n1 $UFW_POLICE_PATH/logs/report.log | cut -d' ' -f5)
now=$(tail -n1 $UFW_POLICE_PATH/logs/report.log | cut -c -14)

# if the IP is in blacklist.log
if grep -q $ip $UFW_POLICE_PATH/logs/blacklist.log; then

  # ... if the IP is being aggressive
  if [ $hits -gt $MAX_IP_REQUESTS_PER_MIN_WITHOUT_BANNING ]; then 

    # ... well, fire!
    sudo ufw insert 1 deny from $ip to any > /dev/null 2>&1
    echo "$now $hits $ip" >> $UFW_POLICE_PATH/logs/banned_ips.log

  fi
fi
