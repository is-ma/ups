#!/bin/bash
source ~/.is-ma/ups/mods/function.get_ups_access_log.sh

# show aliases
echo "### UFW POLICE & STATS (UPS) ### [aliases & utilities]"
echo "     b: Show banned IPs."
echo "     r: Show real traffic."
echo "     m: Tail last 60 rows on logs/minutero.log."
echo "    sm: Search logs/minutero.log (usually IPs or time range)."
echo "    sa SEARCH [DATE] : Raw search Nginx log."
echo "   sac SEARCH [DATE] : Compact search Nginx log."
echo "   sah SEARCH [DATE] : Histogram URL view of an Nginx log search."
echo ""
echo "Top NGINX ups_access.log stats"
echo "------------------------------"
echo "'hm' [DATE]: GET             | request_method"
echo "'hu' [DATE]: /robots.txt     | request_uri"
echo "'hi' [DATE]: 66.249.66.38    | remote_addr"
echo "'hh' [DATE]: 20230421 15     | yyyymmdd hh"
echo "'hc' [DATE]: 200             | status"
echo "'ht' [DATE]: 0.063           | request_time"
echo "'hb' [DATE]: 5831            | body_bytes_sent"
echo "'hs' [DATE]: https           | scheme"
echo "'hd' [DATE]: mydomain.com    | host"
echo "'hr' [DATE]: '-'             | http_referer"
echo "'ha' [DATE]: 'Mozilla/5.0'   | http_user_agent"
echo ""

# define aliases
alias b="tail -n60 ~/.is-ma/ups/logs/banned_ips.log"
alias r="sudo tailf /var/log/nginx/ups_access.log | awk -f ~/.is-ma/ups/mods/realtraffic.awk"
alias m="tail -n60 ~/.is-ma/ups/logs/minutero.log"
alias sm="cat ~/.is-ma/ups/logs/minutero.log | egrep -i"
function sa () { sudo cat $(get_ups_access_log $2) | egrep -i "$1"; }
function sac () { sudo cat $(get_ups_access_log $2) | egrep -i "$1" | awk -f ~/.is-ma/ups/mods/realtraffic.awk; }
function sah () { sudo cat $(get_ups_access_log $2) | egrep -i "$1" | awk '{print $2}' | sort | uniq --count | sort -n | tail -n100; }

alias hm="~/.is-ma/ups/mods/hm.sh"
alias hu="~/.is-ma/ups/mods/hu.sh"
alias hi="~/.is-ma/ups/mods/hi.sh"
alias hh="~/.is-ma/ups/mods/hh.sh"
alias hc="~/.is-ma/ups/mods/hc.sh"
alias ht="~/.is-ma/ups/mods/ht.sh"
alias hb="~/.is-ma/ups/mods/hb.sh"
alias hs="~/.is-ma/ups/mods/hs.sh"
alias hd="~/.is-ma/ups/mods/hd.sh"
alias hr="~/.is-ma/ups/mods/hr.sh"
alias ha="~/.is-ma/ups/mods/ha.sh"
