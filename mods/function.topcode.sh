#!/bin/bash
# Get an histogram of URLs showing a certain response code
source ~/.is-ma/ups/mods/function.get_access_log.sh
topcode() {
  code=$1
  get_access_log $2
  sudo grep " $code " $access_log | awk '{ print $7 }' | sort | uniq --count | sort -n | tail -n100
}
