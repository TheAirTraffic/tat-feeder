# TheAirTraffic Setup Script :airplane:

Feeding TheAirTraffic.com is quick and easy. There are various options depending on what kind of feeder/receiver you use,
and your desired level of customization. it is recommended that FlightAware’s Raspberry Pi based “PiAware” be used to feed
data to TheAirTraffic in order to send accurate MLAT results to the co-op. This script aids in setting up your current PiAware based feeder to feed TheAirTraffic as well.

#### Obtaining And Using This Script

Running the following commands will download and execute the script.

    sudo apt-get install git wget
    git clone https://github.com/jprochazka/TheAirTraffic.git
    cd TheAirTraffic
    chmod 755 TheAirTraffic_setup.sh 
    ./TheAirTraffic_setup.sh
    
#### Reporting Issues

Feel free to report any issues you encounter either in this repositories issue tracker or the TheAirTraffic Setup Script
topic located in the TheAirTraffic forums.

https://github.com/jprochazka/TheAirTraffic_setup/issues  
http://www.theairtraffic.com/forums/topic/TheAirTraffic-setup-script/
