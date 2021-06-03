# TheAirTraffic Setup Scripts :airplane:

These scripts aid in setting up your current ADS-B receiver to feed TheAirTraffic.

### Install the theairtraffic feed client

```
wget -O /tmp/axfeed.sh https://raw.githubusercontent.com/theairtraffic/TheAirTraffic/master/install.sh
sudo bash /tmp/axfeed.sh
```

### Update the feed client without reconfiguring

```
wget -O /tmp/axupdate.sh https://raw.githubusercontent.com/theairtraffic/TheAirTraffic/master/update.sh
sudo bash /tmp/axupdate.sh
```

### Check these two URLs to check if your feed is working

- https://www.theairtraffic.com/myip
- https://map.theairtraffic.com/mlat-map

### If you encounter issues, please do a reboot and then supply these logs on the forum (last 20 lines for each is sufficient):

```
sudo journalctl -u theairtraffic-feed --no-pager
sudo journalctl -u theairtraffic-mlat --no-pager
```


### Display the configuration

```
cat /etc/default/theairtraffic
```

### Changing the configuration

This is the same as the initial installation.
If the client is up to date it should not take as long as the original installation,
otherwise this will also update the client which will take a moment.

```
wget -O /tmp/axfeed.sh https://raw.githubusercontent.com/theairtraffic/TheAirTraffic/master/install.sh
sudo bash /tmp/axfeed.sh
```

### Other device as a data source (networked standalone receivers):

https://github.com/theairtraffic/wiki/wiki/Datasource-other-device

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
sudo bash /usr/local/share/theairtraffic/uninstall.sh
```

If the above doesn't work, you may be using an old version that didn't have the uninstall script, just disable the services and the scripts won't run anymore:

```
sudo systemctl disable --now theairtraffic-feed
sudo systemctl disable --now theairtraffic-mlat
```
