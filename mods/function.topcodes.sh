#!/bin/bash
# Get an histogram of URLs showing response code 404
source ~/.is-ma/ups/mods/function.get_access_log.sh
topcodes() {
  get_access_log $1
  sudo cat $access_log | awk '{ print $9 }' | sort | uniq --count | sort -n | tail
}
