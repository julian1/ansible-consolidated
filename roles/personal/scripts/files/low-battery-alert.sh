#!/bin/bash
# deployed by ansible!

threshold=90
capacity=$(cat /sys/class/power_supply/BAT0/capacity)
status=$(cat /sys/class/power_supply/BAT0/status)

beep() {
  # $1 duration in seconds, $2 freq
  timeout -k ${1}s ${1}s speaker-test --frequency ${2} --test sine 2> /dev/null
}

# test
# beep 0.1 500

# ok. output redirection will be handled by cron. service / systemd
echo "$(date) whoami=$(whoami), status=$status, threshold=$threshold, capacity=$capacity"


if [ $capacity -le $threshold ] && [ $status != "Charging" ] ; then
  beep 0.1 500
fi
