#!/bin/bash

IPATH=/usr/local/share/theairtraffic

systemctl disable --now theairtraffic-mlat
systemctl disable --now theairtraffic-feed

rm -f /lib/systemd/system/theairtraffic-mlat.service
rm -f /lib/systemd/system/theairtraffic-feed.service

rm -rf "$IPATH"
