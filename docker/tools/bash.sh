#!/bin/bash

# $0 build image (build), $1 executable (bash)

if [ -z $1 ]; then
  image=build
else
  image = $1
fi

if [ -z $2 ]; then
  cmd=/bin/bash
else
  cmd=$2
fi


docker run -i -w /root -t $image:latest $cmd

