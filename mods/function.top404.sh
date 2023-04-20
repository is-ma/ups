#!/bin/bash
# Get an histogram of URLs showing response code 404
source ~/.is-ma/ups/mods/function.get_access_log.sh
top404() {
  get_access_log $1
  sudo grep " 404 " $access_log | awk '{ print $7 }' | sort | uniq --count | sort -n | tail -n100
}
