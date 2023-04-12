<!-- GETTING STARTED -->
## UFW Police

This is a small script that keep abusive, impostor crawlers away from my servers.

It uses DNS lookup tool determine if the IP is a legal crawler or not.

UFW Police only ban IPs when traffic is very heavy and there is an abusive IP crawling a site.

It is pre-configured to work with NGINX access log. And the banning is through UFW. 


### Installation

```sh
git clone https://github.com/is-ma/ufw_police.git ~/.ufw_police
```

Create the log files:

```sh
touch ~/.ufw_police/logs/report.log
touch ~/.ufw_police/logs/report_plus.log
touch ~/.ufw_police/logs/ip_blacklist.log
touch ~/.ufw_police/logs/whitelist.log
```
  
Then add these rules to your "crontab -e":

```sh
### UFW_POLICE ###
* * * * * /home/deploy/.ufw_police/every_minute.sh
59 23 * * * /home/deploy/.ufw_police/once_a_day.sh
```


### Tasker

In Tasker repeat every minute:

1) HTTP Request (method GET)
2) Notify %http_data
3) Music Play (if %http_data ~R ^..:.. [2-9][0-9][0-9]


### Shell Tools

- Add a beautiful welcome report in ~/.bashrc
- Add an 'r' alias to show real web traffic

```sh
### UFW_POLICE ###
~/.ufw_police/bash_welcome_report.sh
alias r="sudo tailf /var/log/nginx/access.log | awk -f ~/.ufw_police/mods/realtraffic.awk"
```
