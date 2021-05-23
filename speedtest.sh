#!/bin/bash

case $1 in
    config)
    echo "graph_category network"
    echo "graph_title Internet Connection Speed"
    echo "graph_args --base 1000 -l 0"
    echo "graph_vlabel Download/Upload (Mbit/s) and Ping(ms)"
    echo "graph_scale no"
    echo "down.label Download (Mbit/s)"
    echo "down.type GAUGE"
    echo "down.draw LINE1"
    echo "up.label Upload (Mbit/s)"
    echo "up.type GAUGE"
    echo "up.draw LINE1"
    echo "ping.label Ping (ms)"
    echo "ping.type GAUGE"
    echo "ping.draw LINE1"
    echo "graph_info Graph of Internet Connection Speed"
    exit 0;;
    esac

OUTPUT=`cat /var/log/munin/speedtest.out`
#Ping: 64.78 ms
#Download: 114.37 Mbit/s
#Upload: 72.36 Mbit/s
PING=`echo "$OUTPUT" | grep Ping | sed 's/Ping: \([0-9]*\.[0-9]*\) ms/\1/'`
DOWNLOAD=`echo "$OUTPUT" | grep Download | sed 's/Download: \([0-9]*\.[0-9]*\) Mbit\/s/\1/'`
UPLOAD=`echo "$OUTPUT" | grep Upload | sed 's/Upload: \([0-9]*\.[0-9]*\) Mbit\/s/\1/'`

echo "down.value $DOWNLOAD"
echo "up.value $UPLOAD"
echo "ping.value $PING"
