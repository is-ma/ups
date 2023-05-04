#!/bin/bash

# read configuration file
source /home/deploy/.is-ma/ups/config.sh

# populate logs/raw_minutero.log && IP bags
$IS_MA__UPS_PATH/mods/raw_minutero.sh

# aggressive xploiter IPs must be banned!
$IS_MA__UPS_PATH/mods/ban_aggressive_ip.sh

# xploiters black IPs must be banned!
$IS_MA__UPS_PATH/mods/ban_xploiter_ips.sh

# improve the log to a better looking one
$IS_MA__UPS_PATH/mods/minutero.sh

# show stats on Tasker (mobile device)
tail $IS_MA__UPS_PATH/logs/minutero.log | awk '{print $2,$3,"hits [" $4 ", " $NF "]"}' | tac > $IS_MA__PUBLIC_TXT_FOR_TASKER
