#!/bin/bash

# docker build -t build  .

# To be able to COPY stuff, We rely on being called from the top-level dir
if [ ! -d roles ] || [ ! -d plays ]; then
  echo "Please call from top-level dir"
  exit 1
fi 

docker build -t build -f docker/Dockerfile  .

