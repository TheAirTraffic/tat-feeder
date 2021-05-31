#!/bin/bash
cat >/lib/systemd/system/theairtraffic-mlat2.service <<"EOF"
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
    $PRIVACY \
    RESULTSLINE
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

sed -i -e "s/SERVERPORT/${1}/" /lib/systemd/system/theairtraffic-mlat2.service
sed -i -e "s/RESULTSLINE/${2}/" /lib/systemd/system/theairtraffic-mlat2.service

systemctl enable theairtraffic-mlat2
systemctl restart theairtraffic-mlat2
