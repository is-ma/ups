#!/bin/bash

# configuration
export IS_MA__UPS_PATH=/home/deploy/.is-ma/ups
export IS_MA__WEBLOG_PATH=/var/log/nginx/ups_access.log
export IS_MA__MAX_REQ_MIN=100
export IS_MA__PUBLIC_TXT_FOR_TASKER=/home/deploy/rank_app/code/public/lastminuteplus.txt

# offender xploit filters
ending_in="/setup.txt |/setup.php |/eval\-stdin.php "
having_exactly=" /wp\-login.php | /xmlrpc.php "
starting_with="/__phpmyadmin| /_phpmyadmin| /2phpmyadmin/| /actuator/| /administrator/| /admin/| /dbadmin/| /db/| /myadmin/| /mysql| /phpmy\-admin/| /phpmyadmin| /phppma/|/pma/| /program/| /shopdb/| /sites/| /sql/| /sqlmanager/| /wordpress/| /wp/| /wp\-admin/| /wp\-content/| /wp\-includes/| /test/| /uploads/"

export IS_MA__XPLOIT_DIC="$ending_in|$having_exactly|$starting_with"
