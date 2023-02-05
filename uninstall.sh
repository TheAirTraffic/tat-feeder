#!/bin/bash
set -x

IPATH=/usr/local/share/theairtraffic

systemctl disable --now theairtraffic-mlat
systemctl disable --now theairtraffic-mlat2 &>/dev/null
systemctl disable --now theairtraffic-feed

if [[ -d /usr/local/share/tar1090/html-theairtraffic ]]; then
    bash /usr/local/share/tar1090/uninstall.sh theairtraffic
fi

rm -f /lib/systemd/system/theairtraffic-mlat.service
rm -f /lib/systemd/system/theairtraffic-mlat2.service
rm -f /lib/systemd/system/theairtraffic-feed.service

cp -f "$IPATH/theairtraffic-uuid" /tmp/theairtraffic-uuid
rm -rf "$IPATH"
mkdir -p "$IPATH"
mv -f /tmp/theairtraffic-uuid "$IPATH/theairtraffic-uuid"

set +x

echo -----
echo "theairtraffic feed scripts have been uninstalled!"
