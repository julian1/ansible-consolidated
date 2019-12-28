#!/bin/bash -e


if [ -z $1 ]; then
  # no arg
  echo "using usb tethering"
  set -x
  systemctl stop wicd
  sleep 1
  dhclient -r
  dhclient -r
  dhclient -v usb0
  # ip route
  ifconfig br0 10.3.0.1 netmask 255.255.255.0
else
  # any arg
  echo "using wifi"
  set -x
  dhclient -r
  dhclient -r
  systemctl start wicd
  ifconfig br0 10.3.0.1 netmask 255.255.255.0
fi

