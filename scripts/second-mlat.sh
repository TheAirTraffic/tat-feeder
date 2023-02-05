#!/bin/bash
SERVICE="/lib/systemd/system/theairtraffic-mlat2.service"

if [[ -z ${1} ]]; then
    echo --------------
    echo ERROR: requires a parameter
    exit 1
fi

cat >"$SERVICE" <<"EOF"
[Unit]
Description=theairtraffic-mlat2
Wants=network.target
After=network.target

[Service]
User=theairtraffic
EnvironmentFile=/etc/default/theairtraffic
ExecStart=/usr/local/share/theairtraffic/venv/bin/mlat-client \
    --input-type $INPUT_TYPE --no-udp \
    --input-connect $INPUT \
    --server feed.theairtraffic.com:SERVERPORT \
    --user $USER \
    --lat $LATITUDE \
    --lon $LONGITUDE \
    --alt $ALTITUDE \
    $UUID_FILE \
    $PRIVACY \
    $RESULTS
Type=simple
Restart=always
RestartSec=30
StartLimitInterval=1
StartLimitBurst=100
SyslogIdentifier=theairtraffic-mlat2
Nice=-1

[Install]
WantedBy=default.target
EOF

if [[ -f /boot/theairtraffic-config.txt ]]; then
    sed -i -e 's#EnvironmentFile.*#EnvironmentFile=/boot/theairtraffic-env\nEnvironmentFile=/boot/theairtraffic-config.txt#' "$SERVICE"
fi

sed -i -e "s/SERVERPORT/${1}/" "$SERVICE"
if [[ -n ${2} ]]; then
    sed -i -e "s/\$RESULTS/${2}/" "$SERVICE"
fi

systemctl enable theairtraffic-mlat2
systemctl restart theairtraffic-mlat2
