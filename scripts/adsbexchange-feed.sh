#!/bin/sh
while sleep 30
do
	if ping -q -c 2 -W 5 feed.theairtraffic.com >/dev/null 2>&1
	then
		echo Connected to feed.theairtraffic.com:$RECEIVERPORT
		/usr/bin/socat -u TCP:localhost:30005 TCP:feed.theairtraffic.com:$RECEIVERPORT
		echo Disconnected
	else
		echo Unable to connect to feed.theairtraffic.com, trying again in 30 seconds!
	fi
done
