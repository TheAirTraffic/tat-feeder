#!/bin/bash
set -e

REPO="https://github.com/Jxck-S/feedclient.git"
BRANCH="master"
IPATH=/usr/local/share/theairtraffic
mkdir -p $IPATH

if [ "$(id -u)" != "0" ]; then
    echo -e "\033[33m"
    echo "This script must be ran using sudo or as root."
    echo -e "\033[37m"
    exit 1
fi

if ! command -v git &>/dev/null || ! command -v wget &>/dev/null || ! command -v unzip &>/dev/null; then
    apt-get update || true; apt-get install -y --no-install-recommends --no-install-suggests git wget unzip || true
fi

git clone "$REPO" "$IPATH/git"

cd "$IPATH/git"
bash "$IPATH/git/setup.sh"
