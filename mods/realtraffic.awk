{
if ($0 ~ /google\.com/)                # ✓
  print "  ", $9, $3, "Goog", $7
else if ($0 ~ /bing\.com/)             # ✓
  print "  ", $9, $3, "Bing", $7
else if ($0 ~ /yandex\.com/)           # ✓
  print "  ", $9, $3, "Yndx", $7
else if ($0 ~ /Mediapartners\-Google/) # verified Goo partner
  print "  ", $9, $3, "MGoo", $7
else if ($0 ~ /admantx\.com/)          # verified Goo partner
  print "  ", $9, $3, "Admx", $7
else if ($0 ~ /comscore\.com/)         # verified Goo partner
  print "  ", $9, $3, "Coms", $7
else if ($0 ~ /TTD\-Content/)          # verified Goo partner
  print "  ", $9, $3, "TTDC", $7
else if ($0 ~ /criteo\.com/)           # verified Bing partner
  print "  ", $9, $3, "Crit", $7
else if ($0 ~ /apple\.com/)            # inoffensive
  print "  ", $9, $3, "Appl", $7
else if ($0 ~ /uptimerobot\.com/)      # guardian app
  print "  ", $9, $3, "Upti", $7
else if ($0 ~ /Tasker/)                # android info min by min
  print "  ", $9, $3, "Tskr", $7
else{ 
  print ""
  print $0
  print ""
  }
}
