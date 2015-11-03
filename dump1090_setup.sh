#!/bin/bash

clear

echo -e "\033[31m"
echo "-----------------------------------------------------"
echo " TheAirTraffic Feeder Setup Script. (Dump1090)"
echo "-----------------------------------------------------"
echo -e "\033[33m"
echo "TheAirTraffic.com is a co-op of ADS-B/Mode S/MLAT feeders from around the world."
echo "This script will setup your feeder running Dump1090 to share your data with TheAirTraffic as well."
echo ""
echo "https://github.com/jprochazka/TheAirTraffic"
echo "http://www.theairtraffic.com/how-to-feed/"
echo "http://www.theairtraffic.com/forums/topic/TheAirTraffic-setup-script/"
echo -e "\033[37m"
read -p "Continue setup? [Y/n] " CONTINUE

if [[ $CONTINUE == "" ]]; then CONTINUE="Y"; fi
if [[ ! $CONTINUE =~ ^[Yy]$ ]]; then
    echo ""
    exit 0
fi

SCRIPTDIR=$PWD/scripts

## SET PERMISSIONS ON THE THEAIRTRAFFIC MAINTAINANCE SCRIPT

echo -e "\033[33mSetting permissions on the TheAirTraffic maintainance script..."
echo -e "\033[37m"
sudo chmod 755 $SCRIPTDIR/theairtraffic-maint.sh

## ADD THEAIRTRAFFIC MAINTAINANCE SCRIPT TO RC.LOCAL

if ! grep -Fxq "${SCRIPTDIR}/theairtraffic-maint.sh &" /etc/rc.local; then
    echo -e "\033[33mAdding TheAirTraffic maintainance script startup command to rc.local..."
    echo -e "\033[37m"
    lnum=($(sed -n '/exit 0/=' /etc/rc.local))
    ((lnum>0)) && sudo sed -i "${lnum[$((${#lnum[@]}-1))]}i ${SCRIPTDIR}/theairtraffic-maint.sh &\n" /etc/rc.local
fi

## RUN THE THEAIRTRAFFIC MAINTAINANCE SCRIPT

echo -e "\033[33mRunning TheAirTraffic maintainance script..."
echo -e "\033[37m"
sudo $SCRIPTDIR/theairtraffic-maint.sh start &

## DISPLAY SETUP COMPLETE MESSAGE

echo -e "\033[33m"
echo "Configuration of the TheAirTraffic feed is now complete."
echo "Please look over the output generated to be sure no errors were encountered."
echo "Also make sure to leave the files and folders contained here in place."
echo -e "\033[37m"
read -p "Press enter to exit this script..." CONTINUE
echo ""

exit 0
