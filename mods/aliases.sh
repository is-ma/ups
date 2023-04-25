#!/bin/bash

# show aliases
echo "### UFW POLICE & STATS (UPS) ### [aliases & utilities]"
echo "     r: Show real traffic."
echo "     m: Tail last 60 rows on logs/minutero.log."
echo "    sm: Search logs/minutero.log (usually IPs or time range)."
echo "    sa: Search /var/log/access.log (regexp)."
echo "   sas: Search /var/log/access.log (regexp) and then make it small."
echo "     t: Top NGINX ups_access.log stats."

# define aliases
alias r="sudo tailf /var/log/nginx/ups_access.log | awk -f ~/.is-ma/ups/mods/realtraffic.awk"
alias m="tail -n60 ~/.is-ma/ups/logs/minutero.log"
alias sa="sudo cat /var/log/nginx/ups_access.log | egrep -i"
function sas () { sudo cat /var/log/nginx/ups_access.log | egrep -i "$1" | awk -f ~/.is-ma/ups/mods/realtraffic.awk; }
alias sm="cat ~/.is-ma/ups/logs/minutero.log | egrep -i"
alias t="~/.is-ma/ups/mods/t.sh"
echo ""
