#!/bin/bash

# configuration
export MAX_IP_REQUESTS_PER_MIN_WITHOUT_BANNING=100
export WEBLOG_PATH=/var/log/nginx/access.log
export UFW_POLICE_PATH=/home/deploy/.ufw_police

# let's work on every_minute.log && IP bags
$UFW_POLICE_PATH/mods/every_minute.sh

# aggressive black IPs must be banned!
$UFW_POLICE_PATH/mods/ban_aggressive_ip.sh

# let's improve the log to a better looking one
$UFW_POLICE_PATH/mods/every_minute_plus.sh
