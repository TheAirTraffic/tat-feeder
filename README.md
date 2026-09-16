<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="assets/logo-dark.png">
    <img src="assets/logo-light.png" alt="TheAirTraffic" width="120">
  </picture>
</p>

<h1 align="center">TheAirTraffic Feed Client</h1>

<p align="center">
  Share your ADS-B receiver's data with <a href="https://theairtraffic.com">TheAirTraffic.com</a><br>
  <sub>Works alongside your existing feeders — it will not disrupt them.</sub>
</p>

---

## What this actually does

This does **not** replace your decoder or touch your SDR. Your existing setup — readsb, dump1090, dump1090-fa, PiAware — keeps running exactly as it is.

Instead, the installer sets up two small services that read from your decoder and forward data onward:

```
                        ┌──────────────────────────┐
  your decoder          │  theairtraffic-feed      │
  (readsb / dump1090 /  │  reads Beast on :30005   │──▶  feed.theairtraffic.com:30004
   dump1090-fa /        │  forwards reduced Beast  │
   PiAware)             └──────────────────────────┘
       │
       │                ┌──────────────────────────┐
       └───────────────▶│  theairtraffic-mlat      │──▶  feed.theairtraffic.com:31090
                        │  multilateration client  │
                        └──────────────────────────┘
```

| Service | What it is | Purpose |
|---|---|---|
| `theairtraffic-feed` | A second, headless instance of readsb, installed as `feed-theairtraffic` | Connects to your decoder's Beast output and forwards positions. It runs with `--net --net-only`, so it decodes nothing itself and never touches your SDR. |
| `theairtraffic-mlat` | `mlat-client` in its own Python virtualenv | Sends timing data so aircraft that broadcast no position (Mode S only) can be located by multilateration across several receivers. |

MLAT is optional. Enter `0` as the feeder name during setup to skip it.

## Requirements

- A Linux receiver (Raspberry Pi OS, Debian, or Ubuntu) already decoding ADS-B
- Beast output reachable on port `30005` — this is the default for readsb, dump1090, dump1090-fa, and PiAware
- `sudo` / root access
- Your receiver's latitude, longitude, and antenna altitude

Need your coordinates? Use an [elevation finder](https://www.freemaptools.com/elevation-finder.htm). Enter latitude and longitude to five decimal places — MLAT accuracy depends on it.

## Install

```bash
curl -L -o /tmp/tatfeed.sh https://raw.githubusercontent.com/TheAirTraffic/tat-feeder/master/install.sh
sudo bash /tmp/tatfeed.sh
```

The installer compiles the feed client and MLAT client from source, so expect it to take a few minutes on a Raspberry Pi. You'll be asked for:

| Prompt | Notes |
|---|---|
| **Feeder name** | Shown on the MLAT map. Pick something unique, e.g. `william34-london`. Your pin is offset for privacy. Enter `0` to disable MLAT. |
| **Latitude / Longitude** | Five decimal places. |
| **Altitude** | At the antenna, above sea level. The unit is required, with no spaces — `255ft` or `78m`. |

## Check your feed

After about five minutes:

**<https://theairtraffic.com/myip/>**

To watch the services directly:

```bash
systemctl status theairtraffic-feed theairtraffic-mlat
journalctl -u theairtraffic-feed -u theairtraffic-mlat -f
```

## Update

Updates in place and keeps your existing configuration:

```bash
curl -L -o /tmp/tatupdate.sh https://raw.githubusercontent.com/TheAirTraffic/tat-feeder/master/update.sh
sudo bash /tmp/tatupdate.sh
```

To change your location or feeder name, re-run the installer instead.

## Optional: local map

Installs [tar1090](https://github.com/wiedehopf/tar1090) to view the data you're sending, at `http://<your-receiver-ip>/theairtraffic`:

```bash
sudo bash /usr/local/share/theairtraffic/git/install-or-update-interface.sh
```

## Configuration

Settings live in `/etc/default/theairtraffic` (some SD-card images use `/boot/theairtraffic-config.txt`). Edit, then restart:

```bash
sudo systemctl restart theairtraffic-feed theairtraffic-mlat
```

| Setting | Meaning |
|---|---|
| `INPUT` | Where to read Beast data. Default `127.0.0.1:30005`. |
| `UAT_INPUT` | Optional UAT (978 MHz) source. Default `127.0.0.1:30978`. |
| `LATITUDE` / `LONGITUDE` / `ALTITUDE` | Receiver position. |
| `USER` | Your MLAT feeder name. `0` disables MLAT. |

### Local ports

These are chosen to avoid colliding with other feeder packages, so several networks can be fed from one receiver:

| Port | Direction | Purpose |
|---|---|---|
| `31023` | listen | MLAT results, BaseStation format |
| `30197` | listen | MLAT results, Beast format |
| `30104` | connect | MLAT results back into a local decoder |

## Feeding from another machine

If your decoder runs on a different device, set `INPUT` to its address — for example `192.168.1.50:30005` — and make sure that device allows connections on port `30005`.

Running FR24 or RB24 with no separate decoder? Those don't expose port `30005`, so you'll need a standalone decoder first. See wiedehopf's [readsb install guide](https://github.com/wiedehopf/adsb-scripts/wiki/Automatic-installation-for-readsb).

## Uninstall

```bash
sudo bash /usr/local/share/theairtraffic/git/uninstall.sh
```

Your receiver UUID is preserved, so reinstalling keeps your feeder identity.

## Troubleshooting

**No data / feed not showing up.** Check that your decoder is actually serving Beast data:

```bash
nc -z 127.0.0.1 30005 && echo "decoder reachable" || echo "nothing on 30005"
```

**MLAT not syncing.** MLAT needs an accurate position and several nearby receivers. Confirm your coordinates are correct to five decimal places and that the clock is synced — the installer sets up `chrony` if neither `chrony` nor `ntp` is already running.

**Reading the install log.** The last run is logged to `/usr/local/share/theairtraffic/lastlog`.

## Credits

The feed client is built from [wiedehopf/readsb](https://github.com/wiedehopf/readsb). The MLAT client derives from Oliver Jowett's [mlat-client](https://github.com/mutability/mlat-client) and remains under the GPL-3.0.
