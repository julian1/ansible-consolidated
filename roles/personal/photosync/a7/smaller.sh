#!/bin/bash
# needs to be root

DIR=$(pwd)

[ -d ./smaller ] || mkdir smaller

# resize could also do thumbnails
# [ -d $DIR/smaller ] || mkdir $DIR/smaller 
# chown -R meteo: $DIR || exit

find $DIR/100MSDCF -type f | grep '.*JPG$' | sort -n | while read i; do 
  target="$DIR/smaller/$(basename $i)"
  if [ -f $target ]; then
    echo $target already exists, ignoring!
  else
    # convert $i -resize 2048 $target; 
    echo "converting $i -> $target" 
    # convert $i -resize 2048  -level 0%,100%,1.2  -colorspace srgb  $target; 
    convert $i -resize 1024  -level 0%,100%,1.2  -colorspace srgb  $target; 
  fi
done

