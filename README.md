<!-- GETTING STARTED -->
## UFW Police and Stats (UPS)

This is a script that keep abusive, impostor crawlers away from my servers.

It uses DNS lookup tool determine if the IP is a legal crawler or not.

UFW Police only ban IPs when traffic from certain IP is very heavy (configurable) and is not a legal crawler. 

It is pre-configured to work with NGINX access log. And the banning is through UFW. 


### Installation

```sh
git clone https://github.com/is-ma/ups.git ~/.is-ma/ups
```

Create the log files:

```sh
touch ~/.is-ma/ups/logs/raw_minutero.log
touch ~/.is-ma/ups/logs/minutero.log
touch ~/.is-ma/ups/logs/blacklist.log
touch ~/.is-ma/ups/logs/whitelist.log
touch ~/.is-ma/ups/logs/banned_ips.log
touch ~/.is-ma/ups/logs/daily.log
```
  
Then add these rules to your "crontab -e":

```sh
### UPS: tic toc tic toc ###
* * * * * /home/deploy/.is-ma/ups/every_minute.sh
59 23 * * * /home/deploy/.is-ma/ups/once_a_day.sh
```


### Tasker

In Tasker repeat every minute:

1) HTTP Request (method GET)
2) Notify %http_data
3) Music Play (if %http_data ~R ^..:.. [2-9][0-9][0-9]

Note: Example before will notify when hits/min greater or equal than 200.


### Shell Tools

- Add welcome report every time you log in 
- Add an 'r' alias to show real time web traffic
- Add an 'm' alias to show min by min web traffic

Add these lines to your ´~/.bashrc´:

```sh
### UFW POLICE & STATS (UPS) ###
source ~/.is-ma/ups/bash_welcome.sh
```
