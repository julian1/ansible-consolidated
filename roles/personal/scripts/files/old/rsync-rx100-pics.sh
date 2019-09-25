#!/bin/bash -x

dir=$(pwd)
mnt=./mnt

# mount and rsync
[ -d $mnt/ ] || mkdir $mnt

mount -U 6236-3431 $mnt/ || exit
# blkid 6236-3431

# images
rsync -avP $mnt/DCIM/100MSDCF $dir || exit

# videos
rsync -avP $mnt/MP_ROOT/100ANV01 $dir || exit

umount $mnt/

# needed if root is required to run this, to perform the mount
# should be a way to do the mount without root.
chown -R meteo $dir 
