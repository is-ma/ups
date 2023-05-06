#!/bin/bash
source ~/.is-ma/ups/config.sh
source $IS_MA__UPS_PATH/mods/function.get_ups_access_log.sh

# get appropiate ups_access.log
ups_access_log=$(get_ups_access_log $1)
echo $ups_access_log

sudo cat $ups_access_log | cut -d' ' -f9 | sort | uniq --count | sort -n
