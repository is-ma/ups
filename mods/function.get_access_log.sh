#!/bin/bash
# Get appropiate access.log filepath

get_access_log () {

  # si parámetro fue dado 
  #   - encuentra el archivo apropiado y salva ruta en access_log
  #   si access_log contiene 'gz'
  #     - descomprime en /tmp y actualiza access_log
  if [ ! -z "$1" ]; then
    access_log=$(sudo ls -l /var/log/nginx/access.log* | awk '{ print $9 }' | grep $1)
    if [[ "$access_log" == *"gz"*  ]]; then 
      sudo zcat $access_log > /tmp/is_ma__access.log
      access_log=/tmp/is_ma__access.log
    fi
  fi

  # si parámetro no fue dado
  #  - access_log será /var/log/nginx/access.log
  if [ -z "$1" ]; then access_log=/var/log/nginx/access.log; fi

  echo "access_log: $access_log" # debug
}
