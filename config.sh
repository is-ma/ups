#!/bin/bash

# configuration
export IS_MA__UPS_PATH=/home/deploy/.is-ma/ups
export IS_MA__WEBLOG_PATH=/var/log/nginx/ups_access.log
export IS_MA__MAX_REQ_MIN=100
export IS_MA__PUBLIC_TXT_FOR_TASKER=/home/deploy/rank_app/code/public/lastminuteplus.txt

# offender xploit filters
ending_in="\.7z "\
"|\.asp "\
"|\.aspx "\
"|\.bak "\
"|\.backup "\
"|\.bk "\
"|\.bz2 "\
"|\.cgi "\
"|\.dll "\
"|\.env "\
"|\.envrc "\
"|\.ini "\
"|\.jhtml "\
"|\.jar "\
"|\.jsa "\
"|\.php "\
"|\.pl "\
"|\.swp "\
"|\.sql "\
"|\.tar "\
"|\.war "\
"|\.zip "\
"|/eval\-stdin\.php "\
"|/setup\.txt "\
"|/setup\.php "
having_exactly=" /wp\-login\.php "\
"| /credentials "\
"| /xmlrpc\.php "
starting_with=" /\.git/"\
"| /\.aws/"\
"| /__phpmyadmin"\
"| /_ignition"\
"| /_phpmyadmin"\
"| /2phpmyadmin/"\
"| /actuator/"\
"| /administrator/"\
"| /admin/"\
"| /api/"\
"| /autodiscover/"\
"| /aws/"\
"| /boaform/"\
"| /core/"\
"| /data/"\
"| /dbadmin/"\
"| /db/"\
"| /debug/"\
"| /geoserver/"\
"| /laravel/"\
"| /manager/"\
"| /myadmin/"\
"| /mysql"\
"| /phpmy\-admin/"\
"| /phpmyadmin"\
"| /phppma/"\
"| /phpunit/"\
"| /pma/"\
"| /pools/"\
"| /private/"\
"| /program/"\
"| /shopdb/"\
"| /sites/"\
"| /sql/"\
"| /sqlmanager/"\
"| /system/"\
"| /wordpress/"\
"| /wp/"\
"| /wp\-admin/"\
"| /wp\-content/"\
"| /wp\-includes/"\
"| /test/"\
"| /uploads/"\
"| /vendor/"

export IS_MA__XPLOIT_DIC="$ending_in|$having_exactly|$starting_with"
