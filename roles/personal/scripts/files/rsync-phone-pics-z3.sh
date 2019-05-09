#!/bin/bash -e

# echo the phone needs a different dest each time, if clear old photes because it resets the DSC count at 0
# 

#jmtpfs mnt/phone/

# dir="/home/meteo/mnt/drive/Pictures/phone/$( date --rfc-3339=date )"
dir="/home/meteo/mnt/drive/Pictures/phone/z3"


echo $dir
[ -d $dir ] || mkdir $dir 


rsync -avP '/home/meteo//mnt/phone/Internal storage/DCIM'  "$dir"



