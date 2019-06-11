#!/bin/bash

# apt-get install imagemagick

# just place a smaller file alongside original...
# this requires a careful selective find to match, but makes lots other file handling simpler... backup/s3 etc easier
# can easily add a thumb as well... 


if [ -z "$1" ] ; then
  echo "$0 <dir>"
  exit 123
fi

dir=$1


find "$dir" -type f | egrep '.*JPG$|.*jpg' | sort -n | while read i; do

  size=1024

  # echo "$i"
  target="${i%.*}.smaller-$size.jpg"
  # echo "target $target"

  if [ -f $target ]; then
    echo "ignoring"

    # echo $target already exists, ignoring!

  else
    echo "converting $i -> $target"
    # convert $i -resize 2048 $target;
    # convert $i -resize 2048  -level 0%,100%,1.2  -colorspace srgb  $target;
    # convert $i -resize $size -level 0%,100%,1.2  -colorspace srgb $target;
    convert $i -resize $size  $target;
  fi
done



  # echo "basename $(dirname $i)"
  # target="$dirout/smaller/$(basename $i)"
  # just need to fiddle with the extention


