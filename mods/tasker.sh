#!/bin/bash
source ~/.is-ma/ups/config.sh
source $IS_MA__UPS_PATH/mods/aliases.sh > /dev/null
source $HOME/.is-ma/aliaz/mods/any_os.sh  # function: sumcol

# time related variables
min_ago=$(date --date '1 minute ago' '+%H:%M')  # 14:01
search_min_ago=$(date --date '1 minute ago' '+%Y%m%d %H:%M:')  # 20230525 14:01:

# DNS domain related variables
domain_histogram=$(saipd "$search_min_ago" | tac)
total_count=$(echo "$domain_histogram" | sumcol 1)

# lest's print it!
echo "$total_count TOTAL [${min_ago}h]" > $IS_MA__PUBLIC_TXT_FOR_TASKER
echo "$domain_histogram" >> $IS_MA__PUBLIC_TXT_FOR_TASKER
