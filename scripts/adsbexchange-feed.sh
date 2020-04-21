#!/bin/bash

INPUT_IP=$(echo $INPUT | cut -d: -f1)
INPUT_PORT=$(echo $INPUT | cut -d: -f2)
SOURCE="--net-connector $INPUT_IP,$INPUT_PORT,beast_in"

/usr/local/share/theairtraffic/feed-tat --net --net-only --debug=n --quiet \
    --write-json /run/theairtraffic-feed \
    --net-beast-reduce-interval $REDUCE_INTERVAL \
    $TARGET $NET_OPTIONS $SOURCE
