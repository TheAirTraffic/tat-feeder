#!/bin/bash

if [ -f /boot/adsb-config.txt ]; then
    source /boot/adsb-config.txt
    source /boot/tat-env
else
    source /etc/default/theairtraffic
fi

/usr/local/share/theairtraffic/venv/bin/python3 /usr/local/share/theairtraffic/venv/bin/mlat-client \
	--input-type "$INPUT_TYPE" --no-udp \
	--input-connect "$INPUT" \
	--server "$MLATSERVER" \
	--user "$USER" \
	--lat "$LATITUDE" \
	--lon "$LONGITUDE" \
	--alt "$ALTITUDE" \
	$RESULTS $RESULTS1 $RESULTS2 $RESULTS3 $RESULTS4
