# Preparing a RPi image

## Download the latest raspbian light image

> Note: be nice to projects, use torrents!

1. Download [WebTorrent](https://webtorrent.io/) (or use your favorite torrent client!)
2. Go to: https://downloads.raspberrypi.org/raspbian_lite_latest.torrent
3. Open the downloaded torrent file in WebTorrent and wait for the download to finish

## Flash the image

1. Download [Etcher](https://www.balena.io/etcher/)
2. Insert your SD card
3. Use Etcher to open and flash the image

## Enable and Connect the serial console

[Configure your RPi image to be headless](https://www.raspberrypi.org/documentation/configuration/wireless/headless.md)

## Boot

Startup the pi and head over to your router to see what ip address it was given, then ssh in using the credentials:

```
ssh pi@[ip_address]
username: pi
password: raspberry
```

While in your router's UI, you should take a moment to make this pi's IP address static

## Get ready to run ansible

Use `raspi-config` to:

1. set the locale to `en_US.UTF8`
2. enable ssh
3. connect to wifi
4. turn on the camera (interfacing options -> camera)
5. set the timezone to UTC
6. change the password to something more secure

Next, use `scp` to copy your `~/.ssh/id_ed25519.pub` file to the `~/.ssh/authorized_keys` file on the pi.

## Run ansible

Add the pi to the appropriate section in ./ansible/inventory.yml

* `[nannycam]` - A security camera for your home
  * Requires a camera be connected to the raspberry pi camera connector

Then run:

```
ansible-playbook -i ./ansible/inventory.yml ./ansible/playbook.yml
```
