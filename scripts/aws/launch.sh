#!/bin/bash

# create aws instance, specify zone, add security groups, allocate elastic ip
# Note, that instance knows nothing about public elastic ip, which is handled through NAT

[ -d tmp ] && rm tmp -rf
mkdir tmp

# create instance
aws ec2 run-instances \
  --image-id ami-5dbe983e \
  --count 1 \
  --instance-type t2.medium \
  --placement AvailabilityZone=ap-southeast-2c \
  --security-group-ids icmp ssh http \
  --key-name julian-aws-bsd \
  > tmp/id.json \
  || exit 123

# TODO change name to INSTANCE_ID? or just INSTANCE?
ID=$( jq -r '.Instances[0].InstanceId' tmp/id.json)
echo "id is $ID"


# wait for instance to be created
while true; do

  # get status
  aws ec2 describe-instances \
    --instance-id $ID \
    > tmp/status.json

  STATUS=$( jq -r '.Reservations[0].Instances[0].State.Name' tmp/status.json )

  echo "status, $STATUS"

  # TODO handle error conditions,
  if [ $STATUS = "running" ]; then
    break
  fi
  sleep 5
done


# allocate elastic-ip
aws ec2 allocate-address  \
  > tmp/address.json \
  || exit 123

IP=$( jq -r '.PublicIp' tmp/address.json)
ALLOCATION_ID=$( jq -r '.AllocationId' tmp/address.json)
echo "IP $IP"
echo "ALLOCATION_ID $ALLOCATION_ID"


# associate ip with instance
aws ec2 associate-address \
  --instance-id $ID \
  --allocation-id $ALLOCATION_ID \
  > tmp/association.json \
  || exit 123


# wait for ssh to be available,
while true; do
  if $( nc -v -v  "$IP" 22 -w 1 | grep -q OpenSSH ); then
      break;
  fi
  sleep 5
done

# keyscan

# get and store the host key
echo "get host key"
ssh-keyscan -t rsa -H "$IP" &> tmp/host-key


# test ssh
echo "trying ssh"
ssh "admin@$IP" -o UserKnownHostsFile=./tmp/host-key -i ~/.ssh/julian-aws-bsd.pem uname -a



# aws ec2 run-instances --image-id ami-xxxxxxxx --count 1 --instance-type t1.micro --key-name MyKeyPair --security-group-ids sg-xxxxxxxx --subnet-id subnet-xxxxxxxx

