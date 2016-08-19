#!/bin/bash

# Check if user is using sudo or is logged in a root.
if [ "$(id -u)" != "0" ]; then
    echo "This script must be ran using sudo or as root."
    exit 1
fi

clear

# Set a variable containing the path to this script.
SCRIPTPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

##############
## FUNCTIONS

# Configure FlightAware's PiAware software.
function ConfigurePiAware() {
    # Retreive and clean the current PiAware mlatResultFormat setting.
    echo -e "\033[33m"
    echo "Adding the TheAirTraffic feed to PiAware's configuration..."
    ORIGINALFORMAT="`sudo piaware-config -show mlat-results-format`"
    CLEANFORMAT=`sed 's/ beast,connect,feed.theairtraffic.com:30005//g' <<< $ORIGINALFORMAT`
    FINALFORMAT="${CLEANFORMAT} beast,connect,feed.theairtraffic.com:30005"

    # Set the new PiAware mlatResultFormat setting.
    sudo piaware-config  mlat-results-format "${FINALFORMAT}"

    # Restart PiAware.
    echo ""
    echo "Restarting PiAware so new configuration takes effect..."
    echo -e "\033[37m"
    sudo piaware-config -restart
}

# Setup the Netcat script and execute it.
function SetupNetcat() {
    # Set permissions on teh file theairtraffic-maint.sh.
    chmod 755 $SCRIPTPATH/theairtraffic-maint.sh

    # Add the ADS-B maintainance script to the file /etc/rc.local.
    if ! grep -Fxq "${SCRIPTPATH}/theairtraffic-maint.sh &" /etc/rc.local; then
        echo -e "\033[33m"
        echo "Adding TheAirTraffic maintainance script startup command to rc.local..."
        echo -e "\033[37m"
        lnum=($(sed -n '/exit 0/=' /etc/rc.local))
        ((lnum>0)) && sudo sed -i "${lnum[$((${#lnum[@]}-1))]}i ${SCRIPTPATH}/theairtraffic-maint.sh &\n" /etc/rc.local
    fi

    # Kill any currently running instances of the theairtraffic-maint.sh script.
    echo -e "\033[33m"
    echo "Killing any theairtraffic-maint.sh processes currently running..."
    echo -e "\033[37m"
    PIDS=`ps -efww | grep -w "theairtraffic-maint.sh" | awk -vpid=$$ '$2 != pid { print $2 }'`
    if [ ! -z "$PIDS" ]; then
        sudo kill $PIDS
        sleep 5
        sudo kill -9 $PIDS
    fi

    # Execute the ADS-B maintainance script.
    echo -e "\033[33mRunning TheAirTraffic maintainance script..."
    sudo $SCRIPTPATH/theairtraffic-maint.sh &
}

################
## NO WHIPTAIL

# Welcome message.
echo -e "\033[31m"
echo "-----------------------------------------------------------------"
echo " TheAirTraffic Setup Script"
echo "-----------------------------------------------------------------"
echo -e "\033[33m"
echo "Thanks for choosing to share your data with TheAirTraffic!"
echo ""
echo "TheAirTraffic.com is a co-op of ADS-B/Mode S/MLAT feeders"
echo "from around the world. This script will configure your"
echo "current PiAware and/or Dump1090 installation to share"
echo "your feeders data with TheAirTraffic. It is recommeded"
echo "that FlightAware's PiAware software be installed in order"
echo "to feed accurate \"MLAT\" data but is not required."
echo -e "\033[37m"
read -p "Continue setup? [Y/n] " CONTINUE

if [[ $CONTINUE == "" ]]; then CONTINUE="Y"; fi
if [[ ! $CONTINUE =~ ^[Yy]$ ]]; then
    echo ""
    exit 1
fi

# Check if the PiAware package is installed.
if [ $(dpkg-query -W -f='${STATUS}' $1 2>/dev/null | grep -c "ok installed") -eq 1 ]; then
    # PiAware appear to be installed.
    ConfigurePiAware
fi

# Setup the Netcat script.
SetupNetcat

# Thank you message.
echo -e "\033[33m"
echo "Setup is now complete."
echo ""
echo "Your feeder should now be feeding data to TheAirTraffic."
echo "Thanks again for choosing to share your data with TheAirTraffic!"
echo ""
echo "If you have questions or encountered any issues while using this"
echo "script feel free to post them to one of the following places."
echo ""
echo "https://github.com/jprochazka/TheAirTraffic"
echo "http://www.theairtraffic.com/forums/topic/TheAirTraffic-setup-script/"
echo -e "\033[37m"

exit 0
