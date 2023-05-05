{
# ups_access.log format
request_method=$1
request_uri=$2
remote_addr=$3
yyyymmdd=$4
hhmmss=$5
status=$6
request_time=$7
body_bytes_sent=$8
scheme=$9
host=$10
http_referer=$11
http_user_agent=$12

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
else if ($0 ~ /googleusercontent\.com/)# Goo related
  print status, request_time, "GoUC", request_uri
else if ($0 ~ /googlezip\.net/)        # Goo related
  print status, request_time, "GZip", request_uri
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
