#!/bin/bash

[ -d tmp ] && rm tmp -rf
mkdir tmp

ID="$1" # i-2a0e47a8

# get the address and association for the instance
aws ec2 describe-addresses \
  --filters "Name=instance-id,Values=$ID" \
  > tmp/address.json \
  || exit 123


IP=$( jq -r '.Addresses[0].PublicIp' tmp/address.json)
ALLOCATION_ID=$( jq -r '.Addresses[0].AllocationId' tmp/address.json)
echo "IP $IP"
echo "ALLOCATION_ID $ALLOCATION_ID"


# release elastic ip
# aws ec2 release-address \
#  --allocation-id "$ALLOCATION_ID" \
#  || exit 123


# delete the instance,
aws ec2 terminate-instances \
  --instance-ids "$ID" \
  || exit 123

# aws ec2 describe-instances --instance-id "i-cf0f464d"

# wait for instance to stop
while true; do

  # get status
  aws ec2 describe-instances \
    --instance-id $ID \
    > tmp/status.json

  # STATUS=$( jq -r '.InstanceStatuses[0].InstanceState.Name' tmp/status.json )
  STATUS=$( jq -r '.Reservations[0].Instances[0].State.Name' tmp/status.json )

  echo "status, $STATUS"

  # TODO handle error conditions,
  if [ $STATUS = "terminated" ]; then
    break
  fi
  sleep 5
done





# need to get the instance, then get the ip,
# aws ec2 release-address --allocation-id eipalloc-80a4d8e5
# don't need
# aws ec2 describe-instances --instance-id i-39efa1bb | jq > instance.json


# use this to get the address...
# aws ec2 describe-addresses --public-ip 54.79.10.143

# this to release, which gets rid of it,
# aws ec2 release-address --allocation-id eipalloc-80a4d8e5




