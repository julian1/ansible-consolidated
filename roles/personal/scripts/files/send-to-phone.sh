
set -x

# ip=172.16.2.202
# ip=192.168.4.101
# ip=192.168.4.105
ip=192.168.42.129
# rsync -avzP --delete -e 'ssh -p 2222'  "$1"  "$ip:/sdcard/me/"   
rsync -avzP -e 'ssh -p 2222'  "$1"  "$ip:/sdcard/me/"   

