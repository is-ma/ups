#!/bin/bash
source mods/function.get_ups_access_log.sh

# show aliases
echo "### UFW POLICE & STATS (UPS) ### [aliases & utilities]"
echo "     r: Show real traffic."
echo "     m: Tail last 60 rows on logs/minutero.log."
echo "    sm: Search logs/minutero.log (usually IPs or time range)."
echo "    sa SEARCH [DATE] : Raw search Nginx log."
echo "   sac SEARCH [DATE] : Compact search Nginx log."
echo "   sah SEARCH [DATE] : Histogram URL view of an Nginx log search."
echo "     t SEARCH [DATE] : Top NGINX log stats."

# define aliases
alias r="sudo tailf /var/log/nginx/ups_access.log | awk -f ~/.is-ma/ups/mods/realtraffic.awk"
alias m="tail -n60 ~/.is-ma/ups/logs/minutero.log"
alias sm="cat ~/.is-ma/ups/logs/minutero.log | egrep -i"
function sa () { sudo cat $(get_ups_access_log $2) | egrep -i "$1"; }
function sac () { sudo cat $(get_ups_access_log $2) | egrep -i "$1" | awk -f ~/.is-ma/ups/mods/realtraffic.awk; }
function sah () { sudo cat $(get_ups_access_log $2) | egrep -i "$1" | awk '{print $2}' | sort | uniq --count | sort -n | tail -n100; }
alias t="~/.is-ma/ups/mods/t.sh"
echo ""
