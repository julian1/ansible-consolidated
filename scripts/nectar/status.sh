#!/bin/bash

INSTANCE=$(mktemp)
trap "rm $INSTANCE" EXIT

echo "instance is $INSTANCE"

NAME="$1"


get_nova_property() {
  local name="$1"; shift;
  local file="$1"; shift;
  # might be better to use sed...
  grep " $name " $file | cut -d'|' -f 3 | sed 's/ //g'
}


nova show "$NAME" > $INSTANCE
ID=$( get_nova_property id "$INSTANCE"  )


echo "id is $ID"


# wait for instance to terminate
while true; do
  nova show "$ID" > $INSTANCE
  STATE=$( get_nova_property 'OS-EXT-STS:vm_state' $INSTANCE )
  echo "state, $STATE"
  if [ -z $STATE ]; then
    break
  fi
  sleep 2
done


