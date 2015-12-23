
iptables --flush PREROUTING -t nat
iptables -t nat -A PREROUTING -p tcp --dport 80 -i eth0 -j DNAT --to 10.1.1.16

iptables --flush POSTROUTING -t nat
iptables -t nat -A POSTROUTING -s 10.1.1.0/24 -o eth0 -j MASQUERADE




