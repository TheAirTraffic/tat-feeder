#!/bin/sh

trap "kill 0" SIGINT
trap "kill -2 0" SIGTERM

while sleep 5
do
	if ping -q -c 2 -W 5 feed.theairtraffic.com >/dev/null 2>&1
	then
		echo Connected to feed.theairtraffic.com:$SERVERPORT
		/usr/local/bin/feed-tat
		#/usr/bin/socat -u TCP:$INPUT TCP:feed.theairtraffic.com:$SERVERPORT
		echo Disconnected, reconnecting in 30 seconds!
	else
		echo Unable to connect to feed.theairtraffic.com, trying again in 30 seconds!
	fi
    sleep 25
done
