<!-- GETTING STARTED -->
## UFW Police

This is a script that keep abusive, impostor crawlers away from my servers.

It uses DNS lookup tool determine if the IP is a legal crawler or not.

UFW Police only ban IPs when traffic from certain IP is very heavy (configurable) and is not a legal crawler. 

It is pre-configured to work with NGINX access log. And the banning is through UFW. 


### Installation

```sh
git clone https://github.com/is-ma/ufw_police.git ~/.ufw_police
```

Create the log files:

```sh
touch ~/.ufw_police/logs/report.log
touch ~/.ufw_police/logs/report_plus.log
touch ~/.ufw_police/logs/blacklist.log
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

Note: Example before will notify when hits/min greater or equal than 200.


### Shell Tools

- Add welcome report every time you log in 
- Add an 'r' alias to show real web traffic

Add these lines to your ´~/.bashrc´:

```sh
### UFW_POLICE ###
~/.ufw_police/bash_welcome_report.sh
alias r="sudo tailf /var/log/nginx/access.log | awk -f ~/.ufw_police/mods/realtraffic.awk"
```
