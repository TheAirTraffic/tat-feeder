#!/bin/bash
TMP=/tmp/theairtraffic-git
if ! command -v git; then
    apt-get update
    apt-get install -y git
fi
rm -rf "$TMP"
git clone https://github.com/theairtraffic/TheAirTraffic.git "$TMP"
cd "$TMP"
bash setup.sh
