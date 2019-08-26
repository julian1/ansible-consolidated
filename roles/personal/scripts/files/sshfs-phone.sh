
# start simpleSSHD on phone and get the ip, then run

# good for dir navigation and copying single files
# but use rsync-phone for full backup - due to file fuse/android file locking issues

set -x

#ip=172.16.2.202
sshfs  172.16.2.202:/sdcard/ -p 2222 ./mnt/phone/


