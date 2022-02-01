#!/bin/bash
set -x

IPATH=/usr/local/share/theairtraffic

systemctl disable --now theairtraffic-mlat
systemctl disable --now theairtraffic-mlat2 &>/dev/null
systemctl disable --now theairtraffic-feed

if [[ -d /usr/local/share/tar1090/html-tat ]]; then
    bash /usr/local/share/tar1090/uninstall.sh tat
fi

rm -f /lib/systemd/system/theairtraffic-mlat.service
rm -f /lib/systemd/system/theairtraffic-mlat2.service
rm -f /lib/systemd/system/theairtraffic-feed.service

cp -f "$IPATH/tat-uuid" /tmp/tat-uuid
rm -rf "$IPATH"
mkdir -p "$IPATH"
mv -f /tmp/tat-uuid "$IPATH/tat-uuid"

set +x

echo -----
echo "theairtraffic feed scripts have been uninstalled!"
