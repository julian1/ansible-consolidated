
# start simpleSSHD on phone and get the ip, then run
# perhaps other will want to be changed not to use rsync 

sshfs  172.16.2.202:/sdcard/ -p 2222 ./mnt/phone/
ls ./mnt/phone/

