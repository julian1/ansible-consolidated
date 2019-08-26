
# start simpleSSHD on phone and get the ip, then run

# OK. this is reliable for full backup/copy of /sdcard. although slower than jmtfs. no lockup when read /sdcard with sshfs.
# note it does not work if say '172.16.2.202:/sdcard' without trailing slash

set -x

#ip=172.16.2.202
rsync -avvzP -e 'ssh -p 2222' '172.16.2.202:/sdcard/' /home/large/phone/


