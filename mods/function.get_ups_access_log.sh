#!/bin/bash
# Get appropiate ups_access.log filepath

get_ups_access_log () {

  # si parámetro fue dado
  #   - encuentra el archivo apropiado; salva ruta
  #   si access_log contiene 'gz'
  #     - descomprime en /tmp y actualiza access_log
  if [ ! -z "$1" ]; then
    ups_access_log=$(sudo ls -l /var/log/nginx/ups_access.log* | awk '{ print $9 }' | grep $1)
    if [[ "$ups_access_log" == *"gz"*  ]]; then
      sudo zcat $ups_access_log > /tmp/is_ma__access.log
      ups_access_log=/tmp/is_ma__access.log
    fi
  fi

  # si parámetro no fue dado
  #  - ups_access_log será /var/log/nginx/ups_access.log
  if [ -z "$1" ]; then ups_access_log=/var/log/nginx/ups_access.log; fi

  echo $ups_access_log
}
