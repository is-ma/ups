#!/bin/bash

# read configuration file
source /home/deploy/.ufw_police/config.sh

# populate report.log && IP bags
$UFW_POLICE_PATH/mods/report.sh

# aggressive black IPs must be banned!
$UFW_POLICE_PATH/mods/ban_aggressive_ip.sh

# improve the log to a better looking one
$UFW_POLICE_PATH/mods/report_plus.sh

# show stats on Tasker (mobile device)
tail $UFW_POLICE_PATH/logs/report_plus.log | awk '{print $2,$3,"hits [" $4 ", " $NF "]"}' | tac > $PUBLIC_TXT_FOR_TASKER
