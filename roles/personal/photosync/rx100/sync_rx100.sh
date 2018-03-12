#!/bin/bash -x
# sync from camera to laptop

DIR=$(pwd)
MNT=./mnt


# mount and rsync
[ -d $MNT/ ] || mkdir $MNT


mount -U 6236-3431 $MNT/ || exit

# blkid 6236-3431


# images
rsync -avP $MNT/DCIM/100MSDCF $DIR || exit

# videos
rsync -avP $MNT/MP_ROOT/100ANV01 $DIR || exit


umount $MNT/ # || exit

chown -R meteo $DIR


# resize could also do thumbnails
# [ -d $DIR/smaller ] || mkdir $DIR/smaller 
# chown -R meteo: $DIR || exit
# 
# find $DIR/100MSDCF -type f | grep JPG | while read i; do 
#  target="$DIR/smaller/$(basename $i)"
#   if [ -f $target ]; then
#     echo $target already exists, ignoring!
#   else
#     convert $i -resize 2048 $target; 
#   fi
# done

