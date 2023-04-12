{
if ($0 ~ /google\.com/) 
  print "  ", $9, $3, "Goog", $7
else if ($0 ~ /admantx\.com/) 
  print "  ", $9, $3, "Admx", $7
else if ($0 ~ /bing\.com/) 
  print "  ", $9, $3, "Bing", $7
else if ($0 ~ /yandex\.com/) 
  print "  ", $9, $3, "Yndx", $7
else if ($0 ~ /dataforseo\.com/) 
  print "  ", $9, $3, "Data", $7
else if ($0 ~ /comscore\.com/) 
  print "  ", $9, $3, "Coms", $7
else if ($0 ~ /criteo\.com/) 
  print "  ", $9, $3, "Crit", $7
else if ($0 ~ /apple\.com/) 
  print "  ", $9, $3, "Appl", $7
else if ($0 ~ /uptimerobot\.com/) 
  print "  ", $9, $3, "Upti", $7
else if ($0 ~ /Mediapartners\-Google/) 
  print "  ", $9, $3, "MGoo", $7
else{ 
  print ""
  print $0
  print ""
  }
}
