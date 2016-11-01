#!/bin/bash


[ -d tmp ] && rm tmp -rf
mkdir tmp

# create instance
aws ec2 run-instances \
  --image-id ami-5dbe983e \
  --count 1 \
  --instance-type t2.medium \
  --placement AvailabilityZone=ap-southeast-2c \
  --security-group-ids icmp ssh \
  --key-name julian-aws-bsd \
  > tmp/id.json \
  || exit 123

ID=$( jq -r '.Instances[0].InstanceId' tmp/id.json)
echo "id is $ID"


# wait for instance to be created
while true; do
  aws ec2 describe-instance-status --instance-id $ID > tmp/state.json
  STATE=$( jq -r '.InstanceStatuses[0].InstanceState.Name' tmp/state.json )
  echo "state, $STATE"

  # TODO handle error conditions,
  if [ $STATE = "running" ]; then
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



# associate address,
# eg. like this...
# aws ec2 associate-address --instance-id i-54d09ed6 --allocation-id eipalloc-3da9d558
# jq -r '.PublicIp' address.json
# jq -r '.Instances[0].InstanceId' out.json

# t1.micro needs pvm  and ami  ami-5dbe983e isn't.
# t2.medium

# security groups,
# sg-6ea2a10a icmp
# sg-43a1a227 ssh
# aws ec2 release-address --allocation-id eipalloc-9caed2f9   <- release, not cannot just specify the ip.


# aws ec2 describe-instance-status --instance-id i-48eea0ca  | jq -r '.InstanceStatuses[0].InstanceState.Name'

# may actually work using the group names,
# ICMP=sg-6ea2a10a
# SSH=sg-43a1a227

# aws ec2 run-instances --image-id ami-xxxxxxxx --count 1 --instance-type t1.micro --key-name MyKeyPair --security-group-ids sg-xxxxxxxx --subnet-id subnet-xxxxxxxx

