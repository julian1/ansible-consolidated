#!/bin/bash
# deployed by ansible!

## OK - this can be converted to a systemd service by simply having systemd start a loop script
## eg.  loop.sh 30 low_battery_alert.sh

threshold=90
capacity=$(cat /sys/class/power_supply/BAT0/capacity)
status=$(cat /sys/class/power_supply/BAT0/status)

beep() {
  #https://unix.stackexchange.com/questions/1974/how-do-i-make-my-pc-speaker-beep

  # too short a duration eg. < 0.5s seems to make pop noise, rather than tone
  # $1 duration in seconds, $2 freq
  #timeout -k ${1}s ${1}s speaker-test --frequency ${2} --test sine 2> /dev/null

  speaker-test -t sine -f 1000 -l 1 & sleep .5 && kill -9 $!
}


# use journalctl to follow log
# journalctl -f -u low-battery-alert
echo "$(date) whoami=$(whoami), status=$status, threshold=$threshold, capacity=$capacity"

# beep if below threshold and not charging
if [ $capacity -le $threshold ] && [ $status != "Charging" ] ; then
  echo "should beep"
  beep #0.1 500
else
  echo "no beep"
fi
