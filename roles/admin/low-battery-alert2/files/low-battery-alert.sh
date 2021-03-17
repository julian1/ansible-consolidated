#!/bin/bash
# deployed by ansible!

# looping version. without systemd timer which is too chatty in the logs

beep() {
  #https://unix.stackexchange.com/questions/1974/how-do-i-make-my-pc-speaker-beep
  #speaker-test -t sine -f 1000 -l 1 & sleep .5 && kill -9 $! > /dev/null 2>&1
  speaker-test -t sine -f 1000 -l 1 > /dev/null & sleep .5 && kill -9 $!
}

x() {
  threshold=90
  capacity=$(cat /sys/class/power_supply/BAT0/capacity)
  status=$(cat /sys/class/power_supply/BAT0/status)

  # use journalctl to follow log
  # journalctl -f -u low-battery-alert
  #echo "$(date) xxx whoami=$(whoami), status=$status, threshold=$threshold, capacity=$capacity"

  # beep if below threshold and not charging
  if [ $capacity -le $threshold ] && [ $status != "Charging" ] ; then

    # we are discharging and below threshold capacity
    # log this state only
    echo "$(date) xxx whoami=$(whoami), status=$status, threshold=$threshold, capacity=$capacity"
    echo "should beep"
    beep
  else
    # echo "no beep"
    true
  fi
}


while true; do
  x
  sleep 60
done


