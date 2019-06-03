#!/bin/bash -x


# this should be being added via dhcp???? why not....
ip route add 192.168.0.0/16 via 192.168.43.1 



####################################3

# direct routes bypass vpn

# proxy / aws. 

# bithost vpn - direct route created when starting openvpn !!!  128.199.165.106
# actually no. that's to proxy the aws node... 

# mail / digital ocean
ip route add 128.199.146.167 via 192.168.43.1


# lightning1 / bithost
ip route add 128.199.183.57 via 192.168.43.1

# all local networks . 
# dhcpd will push this as an extra route- because doesn't get it from router. unlike /sbin/dhclient 
# WHY did we ever need this?...
# ip route add 192.168.0.0/16 via 192.168.43.1 

#############

# can work out these, with debug tab -> network in firefox

# IMPORTANT - we do need to pin /etc/hosts entry, because the dns returned from vpn will be 
# different, which is what CDN does

# pacific.tv5monde.com
ip route add 180.150.153.114  via 192.168.43.1 

# fr.sitestat.com
# CDN
ip route add 77.72.118.164 via 192.168.43.1 

# b-tv5mondehlslive-i.akamaihd.net
# CDN - does not round-robbin - the browser does 
ip route add 150.101.106.74  via 192.168.43.1 
ip route add 150.101.106.83  via 192.168.43.1 

#############

# freenode.net - doesn't like aws
# chat.freenode.net (162.213.39.42:6697)
ip route add 162.213.39.42  via 192.168.43.1 

#############


# test01.julian1.io
ip route add 52.63.244.146  via 192.168.43.1 

