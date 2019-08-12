#!/bin/bash -e


echo 'should just rsync the entire phone sdcard instead as backup'  
echo 'eg for anki, zalo, etc'
echo 'eg. just mount the thing then rsync it to large/Phone'
echo 'we can then work out what photos we want to copy to large/Pictures.' 
exit


####################


# echo the phone needs a different dest each time, if clear old photes because it resets the DSC count at 0
# not sure about a20 phone.

# jmtpfs mnt/phone/

# dir="/home/meteo/mnt/drive/Pictures/phone/$( date --rfc-3339=date )"
dst='/mnt/drive/Pictures/phone/a20'
src='/home/meteo/mnt/phone/Phone/DCIM'

#echo $dst
#[ -d $dst ] || mkdir $dst 

# rsync -n -avP "$src" "$dst"
rsync -avP "$src"  "$dst"


