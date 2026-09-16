<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="assets/logo-dark.png">
    <img src="assets/logo-light.png" alt="TheAirTraffic" width="120">
  </picture>
</p>

<h1 align="center">TheAirTraffic Feed Client</h1>

<p align="center">
  Share your ADS-B receiver's data with <a href="https://theairtraffic.com">TheAirTraffic.com</a><br>
  <sub>Runs alongside your existing feeders — it will not disrupt them.</sub>
</p>

---

## What it does

This doesn't replace your decoder or touch your SDR. It installs two services that read from your existing decoder and forward data on:

- **`theairtraffic-feed`** — a headless readsb instance that reads Beast data on `30005` and forwards it to `feed.theairtraffic.com:30004`
- **`theairtraffic-mlat`** — the MLAT client, so Mode S aircraft without positions can be located by multilateration. Optional; enter `0` as the feeder name to skip it.

## Requirements

A Linux receiver (Raspberry Pi OS, Debian, Ubuntu) already decoding ADS-B with Beast output on port `30005` — the default for readsb, dump1090, dump1090-fa and PiAware. You'll need root and your antenna's latitude, longitude and altitude ([elevation finder](https://www.freemaptools.com/elevation-finder.htm)).

## Install

```bash
curl -L -o /tmp/tatfeed.sh https://raw.githubusercontent.com/TheAirTraffic/tat-feeder/master/install.sh
sudo bash /tmp/tatfeed.sh
```

Compiles from source, so allow a few minutes on a Pi. You'll be asked for a feeder name (shown on the MLAT map, pin offset for privacy), your coordinates to five decimal places, and altitude with an explicit unit and no spaces — `255ft` or `78m`.

Check your feed after ~5 minutes at **<https://theairtraffic.com/myip/>**.

## Update

```bash
curl -L -o /tmp/tatupdate.sh https://raw.githubusercontent.com/TheAirTraffic/tat-feeder/master/update.sh
sudo bash /tmp/tatupdate.sh
```

Keeps your configuration. To change location or feeder name, re-run the installer.

## Configuration

`/etc/default/theairtraffic` (some SD images use `/boot/theairtraffic-config.txt`). Restart with `sudo systemctl restart theairtraffic-feed theairtraffic-mlat` after editing.

| Setting | Meaning |
|---|---|
| `INPUT` | Beast source. Default `127.0.0.1:30005`. Point it elsewhere to feed from another machine. |
| `UAT_INPUT` | Optional UAT (978 MHz) source. Default `127.0.0.1:30978`. |
| `LATITUDE` / `LONGITUDE` / `ALTITUDE` | Receiver position. |
| `USER` | MLAT feeder name. `0` disables MLAT. |

MLAT results are available locally on `31023` (BaseStation) and `30197` (Beast). These avoid the ports other feeder packages use, so several networks can be fed from one receiver.

## Other commands

```bash
# status and logs
systemctl status theairtraffic-feed theairtraffic-mlat
journalctl -u theairtraffic-feed -u theairtraffic-mlat -f

# optional local map at http://<receiver-ip>/theairtraffic
sudo bash /usr/local/share/theairtraffic/git/install-or-update-interface.sh

# uninstall (receiver UUID is preserved)
sudo bash /usr/local/share/theairtraffic/git/uninstall.sh
```

## Troubleshooting

**No data.** Confirm your decoder is serving Beast: `nc -z 127.0.0.1 30005`. Running FR24 or RB24 with no separate decoder? They don't expose `30005` — install a [standalone decoder](https://github.com/wiedehopf/adsb-scripts/wiki/Automatic-installation-for-readsb) first.

**MLAT not syncing.** Needs accurate coordinates and a synced clock. The installer sets up `chrony` unless chrony or ntp is already running.

**Install log.** `/usr/local/share/theairtraffic/lastlog`

## Credits

Built from [wiedehopf/readsb](https://github.com/wiedehopf/readsb) and [tar1090](https://github.com/wiedehopf/tar1090). The MLAT client derives from Oliver Jowett's [mlat-client](https://github.com/mutability/mlat-client), GPL-3.0.
