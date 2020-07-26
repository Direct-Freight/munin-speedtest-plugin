# munin-speedtest-plugin
A Munin plugin to graph the results from speedtest-cli

Setup instructions:

1. Install [speedtest-cli](https://github.com/sivel/speedtest-cli)

	*pip / easy\_install*

	```bash
	pip install speedtest-cli

	easy_install speedtest-cli
	```

	*Download*

    ```bash
	wget -O speedtest-cli https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py
    chmod +x speedtest-cli
    ```

1. Create a crontab entry like the following

    ```bash
    sudo crontab -e
    58,18,38 * * * * sudo /<path>/<to>/<file>/speedtest-cli --simple > /var/log/munin/speedtest.out
    ```

1. Copy speedtest.sh into Munin plugins folder (on Debian/Ubuntu)

    ```bash
    sudo cp /<path>/<to>/<file>/speedtest.sh /usr/share/munin/plugins/speedtest.sh
    sudo chmod 755 /etc/munin/plugins/speedtest.sh
	sudo ln -s /usr/share/munin/plugins/speedtest.sh /etc/munin/plugins/speedtest.sh
    ```

1. Restart munin-node to detect the new plugin

    ```bash
    sudo service munin-node restart
	sudo service munin restart
    ```

Original author: Alex Pardoe

Monitoring Internet Connection Speed With Munin<br>
http://www.pardoe.io/blog/2013/04/29/monitoring-internet-connection-speed-with-munin

Github Gist - speedtest-cli.sh<br>
https://gist.github.com/digitalpardoe/5481339
