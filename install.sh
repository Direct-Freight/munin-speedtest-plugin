#!/bin/bash
export host="$1" 
export args="$2" #for options like -issh.key
if test -z "$host"; then
        export host="127.0.0.1"
fi
ssh $args root@$host "apt-get install python3-pip||apt-get install python-pip"
ssh $args root@$host pip install speedtest-cli
ssh $args root@$host rm -f /usr/share/munin/plugins/speedtest /etc/munin/plugins/speedtest
ssh $args root@$host rm -f /usr/share/munin/plugins/speedtest.sh /etc/munin/plugins/speedtest.sh
scp $args speedtest.sh root@$host:/usr/share/munin/plugins/speedtest
ssh $args root@$host chmod a+x /usr/share/munin/plugins/speedtest
ssh $args root@$host ln -s /usr/share/munin/plugins/speedtest /etc/munin/plugins/speedtest
LINE='18,38,58 * * * * root (/usr/local/bin/speedtest-cli/speedtest-cli --simple||speedtest-cli --simple) > /var/log/munin/speedtest.out.new && mv -f /var/log/munin/speedtest.out.new /var/log/munin/speedtest.out'
ssh $args root@$host "cat /etc/crontab |grep -v "speedtest-cli" >/tmp/crontab.tmp; cat /tmp/crontab.tmp >/etc/crontab; echo '$LINE' >>/etc/crontab"
ssh $args root@$host service munin-node restart
