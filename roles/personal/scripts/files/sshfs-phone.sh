
# start simpleSSHD on phone and get the ip, then run
# perhaps other will want to be changed not to use rsync 

# THIS DOES NOT WORK. 
# trying to copy files stalls as it looks like there are locking issues
# presumably because of fuse 

avoid. use rsync over ssh instead. otherwise have problems with file locking.

sshfs 172.16.2.202:/sdcard/ -p 2222 ./mnt/phone/
ls ./mnt/phone/

