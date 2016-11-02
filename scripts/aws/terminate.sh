#!/bin/bash

[ -d tmp ] && rm tmp -rf
mkdir tmp

ID="$1" # i-2a0e47a8

# get address association for the instance
aws ec2 describe-addresses \
  --filters "Name=instance-id,Values=$ID" \
  > tmp/address.json \
  || exit 123


IP=$( jq -r '.Addresses[0].PublicIp' tmp/address.json)
ALLOCATION_ID=$( jq -r '.Addresses[0].AllocationId' tmp/address.json)
echo "IP $IP"
echo "ALLOCATION_ID $ALLOCATION_ID"


# release elastic ip
aws ec2 release-address \
  --allocation-id "$ALLOCATION_ID" \
  || exit 123


# delete the instance,
aws ec2 terminate-instances \
  --instance-ids "$ID" \
  || exit 123

# wait for instance to stop
while true; do

  # get status
  aws ec2 describe-instances \
    --instance-id $ID \
    > tmp/status.json

  STATUS=$( jq -r '.Reservations[0].Instances[0].State.Name' tmp/status.json )

  echo "status, $STATUS"

  # TODO handle error conditions,
  if [ $STATUS = "terminated" ]; then
    break
  fi
  sleep 5
done


# should wait to login...

