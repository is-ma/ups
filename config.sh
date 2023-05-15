#!/bin/bash

# configuration
export IS_MA__UPS_PATH=/home/deploy/.is-ma/ups
export IS_MA__WEBLOG_PATH=/var/log/nginx/ups_access.log
export IS_MA__MAX_REQ_MIN=90
export IS_MA__PUBLIC_TXT_FOR_TASKER=/home/deploy/rank_app/code/public/lastminuteplus.txt

# offender xploit filters
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
"| /credentials"\
"| /data/"\
"| /dbadmin/"\
"| /db/"\
"| /debug/"\
"| /dns\-query"\
"| /geoserver/"\
"| /laravel/"\
"| /manager/"\
"| /myadmin/"\
"| /mysql"\
"| /owa/"\
"| /phpmy\-admin/"\
"| /phpmyadmin"\
"| /phppma/"\
"| /phpunit/"\
"| /pma/"\
"| /pools/"\
"| /private/"\
"| /program/"\
"| /shell"\
"| /shopdb/"\
"| /sites/"\
"| /sql/"\
"| /sqlmanager/"\
"| /system/"\
"| /test/"\
"| /uploads/"\
"| /vendor/"\
"| /wordpress/"\
"| /wp/"\
"| /wp\-admin/"\
"| /wp\-content/"\
"| /wp\-includes/"

ending_in="\.7z "\
"|\.asp "\
"|\.aspx "\
"|\.bak "\
"|\.backup "\
"|\.bk "\
"|\.bz2 "\
"|\.cgi "\
"|\.dev "\
"|\.dist "\
"|\.dll "\
"|\.env "\
"|\.envrc "\
"|\.example "\
"|\.ini "\
"|\.jhtml "\
"|\.jar "\
"|\.jsa "\
"|\.json "\
"|\.local "\
"|\.orig "\
"|\.php "\
"|\.pl "\
"|\.prod "\
"|\.save "\
"|\.stage "\
"|\.swp "\
"|\.sql "\
"|\.tar "\
"|\.war "\
"|\.yaml "\
"|\.yml "\
"|\.zip "\
"|/security\.txt "\
"|/setup\.txt "\
"|/wlwmanifest\.xml "

export IS_MA__XPLOIT_DIC="$starting_with|$ending_in"

# define startings and endings: remove spaces and escape (.) & (-)
startings=$(echo $starting_with | tr -d ' ' | sed 's/\./\\./g' | sed 's/\-/\\-/g' | xargs -I {} echo "^("{}")")
endings=$(echo $ending_in | tr -d ' ' | sed 's/\./\\./g' | sed 's/\-/\\-/g' | xargs -I {} echo "("{}")$")

# write the firewall!
tee /home/deploy/nginx_firewall.auto <<EOF >/dev/null

  # note1: these automatic rules comes from ups/config.sh
  # note2: sudo nginx -s reload

  # startings
  location ~ $startings {
    default_type text/plain;
    return 444 "You will be banned soon!\n";
  }

  # endings
  location ~ $endings {
    default_type text/plain;
    return 444 "You will be banned soon!\n";
  }
EOF
