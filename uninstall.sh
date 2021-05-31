#!/bin/bash
set -x

IPATH=/usr/local/share/theairtraffic

systemctl disable --now theairtraffic-mlat
systemctl disable --now theairtraffic-mlat2 &>/dev/null
systemctl disable --now theairtraffic-feed

rm -f /lib/systemd/system/theairtraffic-mlat.service
rm -f /lib/systemd/system/theairtraffic-mlat2.service
rm -f /lib/systemd/system/theairtraffic-feed.service

rm -rf "$IPATH"

set +x

echo -----
echo "theairtraffic feed scripts have been uninstalled!"
