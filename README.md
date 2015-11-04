# TheAirTraffic Setup Script :airplane:

Feeding TheAirTraffic.com is quick and easy. There are various options depending on what kind of feeder/receiver you use,
and your desired level of customization. This script aids in setting up your current PiAware or Dump1090 based feeder to
feed TheAirTraffic. Although not required it is recommended that FlightAware’s PiAware be used to feed data to
TheAirTraffic in order to send the most accurate MLAT results to the co-op.

### Obtaining And Using The Scripts

Running the following commands will download the contents of this repository.

    sudo apt-get install git
    git clone https://github.com/jprochazka/TheAirTraffic.git
    cd TheAirTraffic

If you have FlightAware's PiAware installed...

    chmod 755 piaware_setup.sh
    ./piaware_setup.sh
    
If you are running a FlightRadar24 feeder or only dump1090...

    chmod 755 dump1090_setup.sh
    ./dump1090_setup.sh
    
**After completing the setup do not delete this repository.**

The file theairtraffic-maint.sh script resides in this folder containing a clone of this repository. The path to execute this script after a reboot has been set to this location. Deleting this folder will result in the theairtraffic-maint.sh script not being executed thus not enabling your feeder to feed TheAirTraffic.

### Reporting Issues

Feel free to report any issues you encounter either in this repositories issue tracker or the TheAirTraffic Setup Script
topic located in the TheAirTraffic forums.

https://github.com/jprochazka/TheAirTraffic_setup/issues  
http://www.theairtraffic.com/forums/topic/TheAirTraffic-setup-script/

