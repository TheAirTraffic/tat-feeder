# TheAirTraffic feed client

- These scripts aid in setting up your current ADS-B receiver to feed TheAirTraffic.
- They will not disrupt any existing feed clients already present

## 1: Find coordinates / elevation:

<https://www.freemaptools.com/elevation-finder.htm>

## 2: Install the theairtraffic feed client

```
curl -L -o /tmp/axfeed.sh https://raw.githubusercontent.com/Jxck-S/feedclient/master/install.sh
sudo bash /tmp/axfeed.sh
```

## 3: Check this URL to check if your feed is working

- <https://theairtraffic.com/feed/myip/>


### Update the feed client without reconfiguring

```
curl -L -o /tmp/axupdate.sh https://raw.githubusercontent.com/Jxck-S/feedclient/master/update.sh
sudo bash /tmp/axupdate.sh
```