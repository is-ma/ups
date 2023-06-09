#!/bin/bash

# read configuration file
source /home/deploy/.is-ma/ups/config.sh

# populate minutero.log (and /ipplus/ip_dom.log)
$IS_MA__UPS_PATH/mods/minutero.sh

# aggressive blacklisted crawlers must be banned!
$IS_MA__UPS_PATH/mods/ban_aggressive_ip.sh

# xploiters black IPs must be banned!
$IS_MA__UPS_PATH/mods/ban_xploiter_ips.sh

# show stats on Tasker (mobile device)
$IS_MA__UPS_PATH/mods/tasker.sh
