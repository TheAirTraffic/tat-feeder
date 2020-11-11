# TheAirTraffic Setup Scripts :airplane:

These scripts aid in setting up your current ADS-B receiver to feed TheAirTraffic.

### Obtaining And Using The Scripts

Use this command to start the setup process:

```
wget -O /tmp/axfeed.sh https://raw.githubusercontent.com/theairtraffic/TheAirTraffic/master/install.sh
sudo bash /tmp/axfeed.sh
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
sudo bash /usr/local/share/theairtraffic/uninstall.sh
```

If the above doesn't work, you may be using an old version that didn't have the uninstall script, just disable the services and the scripts won't run anymore:

```
sudo systemctl disable --now theairtraffic-feed
sudo systemctl disable --now theairtraffic-mlat
```
