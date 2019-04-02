#!/bin/bash -e

echo the phone needs a different dest because DSC restarts at 0

#jmtpfs mnt/phone/

dir="/home/meteo/mnt/drive/Pictures/phone/$( date --rfc-3339=date )"


echo $dir
mkdir $dir || exit

rsync -avP mnt/phone/Internal\ shared\ storage/DCIM $dir



