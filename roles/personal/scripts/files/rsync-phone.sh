
# start simpleSSHD on phone and get the ip, then run

# OK. more reliable than jmtpfs over usb, even if slower. no lockup when read /sdcard.
# note it does not work if say '172.16.2.202:/sdcard' without trailing slash

set -x

#ip=172.16.2.202
rsync -avvzP -e 'ssh -p 2222'  '172.16.2.202:/sdcard/'   /home/large/phone/


