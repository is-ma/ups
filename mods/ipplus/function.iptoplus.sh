#!/bin/bash
source /home/deploy/.is-ma/ups/config.sh

# Get 'ip_plus' (otherwise 'ip')
iptoplus () {
  # human friendly parameter
  ip=$1

  # already on cache? get it
  if grep -q "^$ip " $IS_MA__UPS_PATH/mods/ipplus/ip_dom.log; then
    grep  "^$ip " $IS_MA__UPS_PATH/mods/ipplus/ip_dom.log
    return 0
  fi

  # find it
  host_line=$(host $ip)

  # save it
  if [[ "$host_line" =~ ' pointer ' ]]; then
    # IP: 187.191.42.169
    # 169.42.191.187.in-addr.arpa domain name pointer fixed-187-191-42-169.totalplay.net.
    dom=$(echo $host_line | rev | cut -d' ' -f1 | cut -c2- | awk -F '.' '{if(length($2)>3) print($1 "." $2); else print($1 "." $2 "." $3)}' | rev)
    echo "$ip $dom" >> $IS_MA__UPS_PATH/mods/ipplus/ip_dom.log
  else
    echo "$ip ---" >> $IS_MA__UPS_PATH/mods/ipplus/ip_dom.log
  fi

  # get it
  grep  "^$ip " $IS_MA__UPS_PATH/mods/ipplus/ip_dom.log
}

