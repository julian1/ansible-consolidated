#!/bin/bash

# TODO use local tmp foc caching, instead

INSTANCE=$(mktemp)

echo "instance details, $INSTANCE"

# the instance should have the name of the provisioning script.

nova boot \
  --image e9ffe176-acac-492c-b309-55431a1b197f \
  --flavor m1.small \
  --availability-zone tasmania \
  --security-groups "ssh" \
  --key-name julian3 \
  "$INSTANCE" \
  | tee $INSTANCE


get_nova_property() {
  local name="$1"; shift;
  local file="$1"; shift;
  # might be better to use sed...
  grep " $name " $file | cut -d'|' -f 3 | sed 's/ //g'
}



ID=$( get_nova_property id "$INSTANCE"  )

echo "instance id, $ID"
# echo "****"
#exit

# wait for instance to be created
while true; do
  nova show "$ID" > $INSTANCE 
  STATE=$( get_nova_property 'OS-EXT-STS:vm_state' $INSTANCE )
  echo "state, $STATE"
  if [ $STATE = "active" ]; then
    break 
  fi
  sleep 5
done


# get ip
IP=$( get_nova_property 'accessIPv4' $INSTANCE )
echo "ip is $IP"


# wait til sshd responds
while [ -z "$( ssh-keyscan -t rsa -H $IP )" ]; do
  echo "wait for sshd"
  sleep 5 
done


# get and store the host key
echo "get host key"
ssh-keyscan -t rsa -H "$IP" &> ./host-key


# test ssh
echo "trying ssh"
ssh "debian@$IP" -o UserKnownHostsFile=./host-key -i ~/.ssh/julian3.pem uname -a


# firewall - install sec groups,
nova add-secgroup "$ID" ssh
nova add-secgroup "$ID" http
nova add-secgroup "$ID" icmp
nova add-secgroup "$ID" debug


# too many failed ssh attempts and sshd will lockout valid attempts

#   -vvvv \

ansible-playbook \
  nodes/geoserver.yml \
  -i "$IP", \
  -u debian \
  --private-key ~/.ssh/julian3.pem \
  -s \
  --ssh-extra-args '-o UserKnownHostsFile=./host-key'


# ok, so we want to be able to provision an instance without having to match a hostname
