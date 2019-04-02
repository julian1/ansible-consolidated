#!/bin/bash

# apt-get install imagemagick

# just place a smaller file alongside original...
# this does require a selective find - to just see smaller, but makes other file handling a lot simpler...
# can easily add a thumb as well... 


if [ -z "$1" ] ; then
  echo "$0 <dir>"
  exit 123
fi

dir=$1


find "$dir" -type f | egrep '.*JPG$|.*jpg' | sort -n | while read i; do

  # echo "$i"
  target="${i%.*}.smaller.jpg"
  # echo "target $target"

  if [ -f $target ]; then
    echo "ignoring"

    # echo $target already exists, ignoring!

  else
    echo "converting $i -> $target"
    # convert $i -resize 2048 $target;
    # convert $i -resize 2048  -level 0%,100%,1.2  -colorspace srgb  $target;
    convert $i -resize 1024  -level 0%,100%,1.2  -colorspace srgb $target;
  fi
done



  # echo "basename $(dirname $i)"
  # target="$dirout/smaller/$(basename $i)"
  # just need to fiddle with the extention


