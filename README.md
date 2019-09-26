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

### Checking status

### Display MLAT config

cat /etc/default/theairtraffic

### Systemd Status

sudo systemctl status theairtraffic-mlat

sudo systemctl status theairtraffic-feed

### Restart

sudo systemctl restart theairtraffic-feed

sudo systemctl restart theairtraffic-mlat

