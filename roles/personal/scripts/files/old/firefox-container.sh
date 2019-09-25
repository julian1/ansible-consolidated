#!/bin/bash

export DISPLAY="127.0.0.1:10.0"
export PULSE_SERVER=unix:/run/user/host/pulse/native

./firefox/firefox --new-instance --profile firefox-profile   

