
iptables -t nat -A POSTROUTING -s 10.3.0.0/24 -o usb0  -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.3.0.0/24 -o wlan0 -j MASQUERADE
iptables -t nat -L -v



