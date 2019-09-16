
set -x

ip=172.16.2.202
# ip=192.168.4.101
rsync -avzP -e 'ssh -p 2222'  "$1"  "$ip:/sdcard/me/"   

