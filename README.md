# TheAirTraffic Setup Scripts :airplane:

These scripts aid in setting up your current ADS-B receiver to feed TheAirTraffic.

### Obtaining And Using The Scripts

Running the following commands will download the contents of this repository and begin setup.

    sudo apt-get install git
    git clone https://github.com/theairtraffic/TheAirTraffic.git
    cd TheAirTraffic
    chmod +x setup.sh
    sudo ./setup.sh
    
**After completing the setup do not delete this repository.**

The script creates two files, one named theairtraffic-mlat_maint.sh and another named theairtraffic-netcat_maint.sh which will reside in this folder containing a clone of this repository. The path to execute these scripts after each reboot has been set to this location. Deleting this folder will result in both the theairtraffic-mlat_maint.sh and theairtraffic-netcat_maint.sh scripts to not be executed thus not enabling your receiver to feed TheAirTraffic after your device has been rebooted.
