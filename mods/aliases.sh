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
echo "     t SEARCH [DATE] : Top NGINX log stats."
echo ""
echo "Top NGINX ups_access.log stats"
echo "------------------------------"
echo "'am' [DATE]: GET             | request_method"
echo "'au' [DATE]: /robots.txt     | request_uri"
echo "'ai' [DATE]: 66.249.66.38    | remote_addr"
echo "'ah' [DATE]: 20230421 15     | yyyymmdd hh"
echo "'ac' [DATE]: 200             | status"
echo "'at' [DATE]: 0.063           | request_time"
echo "'ab' [DATE]: 5831            | body_bytes_sent"
echo "'as' [DATE]: https           | scheme"
echo "'ad' [DATE]: mydomain.com    | host"
echo "'ar' [DATE]: '-'             | http_referer"
echo "'aa' [DATE]: 'Mozilla/5.0'   | http_user_agent"
echo ""

# define aliases
alias b="tail -n60 ~/.is-ma/ups/logs/banned_ips.log"
alias r="sudo tailf /var/log/nginx/ups_access.log | awk -f ~/.is-ma/ups/mods/realtraffic.awk"
alias m="tail -n60 ~/.is-ma/ups/logs/minutero.log"
alias sm="cat ~/.is-ma/ups/logs/minutero.log | egrep -i"
function sa () { sudo cat $(get_ups_access_log $2) | egrep -i "$1"; }
function sac () { sudo cat $(get_ups_access_log $2) | egrep -i "$1" | awk -f ~/.is-ma/ups/mods/realtraffic.awk; }
function sah () { sudo cat $(get_ups_access_log $2) | egrep -i "$1" | awk '{print $2}' | sort | uniq --count | sort -n | tail -n100; }
alias t="~/.is-ma/ups/mods/t.sh"

alias am="~/.is-ma/ups/mods/am.sh"
alias au="~/.is-ma/ups/mods/au.sh"
alias ai="~/.is-ma/ups/mods/ai.sh"
alias ah="~/.is-ma/ups/mods/ah.sh"
alias ac="~/.is-ma/ups/mods/ac.sh"
alias at="~/.is-ma/ups/mods/at.sh"
alias ab="~/.is-ma/ups/mods/ab.sh"
alias as="~/.is-ma/ups/mods/as.sh"
alias ad="~/.is-ma/ups/mods/ad.sh"
