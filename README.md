<!-- GETTING STARTED -->
## UFW Police

This is a small script that keep abusive, impostor crawlers away from my servers.

It uses DNS lookup tool determine if the IP is a legal crawler or not.

UFW Police only ban IPs when traffic is very heavy and there is an abusive IP crawling a site.

It is pre-configured to work with NGINX access log. And the banning is through UFW. 


### Installation

This is an example of how to list things you need to use the software and how to install them.
  ```sh
git clone https://github.com/is-ma/ufw_police.git ~/.ufw_police
  ```

Create the log files:

  ```sh
touch ~/.ufw_police/logs/report.log
touch ~/.ufw_police/logs/report_plus.log
touch ~/.ufw_police/logs/ip_blacklist.log
touch ~/.ufw_police/logs/ip_whitelist.log
  ```
  
Then add rule to your "crontab -e" to execute the script every single minute.

  ```sh
crontab -e
  
# show how many requests I've received the last minute
* * * * * /home/deploy/.ufw_police/ufw_police.sh
  ```

You can use Tasker to watch the last 10 lines of the report_plus.log file every minute.

  ```sh
crontab -e

# show stats on Tasker (mobile device)
* * * * * tail /home/deploy/.ufw_police/logs/report_plus.log | awk '{print $2,$3,"hits [" $4 ", " $NF "]"}' | tac > /home/YOUR_USER/YOUR_WEB_FOLDER/.../public/lastminuteplus.txt
  ```

In Tasker repeat every minute:

1) HTTP Request (method GET)
2) Notify %http_data
3) Music Play (if %http_data ~R ^..:.. [2-9][0-9][0-9]
