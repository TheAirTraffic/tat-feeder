# TheAirTraffic Setup Scripts :airplane:

These scripts aid in setting up your current ADS-B receiver to feed TheAirTraffic.

### Obtaining And Using The Scripts

Use this command to start the setup process:

```
sudo bash -c "$(wget -nv -O - https://raw.githubusercontent.com/theairtraffic/TheAirTraffic/master/install.sh)"
```

Alternatively running the following commands will begin the setup process:

```
sudo apt-get install git
sudo rm TheAirTraffic -rf
git clone https://github.com/theairtraffic/TheAirTraffic.git
cd TheAirTraffic
sudo bash setup.sh
```

### Checking status

### Display MLAT config
```
cat /etc/default/theairtraffic
```

### If you encounter issues, please supply these logs on the forum (last 20 lines for each is sufficient):

```
sudo journalctl -u theairtraffic-feed --no-pager
sudo journalctl -u theairtraffic-mlat --no-pager
```

### Restart

```
sudo systemctl restart theairtraffic-feed
sudo systemctl restart theairtraffic-mlat
```


### Systemd Status

```
sudo systemctl status theairtraffic-mlat
sudo systemctl status theairtraffic-feed
```


### Removal / disabling the services:

```
sudo systemctl disable --now theairtraffic-feed
sudo systemctl disable --now theairtraffic-mlat


--tat-git-discord
```
