#!/bin/bash

if [ -z $1 ]; then
  image=build
else
  image = $1
fi


# TODO
# we use --rm to cleanup...
# but when using -i it won't respond to ctrl-c, because bash is not running
# if add -d, then can espace with ctrl-c, but the docker process is left behinid...

docker run --rm -t $image:latest  "/usr/sbin/sshd" -D -d

# also this doesn't work
#docker run --rm -t $image:latest  sh -c "/usr/sbin/sshd" -D -d



