#!/bin/bash

if grep -qs -e 'LATITUDE' /boot/adsb-config.txt &>/dev/null && [[ -f /boot/tat-env ]]; then
    source /boot/adsb-config.txt
    source /boot/tat-env
else
    source /etc/default/theairtraffic
fi

INPUT_IP=$(echo $INPUT | cut -d: -f1)
INPUT_PORT=$(echo $INPUT | cut -d: -f2)
SOURCE="--net-connector $INPUT_IP,$INPUT_PORT,beast_in"

sleep 2

while ! nc -z "$INPUT_IP" "$INPUT_PORT" && command -v nc &>/dev/null; do
    echo "Could not connect to $INPUT_IP:$INPUT_PORT, retry in 10 seconds."
    sleep 10
done

exec /usr/local/share/theairtraffic/feed-tat --net --net-only --debug=n --quiet \
    --write-json /run/theairtraffic-feed \
    --net-beast-reduce-interval $REDUCE_INTERVAL \
    $TARGET $NET_OPTIONS $SOURCE \
    --lat "$LATITUDE" --lon "$LONGITUDE" \
    $UUID_FILE $JSON_OPTIONS
