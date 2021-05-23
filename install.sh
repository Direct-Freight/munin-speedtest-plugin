#!/bin/bash
export host="$1"
if test -z "$host"; then
        export host="127.0.0.1"
fi
ssh root@$host apt-get install python-pip
ssh root@$host pip install speedtest-cli
scp speedtest.sh /usr/share/munin/plugins/
ssh root@$host chmod a+x /usr/share/munin/plugins/speedtest.sh
ssh root@$host ln -s /usr/share/munin/plugins/speedtest.sh /etc/munin/plugins/speedtest.sh
ssh root@$host service munin-node restart
/usr/local/bin/speedtest-cli||speedtest-cli
LINE='18,38,58 * * * * sudo (/usr/local/bin/speedtest-cli/speedtest-cli --simple||speedtest-cli --simple) > /var/log/munin/speedtest.out'
ssh root@$host 'cat /etc/crontab |grep -v "speedtest-cli" >/tmp/crontab.tmp; cat /tmp/crontab.tmp >/etc/crontab; echo "$LINE" >>/etc/crontab'
