#!/bin/sh

INPUT_IP=$(echo $INPUT | cut -d: -f1)
INPUT_PORT=$(echo $INPUT | cut -d: -f2)
SOURCE="--net-connector $INPUT_IP,$INPUT_PORT,beast_in"

while sleep 5
do
	if ping -q -c 2 -W 5 feed.theairtraffic.com >/dev/null 2>&1
	then
		echo Connected to feed.theairtraffic.com:30005
		
		/usr/local/share/feed-tat --net --net-only --quiet \
		--write-json /run/theairtraffic-feed \
		--net-beast-reduce-interval $REDUCE_INTERVAL \
		$TARGET $NET_OPTIONS $SOURCE
		
		#/usr/bin/socat -u TCP:$INPUT TCP:feed.theairtraffic.com:30005
		
		echo Disconnected, reconnecting in 30 seconds!
	else
		echo Unable to connect to feed.theairtraffic.com, trying again in 30 seconds!
	fi
    sleep 25
done
