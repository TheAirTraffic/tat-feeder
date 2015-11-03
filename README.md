# TheAirTraffic Setup Script :airplane:

Feeding TheAirTraffic.com is quick and easy. There are various options depending on what kind of feeder/receiver you use,
and your desired level of customization. This script aids in setting up your current PiAware or Dump1090 based feeder to
feed TheAirTraffic. Although not required it is recommended that FlightAware’s PiAware be used to feed data to
TheAirTraffic in order to send the most accurate MLAT results to the co-op.

#### Obtaining And Using This Script

Running the following commands will download the contents of this repository.

    sudo apt-get install git
    git clone https://github.com/jprochazka/TheAirTraffic.git
    cd TheAirTraffic
    
Depending on if you have PiAware setup or are running Dump1090...

**PiAware**

    chmod 755 piaware_setup.sh
    ./piaware_setup.sh
    
**Dump1090**

    chmod 755 dump1090_setup.sh
    ./dump1090_setup.sh

#### Reporting Issues

Feel free to report any issues you encounter either in this repositories issue tracker or the TheAirTraffic Setup Script
topic located in the TheAirTraffic forums.

https://github.com/jprochazka/TheAirTraffic_setup/issues  
http://www.theairtraffic.com/forums/topic/TheAirTraffic-setup-script/

