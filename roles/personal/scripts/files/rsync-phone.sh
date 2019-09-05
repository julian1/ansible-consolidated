
# start simpleSSHD on phone, get ip, then run script

# OK. better than jmtpfs and fuse over usb, which has file locking issues with file based rsync. 
# even if slower due to wifi
# note requires the trailing slash on /sdcard/, else permissions issue

set -x

#ip=172.16.2.202
ip=192.168.4.101

rsync -avvzP -e 'ssh -p 2222'  "$ip:/sdcard/"   /home/large/phone/


