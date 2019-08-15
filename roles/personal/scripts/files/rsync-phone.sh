
# relies on simpleSSHD and wifi 
# OK. seems more reliable than jmtpfs over usb, even if slower. no lockup when read /sdcard. 
# note it does not work if say '172.16.2.202:/sdcard' without trailing slash

#ip=172.16.2.202
rsync -avvzP -e 'ssh -p 2222'  '172.16.2.202:/sdcard/'   /home/large/phone/