#
# Example of 'hi 20230508' IPs and their 'host' return [100 lines]
#
# 193.186.4.206 206.4.186.193.in-addr.arpa domain name pointer 193-186-4-206.v4.fetch.tunnel.googlezip.net.
# 198.167.198.216 216.198.167.198.in-addr.arpa domain name pointer c6a7c6d8.vpn.njalla.net.
# 44.226.159.159 159.159.226.44.in-addr.arpa domain name pointer ec2-44-226-159-159.us-west-2.compute.amazonaws.com.
# 66.249.66.74 74.66.249.66.in-addr.arpa domain name pointer crawl-66-249-66-74.googlebot.com.
# 52.12.17.165 165.17.12.52.in-addr.arpa domain name pointer ec2-52-12-17-165.us-west-2.compute.amazonaws.com.
# 66.249.80.88 88.80.249.66.in-addr.arpa domain name pointer google-proxy-66-249-80-88.google.com.
# 66.249.80.92 92.80.249.66.in-addr.arpa domain name pointer google-proxy-66-249-80-92.google.com.
# 74.119.119.204 Host 204.119.119.74.in-addr.arpa. not found: 3(NXDOMAIN)
# 35.155.29.68 68.29.155.35.in-addr.arpa domain name pointer ec2-35-155-29-68.us-west-2.compute.amazonaws.com.
# 74.119.118.8 Host 8.118.119.74.in-addr.arpa. not found: 3(NXDOMAIN)
# 34.32.157.144 144.157.32.34.in-addr.arpa domain name pointer 144.157.32.34.bc.googleusercontent.com.
# 35.204.110.72 72.110.204.35.in-addr.arpa domain name pointer 72.110.204.35.bc.googleusercontent.com.
# 51.178.219.31 31.219.178.51.in-addr.arpa domain name pointer ip31.ip-51-178-219.eu.
# 74.119.119.11 Host 11.119.119.74.in-addr.arpa. not found: 3(NXDOMAIN)
# 66.249.92.142 142.92.249.66.in-addr.arpa domain name pointer rate-limited-proxy-66-249-92-142.google.com.
# 74.119.119.14 Host 14.119.119.74.in-addr.arpa. not found: 3(NXDOMAIN)
# 74.119.119.205 Host 205.119.119.74.in-addr.arpa. not found: 3(NXDOMAIN)
# 74.119.119.10 Host 10.119.119.74.in-addr.arpa. not found: 3(NXDOMAIN)
# 74.119.118.23 Host 23.118.119.74.in-addr.arpa. not found: 3(NXDOMAIN)
# 200.63.41.133 Host 133.41.63.200.in-addr.arpa. not found: 3(NXDOMAIN)
# 189.203.252.73 73.252.203.189.in-addr.arpa domain name pointer fixed-189-203-252-73.totalplay.net.
# 143.110.222.166 Host 166.222.110.143.in-addr.arpa. not found: 3(NXDOMAIN)
# 165.232.90.60 Host 60.90.232.165.in-addr.arpa. not found: 3(NXDOMAIN)
# 20.241.233.77 Host 77.233.241.20.in-addr.arpa. not found: 3(NXDOMAIN)
# 20.15.133.190 190.133.15.20.in-addr.arpa domain name pointer msnbot-20-15-133-190.search.msn.com.
# 74.119.118.32 Host 32.118.119.74.in-addr.arpa. not found: 3(NXDOMAIN)
# 66.249.92.4 4.92.249.66.in-addr.arpa domain name pointer rate-limited-proxy-66-249-92-4.google.com.
# 216.244.66.194 Host 194.66.244.216.in-addr.arpa. not found: 3(NXDOMAIN)
# 20.15.133.162 162.133.15.20.in-addr.arpa domain name pointer msnbot-20-15-133-162.search.msn.com.
# 164.90.204.15 Host 15.204.90.164.in-addr.arpa. not found: 3(NXDOMAIN)
# 66.249.92.39 39.92.249.66.in-addr.arpa domain name pointer rate-limited-proxy-66-249-92-39.google.com.
# 200.63.40.145 Host 145.40.63.200.in-addr.arpa. not found: 3(NXDOMAIN)
# 74.119.118.21 Host 21.118.119.74.in-addr.arpa. not found: 3(NXDOMAIN)
# 74.119.118.20 Host 20.118.119.74.in-addr.arpa. not found: 3(NXDOMAIN)
# 189.189.90.199 199.90.189.189.in-addr.arpa domain name pointer dsl-189-189-90-199-dyn.prod-infinitum.com.mx.
# 74.119.118.33 Host 33.118.119.74.in-addr.arpa. not found: 3(NXDOMAIN)
# 52.32.97.42 42.97.32.52.in-addr.arpa domain name pointer ec2-52-32-97-42.us-west-2.compute.amazonaws.com.
# 74.119.118.22 Host 22.118.119.74.in-addr.arpa. not found: 3(NXDOMAIN)
# 74.119.118.9 Host 9.118.119.74.in-addr.arpa. not found: 3(NXDOMAIN)
# 35.235.81.103 103.81.235.35.in-addr.arpa domain name pointer 103.81.235.35.bc.googleusercontent.com.
# 200.63.41.38 Host 38.41.63.200.in-addr.arpa. not found: 3(NXDOMAIN)
# 52.2.19.0 0.19.2.52.in-addr.arpa domain name pointer ec2-52-2-19-0.compute-1.amazonaws.com.
# 66.249.92.141 141.92.249.66.in-addr.arpa domain name pointer rate-limited-proxy-66-249-92-141.google.com.
# 132.145.67.248 Host 248.67.145.132.in-addr.arpa. not found: 3(NXDOMAIN)
# 140.238.95.47 Host 47.95.238.140.in-addr.arpa. not found: 3(NXDOMAIN)
# 140.238.83.181 Host 181.83.238.140.in-addr.arpa. not found: 3(NXDOMAIN)
# 132.145.66.156 Host 156.66.145.132.in-addr.arpa. not found: 3(NXDOMAIN)
# 132.145.11.125 Host 125.11.145.132.in-addr.arpa. not found: 3(NXDOMAIN)
# 140.238.94.137 Host 137.94.238.140.in-addr.arpa. not found: 3(NXDOMAIN)
# 140.238.81.78 Host 78.81.238.140.in-addr.arpa. not found: 3(NXDOMAIN)
# 140.238.95.199 Host 199.95.238.140.in-addr.arpa. not found: 3(NXDOMAIN)
# 132.145.15.209 Host 209.15.145.132.in-addr.arpa. not found: 3(NXDOMAIN)
# 132.145.14.70 Host 70.14.145.132.in-addr.arpa. not found: 3(NXDOMAIN)
# 152.67.128.219 Host 219.128.67.152.in-addr.arpa. not found: 3(NXDOMAIN)
# 132.145.9.5 Host 5.9.145.132.in-addr.arpa. not found: 3(NXDOMAIN)
# 152.67.138.180 Host 180.138.67.152.in-addr.arpa. not found: 3(NXDOMAIN)
# 152.67.137.35 Host 35.137.67.152.in-addr.arpa. not found: 3(NXDOMAIN)
# 132.145.64.33 Host 33.64.145.132.in-addr.arpa. not found: 3(NXDOMAIN)
# 132.145.66.116 Host 116.66.145.132.in-addr.arpa. not found: 3(NXDOMAIN)
# 44.201.255.174 174.255.201.44.in-addr.arpa domain name pointer ec2-44-201-255-174.compute-1.amazonaws.com.
# 187.191.42.169 169.42.191.187.in-addr.arpa domain name pointer fixed-187-191-42-169.totalplay.net.
# 66.249.92.3 3.92.249.66.in-addr.arpa domain name pointer rate-limited-proxy-66-249-92-3.google.com.
# 3.223.183.74 74.183.223.3.in-addr.arpa domain name pointer ec2-3-223-183-74.compute-1.amazonaws.com.
# 5.255.231.176 176.231.255.5.in-addr.arpa domain name pointer 5-255-231-176.spider.yandex.com.
# 213.180.203.140 140.203.180.213.in-addr.arpa domain name pointer 213-180-203-140.spider.yandex.com.
# 213.180.203.175 175.203.180.213.in-addr.arpa domain name pointer 213-180-203-175.spider.yandex.com.
# 213.180.203.207 207.203.180.213.in-addr.arpa domain name pointer 213-180-203-207.spider.yandex.com.
# 213.180.203.236 236.203.180.213.in-addr.arpa domain name pointer 213-180-203-236.spider.yandex.com.
# 5.255.231.187 187.231.255.5.in-addr.arpa domain name pointer 5-255-231-187.spider.yandex.com.
# 5.255.231.193 193.231.255.5.in-addr.arpa domain name pointer 5-255-231-193.spider.yandex.com.
# 5.255.231.21 21.231.255.5.in-addr.arpa domain name pointer 5-255-231-21.spider.yandex.com.
# 5.255.231.65 65.231.255.5.in-addr.arpa domain name pointer 5-255-231-65.spider.yandex.com.
# 5.45.207.161 161.207.45.5.in-addr.arpa domain name pointer 5-45-207-161.spider.yandex.com.
# 5.45.207.168 168.207.45.5.in-addr.arpa domain name pointer 5-45-207-168.spider.yandex.com.
# 87.250.224.83 83.224.250.87.in-addr.arpa domain name pointer 87-250-224-83.spider.yandex.com.
# 95.108.213.207 207.213.108.95.in-addr.arpa domain name pointer 95-108-213-207.spider.yandex.com.
# 95.108.213.244 244.213.108.95.in-addr.arpa domain name pointer 95-108-213-244.spider.yandex.com.
# 52.6.243.18 18.243.6.52.in-addr.arpa domain name pointer ec2-52-6-243-18.compute-1.amazonaws.com.
# 5.45.207.156 156.207.45.5.in-addr.arpa domain name pointer 5-45-207-156.spider.yandex.com.
# 66.249.92.38 38.92.249.66.in-addr.arpa domain name pointer rate-limited-proxy-66-249-92-38.google.com.
# 66.249.66.5 5.66.249.66.in-addr.arpa domain name pointer crawl-66-249-66-5.googlebot.com.
# 54.156.8.33 33.8.156.54.in-addr.arpa domain name pointer ec2-54-156-8-33.compute-1.amazonaws.com.
# 66.249.66.40 40.66.249.66.in-addr.arpa domain name pointer crawl-66-249-66-40.googlebot.com.
# 72.14.201.213 213.201.14.72.in-addr.arpa domain name pointer 72-14-201-213.v4.fetch.tunnel.googlezip.net.
# 193.186.4.213 213.4.186.193.in-addr.arpa domain name pointer 193-186-4-213.v4.fetch.tunnel.googlezip.net.
# 208.115.199.24 24.199.115.208.in-addr.arpa domain name pointer 24-199-115-208.static.reverse.lstn.net.
# 72.14.201.212 212.201.14.72.in-addr.arpa domain name pointer 72-14-201-212.v4.fetch.tunnel.googlezip.net.
# 193.186.4.212 212.4.186.193.in-addr.arpa domain name pointer 193-186-4-212.v4.fetch.tunnel.googlezip.net.
# 66.249.66.78 78.66.249.66.in-addr.arpa domain name pointer crawl-66-249-66-78.googlebot.com.
# 187.190.163.181 181.163.190.187.in-addr.arpa domain name pointer fixed-187-190-163-181.totalplay.net.
# 66.249.92.140 140.92.249.66.in-addr.arpa domain name pointer rate-limited-proxy-66-249-92-140.google.com.
# 66.249.66.4 4.66.249.66.in-addr.arpa domain name pointer crawl-66-249-66-4.googlebot.com.
# 66.249.66.39 39.66.249.66.in-addr.arpa domain name pointer crawl-66-249-66-39.googlebot.com.
# 66.249.66.77 77.66.249.66.in-addr.arpa domain name pointer crawl-66-249-66-77.googlebot.com.
# 66.249.66.3 3.66.249.66.in-addr.arpa domain name pointer crawl-66-249-66-3.googlebot.com.
# 66.249.66.38 38.66.249.66.in-addr.arpa domain name pointer crawl-66-249-66-38.googlebot.com.
# 52.167.144.84 84.144.167.52.in-addr.arpa domain name pointer msnbot-52-167-144-84.search.msn.com.
# 207.46.13.218 218.13.46.207.in-addr.arpa domain name pointer msnbot-207-46-13-218.search.msn.com.
# 52.167.144.43 43.144.167.52.in-addr.arpa domain name pointer msnbot-52-167-144-43.search.msn.com.
# 66.249.66.76 76.66.249.66.in-addr.arpa domain name pointer crawl-66-249-66-76.googlebot.com.
