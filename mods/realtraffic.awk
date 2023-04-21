{
# ups_access.log format
request_method=$1
scheme=$2
host=$3
request_uri=$4
status=$5
body_bytes_sent=$6
request_time=$7
remote_addr=$8
http_referer=$9
http_user_agent=$10
time_iso8601=$11

# sumarizing...
if ($0 ~ /google\.com\/bot\.html/)     # ✓
  print status, request_time, "Goog", request_uri
else if ($0 ~ /\/bingbot\.htm/)        # ✓
  print status, request_time, "Bing", request_uri
else if ($0 ~ /yandex\.com\/bots/)     # ✓
  print status, request_time, "Yndx", request_uri
else if ($0 ~ /Mediapartners\-Google/) # Goo ad partner
  print status, request_time, "MGoo", request_uri
else if ($0 ~ /admantx\.com/)          # Goo ad partner
  print status, request_time, "Admx", request_uri
else if ($0 ~ /comscore\.com/)         # Goo ad partner
  print status, request_time, "Coms", request_uri
else if ($0 ~ /TTD\-Content/)          # Goo ad partner
  print status, request_time, "TTDC", request_uri
else if ($0 ~ /GrapeshotCrawler/)      # Goo ad partner
  print status, request_time, "Grape", request_uri
else if ($0 ~ /criteo\.com/)           # Bing partner
  print status, request_time, "Crit", request_uri
else if ($0 ~ /apple\.com/)            # inoffensive
  print status, request_time, "Appl", request_uri
else if ($0 ~ /uptimerobot\.com/)      # guardian app
  print status, request_time, "Upti", request_uri
else if ($0 ~ /Tasker/)                # android info min by min
  print status, request_time, "Tskr", request_uri
else{ 
  print "____________________________________________________________"
  print $0
  print "¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯"
  }
}
