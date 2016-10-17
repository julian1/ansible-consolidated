#!/bin/bash

# set -x

nova delete JA-TEST

while [ -n "$( nova show JA-TEST )" ]; do
  echo "waiting"
  sleep 5

done

