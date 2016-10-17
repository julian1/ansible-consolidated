#!/bin/bash

LOG=$(mktemp)

echo "log is, $LOG"

nova boot \
  --image e9ffe176-acac-492c-b309-55431a1b197f \
  --flavor m1.small \
  --availability-zone tasmania \
  --security-groups "ssh" \
  --key-name julian3 \
  JA-TEST \
  | tee $LOG


ID=$( grep '| id' "$LOG" | cut -d'|' -f 3 | sed 's/ //g' )

echo "instance id is, $ID"

while true; do
  nova show $ID > $LOG 
  STATE=$( grep  'vm_state' $LOG| cut -d'|' -f 3 | sed 's/ //g' )
  echo "state $STATE"
  if [ $STATE = "active" ]; then
    break 
  fi
  sleep 5
done


IP=$( grep 'accessIPv4' $LOG | cut -d'|' -f 3 | sed 's/ //g' )

echo "ip is $IP"


# add key?

while [ -z "$( ssh-keyscan -t rsa -H $IP )" ]; do
  echo "wait for sshd"
  sleep 5 
done


echo "get host key"
ssh-keyscan -t rsa -H "$IP" &> ./host-key


echo "trying ssh"
ssh "debian@$IP" -o UserKnownHostsFile=./host-key -i ~/.ssh/julian3.pem uname -a




# set +x

# ssh "debian@$IP" -o UserKnownHostsFile=./host-key -i ~/.ssh/julian3.pem
# -o UserKnownHostsFile

# get the id, then poll build status,
# nova show 9b2af64d-a4ca-446b-ba6e-364ce7456ed0 | grep vm_state

# then connect,
# ssh debian@144.6.232.116 -i ~/.ssh/julian3.pem

# then delete,
# nova delete 9b2af64d-a4ca-446b-ba6e-364ce7456ed0 

