#!/bin/bash

clear

echo -e "\033[31m"
echo "-----------------------------------------------------"
echo " TheAirTraffic Feeder Setup Script."
echo "-----------------------------------------------------"
echo -e "\033[33m"
echo "TheAirTraffic.com is a co-op of ADS-B/Mode S/MLAT feeders from around the world."
echo "This script will setup your current PiAware installation to share your data with TheAirTraffic as well."
echo "PiAware is required to be installed in order to use this script to setup the feed to TheAirTraffic."
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

## ASSIGN THE SCRIPTDIR VARIABLE WHICH SHOULD BE THE DIRECTORY CONTAINING THIS SCRIPT

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

## CONFIGURE PIAWARE TO FEED THEAIRTRAFFIC

echo -e "\033[33m"
echo "Adding the TheAirTraffic feed to PiAware's configuration..."
ORIGINALFORMAT=`sudo piaware-config -show | sed -n 's/.*{\(.*\)}.*/\1/p'`
CLEANFORMAT=`sed 's/ beast,connect,feed.theairtraffic.com:30005//g' <<< $ORIGINALFORMAT`
`sudo piaware-config -mlatResultsFormat "${CLEANFORMAT} beast,connect,feed.theairtraffic.com:30005"`
echo -e "\033[33m"
echo "Restarting PiAware so new configuration takes effect..."
echo -e "\033[37m"
sudo piaware-config -restart
echo ""

## SET PERMISSIONS ON THE THEAIRTRAFFIC MAINTAINANCE SCRIPT

echo -e "\033[33mSetting permissions on the TheAirTraffic maintainance script..."
echo -e "\033[37m"
chmod 755 $SCRIPTDIR/theairtraffic-maint.sh

## ADD THEAIRTRAFFIC MAINTAINANCE SCRIPT TO RC.LOCAL

if ! grep -Fxq "${SCRIPTDIR}/theairtraffic-maint.sh &" /etc/rc.local; then
    echo -e "\033[33mAdding TheAirTraffic maintainance script startup command to rc.local..."
    echo -e "\033[37m"
    lnum=($(sed -n '/exit 0/=' /etc/rc.local))
    ((lnum>0)) && sudo sed -i "${lnum[$((${#lnum[@]}-1))]}i ${SCRIPTDIR}/theairtraffic-maint.sh &\n" /etc/rc.local
fi

## KILL ANY CURRENTLY RUNNING INSTANCES OF THE THEAIRTRAFFIC MAINTAINANCE SCRIPT

echo -e "\033[33mKilling any theairtraffic-maint.sh processes currently running..."
PIDS=`ps -efww | grep -w "theairtraffic-maint.sh" | awk -vpid=$$ '$2 != pid { print $2 }'`
if [ ! -z "$PIDS" ]; then
    echo -e "\033[37m"
    sudo kill $PIDS
    sleep 5
    sudo kill -9 $PIDS
fi

## RUN THE THEAIRTRAFFIC MAINTAINANCE SCRIPT

echo -e "\033[33mRunning TheAirTraffic maintainance script..."
echo -e "\033[37m"
sudo $SCRIPTDIR/theairtraffic-maint.sh &

## DISPLAY SETUP COMPLETE MESSAGE

echo -e "\033[33mConfiguration of the TheAirTraffic feed is now complete."
echo "Please look over the output generated to be sure no errors were encountered."
echo "Also make sure to leave the files and folders contained here in place."
echo -e "\033[37m"
read -p "Press enter to exit this script..." CONTINUE
echo ""

exit 0
