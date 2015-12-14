
cryptsetup luksOpen /dev/sda2 sda2-luks || exit

cryptsetup status sda2-luks || exit

zpool import storage

